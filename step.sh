#!/bin/bash
set -ex

# echo "This is the value specified for the input 'example_step_input': ${example_step_input}"

#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
# envman add --key EXAMPLE_STEP_OUTPUT --value 'the value you want to share'
# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.

MESSAGE="🚨⚠️ *$BITRISE_APP_TITLE*: Сборка $BITRISE_BUILD_NUMBER отвалилась 🗿\nСсылка (Bitrise): $BITRISE_APP_URL"
if [ ! -z "$BITRISE_GIT_MESSAGE" -a "$BITRISE_GIT_MESSAGE" != " " ] ; then MESSAGE+="\nСообщение: $BITRISE_GIT_MESSAGE" ; fi
MESSAGE+="\n\n $custom_message"

if [ $BITRISE_BUILD_STATUS -eq 0 ] ; then 
	MESSAGE="✅ <b>$BITRISE_APP_TITLE</b>: Сборка $BITRISE_BUILD_NUMBER успешна! "
	NUM=$(shuf -i 0-18 -n 1)
	if [ $NUM -eq 0 ] ; then MESSAGE+="Блистательно 🏅"
	if [ $NUM -eq 1 ] ; then MESSAGE+="Восхитительно 🏆"
	if [ $NUM -eq 2 ] ; then MESSAGE+="Изумительно 🍾"
	if [ $NUM -eq 3 ] ; then MESSAGE+="Волшебно 🪄"
	if [ $NUM -eq 4 ] ; then MESSAGE+="Чудно 💫"
	if [ $NUM -eq 5 ] ; then MESSAGE+="Потрясающе 🔥"
	if [ $NUM -eq 6 ] ; then MESSAGE+="Шикарно 👑"
	if [ $NUM -eq 7 ] ; then MESSAGE+="Дивно 🤌"
	if [ $NUM -eq 8 ] ; then MESSAGE+="Великолепно 🤝"
	if [ $NUM -eq 9 ] ; then MESSAGE+="Превосходно 🤩"
	if [ $NUM -eq 10 ] ; then MESSAGE+="Блестяще 🎆"
	if [ $NUM -eq 11 ] ; then MESSAGE+="🅰️🅱️🅾️🅱️🅰️"
	if [ $NUM -eq 12 ] ; then MESSAGE+="Замечательно 🎇"
	if [ $NUM -eq 13 ] ; then MESSAGE+="Красиво 🌠"
	if [ $NUM -eq 14 ] ; then MESSAGE+="Прекрасно 🌟"
	if [ $NUM -eq 15 ] ; then MESSAGE+="Божественно ✨"
	if [ $NUM -eq 16 ] ; then MESSAGE+="Мощно 🦾"
	if [ $NUM -eq 17 ] ; then MESSAGE+="Норм."
	if [ $NUM -eq 18 ] ; then MESSAGE+="Пойдет."
	if [ ! -z "$BITRISE_GIT_MESSAGE" -a "$BITRISE_GIT_MESSAGE" != " " ] ; then MESSAGE+="\nСообщение: $BITRISE_GIT_MESSAGE" ; fi
	MESSAGE+="\n\nСсылки на скачивание ⬇️: $download_url \n\n$custom_message"
fi

payload="{ \"chat_id\": \"'${telegram_chat_id}'\", \"text\":\"$MESSAGE\", \"parse_mode\": \"HTML\" }"

RESULT=$(curl -X POST https://api.telegram.org/bot${telegram_bot_token}/sendMessage \
-H "Content-Type: application/json" \
-d @- <<EOF
{
    "chat_id":"${telegram_chat_id}", 
    "text":"$MESSAGE",
    "parse_mode":"HTML"
}
EOF)

# echo "$payload"
# echo "$BITRISE_GIT_MESSAGE"
# echo "$MESSAGE"
# echo "$RESULT"


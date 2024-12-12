#!/bin/sh

yt-dlp -o "twit_%(episode_number)s.%(ext)s" https://feeds.twit.tv/twit.xml

IFS="$(printf '\n')"
for f in *.mp3; do
	case "$f" in
		*_m.mp3)
			continue
			;;
	esac

	base=${f%%.*mp3}
	min=${base}_m.mp3

	if [ -e "$min" ]; then
		continue
	fi

	ffmpeg -i $f -af \
		"atempo=1.5,silenceremove=1:0:-45dB:0:any:-1:0:-45dB:0:any:rms:0.002" \
		-n $min
done

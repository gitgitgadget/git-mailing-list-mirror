From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow custom "comment char"
Date: Tue, 15 Jan 2013 11:12:13 -0800
Message-ID: <7v622y45wy.fsf@alter.siamese.dyndns.org>
References: <7vk3rk25iw.fsf_-_@alter.siamese.dyndns.org>
 <1358275827-5244-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvBw7-0000Et-1k
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab3AOTMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 14:12:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755278Ab3AOTMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 14:12:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B2A895D1;
	Tue, 15 Jan 2013 14:12:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6odl1MuT6DklKa7ir2m04A5Zva0=; b=qSjZFt
	CGPopndzVx8RRXMXZoPj6idIqoMi/hE7la2aRU8gWyXzQewffqY7ravmY+sRkv4l
	mCoR0WK9aTQPpwr/HwFigJrADf/RsjneNK6bXYugzoHdPSwBid70L1tmXidiWNUe
	0MhzhNnNPmBqaxlO/sjFLlAX7r+3OYzdRV4l8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R7XBj4CRy9v6q8VgBiZJlh+ZnMz5BRMl
	jeuCvMvy85ns+3lkTzdqS5CMfZC8Oa7rlORNHKyei7jPjGyY5XKbNV5g9XDOot5r
	WaXnSbkePCV1gJQvtuh6CsFt28J1RDUFmkmWkcxyNE5b/3f7qFdHstzhE84YBxFC
	STr6v17RWk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E9E595CF;
	Tue, 15 Jan 2013 14:12:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44D5D95C9; Tue, 15 Jan 2013
 14:12:15 -0500 (EST)
In-Reply-To: <1358275827-5244-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Tue, 15 Jan 2013 19:50:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 790F5F2E-5F47-11E2-A52C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213662>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Some users do want to write a line that begin with a pound sign, #,
> in their commit log message.  Many tracking system recognise
> a token of #<bugid> form, for example.
>
> The support we offer these use cases is not very friendly to the end
> users.  They have a choice between
>
>  - Don't do it.  Avoid such a line by rewrapping or indenting; and
>
>  - Use --cleanup=whitespace but remove all the hint lines we add.
>
> Give them a way to set a custom comment char, e.g.
>
>     $ git -c core.commentchar="%" commit
>
> so that they do not have to do either of the two workarounds.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

It would have helped if you said you finished the NEEDSWORK: in
builtin/branch.c in the earlier draft with strbuf_commented_*
functions ;-)

Looks like a good progress overall, except for nits here and there.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 453457a..5e84e35 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -92,10 +92,7 @@ static const char * const git_notes_get_ref_usage[] = {
>  };
>  
>  static const char note_template[] =
> -	"\n"
> -	"#\n"
> -	"# Write/edit the notes for the following object:\n"
> -	"#\n";
> +	"Write/edit the notes for the following object:";

I think this (and its use site that manually adds "\n#\n") is a
symptom of strbuf_commented_add*() function not designed right.
When it iterates over lines and adds each of them in a commented out
form, it could check if the line is an empty one and refrain from
adding a trailing SP if that is the case.  Then this can become

    "\nWrite/edit the notes...\n\n";

You have to create the "\n" blank line at the beginning manually,
but that is logically outside the commented out block, so it is not
a problem.

> @@ -181,11 +172,16 @@ static void create_note(const unsigned char *object, struct msg_arg *msg,
>  			write_or_die(fd, msg->buf.buf, msg->buf.len);
>  		else if (prev && !append_only)
>  			write_note_data(fd, prev);
> -		write_or_die(fd, note_template, strlen(note_template));
> +
> +		strbuf_addf(&buf, "\n%c\n", comment_line_char);
> +		strbuf_commented_addstr(&buf, note_template);
> +		strbuf_addf(&buf, "\n%c\n", comment_line_char);
> +		write_or_die(fd, buf.buf, buf.len);

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9c3e067..e1b72be 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -246,19 +246,13 @@ static int do_sign(struct strbuf *buffer)
>  }
>  
>  static const char tag_template[] =
> -	N_("\n"
> -	"#\n"
> -	"# Write a tag message\n"
> -	"# Lines starting with '#' will be ignored.\n"
> -	"#\n");
> +	N_("Write a tag message\n"
> +	"Lines starting with '%c' will be ignored.");
> ...
> +			else
> +				strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
> +			strbuf_addf(&buf, "\n%c\n", comment_line_char);
> +			write_or_die(fd, buf.buf, buf.len);

Same here.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 22ec5b6..1b8d95f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -975,13 +975,19 @@ cmd_summary() {
>  		echo
>  	done |
>  	if test -n "$for_status"; then
> +		comment_char=`git config core.commentchar`
> +		if [ ! -n "$comment_char" ]; then
> +			comment_char='#'
> +		elif [ ${#comment_char} -gt 1 ]; then

Not portable, I think.

> +		echo "$comment_char"
> +		sed -e "s|^|$comment_char |" -e "s|^$comment_char $|$comment_char|"

Can $comment_char be a '|'?

> diff --git a/strbuf.c b/strbuf.c
> index 9a373be..8af4b4f 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -204,6 +204,44 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
>  	va_end(ap);
>  }
>  
> +void strbuf_commented_addstr(struct strbuf *sb, const char *s)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf prefix = STRBUF_INIT;
> +
> +	strbuf_addf(&prefix, "%c ", comment_line_char);
> +	strbuf_addstr(&buf, s);
> +	strbuf_add_lines(sb, prefix.buf, buf.buf, buf.len);
> +
> +	// remove additional '\n' added by strbuf_add_lines()

No C++ comments.

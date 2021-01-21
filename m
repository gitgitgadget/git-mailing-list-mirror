Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0582C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE882389A
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbhAUDoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:44:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54857 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391868AbhAUBi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 20:38:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F9CFFDBE5;
        Wed, 20 Jan 2021 20:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cuPudv8L/J88eR0ulQ2VzTJUpO8=; b=j5Togb
        N8PUvgFRQHIM3+O3oFbu7bQFs5Zz/d856Cw2EN1bAjWLIvXqf1tvRjn31mbwk2qc
        L0qzx/1oNWGtVXq2S5ExKfPCSjbJN9YPWBY9QUhSFcPnf4P/zzk6w68v4WvpFs5Z
        GL/1CY8PSrjcVS3Hpd3g7rehnQEnLQYQJi7Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wWYJREb+smx5l4d9RsaCaGGZ6k8oW6iF
        yDEDZPJBHKQkfA2ba6Uz68Nfad4K7cvmQMRBrQwRtznNh2BrUGHXgFf3Ce488AFi
        ctq9cPPuU3qgIS+96KKC9dD/ndT768o3R+5/xwISQnz15H50Jh5pgG4PjF8gUCEh
        ZFwzxhIk5uU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27C6BFDBE4;
        Wed, 20 Jan 2021 20:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FE8AFDBE3;
        Wed, 20 Jan 2021 20:38:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org,
        phillip.wood@dunelm.org.uk, me@ttaylorr.com
Subject: Re: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
References: <20210108092345.2178-1-charvi077@gmail.com>
        <20210119074102.21598-4-charvi077@gmail.com>
Date:   Wed, 20 Jan 2021 17:38:04 -0800
In-Reply-To: <20210119074102.21598-4-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Tue, 19 Jan 2021 13:10:58 +0530")
Message-ID: <xmqqmtx3dq83.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FF09698-5B89-11EB-A3A0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> +static size_t subject_length(const char *body)
> +{
> +	size_t i, len = 0;
> +	char c;
> +	int blank_line = 1;
> +	for (i = 0, c = body[i]; c; c = body[++i]) {
> +		if (c == '\n') {
> +			if (blank_line)
> +				return len;
> +			len = i + 1;
> +			blank_line = 1;
> +		} else if (!isspace(c)) {
> +			blank_line = 0;
> +		}
> +	}
> +	return blank_line ? len : i;
> +}

I cannot quite tell what this loop is trying to compute at the first
glance.

 - If body[0] == '\n', then i==0, c==LF, blank_line==1 and len==0
   so len==0 is returned immediately.

 - If the first line has only SP, HT, CR, etc. whitespace,
   blank_line stays 1 and at the end of the line when we see
   c=='\n', body[i] is pointing at that '\n', blank_line is true, so
   len is returned from the previous iteration (e.g. body="   \n"
   returns 0)

 - If the first line has some non space, blank_line becomes false,
   so at the end of that line when we see c=='\n', body[i] is
   pointing at that '\n', len==i+1 becomes one past that LF and then
   we reset blank_line to true??? and go on to the next line.

So when we see LF, if we have seen any non whitespace byte on that
line, blank_line is false.  Only when we saw LF followed by zero or
more whitespace before seeing another LF, we return len that was set
when we saw the previous LF (which is one past that LF).
    
So... is this trying to find the first paragraph-break-looking line
to find the end of the first paragraph.  OK.

There must be an easier-to-read way to write all this, though, I
would think (or don't we already have an existing code that is
waiting to be factored out?).

In any case, let's keep reading.

>  static void append_squash_message(struct strbuf *buf, const char *body,
>  				  struct replay_opts *opts)
>  {
> +	size_t commented_len = 0;
> +
>  	unlink(rebase_path_fixup_msg());
> +	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
> +		commented_len = subject_length(body);
>  	strbuf_addf(buf, "\n%c ", comment_line_char);
>  	strbuf_addf(buf, _("This is the commit message #%d:"),
>  		    ++opts->current_fixup_count + 1);
>  	strbuf_addstr(buf, "\n\n");
> -	strbuf_addstr(buf, body);
> +	strbuf_add_commented_lines(buf, body, commented_len);

As add_commented_lines places the comment character at the beginning
of each line, it is OK for body[0..commented_len) to contain more than
one lines.  Good.

> +	strbuf_addstr(buf, body + commented_len);

And we add everything after the beginning of the paragraph-break
looking line.  This code may add a line, immediately after the
previous "commented out" block, bunch of whitespaces and then a LF.
It will be cleaned up with stripspace most of the time, but
depending on the end-user settings, it may be left behind.  I am
guessing that is what we want, but thought it would not hurt to
double check.

> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 7bab6000dc..551dc06bc3 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -81,8 +81,7 @@ test_auto_squash () {
>  	echo 1 >file1 &&
>  	git add -u &&
>  	test_tick &&
> -	git commit -m "squash! first" &&
> -
> +	git commit -m "squash! first" -m "extra para for first" &&

It is not "extra"; that's the beginning of the "body" ;-).

>  	git tag $1 &&
>  	test_tick &&
>  	git rebase $2 -i HEAD^^^ &&
> @@ -139,7 +138,7 @@ test_expect_success 'auto squash that matches 2 commits' '
>  	echo 1 >file1 &&
>  	git add -u &&
>  	test_tick &&
> -	git commit -m "squash! first" &&
> +	git commit -m "squash! first" -m "extra para for first" &&
>  	git tag final-multisquash &&
>  	test_tick &&
>  	git rebase --autosquash -i HEAD~4 &&
> @@ -192,7 +191,7 @@ test_expect_success 'auto squash that matches a sha1' '
>  	git add -u &&
>  	test_tick &&
>  	oid=$(git rev-parse --short HEAD^) &&
> -	git commit -m "squash! $oid" &&
> +	git commit -m "squash! $oid" -m "extra para" &&
>  	git tag final-shasquash &&
>  	test_tick &&
>  	git rebase --autosquash -i HEAD^^^ &&
> @@ -203,7 +202,8 @@ test_expect_success 'auto squash that matches a sha1' '
>  	git cat-file blob HEAD^:file1 >actual &&
>  	test_cmp expect actual &&
>  	git cat-file commit HEAD^ >commit &&
> -	grep squash commit >actual &&
> +	grep -v "squash" commit &&

This says that the file must have at least one line that does not
say "squash" or the test is a failure.  It does not say "there
should be no line that has "squash" on it".  Intended?

> +	grep "extra para" commit >actual &&

I can tell that you want the "extra para" to still remain, but how
does the grep that is not anchored guarantee that?  Perhaps look for

	grep "^extra para" commit

to ensure that you are not seeing a commented out but somehow failed
to get stripspaced out?

>  	test_line_count = 1 actual
>  '

Thanks.

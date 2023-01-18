Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F9CC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjARQI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjARQIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:08:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC158670
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:04:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so1978893pjq.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HlMx/sg7BoBtRrmCaT0WuCi7ZT6HiB3VkDiBrJu/Uk=;
        b=nD26QzjGvKZQ6/+1FRB4X02sAru4AtSqDJP5rv+KYHWXTNYK7DhyMO82/3/xpJVSuq
         Edx5WCWFrNZtLaidDyhyxJfHRXd0qW21rB38ucsWnxDgFkWgv3mzOaQSzUdKEta8nyN4
         /3NQ9A9+M8cd6+bRWGCoiuYEq5nDZKrCkyxVDYGxKHQaRup+KRUilm8+Jv56HSStWxUu
         akHogfi2yBwT0uF1paN/hcemFF7TI1O/Pho+NIa0znOzbtOO6AY//pFwql8cKFxAKrzI
         rHzQKhVGQtQEvyf1AZ692+I9+/JKbaxoUavNLW/oGrHbJt+8RV1j6JhdgumnWE+Ub7k5
         odrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/HlMx/sg7BoBtRrmCaT0WuCi7ZT6HiB3VkDiBrJu/Uk=;
        b=ugMK/Ze6DyUwSMMEkHNpIrwlYlEYqfbtUPnSGV5uXc1ZNf3CG4ORUfKwbGHfCI9yRA
         oejxl2AgcWdCMZsxH9XcbviRlpX2ezAHmcMg5Eje8bEhY4TzgBJMyDnekPTdkMDGi6Dt
         HyX5j6ioupD1ZIxfgIrPWD2iPP8wLf8cRHjai2omHUvuUtBMMUTXmyfAQEoqFN1Db2dt
         VhfW9NwWxCWTfzHs8r22Dr00no1dP0wVzPCGbEBwdcwDBd5YJakOGgucd3gSgURKkd3w
         DQ55Cx+sTBpcDuS9t6FwMQ54LWoWpF/Y1ObrQgikL37Iltv1QHj8u2Eg0NT7HRIXE2ae
         28/Q==
X-Gm-Message-State: AFqh2kqUChKtOn8SjBZ/lADQ4fGz00oIjFH6rDocDaVS208jV3iJdYlg
        PPgCBapPdqfTDqBctbmKe7o=
X-Google-Smtp-Source: AMrXdXvOqHhhevwsAPMGK86gt6onyxi3T1aDNu4lSK6LlC+9NK1v1osoXgcDI3royUwpurPlm2OYlA==
X-Received: by 2002:a05:6a20:6595:b0:b5:46fa:24e8 with SMTP id p21-20020a056a20659500b000b546fa24e8mr6640934pzh.38.1674057872165;
        Wed, 18 Jan 2023 08:04:32 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e3-20020a63f543000000b004cd2eebc551sm5040474pgk.62.2023.01.18.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:04:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: replace strbuf_addstr with strbuf_addch for all
 strings of length 2
References: <pull.1436.git.git.1673992498572.gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 08:04:31 -0800
In-Reply-To: <pull.1436.git.git.1673992498572.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Tue, 17 Jan 2023 21:54:58 +0000")
Message-ID: <xmqqr0vr6d80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> This helps reduce overhead of calculating the length

Have you measured how much overhead this change is saving, or is
this a 300 line e-mail message that churns code without giving us
any measurable improvement?

There also seem to be some totally unrelated changes of dubious
merit hidden in these patches (see below).

> Subject: Re: [PATCH] git: replace strbuf_addstr with strbuf_addch for all strings of length 2

I think you are touching strings of length 1, not 2.  Running
strlen() on such a string returns will return 1 without counting the
terminating NUL.

> diff --git a/builtin/am.c b/builtin/am.c
> index 7e88d2426d7..c96886e0433 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -329,13 +329,11 @@ static void write_author_script(const struct am_state *state)
>  
>  	strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
>  	sq_quote_buf(&sb, state->author_name);
> -	strbuf_addch(&sb, '\n');
>  
> -	strbuf_addstr(&sb, "GIT_AUTHOR_EMAIL=");
> +	strbuf_addstr(&sb, "\nGIT_AUTHOR_EMAIL=");
>  	sq_quote_buf(&sb, state->author_email);
> -	strbuf_addch(&sb, '\n');
>  
> -	strbuf_addstr(&sb, "GIT_AUTHOR_DATE=");
> +	strbuf_addstr(&sb, "\nGIT_AUTHOR_DATE=");
>  	sq_quote_buf(&sb, state->author_date);
>  	strbuf_addch(&sb, '\n');

This may reduce the number of lines, but markedly worsens the
readability of the resulting code.  Each of the three-line blocks in
the original used to be logically complete and independent unit, but
now each of them depend on what the last block wants.

In any case, this has nothing to do with "addstr() of constant string
can be replaced with add() with a constant length or addch() of a
sing character to make it unnecessary to compute the length".

By the way, the current implementation of strbuf_addstr() looks like
this:

        static inline void strbuf_addstr(struct strbuf *sb, const char *s)
        {
                strbuf_add(sb, s, strlen(s));
        }

Decent optimizing compilers should be able to see through the code
like this you write:

	strbuf_addstr(&sb, "constant");

which becomes

	strbuf_add(&sb, "constant", strlen("constant"))

when inlined, and realize strlen("constant") can be computed at
compile time, turning it into

	strbuf_add(&sb, "constant", 8);

That way, people can make their strbuf_addstr() calls in the way
they find the most natural, i.e. without having to choose between
_addstr() and _add().  If the compilers can do their unnecessary
thinking for us humans, we should make them do so to help us.

If somebody can prove that between these two

	strbuf_add(&sb, "c", 1);
	strbuf_addch(&sb, 'c');

there is a meaningful difference in overhead to encourage us to
rewrite the former to the latter, perhaps a similar trick can be
employed in the implementation of strbuf_add(), perhaps like:

        static inline void strbuf_add(struct strbuf *sb, const void *data, size_t len)
        {
                if (len == 1) {
                        strbuf_addch(sb, *((char *)sb));
                } else {
                        strbuf_grow(sb, len);
                        memcpy(sb->buf + sb->len, data, len);
                        strbuf_setlen(sb, sb->len + len);
                }
        }

That way, people can make their strbuf_add() and strbuf_addstr()
calls in the way they find the most natural, i.e. without having to
choose between _add() and _addch() depending on the length of the
string.  This makes the code easier to maintain, as we do not have
to change the code all that much when the length of the string we
need to append to a strbuf changes from 1 to more (or the other way
around).

But I somehow doubt it is worth it.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 71f925e456c..3ab4cc0a56b 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -143,11 +143,9 @@ static void get_ac_line(const char *inbuf, const char *what,
>  
>  	if (split_ident_line(&ident, tmp, len)) {
>  	error_out:
> -		/* Ugh */
> -		tmp = "(unknown)";
> -		strbuf_addstr(name, tmp);
> -		strbuf_addstr(mail, tmp);
> -		strbuf_addstr(tz, tmp);
> +		strbuf_addstr(name, "(unknown)");
> +		strbuf_addstr(mail, "(unknown)");
> +		strbuf_addstr(tz, "(unknown)");

This is another unrelated change that has not much to do with the
theme of the change, to use addch() when the string is of length 1.

>  	if (opt->priv->call_depth) {
> -		strbuf_addchars(dest, ' ', 2);
> -		strbuf_addstr(dest, "From inner merge:");
> +		strbuf_addstr(dest, "  From inner merge:");
>  		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);

Ditto, even though this is not as horrible as the change to builtin/am.c
we saw earlier.

I'll stop here.

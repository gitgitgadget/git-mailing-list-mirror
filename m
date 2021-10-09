Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE4C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51AE60F55
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbhJICCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 22:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJICCC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 22:02:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823CBC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 19:00:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so43267264edc.11
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 19:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XW/U+x/fXppkUZLn7mjrL8pV36eMhF8zFEnWFzfDlPY=;
        b=IF94cNR6JbMb1H8sHvdsxHbQCbvLkm5gmGLLKXls2DzIB9x707zmT9N9mLmntd5QGr
         OFKB++D3AsQq7zxdc4GIuaBLjm7PAcYqFETKSNHzAkzJbf1lzJqF5g6TcL0l+HGPMF0c
         uZkFbZxvsb8vCqCm277ByyS3gMDRv7lX1oTENSf+TI/Q+2hVjJsiczuNo+9Ntqp0SJ5i
         Y4USBAyqBuF8C11GK4zjmiI7HO54MsB55HuosQaCnM4vBGKi+3bgh2pZFhNgvomRWmRi
         YnYd/BolAqOtJgk65ZuPYnu0AKDjjGOQ5bFalR6/U2iZC8+y8E9vh8bQx6TrwMnSGS4A
         yMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XW/U+x/fXppkUZLn7mjrL8pV36eMhF8zFEnWFzfDlPY=;
        b=vv1zYK4uWBc3rnh8b59mas1iBudgnLUCGTR6da2My/UQgI2dYJTQeBC5MzYoL1/wdC
         oXxMqaADS3XThee3rjqWR6rhHj/P2a/Y2Ty3EwaxMf6Rblylli127ZWLlyckIBuzIsxL
         um51G+gYydJUBSbRFd3FoE8vtRJOEuH9Ubdr7ycSy8t2DMF4sWrcU4oWqj0oGNMyJTFX
         JP7bLctyuyIh3CzoE8gbERhJDTUq11VH5KqmCAlacBVq/PsZlaUFykyuDc0lKjQC5OZC
         an3olDZ/mKLFVEA0XasXveLleDJR0lLrVWXnAiM8O9BpW0R7ULrNswyHsHz153jaetSf
         4k1A==
X-Gm-Message-State: AOAM532oqqvowApSaf3nRb0liTLatA1JG0nL4GQn5rbyf7xM8ZCpZwlf
        qJG/dxxgbf983q9m3D1wRxk=
X-Google-Smtp-Source: ABdhPJxDZy7cwc4ApvUrG8W5f9k43T/zInwTINwE0+JOzfUXCG3/dltiWImvLE1Tard4bPwAEwlzuA==
X-Received: by 2002:a05:6402:5186:: with SMTP id q6mr20311475edd.64.1633744803703;
        Fri, 08 Oct 2021 19:00:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r1sm407862edp.56.2021.10.08.19.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 19:00:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v12 3/3] grep: fix an edge case concerning ascii
 patterns and UTF-8 data
Date:   Sat, 09 Oct 2021 03:37:58 +0200
References: <20211008224918.603392-1-someguy@effective-light.com>
 <20211008224918.603392-3-someguy@effective-light.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211008224918.603392-3-someguy@effective-light.com>
Message-ID: <87a6jjlzz1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Hamza Mahfooz wrote:

> If we attempt to grep non-ascii log message text with an ascii pattern, we
> run into the following issue:
>
>     $ git log --color --author=3D'.var.*Bjar' -1 origin/master | grep ^Au=
thor
>     grep: (standard input): binary file matches
>
> So, to fix this teach the grep code to mark the pattern as UTF-8 (even if
> the pattern is composed of only ascii characters), so long as the log
> output is encoded using UTF-8.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
> v12: get rid of utf8_all_the_things and fix an issue with one of the unit
>      tests.
> ---
>  grep.c                          |  6 +++--
>  t/t7812-grep-icase-non-ascii.sh | 48 +++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index fe847a0111..f6e113e9f0 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -382,8 +382,10 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern=
) &&
> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
> +	    (!opt->ignore_locale && is_utf8_locale() &&
> +	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
> +					    (p->fixed || p->is_fixed))))
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

I think at least some of that existing "if" is my fault, and I *think*
your patch works here, but FWIW I'd find something like this way more
readable:
=09
	@@ -382,8 +383,16 @@ static void compile_pcre2_pattern(struct grep_pat *p,=
 const struct grep_opt *opt
	                }
	                options |=3D PCRE2_CASELESS;
	        }
	+       if (opt->utf8_all_the_things) {
	+               options |=3D PCRE2_UCP;
	+               do_utf8 =3D 1;
	+       }
	+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
	        if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pa=
ttern) &&
	            !(!opt->ignore_case && (p->fixed || p->is_fixed)))
	+               do_utf8 =3D 1;
	+
	+       if (do_utf8)
	                options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

Well, without the "utf8_all_the_things" probably. That's a reference to
a popular meme, probably better to name it differently, and the
PCRE2_UCP is just something I was experimenting with.

It's late here, but I've got to admit that I'm still a bit confused by
this. Let's see if I can try to sum up why:

Ultimately whether we use PCRE2_UTF *should* have nothing do to with
whether the pattern is UTF-8 or not, because even an expression like:

    /.*/

Will behave differently under UTF-8, i.e. character classes change, byte
boundaries change to "character" boundaries etc.

That the existing code has has_non_ascii() and the like is a trade-off
that had to be made for the grep-a-file case, because you might run into
arbitrary binary data, but logs are cleaner/encoded/re-encoded etc.

If you run PCRE in UTF-8 mode it will die on some of that data (as
you'll see from our test suite if you turn it on unconditionally).

Are there cases where my "utf8_all_the_things" POC patch would have
turned on PCRE2_UTF, but yours doesn't? IOW is there a 1=3D1 mapping still
between the encoding mode log/revision.c thinks it's in & PCRE2_UTF?

Anyway, I've tried to break things with this patch and haven't
succeeded, so maybe it's all OK now, thanks a lot for working on this
again, it's a really neat feature. Just wondering if there's any
remaining edge cases we know about...

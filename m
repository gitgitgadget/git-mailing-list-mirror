Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E5FC433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 17:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3846196D
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 17:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhC0R5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhC0R5A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 13:57:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B4C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 10:56:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ce10so13201578ejb.6
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hgePWV5vuhgmXv1uBzIWg86+M/wbZLYO63rNw1UQNus=;
        b=OMshOZOCaEgRpy0yJhvfIEeYJQEWqUjgkEnTSrllxYE1CC7HDzHQF+Wq1y0lk1rgsh
         DS2tTybO99LczlFJ/9k95xOb/89QO21o1+saJJSuYtqmrET++7M2uaUo/lrb2Mm5TLNA
         /NhqktBlkp3axLVzv3bFpzFQ91CwpGrl2GFX4m13ubO6kOnRKK9Olk0JyoO4ZBzsLr4R
         6svb9CQxa2U88fzxKzvsqsAK/oRTMwA4xwp8C5qem0IQWiAYivg/kFX4VSnq3Idj24I+
         LMX0uFvJOYYrgSCwenaapZm9uN400MQ+40dyWTsk+Hlw0d83MeilvX86MAd36g61wIrn
         N7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hgePWV5vuhgmXv1uBzIWg86+M/wbZLYO63rNw1UQNus=;
        b=e3gO7x97VLWcpnshIwWQDjN8p/Ot2otQk9+AplLL4cy0lL4va8jez4sfVEGeFISMtF
         F/SL+AhDCoSBc5OzBjukGIkk0Pk1eOVeQLgH81UsPC4HoDupR/qNgqEIs5qqqEZmZfh3
         6AzmneuX/dnBpshSnS42gc+pYRfVi/y0AjvVpywnZRGMpThyvw6ZsuLBYvl2EbBoXAfU
         W5JnHoFmm9m2Us7DfxHTgZidSoK+0d4E0I6mmExy8Qgi+T18IUyykK0qHyKO7IZVCPAk
         ml9Kyp0fg7ZCuPDbpAygo7hufx1MoQeA5di0+S/3gGyfhxktuQHHMa0w0R59FF4a11pt
         7JTA==
X-Gm-Message-State: AOAM531Gt+ck4rxMsw7i58FbgJG5H3JyWqerO+W6wBnhRD87QA/dlTXl
        eIfihs23LTfv7urYOzpDywY=
X-Google-Smtp-Source: ABdhPJyNRMMsFVyFWTCfr2xWLF99yXLwU+NFt2Na3iOeH4dlCy6jlJMiroFx0LNmeMlkdJfbqP1UKQ==
X-Received: by 2002:a17:906:8a65:: with SMTP id hy5mr21658815ejc.250.1616867816176;
        Sat, 27 Mar 2021 10:56:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id wr20sm5460660ejb.111.2021.03.27.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:56:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
        gitster@pobox.com, jeffhost@microsoft.com
Subject: Re: [PATCH v2] usage: trace2 BUG() invocations
References: <20210205054914.104640-1-jonathantanmy@google.com>
 <20210205200908.805639-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210205200908.805639-1-jonathantanmy@google.com>
Date:   Sat, 27 Mar 2021 18:56:49 +0100
Message-ID: <87mtuoo4ym.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 05 2021, Jonathan Tan wrote:

> die() messages are traced in trace2, but BUG() messages are not. Anyone
> tracking die() messages would have even more reason to track BUG().
> Therefore, write to trace2 when BUG() is invoked.
> [...]
> +# Verb 007bug
> +#
> +# Check that BUG writes to trace2
> +
> +test_expect_success 'normal stream, exit code 1' '
> +	test_when_finished "rm trace.normal actual expect" &&
> +	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
> +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
> +	cat >expect <<-EOF &&
> +		version $V
> +		start _EXE_ trace2 007bug
> +		cmd_name trace2 (trace2)
> +		error the bug message
> +		exit elapsed:_TIME_ code:99
> +		atexit elapsed:_TIME_ code:99
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  sane_unset GIT_TRACE2_BRIEF
>  
>  # Now test without environment variables and get all Trace2 settings
> diff --git a/usage.c b/usage.c
> index 1868a24f7a..1b206de36d 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -266,6 +266,10 @@ int BUG_exit_code;
>  static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
>  {
>  	char prefix[256];
> +	va_list params_copy;
> +	static int in_bug;
> +
> +	va_copy(params_copy, params);
>  
>  	/* truncation via snprintf is OK here */
>  	if (file)
> @@ -274,6 +278,13 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
>  		snprintf(prefix, sizeof(prefix), "BUG: ");
>  
>  	vreportf(prefix, fmt, params);
> +
> +	if (in_bug)
> +		abort();
> +	in_bug = 1;
> +
> +	trace2_cmd_error_va(fmt, params_copy);
> +
>  	if (BUG_exit_code)
>  		exit(BUG_exit_code);
>  	abort();

I see it's an existing bug/misfeature of this whole part of trace2 that
error()/warning()/usage() etc. don't pass down the file and line number
of their callers. We'd need to make all of those functions a macro for
that to work.

But it can work for BUG(), since we have the file/line parameters
there. Any reason that's not passed down to trace2 in this case, instead
of calling trace2_cmd_error_va() which'll lose that information?

I.e. if you change your test to use GIT_TRACE2_EVENT you'll see that you
get an event like:

    {"event":"error"[...]"file":"usage.c","line":308,
    "msg":"the bug message","fmt":"the bug message"}

It seems that currently the only way to tell these error events apart
now is to hardcode those known usage.c line numbers on the consumer
side, unless I'm missing something.

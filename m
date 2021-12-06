Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBDC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 18:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhLFSrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 13:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347290AbhLFSrB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 13:47:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA36C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 10:43:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np3so8402592pjb.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vGgZIHqUde+3ZFrjDLzu6CqUr8cmlRgEZ8WYg/2lXho=;
        b=Unz+o9hS+mIkRx86WFdC7ZopVBszIKYqM/hUzYmg+svw4X8inLQLRMAPo3p0Mdkdx/
         v6b1a3VBFbAeNw+7UgRM5QlCDsVHl6QXUjoRPyJ84rOysvvhXGtr3nwvBG9uK10pi6hV
         PJJb8Fi3FILP2ufEh/bm4Po3Y8og5Tu573ZnL5qz/pHMQ194+IFwuQ/M67y2otma2Ryh
         QxUJv2WUtcp6m8K0A9e1Hi0psi9CQt+lBJcUjUxbr725Id0n195mLMsey7cx1Ud3i1VO
         8qv4wlUuT7HdmsvLzE6ZhHPuiCudmvOpUw0hP6dQQyY4i80zJJREaJnBzaA5aaoZGDIT
         sSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vGgZIHqUde+3ZFrjDLzu6CqUr8cmlRgEZ8WYg/2lXho=;
        b=5wS6fBn5h92b2OpsMtnPJ+ieHimV2EYnFtkcU0iGHVdq1/tRG4F1uzJmUu4oQkwdTG
         YNuFDukU+PNo7qW7dqJOfr2mSOz+UyrzHa/Y8lHPewedodrBBJJG0w/uHRTvY1On3ekE
         vmfw22DzzQCtSCsuIiG1hU1z9WwmGoOvq/kPguz6/uo8ru5inEgJbLt7BCSho4qLJJNL
         ZqA32x/MGj47hp0fKK/0/taNEZACA+HPK/U9/VwF/Ift3DDV1hpZXzm8dbxUk5rp652V
         QqRx6yjsGcRgk2oYDUN8nI8lmZUH2sZ3/NJ8643hBoEVVHwwJ4dkJijYxrUc134bcOtm
         sbpA==
X-Gm-Message-State: AOAM531U79uzZoYCrIMyBAn4yJShuJt1oLijMbuWL67f33L4as+IRJwh
        PlV5HsiE3lmQCzOSLhhDCEo=
X-Google-Smtp-Source: ABdhPJzbS6S0D0vwcDVCAOVCD0FxCILorvo3nvmAPPjuDa/bnr3racO64qXSl7iGQZOt8RJrp4DMsA==
X-Received: by 2002:a17:902:da8d:b0:142:4fa:9147 with SMTP id j13-20020a170902da8d00b0014204fa9147mr44730549plx.72.1638816211892;
        Mon, 06 Dec 2021 10:43:31 -0800 (PST)
Received: from localhost ([2620:15c:289:200:9206:9546:da97:4e9c])
        by smtp.gmail.com with ESMTPSA id h26sm10274111pgm.68.2021.12.06.10.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:43:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] common-main.c: call exit(), don't return
References: <patch-v1-1.1-6fedf9969b6-20211206T161001Z-avarab@gmail.com>
Date:   Mon, 06 Dec 2021 10:43:30 -0800
In-Reply-To: <patch-v1-1.1-6fedf9969b6-20211206T161001Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Dec
 2021 17:11:03
        +0100")
Message-ID: <xmqqzgpdfub1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the main() function to call "exit()" instead of ending with a
> "return" statement. The "exit()" function is our own wrapper that
> calls trace2_cmd_exit_fl() for us, from git-compat-util.h:
>
> 	#define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
>
> That "exit()" wrapper has been in use ever since ee4512ed481 (trace2:
> create new combined trace facility, 2019-02-22).
>
> This changes nothing about how we "exit()", as we'd invoke
> "trace2_cmd_exit_fl()" in both cases due to the wrapper, this change
> makes it easier to reason about this code, as we're now always
> obviously relying on our "exit()" wrapper.

Up to this point, this makes readers expect that the result would be
a simple patch

    diff --git i/common-main.c w/common-main.c
    index 71e21dd20a..f6b3a18c7f 100644
    --- i/common-main.c
    +++ w/common-main.c
    @@ -49,9 +49,5 @@ int main(int argc, const char **argv)
            trace2_cmd_start(argv);
            trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);

    -	result = cmd_main(argc, argv);
    -
    -	trace2_cmd_exit(result);
    -
    -	return result;
    +	exit(cmd_main(argc, argv));
     }

and that would have been justified quite well.  trace2_cmd_exit() is 
a thin wrapper around trace2_cmd_exit_fl and the whole thing amounts
to the same thing given how exit() is defined in compat-util as the
earlier part of the log message showed us.

>  Documentation/technical/api-trace2.txt | 9 ++-------
>  common-main.c                          | 9 ++++++---
>  t/helper/test-trace2.c                 | 8 ++++++--
>  trace2.h                               | 2 --
>  4 files changed, 14 insertions(+), 14 deletions(-)

So readers would naturally wonder why do we have all other changes.
Let's find out.

> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index bb13ca3db8b..568a909222a 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -828,16 +828,11 @@ Initialization::
>  ----------------
>  int main(int argc, const char **argv)
>  {
> -	int exit_code;
> -
>  	trace2_initialize();
>  	trace2_cmd_start(argv);
>  
> -	exit_code = cmd_main(argc, argv);
> -
> -	trace2_cmd_exit(exit_code);
> -
> -	return exit_code;
> +	/* Our exit() will call trace2_cmd_exit_fl() */
> +	exit(cmd_main(argc, argv));
>  }
>  ----------------

The comment above this hunk says

    == Example Trace2 API Usage

    Here is a hypothetical usage of the Trace2 API showing the intended
    usage (without worrying about the actual Git details).

    Initialization::

            Initialization happens in `main()`.  Behind the scenes, an
            `atexit` and `signal` handler are registered.

I doubt that "Our exit() does this, so trace2_cmd_exit() is not
necessary" sits well in that context.

> diff --git a/common-main.c b/common-main.c
> index 71e21dd20a3..eafc70718a5 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -51,7 +51,10 @@ int main(int argc, const char **argv)
>  
>  	result = cmd_main(argc, argv);
>  
> -	trace2_cmd_exit(result);
> -
> -	return result;
> +	/*
> +	 * We define exit() to call trace2_cmd_exit_fl() in
> +	 * git-compat-util.h. Whether we reach this or exit()
> +	 * elsewhere we'll always run our trace2 exit handler.
> +	 */
> +	exit(result);
>  }

This is good; the new comment is also good.

> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> index f93633f895a..9954010bc89 100644
> --- a/t/helper/test-trace2.c
> +++ b/t/helper/test-trace2.c
> @@ -262,8 +262,12 @@ static int print_usage(void)
>   *    [] the "cmd_name" event has been generated.
>   *    [] this writes various "def_param" events for interesting config values.
>   *
> - * We further assume that if we return (rather than exit()), trace2_cmd_exit()
> - * will be called by test-tool.c:cmd_main().
> + * It doesn't matter if we "return" here or call "exit()", since our
> + * "exit()" is a wrapper that will call trace2_cmd_exit_fl. It would
> + * matter if we bypassed it and called "_exit()". Even if it doesn't
> + * matter for the narrow case of trace2 testing, let's be nice to
> + * test-tool.c's "cmd_main()" and common-main.c's "main()" and
> + * "return" here.
>   */

Hmph.  While nothing is technically incorrect in the new text, I
think small fixup to the original should suffice.

    We return from here and let test-tool.c::cmd_main() pass the
    exit code to common-main.c::main(), which will use it to call
    trace2_cmd_exit().

There is nothing gained by saying "we assume it is OK to do this"
when "we do this" is enough.  "it does not matter if we did this
or did this some other way, but we chose this because" is something
you'd want in the log message but not here.

>  int cmd__trace2(int argc, const char **argv)
>  {
> diff --git a/trace2.h b/trace2.h
> index 0cc7b5f5312..73876781294 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -110,8 +110,6 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv);
>   */
>  int trace2_cmd_exit_fl(const char *file, int line, int code);
>  
> -#define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
> -

This is documented in Documentation/technical/api-trace2.txt and I
do not think the proposed update in this patch is a good idea, which
makes it better to keep this #define here.

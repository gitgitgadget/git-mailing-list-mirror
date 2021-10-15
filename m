Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C54C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9672261151
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbhJORSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbhJORR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:17:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D9C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:15:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so9798046pjb.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NOlneyiEzHirV7DcJdh7wgrEOQvSo16rG0XjsIAoXHQ=;
        b=Bna6J8vMhhzgWwqDmIiV3dV92E3SHuTQrdZ3IOVYyBP5uhufpGyv4h9sxQ9VoLkXQ1
         dhhcvQnXcgJBKTeXQvijSly/Mvl95AoDMaGtIiqLNhAwD+kffGskmc3IEd5x5gIOXAqC
         jvCWXiSogAlH6UHwFuPoZtEuetEgO0SEuLbWow1TSIaPEmfXxqokwrl7Bver4CjhnkBn
         Kmpt100avfUVPNVZWNLGJwNTDyIROSR0qQmDio4s7lFJlnrYGDU47UsNfXGojQGlscwk
         Yth+C2Wqs6CVU344IQ7qkTheOQqfJGd1okEw7pUJjcqz2ziH8QeH8j9wB9QpoeWxdUvE
         Jfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NOlneyiEzHirV7DcJdh7wgrEOQvSo16rG0XjsIAoXHQ=;
        b=OxkBJIiWy9ygTOjxO/yT3N2mN2xwha2oqjwvnZ/6F9o1rCEW3uUSogwWRBkl4JlWhA
         +kZXCXiwTK5D5F035JakG3Hm6ZsPL3eypx7GiegYAishEJNcc/R5w/RsgvVCmn/p8CpB
         qaEjAu21gcNvsm/XGcRMC47hNXbsQbqnRDa07KDLeTQvrLEM81He/+K813H8geQoelVa
         guy4rWX5hnUyZuIwPQscF9nS4ph0aaiy7Sa2TRvXyPOAXXftRbhsWc8+2vrV57QVoWl7
         u1eZSxJVPdf8p2k2R2qFVYtGBs5AxQBVbdSr6l/ko+3fjj4CRDrgU9SFwZNVGjxIKMbx
         q5Fw==
X-Gm-Message-State: AOAM532MwO/exKqhA/KPjELd9Lv58JInoOoHn/gMDL93C8QFzzn8pFr7
        97GJNoLfv7MIulxuPut5xW+yNg==
X-Google-Smtp-Source: ABdhPJzXiu/tnQ9MrsPIcdylPZWPuMYceDlm8d6k56Hxq7CzdUbfP8f85kt3FjEI9xT61vBDyX2dnQ==
X-Received: by 2002:a17:90a:4681:: with SMTP id z1mr15224465pjf.113.1634318149175;
        Fri, 15 Oct 2021 10:15:49 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id h3sm5655891pfr.98.2021.10.15.10.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:15:48 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:15:43 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 10/13] commit: convert {pre-commit,prepare-commit-msg}
 hook to hook.h
Message-ID: <YWm3P5EqiE4hYrJr@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-10.13-dc31d98acdf-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-10.13-dc31d98acdf-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 11:43:38AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Move these hooks hook away from run-command.h to and over to the new
> hook.h library.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Very straightforward.
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  commit.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index 551de4903c1..4e7cbd7585d 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -21,6 +21,7 @@
>  #include "commit-reach.h"
>  #include "run-command.h"
>  #include "shallow.h"
> +#include "hook.h"
>  
>  static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
>  
> @@ -1700,22 +1701,22 @@ size_t ignore_non_trailer(const char *buf, size_t len)
>  int run_commit_hook(int editor_is_used, const char *index_file,
>  		    const char *name, ...)
>  {
> -	struct strvec hook_env = STRVEC_INIT;
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>  	va_list args;
> -	int ret;
> +	const char *arg;
>  
> -	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
> +	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
>  
>  	/*
>  	 * Let the hook know that no editor will be launched.
>  	 */
>  	if (!editor_is_used)
> -		strvec_push(&hook_env, "GIT_EDITOR=:");
> +		strvec_push(&opt.env, "GIT_EDITOR=:");
>  
>  	va_start(args, name);
> -	ret = run_hook_ve(hook_env.v, name, args);
> +	while ((arg = va_arg(args, const char *)))
> +		strvec_push(&opt.args, arg);
>  	va_end(args);
> -	strvec_clear(&hook_env);
>  
> -	return ret;
> +	return run_hooks_oneshot(name, &opt);
>  }
> -- 
> 2.33.1.1338.g20da966911a
> 

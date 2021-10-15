Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F76C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E87B61181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbhJOQ0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbhJOQ0x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:26:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5996BC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:24:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i5so470030pla.5
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/L6YEWCMYSdQZo/jqH0WJzino/bOYMGM2PlQrSHJDjk=;
        b=Z0CVyGvtmYB6nR3BG/3BGJDNca35gQ8Jrrk6LsM2DNXOpVHx1g0WzQSEcdMEBRymvf
         jIyNYTqHwK30l/ic/xtgIbpjUHw8C8dCotOfUuIgblmmSXRU5c39evilrm6oi6eXw+V+
         TsDAHfVMiya1mJ0+TVPp9xCxhkwd41zcDngYXyQ0h0vGwx9o68uiuz+o//H+374U3Ivk
         6+DS4xagekUMPT5K5v08d5xT8LOaNlfdz8UHv0P8DNIhPwf7pHcoOz3JPj72nyxTdwGq
         Oz9NT82V3V0n49NJuBdISfHFondTwyQb074iJrglSwJU25pwEJyb3lVNwiSsoFa5mdxC
         D08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/L6YEWCMYSdQZo/jqH0WJzino/bOYMGM2PlQrSHJDjk=;
        b=krdR9T6zGSRCM+wrAXMst5oZMh3xxljpfZKUGgy/LL7YoxbauQykSARfobD2fR4+jE
         bGSS2lbJNUGqUSohARu3/OpdvUX/udc5pblS6HUiae88CrG97o02U9R24zkWevgLCV11
         NhIjDUwm7gc4sGIvGTYJTX1blj6uZRJXyv58Z21ojpdfmowQxMpusAi1l+rbP7X49Lk6
         KwN13FbExLYqK5xQbKB8/7BDAX+j2UF7IsMYeh1QLS5IbI43s8HSLSk3OHenhVCRpKXM
         RoD/fDJ2FaiSSCZkAhplewk49b+P5RG2lLBIvnyRt5j8TMVsE0DGnpFV4OyQZ7cq9k7K
         N3Ww==
X-Gm-Message-State: AOAM5327FWaIKG4CvLFiCmp30WkXm4aq+GE4NI2RQBRIK+x6lGOFFV+Y
        85iRhTwvSQSudjj53uF7o2Mwvw==
X-Google-Smtp-Source: ABdhPJxk4gp7pzk2vdsIKxIVk+woV37CSOdmWjvoP3M/6a704cGAvHrGRvhhGFBxGygfXd0wm4T6XQ==
X-Received: by 2002:a17:90a:c594:: with SMTP id l20mr28055182pjt.223.1634315085674;
        Fri, 15 Oct 2021 09:24:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id h13sm4870675pgf.14.2021.10.15.09.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:24:45 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:24:40 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 02/13] gc: use hook library for pre-auto-gc hook
Message-ID: <YWmrSAGTwM0Of/oZ@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-02.13-e3dc0aed81b-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-02.13-e3dc0aed81b-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:30:27PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Move the pre-auto-gc hook away from run-command.h to and over to the
> new hook.h library.
> 
> To do this introduce a simple run_hooks_oneshot() wrapper, we'll be
> using it extensively for these simple cases of wanting to run a single
> hook under a given name, and having it free the memory we allocate for
> us.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/gc.c |  3 ++-
>  hook.c       | 20 ++++++++++++++++++++
>  hook.h       | 13 +++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6b3de3dd514..95939e77f53 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -32,6 +32,7 @@
>  #include "remote.h"
>  #include "object-store.h"
>  #include "exec-cmd.h"
> +#include "hook.h"
>  
>  #define FAILED_RUN "failed to run %s"
>  
> @@ -394,7 +395,7 @@ static int need_to_gc(void)
>  	else
>  		return 0;
>  
> -	if (run_hook_le(NULL, "pre-auto-gc", NULL))
> +	if (run_hooks_oneshot("pre-auto-gc", NULL))

I like that the oneshot gives us such a simple replacement for run_hooks_le.

>  		return 0;
>  	return 1;
>  }
> diff --git a/hook.c b/hook.c
> index 240270db64e..bfdc79e2f1a 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -141,3 +141,23 @@ int run_hooks(const char *hook_name, const char *hook_path,
>  
>  	return cb_data.rc;
>  }
> +
> +int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
> +{
> +	const char *hook_path;
> +	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
> +	int ret = 0;
> +
> +	if (!options)
> +		options = &hook_opt_scratch;
> +
> +	hook_path = find_hook(hook_name);
> +	if (!hook_path)
> +		goto cleanup;
> +
> +	ret = run_hooks(hook_name, hook_path, options);
> +cleanup:
> +	run_hooks_opt_clear(options);
> +
> +	return ret;
> +}

Reasonable enough - lookup, run, cleanup. Thanks.

> diff --git a/hook.h b/hook.h
> index 111c5cf9296..a2b8d4fc6bd 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -49,7 +49,20 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
>  /**
>   * Takes an already resolved hook found via find_hook() and runs
>   * it. Does not call run_hooks_opt_clear() for you.
> + *
> + * See run_hooks_oneshot() for the simpler one-shot API.
>   */
>  int run_hooks(const char *hookname, const char *hook_path,
>  	      struct run_hooks_opt *options);
> +
> +/**
> + * Calls find_hook() on your "hook_name" and runs the hooks (if any)
> + * with run_hooks().
> + *
> + * If "options" is provided calls run_hooks_opt_clear() on it for
> + * you. If "options" is NULL the default options from
> + * RUN_HOOKS_OPT_INIT will be used.
> + */
> +int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
> +
>  #endif
> -- 
> 2.33.0.1567.g7b23ce7ed9e
> 

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

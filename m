Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EABEC4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E5860EB5
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhGVVRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhGVVRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 17:17:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E9AC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:58:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e10so999884pls.2
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R9efw6/4IJuLMVlFNm5p2l8hZF/Eb0cYKT1oM/u3tyk=;
        b=oM457bVXZyL6CwSKeLjD7Pwk1nIeKM84boCBsV+HwEr0INei4SNr0zO8TmO0eBfQMq
         fVszVQhp3AHEQv06FSoyp47yvH53lhF/GtviMV26LfLQoTWwJHl0k+WskoIHfHzg2XHO
         eoL6t5Pe1tBj1/6a4+UrSpJNMtcC30g5z9Pyb1hYt1TgYJS66hwMvOnw3F/iAyBc1KVz
         vLL8frayObRB0MQMUi81kpOrwZllLd5ppuzJrEY/mc9EYuNMJAMh1KbVnWTb54svb98D
         xhSfqit7+MkPv6DtpeNHLrBUH/2EYcrzyXzb1688JOr7TKHUhDLICnGxycAfZI8LYSfm
         frlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R9efw6/4IJuLMVlFNm5p2l8hZF/Eb0cYKT1oM/u3tyk=;
        b=GN6ac40vMpxM1m0iJGUdGS0VF1pvCG5qIqOxy49jdoF/QhWScZy+AB+8zDbhujN5ak
         grfnrDaWksrsUet/Z9va7Kn5faQ6PyIKl4EzjVllxf18gJuDsHKjcFAROydakbVat8KH
         OE9J/G1qZV60c63fH0tz9fV99hgvgmprkCruJhgrW2l4GwRLolBcYZPEPTnhsgdw/Ity
         98/lznlZQgjaCL9FVYyJbw9utRmZYILqQwdk1nQpBEmUoNZUWz8plLieAX57cTR+uMBM
         ZLGouhG7BcJx8J8uz0YIN5HSib/6T6KWtaIXVgZTOaU2/5CpU0u8n7+rVH+nbQheUvtX
         Yh7A==
X-Gm-Message-State: AOAM532wRKYyr5cz4W1rtudLRtxMceJghyN4dYnL2AojV41DtDHB9PBW
        /BtYQdhh+Gye6poGXKHDyGrUmQ==
X-Google-Smtp-Source: ABdhPJz2chZ/GWvp9ga6B5YEhCvcZHUHN+qb4Mi+EjCKHvA0n7V09EfD8r3T/nfWj82WVvw8msIskw==
X-Received: by 2002:a63:234c:: with SMTP id u12mr1931245pgm.345.1626991087854;
        Thu, 22 Jul 2021 14:58:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c03:6226:e12f:afc9])
        by smtp.gmail.com with ESMTPSA id a16sm30070824pfo.66.2021.07.22.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:58:07 -0700 (PDT)
Date:   Thu, 22 Jul 2021 14:58:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 02/27] gc: use hook library for pre-auto-gc hook
Message-ID: <YPnp6akn9bfxGlnG@google.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <patch-02.27-7209f73f28-20210617T101217Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-02.27-7209f73f28-20210617T101217Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 12:22:36PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Using the hook.h library instead of the run-command.h library to run
> pre-auto-gc means that those hooks can be set up in config files, as
> well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

This one is a good example of an issue Junio pointed out to me in an
earlier iteration - since the strvecs in run_hooks_opt need to be
cleared, you need to be careful with exiting without running
run_hooks_opt_clear(). need_to_gc() can exit before running the hook in
some cases.

 - Emily

> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/gc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index f05d2f0a1a..a12641a691 100644
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
> @@ -348,6 +349,8 @@ static void add_repack_incremental_option(void)
>  
>  static int need_to_gc(void)
>  {
> +	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
> +
>  	/*
>  	 * Setting gc.auto to 0 or negative can disable the
>  	 * automatic gc.
> @@ -394,8 +397,11 @@ static int need_to_gc(void)
>  	else
>  		return 0;
>  
> -	if (run_hook_le(NULL, "pre-auto-gc", NULL))
> +	if (run_hooks("pre-auto-gc", &hook_opt)) {
> +		run_hooks_opt_clear(&hook_opt);
>  		return 0;
> +	}
> +	run_hooks_opt_clear(&hook_opt);
>  	return 1;
>  }
>  
> -- 
> 2.32.0.576.g59759b6ca7d
> 

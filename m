Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BD4C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiAGV4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiAGV4W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:56:22 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04190C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 13:56:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v13so6237706pfi.3
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 13:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jtwLp8SXbFmlapGut8DUk3nfGuAGQPAojGrAuf5PzPs=;
        b=XanJ9iSfP3j9qGLXcWwn28SHj37SsS9CnuaFLaCXfWjoeovLxucfuHIWj5WlE4vWxU
         I1ILhtd0+L3iE0CCsbea/heq9xlHpXBSvakhOxN+gnhOggIq78q0P8qJ0PTYHp2qfWXi
         SfDgDqtoMxGiP3a7gn9mcJru20Q76Gs1RAfMVdGQulwnAyXEVGRAcbBy64SmABxPkkNn
         ChlF1JSYQjeKEi64NL5TF9xRGG8q8Jsn57sPtsKw0Bq8W81kF3eMw34u6qzB3e1uiMSN
         ZiLi3d3vKOPymV8wFVgpnK1AMKbM1T3lA6kzuksYA3nrjoQVWXVtRoyPcoo3mobhxQ71
         Zm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jtwLp8SXbFmlapGut8DUk3nfGuAGQPAojGrAuf5PzPs=;
        b=ru1+hFbjPG2R0a3k/NZfXiO1Xc2oiyGNoy0X5Y7x5J+1TbJv7sRgHRT0nePHB6C8mI
         AfW0p5HWnteHfUXRob6tHWAfg5127yLyV0XcLje2o+Jmr79WcETm2EgwJmpJfzOxd1Mh
         8B+CmjKDBlwj+Fiq2Nryr4CORsGUGxugWMxkqryzi1K4NfuQ3UUBXvGDjxpLcsMPS1XB
         7/cCQtKAd3IvPYuvv2kXaYlyQE+aBVlPNLu3u5CV9yf4iEdDuq0aYABHSIiveG7Yap9I
         wln/Lr+C2uc9KfzFHqqDDDWAkTeo2HLc1FBD1onA+t7DsFzgPlKzGCj7rmt3c6JujiEI
         f+gQ==
X-Gm-Message-State: AOAM530IjHgowDjGfLSRU2E4zXw+YYjXPYhpLCnpLc19PUyS6NO6/7iA
        rcZWtxSQNFmoq4zHfWEAE2UZgA==
X-Google-Smtp-Source: ABdhPJyYO8fjocfBiBHcXAxdBJkEOTcRXzVE4MbvtUhotpgiIA8yWdPFOkCq0VbaPZrzXqeE5L0aUw==
X-Received: by 2002:aa7:88ce:0:b0:4ba:efec:39e0 with SMTP id k14-20020aa788ce000000b004baefec39e0mr66531287pff.80.1641592581306;
        Fri, 07 Jan 2022 13:56:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:3205:d63a:54aa:9c9d])
        by smtp.gmail.com with ESMTPSA id w6sm5177229pga.25.2022.01.07.13.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:56:20 -0800 (PST)
Date:   Fri, 7 Jan 2022 13:56:15 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 05/17] hook API: add a run_hooks_l() wrapper
Message-ID: <Ydi2/89zaLnsFc/Y@google.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
 <patch-v6-05.17-d6162fbef80-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-05.17-d6162fbef80-20211222T035755Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 04:59:31AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> Add a run_hooks_l() wrapper, we'll use it in subsequent commits for
> the simple cases of wanting to run a single hook under a given name
> along with a list of arguments.

I've got a slight allergy to varargs, just as personal preference, but
there's no denying that this makes the following callsite conversions
extremely mechanical and easy to review.

Does this calling convention make it easier for us to try and inline
results from something like oid_to_hex(), which may become stale,
compared to needing to put together a struct with args? I think probably
it's fine - because strvec_push() creates a copy, and run_hooks_l() is
not something we'd want to call multiple times in parallel (I hope).

Anyway,
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  hook.c | 14 ++++++++++++++
>  hook.h | 10 ++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/hook.c b/hook.c
> index d67a114e62d..1ad123422b2 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -149,3 +149,17 @@ int run_hooks(const char *hook_name)
>  
>  	return run_hooks_opt(hook_name, &opt);
>  }
> +
> +int run_hooks_l(const char *hook_name, ...)
> +{
> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> +	va_list ap;
> +	const char *arg;
> +
> +	va_start(ap, hook_name);
> +	while ((arg = va_arg(ap, const char *)))
> +		strvec_push(&opt.args, arg);
> +	va_end(ap);
> +
> +	return run_hooks_opt(hook_name, &opt);
> +}
> diff --git a/hook.h b/hook.h
> index 9c358789958..54528395953 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -54,4 +54,14 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
>   * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
>   */
>  int run_hooks(const char *hook_name);
> +
> +/**
> + * Like run_hooks(), a wrapper for run_hooks_opt().
> + *
> + * In addition to the wrapping behavior provided by run_hooks(), this
> + * wrapper takes a list of strings terminated by a NULL
> + * argument. These things will be used as positional arguments to the
> + * hook. This function behaves like the old run_hook_le() API.
> + */
> +int run_hooks_l(const char *hook_name, ...);
>  #endif
> -- 
> 2.34.1.1146.gb52885e7c44
> 

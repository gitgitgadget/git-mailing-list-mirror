Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5111C4708D
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 00:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLHAHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLHAHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 19:07:01 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE6633F
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 16:07:00 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u6-20020a170903124600b00188cd4769bcso20518628plh.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=USGIckYu294BvBuJPWGz5yfwvA3JeYnEwnZOxPLSDmc=;
        b=MKtZl7p98rLvL5ci4JBmTKnFJWvTXzSjYztqijA1NZN3EoGMofbLruSDKrUZx/Q4QW
         SRULJzcTboY1oq/Nikmd3pA2EtB0Jel+VmvGH/ZdXENDf8kQRRE3SeTRIJYbPhRz9NTG
         95Ui98Cn7oxp/uTNH4n7P2QISqc/7P8MjysQ5UP9hosnLA1q2xJ6vQh5zFfdBSq/cbt1
         FVK49zaUGCatPYN5qmS9wqQyLis3fmbpBmA1LZTmZRFPvcH7i/22gSNJxvOtmbI16Tdf
         HrLxEz20ShQQvuX0pv/UKW0ooE0q2QywxoDYXUGGvaPesIqvSUwF8xUx16DOMfhIG5NW
         1qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USGIckYu294BvBuJPWGz5yfwvA3JeYnEwnZOxPLSDmc=;
        b=GZk/m7frZsn9mMhXRLLypoGBVl3xa1BEveCRJK7AQezCgQiEGQSCrUu9XSBb9dmJT1
         wnd2TkY/DjbSGaP7y6gM+WVUrQmvf08EHuoeUU9jDCXQmaBqfSft78qsuKg4kX9TBulp
         OG619GR3jNHebIJxmYL4TgbnLiDfJCLyL3y9Oi2vXw8Ro9dXrso9DvZi/B1J4OhUVjjy
         A0GKJbo8+Q17goqG+J+Lyw/eyyPq2Zt/efZpa1YBcIWNyy9GXIIrHZZZz9Vq7i1PoYhu
         GNlt+Am6uRTcmgp85NJ3Y3RuguBMFILJPG8rwlssl+O1JqrOVFCWNP8Ma33U8wEZrZMA
         H76w==
X-Gm-Message-State: ANoB5pkU2lgg+RkoXngLNR2O0LdcOmTF+7PH4fSHSQCzCnbLJl9yStmp
        dPku34/rLP3wmat9EfGh0XDF8NwMTnEAtg==
X-Google-Smtp-Source: AA0mqf7I8ZpUgMTNUkvzvkebQbVygybsfxiMM4iKVM/czOAujI0Sdwuf0+y1Nf1a7FfLRxrbJuclj3J9S+f0Yw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:4308:b0:575:649c:e9e3 with SMTP
 id cb8-20020a056a00430800b00575649ce9e3mr44064786pfb.48.1670458020394; Wed,
 07 Dec 2022 16:07:00 -0800 (PST)
Date:   Wed, 07 Dec 2022 16:06:58 -0800
In-Reply-To: <20221127093721.31012-2-sorganov@gmail.com>
Mime-Version: 1.0
References: <20221127093721.31012-1-sorganov@gmail.com> <20221127093721.31012-2-sorganov@gmail.com>
Message-ID: <kl6lfsdqep25.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 1/5] diff-merges: implement [no-]hide option and
 log.diffMergesHide config
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> @@ -49,10 +49,11 @@ ifdef::git-log[]
>  --diff-merges=m:::
>  -m:::
>  	This option makes diff output for merge commits to be shown in
> -	the default format. `-m` will produce the output only if `-p`
> -	is given as well. The default format could be changed using
> +	the default format. The default format could be changed using
>  	`log.diffMerges` configuration parameter, which default value
>  	is `separate`.
> ++
> +	`-m` is a shortcut for '--diff-merges=on --diff-merges=hide'
>  +

I found this description difficult to parse, since

a) it wasn't clear that multiple "--diff-merges" would all be respected
b) I had to read the --diff-merges=hide documentation to understand what
   this means

Keeping the plain english description would help, something like:

  `-m` only produces the output if `-p` is also given, i.e. it is a
  shortcut for '--diff-merges=on --diff-merges=hide'.

> diff --git a/builtin/log.c b/builtin/log.c
> index 56e2d95e869d..e031021e53b2 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -581,6 +581,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  	}
>  	if (!strcmp(var, "log.diffmerges"))
>  		return diff_merges_config(value);
> +	if (!strcmp(var, "log.diffmergeshide"))
> +		return diff_merges_hide_config(git_config_bool(var, value));
>  	if (!strcmp(var, "log.showroot")) {
>  		default_show_root = git_config_bool(var, value);
>  		return 0;

Since we have log.diffmergeshide that is different from log.diffmerges,
it seems like it would be more consistent to have '--diff-merges-hide'
as a separate flag.

> @@ -69,6 +87,10 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
>  {
>  	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
>  		return set_none;
> +	if (!strcmp(optarg, "hide"))
> +		return set_hide;
> +	if (!strcmp(optarg, "no-hide"))
> +		return set_no_hide;
>  	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
>  		return set_first_parent;
>  	if (!strcmp(optarg, "separate"))
> @@ -105,7 +127,19 @@ int diff_merges_config(const char *value)
>  	if (!func)
>  		return -1;
>  
> -	set_to_default = func;
> +	if (func == set_hide)
> +		hide = 1;
> +	else if (func == set_no_hide)
> +		hide = 0;
> +	else
> +		set_to_default = func;
> +
> +	return 0;
> +}

The code is also simpler if we took a separate CLI flag, e.g. we could
get rid of this special casing of "(func == X)".

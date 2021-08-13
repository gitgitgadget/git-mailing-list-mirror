Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6047C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873F060F00
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhHMJjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbhHMJjm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 05:39:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A7C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:39:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q3so10428411edt.5
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W+243FyVjkVvKCgBZ+7O/rfmAIIpghm8psaF7P2MIJQ=;
        b=RXQgtqvFFRkn7qF6FqbjYM5Pr5+sHKv8I7A0m28CtXrSgDAT48HAhhxBATl2RHX3Gw
         cgw5ieumDFgEVdpVKZhC7tdOUv250hkZO0poHiqspaRts5Vlq80kh71pTrVV7ux6EBkL
         oFc0dzoMZ3dzkPTb3gSvZ6NVOCWp8LZgeoU1AUPMsxBLdGDQu/5sg0ST0+wWXNGJX9xl
         oNeFLMbGs7zD6W9QlYRI59CHPxv90ZhA7lQt9H2ahPIwukgjf+tXTudWA0zDuGHVBu86
         w9mypY/0zcCe2CB8wfDtp9oBea6nxwPOUMLxzeAmoHr3OsxvFGcs7IvZG7CKlvsHvrRN
         dZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W+243FyVjkVvKCgBZ+7O/rfmAIIpghm8psaF7P2MIJQ=;
        b=oQ0doxtl3IjCfPFxndO831orjtTa9msTj9nV6rSY4SjNgVgLR0cXqAiMmGfPnjkp/A
         kcRtQ3s/njxBHa0agXbXqJnmP6n15hH02rRwZlzQd4BUa+pcDCLIpSFQ8ClvSOfCNITI
         04yj+4OCUMWSFxpPcUzzdvAMTWaX7C2TnFI6pq67ASWACrqslUze+nVIyKtruWYgTrU1
         6OW8qLMphhk610FKYGqgc3OKgLcJSIvIZuGeAl0soBzN4ZIVgvLjJjogHqU3o7bdgGmv
         5uIaw17ZdklBbvBToxDUnqESLUoVp3LzyxfY7soN4sXTz6Er0xRHcHAu2zBX6+A/1Mdu
         h2qw==
X-Gm-Message-State: AOAM5312vGvO6Zwi96PzbjXfd1onlgVZ9Wdmi2htZowPCfTyr+EtFcK0
        5sVD/9V3FZ8ByQG0rKj1yZo=
X-Google-Smtp-Source: ABdhPJxako68kq2CcKsR4BIcJkbAMhdquYpADnzJ1DFhv86/B7lR2vE2zJckYaD7kz7SMIVGMbMeeA==
X-Received: by 2002:aa7:ce96:: with SMTP id y22mr1937230edv.115.1628847554826;
        Fri, 13 Aug 2021 02:39:14 -0700 (PDT)
Received: from szeder.dev (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id ck17sm607487edb.88.2021.08.13.02.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 02:39:14 -0700 (PDT)
Date:   Fri, 13 Aug 2021 11:39:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, emaste@FreeBSD.org
Subject: Re: [PATCH] ci: update freebsd 12 cirrus job
Message-ID: <20210813093909.GA3866771@szeder.dev>
References: <20210812202200.82465-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812202200.82465-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 01:22:00PM -0700, Carlo Marcelo Arenas Belón wrote:
> make sure it uses a supported OS branch and uses all the resources
> that can be allocated efficiently.
> 
> while only 1GB of memory is needed, 2GB is the minimum for a 2 CPU
> machine (the default), but by increasing parallelism wall time has
> been reduced by 35%.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  .cirrus.yml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index c2f5fe385a..e114ffee1a 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -2,8 +2,15 @@ env:
>    CIRRUS_CLONE_DEPTH: 1
>  
>  freebsd_12_task:
> +  env:
> +    GIT_PROVE_OPTS: "--timer --jobs 10"

Why these prove options?

On other CI systems we pass 'prove' the option
'--state=failed,slow,save' as well to reduce runtime.  However, this
only works when there is a persistent place for prove's state files,
e.g. the cache feature of Travis CI.  If Cirrus CI lacks a similar
feature, then we can't benefit from this option, but it'd be worth
mentioning in the commit message.

> +    GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"

Why these test options?

chain-linting is done by a mighty sed script; I think it's worth
running it with FreeBSD's 'sed' as well.

Quoting 't/README', '--no-bin-wrappers' "can speed up test runs
especially on platforms where running shell scripts is expensive".  Is
running shell scripts really that expensive on FreeBSD?

OTOH, why are there no options that would show us some information
about test failures, i.e. why no '--verbose-log -x --immediate' like
on other CI systems?

> +    MAKEFLAGS: "-j4"
> +    DEFAULT_TEST_TARGET: prove
> +    DEVELOPER: 1
>    freebsd_instance:
> -    image: freebsd-12-1-release-amd64
> +    image_family: freebsd-12-2
> +    memory: 2G
>    install_script:
>      pkg install -y gettext gmake perl5
>    create_user_script:
> -- 
> 2.33.0.rc1.379.g2890ef5eb6
> 

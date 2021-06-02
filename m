Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC66EC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE906102A
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFBBQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 21:16:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FFBC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 18:14:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l1so893424pgm.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 18:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JbNYEpPTmt2lAak2fDnlgNgDiD4fdcTtxxRPhHC/BdI=;
        b=hDVRSjb+9OAVx7hh7yOM67BldpGvzBHDRRE/xt0PoPOu9wKNym7WR1g9qjxzAM/I9c
         FuwOnhcOzCrnmc15M6JdVmAu+nhsa/bBFIr3/Omkl36tUPXso7dTsw/Pz8ka7eVfnRh8
         JWaRTBPoebWEhoew7OAy3tD5LmYefdeH0ucWrr1PuavoAc69s0HxDbglbJ+22lvaCEVw
         s0wNgroK4irhxeBllJnlHMK1VJOCIoHvJB5ULOnjo2wNM3mzdLjiE61e6I7ZOMb31kqn
         4Iph9fZyIxeuZss3bfN0ah5RUOTafZ5uHZeVBQf15XEMRBm5sOolIVxRYPiO3geRGZ8/
         khnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JbNYEpPTmt2lAak2fDnlgNgDiD4fdcTtxxRPhHC/BdI=;
        b=UmQMYOUfVxxZRQP+8T+RCUbh/epnBwL+udSf/ESEcEVAhHcV4s64X6D/TwCAUuk2fC
         CoXIzZOzie7517nXHYl9Ouq0G5pdTS8nF9Cn/gWhKHIF6jhn+YGSw/AODQMWEsQVf5G+
         jXawSYx7zwn6GTc1cDzl+xlmY2j5c4ZtJ1xu6zyBHm4CVdoywogVLEFbykvWuEiP/Rlt
         TBPp+/Wja3XhaSm/9k0x23+h4fLwm4nOATAGfxIJ/BqHys7qvDQxNkqH6DPUvw6t83ob
         kr0JP6C68U0c+beDCignvHYJRj5LrvETBjdJMFllxKxoYa5pTF+jBhY3EbdceeJSzYfs
         fMxg==
X-Gm-Message-State: AOAM530qMC4ZWSyirkc6l9iVZHxB7ouSLEWft6KGyYMYQaNpstrZjdX8
        FzRAjp/e9yjyt5lqgZt4KHM=
X-Google-Smtp-Source: ABdhPJwbfnw78zfiJpbpBYodPTqRnRDWHExorXBjrlKOtmeWia0oGaZk/OIbzCFXqoZ4/6k8G1ewvw==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr12054267pgp.292.1622596492763;
        Tue, 01 Jun 2021 18:14:52 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id t14sm13397479pfg.168.2021.06.01.18.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 18:14:51 -0700 (PDT)
Date:   Wed, 2 Jun 2021 08:14:49 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
Message-ID: <YLbbifC5dt5TsIPl@danh.dev>
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602001132.459705-1-rybak.a.v@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-02 02:11:32+0200, Andrei Rybak <rybak.a.v@gmail.com> wrote:
> Config variables feature.experimental and feature.manyFiles are grouped
> together under "feature.*".  However, this is not easily visible when
> scanning the help page of git-config.

Skimming over Documentation, only "advice.*" does grouping and
indenting, however, "advice." part is being skipped there. 

I don't know what is the preference.

-- Danh

> 
> Indent the descriptions of individual feature.* config variables to help
> the reader distinguish this group of variables.
> 
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  Documentation/config/feature.txt | 40 +++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index cdecd04e5b..2c4dee170b 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -3,24 +3,26 @@ feature.*::
>  	a group of other config settings. These groups are created by the Git
>  	developer community as recommended defaults and are subject to change.
>  	In particular, new config options may be added with different defaults.
> -
> -feature.experimental::
> -	Enable config options that are new to Git, and are being considered for
> -	future defaults. Config settings included here may be added or removed
> -	with each release, including minor version updates. These settings may
> -	have unintended interactions since they are so new. Please enable this
> -	setting if you are interested in providing feedback on experimental
> -	features. The new default values are:
>  +
> -* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
> -skipping more commits at a time, reducing the number of round trips.
> +--
> +	feature.experimental::
> +		Enable config options that are new to Git, and are being considered for
> +		future defaults. Config settings included here may be added or removed
> +		with each release, including minor version updates. These settings may
> +		have unintended interactions since they are so new. Please enable this
> +		setting if you are interested in providing feedback on experimental
> +		features. The new default values are:
> +	+
> +	* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
> +	skipping more commits at a time, reducing the number of round trips.
>  
> -feature.manyFiles::
> -	Enable config options that optimize for repos with many files in the
> -	working directory. With many files, commands such as `git status` and
> -	`git checkout` may be slow and these new defaults improve performance:
> -+
> -* `index.version=4` enables path-prefix compression in the index.
> -+
> -* `core.untrackedCache=true` enables the untracked cache. This setting assumes
> -that mtime is working on your machine.
> +	feature.manyFiles::
> +		Enable config options that optimize for repos with many files in the
> +		working directory. With many files, commands such as `git status` and
> +		`git checkout` may be slow and these new defaults improve performance:
> +	+
> +	* `index.version=4` enables path-prefix compression in the index.
> +	+
> +	* `core.untrackedCache=true` enables the untracked cache. This setting assumes
> +	that mtime is working on your machine.
> +--
> -- 
> 2.31.1
> 

-- 
Danh

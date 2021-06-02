Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E65C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01BB6101C
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 23:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFBXFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBXFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 19:05:47 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CDCC06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 16:04:04 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso954914oow.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=46l6bcsmL7gkcUWuZBPeDFlwBG6KKMUABlNmZJu/lGk=;
        b=MINhQYig0KOf7KIo/Ry2WK62n7fj8a63LpreQjGPhKd09OWPEd6B7Tww90gnWzMK9f
         hksSeYZO39s7avbAcYxsd5krzQpVIAAqr7LVl29gcQOZ8300XCqpWZTQ/AjqUi/AyBie
         IgWhbW6hxVXfeshI+fBd8e5u551sCUsb3+j09Jdy1pFJwafT3EsotGFyFTcKfDL6aYrt
         gQ4KYcpAHuU7Jmo3CFFDwOMYrF5xb697VoLN6tn+BruOUDcTmmjud0/PeO1E/DSAwgAT
         OCJg3XK5+wKM1tIjG6PbZpr93mhgf2lqF8LTeWnvnRgHkNDStrns5icwakYa3W9wIdP1
         QBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=46l6bcsmL7gkcUWuZBPeDFlwBG6KKMUABlNmZJu/lGk=;
        b=seJVqIH393m+stJ+9HcCICBJtwjT7hmvwaYM99vo6ncTvuKB3UnmsTrTZjA4yMV6Wb
         vma0q9EVbxCUw66N8Ah8mezAeSS3oBd2Tog35TM1dWY/QYh8kCLER2wfy7fghJHGUl54
         TWaMWxmQxEI0bK8Z6gNUEp+rhCNLawrS7kNfcFWNOS9zyFkY2eBSpjERIrA3psoOaKyI
         iazEah/z4ebDKbV2K1ONHABZ49lq46A78O3n+nmavMP6v/kefLsH1CxpK77szwdneAje
         YkelpHP65CHHOs47r5roSrKEMFP3YbE+KTAeTVYYv3LDHIraftYPAJpTeSDT1Z1Pnd0d
         kh+g==
X-Gm-Message-State: AOAM533RuYp6I0IRKFgdmB9n+4D7luLz0NNsxNPodDLnWIEmgNDx6qp3
        GSe3T/XNrz50gYXl2G8PZ9A=
X-Google-Smtp-Source: ABdhPJzPCptREcKQM7wdWFCNCtxD+j30QJmIWrishVPjev+OFJaa5TEgYfl8y/d6710mvFkxWNs1GQ==
X-Received: by 2002:a4a:d4c7:: with SMTP id r7mr26919542oos.85.1622675043730;
        Wed, 02 Jun 2021 16:04:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b19sm284262oib.46.2021.06.02.16.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 16:04:03 -0700 (PDT)
Date:   Wed, 02 Jun 2021 18:04:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Message-ID: <60b80e62b782_16df0720895@natae.notmuch>
In-Reply-To: <20210602203849.GD15354@pobox.com>
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
 <057126a2-81c4-41cf-e41a-52a24a0c9a52@gmail.com>
 <YLe4+2JKH1LYRTvv@nand.local>
 <20210602203849.GD15354@pobox.com>
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -12,7 +12,7 @@ feature.*::
>  		have unintended interactions since they are so new. Please enable this
>  		setting if you are interested in providing feedback on experimental
>  		features. The new default values are:
> -	+
> +
>  	* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
>  	skipping more commits at a time, reducing the number of round trips.
>  
> @@ -20,9 +20,9 @@ feature.*::
>  		Enable config options that optimize for repos with many files in the
>  		working directory. With many files, commands such as `git status` and
>  		`git checkout` may be slow and these new defaults improve performance:
> -	+
> +
>  	* `index.version=4` enables path-prefix compression in the index.
> -	+
> +
>  	* `core.untrackedCache=true` enables the untracked cache. This setting assumes
>  	that mtime is working on your machine.
>  --
> 
> With the above, the man page output renders identically with
> asciidoc (9.1.0) and asciidoctor (I tested both 2.0.10 and
> 2.0.15).

I can confirm the above looks fine in both.

-- 
Felipe Contreras

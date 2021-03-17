Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3886C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91C764F07
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCQRms (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhCQRmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:42:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F422C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 10:42:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r17so3944181ejy.13
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=RgdtQXuSdlGhXUs4qg2P/hLxizDRF4pWK73ZiCk/tKw=;
        b=PxzCQN/khLftz+bf/VSD7QYneh/CqpeJwoHG7Rb24gBhA/ZqpSkl1qq29Ju/X+UB91
         AV/Bt2A7WY8r0c2+MvAjaRTLI+3A9sbfcCdHDjVVREOCNYzuYmjYqJmNtVjlORd0knNt
         v9SL/2K4DCNNypD/dJlbZB2QpRL7NNFBcWct+uvFfwWp/ZXgSaVTUEwGH/j3BFFf/GSX
         oJ1vsI7cCJMA/7C8v9TbpfjaNuRDkLvu8xEYdiM2ORvK8NagLJyzu1U+jZZAUsDZBERn
         7BFIhlhcaWb1FFkuK4D+9FDhKiwD07MuXiH7PPmCihphGCXZwPSyrGiHo+rz46FXKtA6
         Itzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=RgdtQXuSdlGhXUs4qg2P/hLxizDRF4pWK73ZiCk/tKw=;
        b=EPkabMJZfNqwq1jCbYe1gMnE6bnnsaOP0/y4SaUkGuXKlkH9rQGFx++JSBov+4c8SM
         lPzEscmdTjWB/7z32cBHcrMdEUzxED+bRWPlfJM5Key6EKRogdzYL/NuSDv34nWq4EiI
         xMfq0L7ComLOUS+ODVjUQrc5JHvF6oz7rrsGCWF7IiO2FoVUmy9oT1YTqmWREek4aaMf
         gnf8XhsSQIvDx3gCEntaTOSDyClvyEQaXh2IcEczG4z/HM86aEtWmI24Y6bXyYuXgFfV
         3Pvab8ak8LhW24R2cbL2PRD7fhU5HD+DoNbygPmrXjIPO8gzIImWfMJxZT82Z34Z44r/
         Z2Vw==
X-Gm-Message-State: AOAM5335SPtdLanGQJWXgmNGEX2sOc4L4U5M/oCCoPQS7AOn8dkemIrR
        8BdRM8CxC7Fz6vpI449STB6qfmXkwow4xg==
X-Google-Smtp-Source: ABdhPJykNGR2wwmBw3xi7F17ShKE+4hjlAgGRIkUct8yWV0F+uR7i2CBBIZB8EyMQeA4ZtCNw9hEow==
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr35918372ejz.382.1616002932624;
        Wed, 17 Mar 2021 10:42:12 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s20sm13485265edu.93.2021.03.17.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 10:42:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
References: <cover.1615856156.git.liu.denton@gmail.com>
 <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
 <87mtv2dk18.fsf@evledraar.gmail.com>
 <YFI9QzKMKLMXYoyz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YFI9QzKMKLMXYoyz@coredump.intra.peff.net>
Date:   Wed, 17 Mar 2021 18:42:11 +0100
Message-ID: <87r1kdzngs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Jeff King wrote:

>  SCRIPT_SH += git-bisect.sh
>  SCRIPT_SH += git-difftool--helper.sh
>  SCRIPT_SH += git-filter-branch.sh
> @@ -1037,6 +1047,7 @@ LIB_OBJS += ws.o
>  LIB_OBJS += wt-status.o
>  LIB_OBJS += xdiff-interface.o
>  LIB_OBJS += zlib.o
> +$(call check-sort,LIB_OBJS)
>  
>  BUILTIN_OBJS += builtin/add.o
>  BUILTIN_OBJS += builtin/am.o
>
> And then it's just a single-liner for each block that should be checked.
> We haven't used $(call) or $(eval) yet in our Makefile, but past
> discussions have reached the conclusion that they should be safe
> (they're both in GNU make 3.80, which is the oldest version worth caring
> about).

...also this sort of thing can be guarded by "ifdef DEVELOPER" or
something, which AFAICT (from trying to introduce syntax errors etc.)
will get parsed first, before "make" even tries to parse what's within
the ifdef.

So if we have bells & whistles in that sort of setup it can be less
portable than the Makefile in general..

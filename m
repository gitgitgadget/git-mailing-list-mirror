Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08558C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9FE6109F
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350424AbhESMWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347770AbhESMWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 08:22:41 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03003C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:21:21 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so2956968ool.1
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=9cBi8gtU6gOOQMR9vK0nJk+ekpBqnIFB2eGgKE7HNx8=;
        b=AQq5ydtux2xES7lCxwEfDqD2r0ehnEUCPFVy0sHVCmfDFD/3k1SenSZudrFSgmt0vh
         7iJmQveEAPg/GmyFCZXXB9u0gwWs/6BBd5ybYb1WL4mLSJ/CAp9bJdliXjVkhXrZ7BvH
         omRGCz/OSztA5HKF07mQODqvNC1sC3GcwevTg/5Obzv42BYter58sLx04MacMYMGvdq6
         nD7kfH4x+tIrYGF40ZB8u39JM1rpZ132HQwCr3A+oIPyoQlg76uv4u8GhaOJ8upGpy/h
         GH/4pbfM/xWVvdPYnuEvw1sWokNBd+wvD5DzAedErM3KasBHwPUDAV2IsOHRckU2qtJN
         EcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=9cBi8gtU6gOOQMR9vK0nJk+ekpBqnIFB2eGgKE7HNx8=;
        b=IyjEjMF9UE3oHJ1L3E0oYRvNdu4RCFh2m77NAbLKQ6qEYMw5MD2kgXTm1AoWAtr2YC
         ChZx2YtWoKkIrDA65Yuu93eB3KvN/ZbwR++/6Nz5KT3kxpYoTJ3Uv6WCbDnOi5rGSIRR
         E2RqScMGcjS9CL1ZYaRWbN9qopNE+IjkjgPcDkA3aZO53nnEjGZ+PRfl+yO6APE+kDID
         A92FrdyGOIIeKlHYnz+OKgXSMDNtTmSHs2v4+14tute4PxNoIgNVYgymBvCqKfezdFYg
         YO2w8x+FqTAPDTxcsVYkipE83GU8018Atfbbg+dGlEN7CjLyrZn/h0PAGC48435nS0/a
         ieMA==
X-Gm-Message-State: AOAM532AD4MED/5BYztL5P1gkgsVhzuigFCQOrNbxz/xIqzioFmdGPhJ
        bq2NJ/RVU+LwxiMlAeD/Dyc=
X-Google-Smtp-Source: ABdhPJyrJvF79i+k3q1/SYjzcndy5HO2mZDOO4sPUYNaFPGoJYpJWTn+9a+QLd46t5E8b4nJzyzKTA==
X-Received: by 2002:a4a:3e0c:: with SMTP id t12mr6017908oot.24.1621426880313;
        Wed, 19 May 2021 05:21:20 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 186sm4249830oof.14.2021.05.19.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:21:19 -0700 (PDT)
Date:   Wed, 19 May 2021 07:21:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a502be5eaa5_17b88208cc@natae.notmuch>
In-Reply-To: <60a4f4312264f_86a82089b@natae.notmuch>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
 <60a4f4312264f_86a82089b@natae.notmuch>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> This is the equivalent of my latest patch:
> 
>   man () {
>     GROFF_NO_SGR=1 \
>     LESS_TERMCAP_md=$'\e[1;31m' \
>     LESS_TERMCAP_me=$'\e[m' \
>     LESS_TERMCAP_us=$'\e[1;34m\e[4m' \
>     LESS_TERMCAP_ue=$'\e[m' \
>     LESS_TERMCAP_so=$'\e[1;35m\e[7m' \
>     LESS_TERMCAP_se=$'\e[m' \
>     command man "$@"
>   }

Wait a second...

  MANPAGER="less -Dd+r -Du+b -Ds+m" GROFF_NO_SGR=1 command man "$@"

Reading man pages pays off ;)

-- 
Felipe Contreras

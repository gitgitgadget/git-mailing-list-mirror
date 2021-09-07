Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B3AC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05BD60E77
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbhIGQtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345090AbhIGQtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 12:49:46 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06405C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 09:48:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id s16so6159987qvt.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hCY32A/XSJsamTIjoAJLg4hn41BLta76H9XCH1WQN/U=;
        b=RL+a0tQxq9TZNGkj//qPakbTn1FOhgC3CUbUvnfqe7Ak5ENi4AJroiBY3crd0pf1nK
         Nb1Ijid4Rwzo+A3oiPTUXPM3DtjeeA2znt4OwVGa+tlZY4bo1EOfFieJArzFqaSKD1j5
         2deXGzzwtiKlnRPI7JH+4cZX1TNyhcy8k0Iy8SeFXh2D5s3Gs8MS+7VbW155/i2eIi1J
         iRs1FEwa1BBfrIdBWpR/uRwRXzaibz4xodLhOVNqzXDdWxncCrjMAbHiMwXKxIoHfdMe
         SHUtZaFox5rzB4WUhqbxK+yjasx5yKLoqc6ALCvCcopxGK852aBDIZfNRozIqURxSDpv
         t0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCY32A/XSJsamTIjoAJLg4hn41BLta76H9XCH1WQN/U=;
        b=mlu5iCzS3thxXhJA65ckX57mIsN5n2pYuAFQOUIXA1CoS8H8xY+t83L1GQY0/S/63y
         gClHSn2wQ1POCtnBzqc1ZsBiNNzsXPubNym9fwSW/8Z/CR/X+aN4WFBhzVCNeuQFC3Eu
         IXU7/fREBtQzQEyxlJfoZpcfUTaTq2+Nu39UNtB4aa1Kv2dIvgtuDcOX11FdmMBMJa2j
         VSUkZ8uxelWaPGjLNI8sUa20m9EstdAYpsxFcxC++LKlxvVoHWcBWWIqav67HztDiaPb
         xMmY8mJUAWxA40tUfqFhQKJwzThsNMiKaxrpFVI4rZ+2oMw+TEU3tB3H7SPJzvF/AAV5
         BtMw==
X-Gm-Message-State: AOAM5320RwKZlLr3EwmVoHbbm3qd/TSEFh/O5Mdkh7ayPvDYZ6tiN+FQ
        /BnytmARuq0ccmfJCHg3Uyk=
X-Google-Smtp-Source: ABdhPJy9a5sF9yAU3GNn4uvwXPW1EP51NQcvdi/oPpKH3RbNB6RPuyGyNNzvyP7widCG5zxYmUynfg==
X-Received: by 2002:ad4:4e0f:: with SMTP id dl15mr18307031qvb.60.1631033319040;
        Tue, 07 Sep 2021 09:48:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68f1:6471:8b2:7688? ([2600:1700:e72:80a0:68f1:6471:8b2:7688])
        by smtp.gmail.com with ESMTPSA id a9sm9429501qkk.82.2021.09.07.09.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:48:38 -0700 (PDT)
Subject: Re: [PATCH v10 0/3] maintenance: add support for systemd timers on
 Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20210827210255.12565-1-lenaic@lhuard.fr>
 <20210904205500.13074-1-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28e0f22a-e9be-bb18-df0f-4d95cb6d5145@gmail.com>
Date:   Tue, 7 Sep 2021 12:48:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210904205500.13074-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/4/2021 4:54 PM, Lénaïc Huard wrote:
> Hello,
> 
> Please find hereafter my updated patchset to add support for systemd
> timers on Linux for the `git maintenance start` command.
> 
> The only changes compared to the previous version are fixes for the
> two typos in a comment that Ramsay Jones pointed out [1]
> 
> [1] https://lore.kernel.org/git/51246c10-fe0b-b8e5-cdc3-54bdc6c8054e@ramsayjones.plus.com/

The changes in the most recent two versions look good to me.

Thank you for this contribution!
-Stolee

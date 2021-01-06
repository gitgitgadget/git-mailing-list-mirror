Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE8EC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 02:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18E222D50
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 02:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAFCQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 21:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbhAFCQn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 21:16:43 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AACC061388
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 18:16:03 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id r9so1678078otk.11
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 18:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3bJuBRzvHWb7U7b43Rn2KYAMDJ/qVfwyK/JVEMaYci8=;
        b=Yb0jhk4ZM7DTfu9DTveqdqgE91R4hjyZgVp4PozoudQui4gB926Leu7cfxNLL7onhc
         XM4iVZATXXSpjtuwjx1SlD60H66cqKlq1sbYyYOtrSvUrKjno5eBIcjJnODbHh5QDcBt
         HZUbA097uB9cb+LXR/jEb0HESoskk0uefpY3MTlETSC3qns0GByrOYdpjio/EkwF5emD
         WG84yyJ4BCn3D2QX1zgrlz/Jc82rkoKwEbkWi/VstA9GmsmSsN69pa97okWWm+wAURPH
         ZrUXxMOcI6ez3PLL4b9Eg0Qvj7BDiXJDsYJ5571x+1BuEX8oyo5iDy5M8OWcNXQ/u8mA
         Dl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bJuBRzvHWb7U7b43Rn2KYAMDJ/qVfwyK/JVEMaYci8=;
        b=NcN1dQ9cXWPr325ilUv7DRkwcLidjZ1BnQLyoGG/0vKbmvtpQpxXMacqXj8Iuz13H/
         mNs/IWjT8z/rxJJZkohC2rdaIO1Hga94C2i3fBbF2lneG5Q9LORCCnljl2el5CEboz5u
         TQqKtdRl8wacb5BRqYucyUq058JwniqKbq61k28J6eV5c57eo8wInDe8ToOhNpSv7a0V
         UbrxCnU6kjayk43R60pydZl0XElXMsuM35YyAQFZXCkzmAiDrZNDz3k1CxEXDykddCws
         jsWNBNccm2aTxAM8MsFIm7c1TBgzkXH8nyeBI+9x+aTpVnFvd6St6QApMw1UbnE1vrCc
         3gFA==
X-Gm-Message-State: AOAM5301kIhf3mfoXQ+21rEbF6cCfrlSgwSAahPUL1Yss4C5NoPRiyJ4
        iH6zEVKqc5yMDjy+iDeHvt4=
X-Google-Smtp-Source: ABdhPJzyU/7qud9ZQRQRatYwHa1k/vQuxPZH9fswmyY+GiItjTgSUcExtr9kRUv6SE2an+Ej8Wri8Q==
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr1792807otq.199.1609899362686;
        Tue, 05 Jan 2021 18:16:02 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id k3sm256904oof.31.2021.01.05.18.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 18:16:02 -0800 (PST)
Subject: Re: [PATCH 0/5] avoid peeking into `struct lock_file`
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>
References: <cover.1609874026.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a401a6a7-fc15-9f26-2345-651964cf7b5d@gmail.com>
Date:   Tue, 5 Jan 2021 21:16:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <cover.1609874026.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/5/2021 2:23 PM, Martin Ågren wrote:
> I made a comment in [1] about how we could avoid peeking into a `struct
> lock_file` and instead use a helper function that we happen to have at
> our disposal. I then grepped around a bit and found that we're pretty
> good at avoiding such peeking at the moment, but that we could do
> a bit better.
> 
> Here's a series to avoid such `lk.tempfile.foo` in favor of
> `get_lock_file_foo(&lk)`.
> 
> [1] https://lore.kernel.org/git/CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+wz6NXCXTsfcvGg@mail.gmail.com/

Thanks for being diligent and keeping the code clean.

This series is good-to-go.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C1C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB094206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUCdSxXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgFNPUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 11:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNPUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 11:20:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A016C05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 08:20:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d27so10757997qtg.4
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LmF0On3/euqjYBmfpRGxphSpU12ec/MglQeJO7qcnyg=;
        b=TUCdSxXYhUKdw6OrXs12svh/DtqYt3VnJJW8HHAUVCCBiM/Df9MlY3Gi3VRy/fqNWj
         TmaMTWbKucCRY4Gyds5mbpZz2GHtlFqse/NKytMmHWGuULoz8fJuMXjtGQdKqiUQJdeY
         TPPc/sudV6abAHfzrDau51sxYzLKpVLu7Nt2KTp837toce2tr7B798uVAa4/L5Rqz5mC
         w2uXKGbmCsyG2Ny/lOxsCoKM0mteG8owv2tZLi++3OLGS7V3dAEGugCLdS4WigNpN2uG
         UVf2CpSSxihuUM4XwCBPUaQxEz9yA9nFpKM65rC4A5VUSDk5fwQ+BNGpq6wAwuEwkro6
         cBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LmF0On3/euqjYBmfpRGxphSpU12ec/MglQeJO7qcnyg=;
        b=RORk9z0ssZc9sPjV0aCziz9dQ5fdIwcNZjZYoHWkNM+X7Px2ATir8cy8WRi4A96mju
         27oj35TPpdqphJ7pjN4Kzqs9zfXVFRDZJTyNXo3IfGjiNL8R8ssKhq/DOPzldi5mtdAt
         v6e6kzTsEqzY8e/D1CTBeWIdhGDthbvzqED2RJ/xRdAPTNkiEhHNUH+d0+xXw4qZVyxh
         kIqhZQx7AZkBaru417H4K/prspLqCoOnwxAqLMaB9DCwCU7WYFmqBMKYsPy4rjs0WLzy
         M+v+xPwlIQ2WHQMXz5KF1p/LL3S2VpqxxawPjoeOibzErgeMJTsPgaHsvLCcIVNrEtNC
         pM8g==
X-Gm-Message-State: AOAM531du5ogPbeMDS/WI5pH9GTj+r8xNScunP9XS0TtZpyi/jbFfvJx
        d2053jQrkLn/6PcfdetdBYyWFvTbDeQ=
X-Google-Smtp-Source: ABdhPJxnyejGmujpmNJZa+7tZPehpwRAiAIExzeexzOHwyqU9r+NG/k7MQKGmq6NqEBkgv0jRFs/Ew==
X-Received: by 2002:ac8:17a1:: with SMTP id o30mr12202696qtj.140.1592148051790;
        Sun, 14 Jun 2020 08:20:51 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id m6sm8525696qkk.4.2020.06.14.08.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 08:20:51 -0700 (PDT)
To:     simon@bocoup.com
Cc:     git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <7265e8cd-6166-1da6-c1b9-85d5d591bfd7@gmail.com>
Date:   Sun, 14 Jun 2020 12:20:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm just posting it here because apparently the guy posted but it wasn't 
included here? I don't know.

"Michael Felt aixtools@felt.demon.nl

﻿How does the saying go...

You can please some of the people all of the time,  ..., but you cannot please all of the people all of the time.

I learned as a child that my choice of certain words was influenced by words used by people i trusted. Words that I clearly did not understand completely because when I (tried) to use them, with no negative intention, but saw the use of a word shocked the people who heard me.

Does that mean I was a racist, or am a racist, because I used a word that others considered racist. Yes, I was naive. But I learned words can offend, regardless of intent.

And I feel that is what is missing here. Using a term that someone else takes offense to does not mean any offense was ever intended. But I tire of hearing that I am responsible for knowing what offends “them”. And since I am one of the unlucky, not clearly belonging to a “minority “ of some kind, I may never complain.

But I was well above 40, and learning from my own children,  before I learned to deal with all the persecution i had to live through in my early years.

Racism is a powerful word, and it exists everywhere. Sometimes it is intentional - and we need to address that. But do not make the mistake that it is always intentional.

A git “master” or “main” - who really cares. Do not seek offence where none is intended. You only make your own life miserable.

Compare that with teasing (not as horrible as racism it seems). Just remember, teasing is always intentional, the object and objective of teasing is always clear.

The intent of a word choice is not always how it is received.

If “master” offends you, I feel for you. If “main” makes you happy, I am happy for you.

I am saddened that people feel that “master” in git is an expression of racism. It is not. I am saddened that people feel it must be changed because someone takes offense.

I also know my opinion does not matter. The fear of the many becomes the “ring that rules them all”. "


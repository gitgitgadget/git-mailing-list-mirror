Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615BC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 16:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389EE20770
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 16:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgL3QNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 11:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgL3QNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 11:13:52 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E45C06179B
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 08:13:11 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 186so14278037qkj.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 08:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eXtTg8qLbQIQaPMfHTOWKEYvWn+EcPxwVWxUgHSkLGo=;
        b=jpWDIudtBHuB6DG+eh6i45oODrVuk4dtwbbBIt1/Y8FSvtHm44Mbe937OZvRueX3Oj
         LDU5NLwyX9UAMNIODio3w+m0QKd/qqZa8Df+2Be+lg7AfOu2xTTNBkKBql05sn2xDrIC
         upigqYQrQ8H/DTQUbm++read+ThRbY33k1EXtoP36fMAo53T5aFPtt5GcMSkGbGr42nI
         vIIvuVBvZmBNpl3LQfPv/klQ/dA/XN1YiFgTBjbj1bvz2xNwlcO6mGuNulNG97kvC4Bu
         2NzcAzpfsEnuljjB1fSGprWyOBCZ8FkvS/BQW97TtAhOoxgGirmOVK6en0PBfrk5w5kV
         8m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eXtTg8qLbQIQaPMfHTOWKEYvWn+EcPxwVWxUgHSkLGo=;
        b=ARdCtARZl3vjjaR4Op1qZU34cfXoSMRBD2KkYDEPSSP1x6Q2zBVnvH+2l3DOqztwmC
         dqhZlMoZUTTLXnMUH/bVsqXTz3pMFikTsrNdugnP0o+Q4dRkL3yVNssZaRfU0jGBD0iE
         sRcf9nsB4A8BSluPeCFVa7rAOmvTRVYgBLC1EzxHHqCKN5vGNoBPwHVM44CkK3BE5KJF
         jDuUmg9WmlE2P6V25hYbhdLdN9ityXhNG1kbjPYDN/DWU92Lh58IkTsfhhyYXSPGRdRa
         SaPIWO0lWlwHBi2G6R7QXVEsOfgsgp1ke/cE7JqjnSRxR8dWeazzxYa0Zlw1lG79esqr
         NSaQ==
X-Gm-Message-State: AOAM532WrBrNT+wOrE/Yig/r3K4Ju2/3/Gw5mBkyvpUQxUCgiMu2gZpD
        XufOp6pJFbpux5niEDY685i6V8F1d3AB2g==
X-Google-Smtp-Source: ABdhPJzli4wDbT0JjG9rGHIIX78Wev2tzOB4522hosivWfcEcReq+3tFKIPjmThnyxJs4XXiPXbcLg==
X-Received: by 2002:a37:67cc:: with SMTP id b195mr53692954qkc.406.1609344790743;
        Wed, 30 Dec 2020 08:13:10 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id j203sm27694768qke.134.2020.12.30.08.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 08:13:10 -0800 (PST)
Subject: Re: git show submodule
To:     =?UTF-8?B?0JzQuNGF0LDQuNC7INCf0LDQstC70L7QstC40Ycg0KHQuNC00L7RgNC10L0=?=
         =?UTF-8?B?0LrQvg==?= <motherlode.muwa@gmail.com>,
        git@vger.kernel.org
References: <ab49430e-5a9f-5910-e048-7f07dca8f898@gmail.com>
 <4ddc481f-7d03-e225-13a0-d5fd33456c43@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5b66521a-9533-63dd-09dc-25785d03f76a@gmail.com>
Date:   Wed, 30 Dec 2020 11:13:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4ddc481f-7d03-e225-13a0-d5fd33456c43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mikhail,

Le 2020-12-30 à 02:29, Михаил Павлович Сидоренко a écrit :
> Hello!
> 
> git show dose not work with file-submodule. Try this series of commands:
> 
> cd /tmp/
> git clone https://github.com/abdes/submodule-docker-dev-workflow.git
> cd submodule-docker-dev-workflow
> git show ee83dd336f27315d14a7ad6ad934897a61e49623:LICENSE | head -n 1 # good
> git show ee83dd336f27315d14a7ad6ad934897a61e49623:server # bad
> 
> My output:
> 
> $ cd /tmp/
> $ git clone https://github.com/abdes/submodule-docker-dev-workflow.git
> Клонирование в «submodule-docker-dev-workflow»…
> remote: Enumerating objects: 110, done.
> remote: Total 110 (delta 0), reused 0 (delta 0), pack-reused 110
> Получение объектов: 100% (110/110), 24.76 KiB | 313.00 KiB/s, готово.
> Определение изменений: 100% (56/56), готово.
> $ cd submodule-docker-dev-workflow
> $ git show ee83dd336f27315d14a7ad6ad934897a61e49623:LICENSE | head -n 1 # good
> The MIT License (MIT)
> $ git show ee83dd336f27315d14a7ad6ad934897a61e49623:server # bad
> fatal: bad object ee83dd336f27315d14a7ad6ad934897a61e49623:server

I can reproduce that behavior, and it happens even if the submodules
are initialized (`git submodule update --init`, or `git clone --recurse-submodules`).

> 
> It would be convenient for me so that I could see the revision of the submodule through git show. Without using the git submodule status command.

Note that `git rev-parse ee83dd336f27315d14a7ad6ad934897a61e49623:server`
does work.

> 
> Happy New Year,
> Mikhail Pavlovich Sidorenko.

Cheers,

Philippe.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851A0C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CADA6127B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhHWG3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 02:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhHWG3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 02:29:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B4CC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 23:28:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n12so9554230plf.4
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ep/4kaq8tOBoH7IXKPYm0Fv+Nxxn+OMPoWzsKNUG3iQ=;
        b=uou0/mAyhb7Q6YtNn0IWHxNyJ4CZfhCL5VE81LRr6co5hari6kAErPEsLpG3s7OfOr
         aXLtooprJuul+wxK7UVKmOq3nJuLyGiuBhibFb+yogae3OzWWzrcMT2F6jDzRFYxQrrL
         a8Rn/uDiLkpWK61iZoRiR/ZMRZPOeLpjjwAyHgAzXqvSvaENeMYGL+4MSrLEv3X5zKpu
         UVEgXoOXmOY5MoUT/ov0ugRkvvUjZPKJajXWZk2XcOug8n5AisZEb+Y1TbBYxMw8Mjf0
         U587IalujYHbJStXHnKKMK/VwY0Jb9ILtGSG8JMd9XSIm5/jgIZ52LnqryJZWSV1iKoZ
         tFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ep/4kaq8tOBoH7IXKPYm0Fv+Nxxn+OMPoWzsKNUG3iQ=;
        b=jNZJ2ye+OCx9b0D1gRBJGvF7FsyaLmXuPyi18+tURV4FNQ1RkuLuO13MZfxchzomEq
         iTxFadOre/qQDQIyMfm70ySLHeWRUsp40AS/qz+5UG67b3JccUt++2EoyXzTWSq3/kXd
         dWfvaYC4+Dq7slTtD03WnLTrmpaZEh1vzAfSOcncAHlEIoe3LDSrpraei87U+fo/T+Xh
         2vvSq1P883/XAJZwrAAv45YeYnEyZYLsMbd0PHHLBCd1YgmfMCO0xkzMsxXTyvO4eICU
         pO7QLJk9ZzNnTq9LV/BTcak/B+rFNa2+4Ma+bI90j5mtahpKW4TYTD0miW8wntbRhHKP
         JYNw==
X-Gm-Message-State: AOAM530aEso1R4oxuXBkbnXwVNunBrewSsu1MvS+lszB7IuO/t5pCTm1
        beDN4Z9nQapBv49PcIGj2AA=
X-Google-Smtp-Source: ABdhPJxCrIw7KHBqNXemeUIIguZyD8c36OvbcRKPKtnjFDVvePBczVsK+GC415BDiO/I2s3NTgT2pg==
X-Received: by 2002:a17:90a:9314:: with SMTP id p20mr18571424pjo.87.1629700113687;
        Sun, 22 Aug 2021 23:28:33 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-47.three.co.id. [116.206.12.47])
        by smtp.gmail.com with ESMTPSA id f5sm14497919pfn.134.2021.08.22.23.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:28:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
To:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=c3=adaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <20210822161325.22038-2-worldhello.net@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <70420665-c276-b18d-72fe-1b54609c1c46@gmail.com>
Date:   Mon, 23 Aug 2021 13:28:26 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210822161325.22038-2-worldhello.net@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/21 23.13, Jiang Xin wrote:
> +    - uses: actions/setup-go@v2
> +      with:
> +        go-version: ">=1.16"

Currently there is newer Go (1.17) [1], why don't you update to it?

[1]: https://golang.org/dl/go1.17.linux-amd64.tar.gz

-- 
An old man doll... just what I always wanted! - Clara

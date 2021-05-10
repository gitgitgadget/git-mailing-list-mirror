Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB719C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99811611F1
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEJFvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 01:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhEJFvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 01:51:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4119EC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 22:50:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g24so9111472pji.4
        for <git@vger.kernel.org>; Sun, 09 May 2021 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rmxMZxuv23uTWLOihOzMmLIGQkGELbj+6YZW1jeOHvw=;
        b=aEue4/mp59bCFo/aTsRaSR2RLYIjX+TgyWbj0YnTITVL36ejVz0fHvdgmgW2MtERoF
         UsLcl45K5dEks5fsTeh0uwqWfQShtJJ0bjGFTn60fqBNRblzIp9ukVaAyb77k1X0b4Rg
         r+KtcrUnDMbUZWcwE2z0Lz2Ol/UUKVigv5vcuhUrR/A0KIQmsZE+6tcP9K2+1ySnLGew
         GVDluIVQE2Tb8Xz30VC16USUYnnQzcoeDxcb2CQpmT1Cl5OjRiNr0ew+RLBpGQHqGB+b
         CTCq7r3JbtmyNeN99geGIRUh8fJwY3yTYbWmSAl4G/8Pqa0W3FLoTnk7GwpcCf4mVQ7E
         QBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rmxMZxuv23uTWLOihOzMmLIGQkGELbj+6YZW1jeOHvw=;
        b=h6pBCfy4ILjCKfOTRAlldFmp8wJDP4GwNskHDf1roe1AX/SIIWz0kCYF6kKUoIyy4B
         tuTOmVD2WHStwTcTJEcHmDDexQBDHnCYdXWPGYxpP4k9viHTxgC5z+wlRzsMi7miUsA3
         3oh9bxayTBGn6GP4hB6jpQm8baBb7tnIMa5sBexuLVrdSQNfwO2H2FRGHX9siueG+n3J
         55dwQX67N9aNOEyw8Pb5h9YFosvvpPFikhYVK/B8ssXGVd/SODus3wO3EzFuQCug3Rtc
         5xGE2MGhZAMttQCG6djNLN6f37a7UA3GAb95LzYGkBfEDqUpCdADb3I3b44sIqhRdzpi
         jS4g==
X-Gm-Message-State: AOAM531pyMGFanjupuRYZc1urxepqM/BvtA4+jerCB8xKlYeLPpA8yUX
        c+Md9ZSD9X4Bw0zmlRVDm4g=
X-Google-Smtp-Source: ABdhPJxgBJfi/VHhnJ2KNJAAnP/6DIdSbNAPpfoE1+x7fKdIK23G7v7bDKhY0qyUPThkh9+XYdRbnA==
X-Received: by 2002:a17:90a:cc11:: with SMTP id b17mr25417109pju.119.1620625810740;
        Sun, 09 May 2021 22:50:10 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-59.three.co.id. [116.206.28.59])
        by smtp.gmail.com with ESMTPSA id o4sm17869197pjs.38.2021.05.09.22.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 22:50:10 -0700 (PDT)
Subject: Re: [PATCH] merge-ort: split "distinct types" message into two
 translatable messages
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com, gitster@pobox.com
References: <20210509215250.33215-1-alexhenrie24@gmail.com>
 <bb3a3968-f78e-7534-1274-2e6c916b9a8a@gmail.com>
Message-ID: <4c86452a-81dd-3bb9-a6a8-29cb1a0dd0de@gmail.com>
Date:   Mon, 10 May 2021 12:50:08 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <bb3a3968-f78e-7534-1274-2e6c916b9a8a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05/21 12.36, Bagas Sanjaya wrote:
> Seems OK.
> 
> For example, in Indonesian, the first case (both sides are renamed) would be
> something like:
> ```
> %s punya tipe yang berbeda pada setiap sisi, kedua-duanya dinamai ulang...
> ```
> The second case (only one side) would be something like:
> ```
> %s punya tipe yang berbeda pada setiap sisi, salah satunya dinamai ulang...
> ```
> But the status quo (before this patch) would be translated as:
> ```
> %s punya tipe yang berbeda pada setiap sisi, (kedua-duanya | satu) dari mereka
> dinamai ulang...
> ```
> On the both sides case of status quo, the personal pronoun `mereka` (they)
> refers to the conflicted sides, where as on this patch, such conflicted sides
> are instead be referred as `-nya` suffix on the translation.
> 
> I personally avoid using `mereka` atau `ia` as personal pronoun that refer
> to things, and instead using `itu`.
> 

What I meant was I use `itu` as personal pronoun that refers to things (not
people) instead of `mereka` or `ia` as translation of English pronouns
"them" and "it".

-- 
An old man doll... just what I always wanted! - Clara

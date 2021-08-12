Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A6C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04366103A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhHLIgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhHLIgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 04:36:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B15C061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:35:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n12so5691430plf.4
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a7M85WY/lkYrZiohUcujemDF/ap+wvgHunHsbsmFpTg=;
        b=DWz0F/Ct864BPdg3F8htLDju4trNC6UlxS3Ghmhjb6otP2ZN7Aqp2UDjBPNANuGVtC
         /+ICuLFtO6hoynrRTiwDdHLVkGtKg/GBb7nAp2Bwh4eFkRMWYquXtm/Dn5NZAkSTWj7e
         F/0wJkHh7WUb2/KFeCX2ejkedQDLjhktbPDmp1hHvQbQ5GckvPKplcUU74UosJFNGuDG
         Z3+J+hWO+Z1fSrLWbYqKS5CGIm9gq6GvaHGFXT1NArx79QxIIAKM2mB4aAZESkazl6tH
         DMTMisN044vQ2LH7ZWt0ZRcEV27AwKnEAdb8SWajl08pfo9zyPvZE4ERlAMDLpAARUit
         GCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7M85WY/lkYrZiohUcujemDF/ap+wvgHunHsbsmFpTg=;
        b=daVvItfw/g9wE7WVoDtEfTQ0/yDI801L2fphX1NWM+nF2O4RYIWxig2vkx7Pm/4FS+
         GR/U/DEYhBhlkFJ7FTZpdsTSLxBYr5c/csRPH+kkWA5i8FaBDuc6z3DatujHCq5DgSNK
         YYmtA2inLh4cD2OoQzbWRb+BqJcPt/MmEa33v1ApSeU9aYZLb5y5X76oC/hTvjRsB1wb
         W1Wj2/kXqghosWjiGToHmT7oVe17EyrLvLJ4HDQGH9hWbJx0RXgsfvvk6nL2kOL9CdzL
         EiESWGpP04xVR4RN6N8+4CTcIb6VXc8vEsg/lQ0Lj64qNKOm+bpJzpq4XP8BcWuoX/En
         3rDQ==
X-Gm-Message-State: AOAM531cMWxrMlWSQuI/E0QzuPjf9lUIakJGVIQRZGUsaikfWnL/G7jX
        gxeopnTHln51SacOIWbS0M2jOir3u4o=
X-Google-Smtp-Source: ABdhPJxu98r9ZRJEX8l5SZmT14R57rsrE/zTIMzFT6aTmpuwnFS4C3E+MWMjyIfXMzfgktYMjeNLMg==
X-Received: by 2002:a17:90a:6407:: with SMTP id g7mr3305460pjj.230.1628757336346;
        Thu, 12 Aug 2021 01:35:36 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-47.three.co.id. [116.206.28.47])
        by smtp.gmail.com with ESMTPSA id q11sm2289743pfk.32.2021.08.12.01.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:35:35 -0700 (PDT)
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c3eed187-6f16-65eb-a4e5-cb747ba5f36a@gmail.com>
Date:   Thu, 12 Aug 2021 15:35:32 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0lrtuh4.fsf_-_@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/07/21 23.25, Junio C Hamano wrote:
> +  - If you still need to refer to an example person that is
> +    third-person singular, you may resort to "singular they" to avoid
> +    "he/she/him/her", e.g.
> +
> +      A contributor asks their upstream to pull from them.
> +
> +    Note that this sounds ungrammatical and unnatural to those who
> +    learned English as a second language in some parts of the world.
> +

Addendum: For grammatical correctness (for ESL people), proper, plural 
they can be used. So the last example can be rewritten as:

   Contributors ask their upstream to pull from their repository.

-- 
An old man doll... just what I always wanted! - Clara

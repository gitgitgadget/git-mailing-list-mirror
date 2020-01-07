Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13CC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510E92087F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGIJUWXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgAGSpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:45:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37185 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSpj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 13:45:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so615458qtk.4
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K0N9EJPfcqDDbAZgWz6sscX3Izu+DjjPI4f8km5xsMU=;
        b=fGIJUWXnBHDa4nnLBIRE/kcEMuSnTivhu8yAZ6Q7evx+gj7M3cbtAZfoOv2df0SENm
         0mNBCN0CfyU4kSqjGeOUXFfIMpYy7o1uo+gnzeWhmlR567+MtqV9VSOdJtCxviC/TAWZ
         EViV9IbRm1P0TZQgypkiAIhmZZQGedrhMNZM7GJsqU5TCOt1qe49bb8I0jXCSuSOjK6I
         +i8iOE9jPUnOhApgjNjXYzreUz9wcsvIJkepmZoS9LqtOH0ggR3eUEtLek6RGGALlBNu
         Q4B+kgOy2KFEX0HiIFXP9jZGcvN8A/YFym22LEmdyDGN3NNI6MfoADBOXmL8QzQaE3E3
         EY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K0N9EJPfcqDDbAZgWz6sscX3Izu+DjjPI4f8km5xsMU=;
        b=LmQMopZoYgjAKRGViSqv0/KIhqEpeFnbDTl0xNKvSyVDR2orTcoOtHXUf+4BjAfUfK
         AJCYXfyItiWF7SbRmY7rEXU1ChrliYTrB5cjFlFi2Jh0gLpt0Af9S5xjOQ7X6zj0u/eT
         +lfMIYaFRn1J44Up5nT0FYrqf3iGIxgsClYK/kBO/SzUc0d6B707DQDZAKQLjH1NO9Vr
         lrsOMUn1yCcIkBH4FHgmCZW+M1GMkhgd+jg+eCWlIeKtods3belFeTaRcP9cp5dYVy3W
         A2QOj4ht0MprSaMcujctqpR+SpCzUIYSQzGdQmWzaSbq81TW+f4vD6GdeVeUX2pdhL+J
         Ch+A==
X-Gm-Message-State: APjAAAX6A9Ji7ZPFOg6JcI5AeaTLnPhWX1C76XBzKZJSi3eUVqe8QqID
        u0Yyd1eziVIgjDj5cg/i8JU=
X-Google-Smtp-Source: APXvYqzKNaKp6cZEY6ocIWKAllf0Pn/6boiPg2YJYemUB2B+LmAybvCIsgutWKe5fuoBo4R2QpH1rA==
X-Received: by 2002:aed:22c8:: with SMTP id q8mr321722qtc.133.1578422738352;
        Tue, 07 Jan 2020 10:45:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1010:f14d:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id 186sm218875qkm.93.2020.01.07.10.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:45:37 -0800 (PST)
Subject: Re: [PATCH 2/3] graph: replace assert() with graph_assert() macro
To:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Bradley Smith <brad@brad-smith.co.uk>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <5dd305d2f0de43a70b46336c8f1a62437e0511e1.1578408947.git.gitgitgadget@gmail.com>
 <20200107153651.GB20591@coredump.intra.peff.net>
 <CAPig+cTu=iAeQNm8z53cyG8C1dgokpZBvRVgev091nBFg8tCXQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d024980-5d5e-5818-3c90-6eb0c7e112be@gmail.com>
Date:   Tue, 7 Jan 2020 13:45:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTu=iAeQNm8z53cyG8C1dgokpZBvRVgev091nBFg8tCXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 10:51 AM, Eric Sunshine wrote:
> On Tue, Jan 7, 2020 at 10:36 AM Jeff King <peff@peff.net> wrote:
>> On Tue, Jan 07, 2020 at 02:55:46PM +0000, Derrick Stolee via GitGitGadget wrote:
>>> The assert() macro is sometimes compiled out. Instead, switch these into
>>> BUG() statements using our own custom macro.
>>
>> I can buy the argument that compiling with and without NDEBUG can lead
>> to confusion. But if that is the case, wouldn't it be so for all of the
>> assert() calls, not just ones in the graph code?
> 
> This wasn't just a matter of potential confusion. It's one thing to
> have assert()s in the code in general, but another thing when a
> scripted test specifically depends upon the asserted condition, as was
> the case with the test as originally proposed. Since the final patch
> series removes that particular assert() altogether, it's perhaps not
> that important anymore.

I'm happy to drop this commit, too. I misunderstood your point.

-Stolee


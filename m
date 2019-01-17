Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32E31F453
	for <e@80x24.org>; Thu, 17 Jan 2019 16:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfAQQnK (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 11:43:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39822 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfAQQnK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 11:43:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so11999876qtj.6
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JDGeud0vsiQdgd25ObhRR4uh7/xEJltEuXpCOaIi+Rg=;
        b=GvNLTMt+QVgj0GF7u/VXBR1RxxfVjpriHroT1CcHJPP1Sc6h5DMyCiwnwNmCkJimYX
         f7dKr5pF596ekfaftUpsWlYVnfokCo2/JJ4e6AJPQaQlXrIzI4Kg7xjJnsanrlOJrihj
         wM51M0uiXBFLV9dQ0btNeFrZSLhRAto/F1cL0/h0dMQirPH//LFiz6sxmyHLMRY6spmH
         BqhVf8QumBmy2BODvJoS+JXkHwLKnWPFVBzlv07m1KlTVycjdrXUZ+f43KrsXxxHsWhJ
         tr2VKET7VCyBDRYq4uoUGgY+dmz63cUn7km1zcjBGIylVJWDwa+9w3f3baHlkEbyI6Ep
         RNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JDGeud0vsiQdgd25ObhRR4uh7/xEJltEuXpCOaIi+Rg=;
        b=dWVXwzRx39kAmPCJ+P9RmD3CgXhtZDSzhrY4ctTqq9iOAX4PcNIB+JyVzU5HUoNN/B
         NhVefyzoiFCpIUlt2lcVMppcf30rjZPUN7M+rqDnQ1fGwtqDw3wiaircoQ6HS/DdAqL8
         5aQj9ZuWxx3rlMD1exFd//fNMcjUvPPKicMxoofEefta5Q8xZaw+JJBV3jo+gGR3sIbJ
         gs5An3GhDpbNDHpfRgVOfHJrwrJJLKMYhp4FoYYLqibWw+YHtnsUHQgdJJpWwu5JCPWn
         n94lz9rgXDZjtBRbkT7dRrKjeeLcCfRKrzh2V0ock7T9EmvF8ME++HWhQmuTEsilrzlk
         eWUw==
X-Gm-Message-State: AJcUuke5M9tgiqOmaNQWRWY87XSG8E/9dsSrkpzeeV74gSm+DGpY5Ju4
        waYR2aG19YNRLSKVC17aUmE=
X-Google-Smtp-Source: ALg8bN707HYn8enarSNCxFjeJjmZyeisH89G8ThHidceIb7ZWrmwbTZm2r0R1W3hBRevCzf1vcJuJQ==
X-Received: by 2002:a0c:f313:: with SMTP id j19mr12001603qvl.200.1547742899951;
        Thu, 17 Jan 2019 08:34:59 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c447:1d70:84f9:bac9? ([2001:4898:8010:0:ad7d:1d70:84f9:bac9])
        by smtp.gmail.com with ESMTPSA id o65sm52484546qkl.11.2019.01.17.08.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:34:59 -0800 (PST)
Subject: Re: [PATCH] commit-graph write: use pack order when finding commits
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20190116132947.26025-10-avarab@gmail.com>
 <20190117132345.29791-1-avarab@gmail.com>
 <5b1146a1-9ec6-f30e-80e9-cb7cd4dc1a58@gmail.com>
Message-ID: <f71fa868-25e8-a9c9-46a6-611b987f1a8f@gmail.com>
Date:   Thu, 17 Jan 2019 11:35:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <5b1146a1-9ec6-f30e-80e9-cb7cd4dc1a58@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2019 10:09 AM, Derrick Stolee wrote:
>
> The code itself looks good, I just need to double-check the 
> performance numbers.

I tested this patch on our VFS-specific version using five "prefetch 
packs".

Before: 22.61 s (avg)
After: 22.18 s (avg)

Improvement: 2%

The error rate among the samples is very low (~.15 s) so this result is 
significant.

Considering that we are writing 4.4 million commits -- many more than 
the objects in the packs that we are reading -- this is an excellent 
improvement!

Thanks!
-Stolee

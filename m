Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC2C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F88520720
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCPevgJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgBGQdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:33:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34251 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 11:33:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id a23so2806201qka.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 08:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FoJnpPTcJEW6oufmZl855UiCyNtn4YkmQPQfyYFWSHw=;
        b=GCPevgJs4qcGTmKqV73AjngVAadtaZpsQZRxZZX6gPZmMq0xAaieWZiJjMoLbejEPV
         boSwV5lHsbVxN3Do5gfFDlr1QA180N8tDFyvS+KIAODLdPPR+8kgnvkJmORbCTRe622J
         SJKdpqLIKP14wJq2wNknvQLCAtnw6n6z0JjcFYrChW6dTZqwLAEGpTlFDK8Dl4NWxNms
         rFYXUDASgmD+aG/JWKTozerQDE8IB13JCo6A5Qo8F51v8ACXMaKjeIhy/O7Je/77p7NF
         TCwsv2cn2lQTAbGX242YjH+tf47YO7KefOYk9tbki6ILgwmD8A3QCyw2ZwWNSHkkllTb
         7iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FoJnpPTcJEW6oufmZl855UiCyNtn4YkmQPQfyYFWSHw=;
        b=RVs15RmzFXR1xxNNRNPcSVLX9iRWVoAtP59ruEqLajjY5Vci5nKx4yO4VrLQnJxQBu
         7lmL8AdCG3BxCCUmRsiG8QFyPJpOE4Mx48bL+xaZgth0Tt69IIfikwhjWBjWuFXk7kuE
         +uoOOBaGABqJgwEJMIZmQLe2k6YwR9gdK43BdfoY/ge10cMzlR4uyymlEXxQbirG46ku
         ML/Y73fc/Z3Jeb8jUM4ui0ahC8QYeUcfHKUtE1OlpqrG5R38uh53IlW2st83llXkunBN
         5DeKhV7/y/MG226L05RDJa7M+RDY7Ge3grpSryFDukhQoMzYmC2TVmENNULuc2k8CHhm
         Bi/A==
X-Gm-Message-State: APjAAAWmyMn1Tpu1PUYqIngidFQcgp3GbohpBdDteyz0hTWEihTCIluK
        8ohoB2IXJW6oPV+aZqXd72w=
X-Google-Smtp-Source: APXvYqxTweivoHjGkZljCL/9zrQPJxbSNJDqnsOhVd9FmNB18IwE6my35hYYh2yhXQdiGArVmuTRFg==
X-Received: by 2002:a37:a587:: with SMTP id o129mr8270039qke.268.1581093198899;
        Fri, 07 Feb 2020 08:33:18 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:439:e50b:6e3c:1277? ([2001:4898:a800:1012:b56c:e50b:6e3c:1277])
        by smtp.gmail.com with ESMTPSA id e64sm1590591qtd.45.2020.02.07.08.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:33:18 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Garima Singh <garimasigit@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        jnareb@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <20200207135249.GD2868@szeder.dev>
 <140cf2f4-23d5-09ab-8f23-bbbd397c68f7@gmail.com>
 <88c8e5da-72f2-25cc-f55b-f62500c52a24@gmail.com>
 <20200207161528.GA18146@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <49cd87c0-3a5d-09fb-fe08-57b0a7b7a194@gmail.com>
Date:   Fri, 7 Feb 2020 11:33:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200207161528.GA18146@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2020 11:15 AM, SZEDER Gábor wrote:
> On Fri, Feb 07, 2020 at 10:36:58AM -0500, Derrick Stolee wrote:
>> On 2/7/2020 10:09 AM, Garima Singh wrote:
>>>
>>> On 2/7/2020 8:52 AM, SZEDER Gábor wrote:
>>>>>  * Added unit tests for the bloom filter computation layer
>>>>
>>>> This fails on big endian, e.g. in Travis CI's s390x build:
>>>>
>>>>   https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647253022#L2210
>>>>
>>>> (The link highlights the failure, but I'm afraid your browser won't
>>>> jump there right away; you'll have to click on the print-test-failures
>>>> fold at the bottom, and scroll down a bit...)
>>>>
>>>
>>> Thank you so much for running this pipeline and pointing out the error!
>>>
>>> We will carefully review our interactions with the binary data and 
>>> hopefully solve this in the next version. 
>>
>> Szeder,
>>
>> Thanks so much for running this test. We don't have access to a big endian
>> machine right now, so could you please apply this patch and re-run your tests?
> 
> Unfortunately, it still failed:
> 
>   https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647395554#L2204

Thanks! Both fail on test 2 of t0095-bloom.sh, which includes this
expected output line:

	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab310098051a8|

We may not be properly adjusting the output in the test-helper.

I still think the fixup patch I included is a good idea, but Garima
continues to dig into the problem from all angles to understand this
failure and the full fix.

-Stolee


Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7594CC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D07214AF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob9uE8vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636397AbgDPQCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895324AbgDPN0z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 09:26:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFAC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 06:26:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id bu9so1928391qvb.13
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q8okj/8hWlaA/uQI9+yt7n4BjSttT3nT3PgnIDHbaTM=;
        b=Ob9uE8vsJ9DRZiydX0QK/rKQPZ0MyH37LT6MBfPTqX4vDzyvTLEQ/p5e+/h8XOR8G9
         T33HvJZ6zpRkdVnoIqq0JL4wwx69PaUh8aSEgrADAD8/GWXYUw+oOdRQp8hyRU3a3kpA
         zSgbeMrot4yEyyFxaMB4W7s6bXRpaDoMb4JTjbhg96C0zTnyH4mK82R0rUcWKZehZ95p
         2PXpznyAI51V2yTq7Lbt2I0e82yn+462/FD+Uf+WNtpb8oN/qHdMFUiKj4rQJL5RjR/f
         3K9m97pM/z74suBdsW8eWppr3b7Cid2bICnrFV285pHlLNm1YtFq9u4qHIpgQUww0iRA
         +a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8okj/8hWlaA/uQI9+yt7n4BjSttT3nT3PgnIDHbaTM=;
        b=P2qdFcBes7UJEG924Lc3Osx1uDZLTdVQtd/Gn8GYbbLzYLG7keMzU+n59xdxhyFBEn
         blcCa7bSDsmOeDO4ymBGtwhgj/swtK/Msi4kqqHd5rirsePoj7uhABSNZvvuR1rCJdpm
         99HfKhjcVMXNAJC333sjU7K9Kksy+CBYAFfmx5WH8itl1UXTwXiZZbTXCO8SGDRYZxdg
         3GBBS+2fGtyQL2KSXd9XGoeSWNzGa+c07COiPoofOFKNc0DbFnispArpBYtFN8yQ3Hna
         EgSkyU3GjNH+CdGNCuW6A38sbA+HV14+PMS+u+EU9izvHfCypGpSaG8t00I1DA0c3kGq
         v7ww==
X-Gm-Message-State: AGi0PuasNHGesCOkyesxgLM+qK0KviEw5w/UC03MbMtM0nPsCxbWprB0
        yvb2FvskRNI0BgrfU4OCZS0=
X-Google-Smtp-Source: APiQypJKrOXYsJa+04gF0Ht6OU0btGSJ8aVsJH/xUurjasr05zz5ncTaBkCbxY8Fo1v3z2LeGAOVmQ==
X-Received: by 2002:a0c:9baa:: with SMTP id o42mr10399995qve.124.1587043614225;
        Thu, 16 Apr 2020 06:26:54 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t15sm15939923qtc.64.2020.04.16.06.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:26:53 -0700 (PDT)
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Garima Singh <garimasigit@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com>
 <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
 <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
 <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
 <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
 <CANQwDwdcM-hc+Nyc0nBnp79W0BuH2PfdgM6WLqET3sPn1GYc-A@mail.gmail.com>
 <20200416005241.GB36156@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <67350f6c-d558-8b9b-4d57-5830f7a74fab@gmail.com>
Date:   Thu, 16 Apr 2020 09:26:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200416005241.GB36156@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/15/2020 8:52 PM, Taylor Blau wrote:
> On Thu, Apr 16, 2020 at 12:18:33AM +0200, Jakub Narębski wrote:
>> On Wed, 15 Apr 2020 at 20:37, Derrick Stolee <stolee@gmail.com> wrote:
>> [...]
>>> -->8--
>>> From 89beb9598daabb19e3c896bbceeb0fc1b9ccc6ca Mon Sep 17 00:00:00 2001
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>> Date: Wed, 15 Apr 2020 18:04:25 +0000
>>> Subject: [PATCH] bloom: compute all Bloom hashes from lowercase
>>>
>>> The changed-path Bloom filters currently hash path strings using
>>> the exact string for the path. This makes it difficult* to use the
>>> filters when restricting to case-insensitive pathspecs.
>>>
>>> * I say "difficult" because it is possible to generate all 2^n
>>>   options for the case of a path and test them all, but this is
>>>   a bad idea and should not be done. "Impossible" is an appropriate
>>>   alternative.
>>>
>>> THIS IS A BREAKING CHANGE. Commit-graph files with changed-path
>>> Bloom filters computed by a previous commit will not be compatible
>>> with the filters computed in this commit, nor will we get correct
>>> results when testing across these incompatible versions. Normally,
>>> this would be a completely unacceptable change, but the filters
>>> have not been released and hence are still possible to update
>>> before release.
>>>
>>> TODO: If we decide to move in this direction, then the following
>>> steps should be done (and some of them should be done anyway):
>>>
>>> * We need to document the Bloom filter format to specify exactly
>>>   how we compute the filter data. The details should be careful
>>>   enough that someone can reproduce the exact file format without
>>>   looking at the C code.
>>>
>>> * That document would include the tolower() transformation that is
>>>   being done here.
>>
>> Why not modify the BDAT chunk to include version of
>> case folding transformation or other collation algorithm
>> (other transformation).that is done prior to computing
>> the Bloom filter key? Though that might be unnecessary
>> flexibility...
> 
> If this ends up being something that we want to do, I agree with
> Stolee's reasoning that this should be a breaking change. If we were,
> say, several months into having Bloom filters in a release and decided
> at that point to make the change, then: sure, supporting both by writing
> a bit in the BDAT chunk makes sense.
> 
> But, we're many months away from that state yet, and so I don't think
> the cost of rebuilding what few commit-graphs exist with bloom filters
> in them today to support both ordinary and lower-cased paths in the
> filter.
> 
> Anyway, I'm still not sold on this idea in general (nor do I understand
> it that others are), so I'll respond in more detail in another part of
> the thread...

I agree that this is not a good direction to go. I created the patch
because I was curious how difficult it would be, and it is good to have
a record of the possible direction. However, it complicates the file
format and will have unpredictable effects on the entropy (or on the
performance of history for case-colliding paths).

It is good that we have the capability to extend the filter data in
the future if we really need to.

I'll make a TODO item for myself to try writing that detailed Bloom
filter format documentation as a follow-up. In the meantime, I'll try
to close this out by responding to the feedback we have so far.

Thanks,
-Stolee



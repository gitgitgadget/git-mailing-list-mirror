Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DDEC04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2A420720
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFjHiP88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGPhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:37:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33291 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGPhN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 10:37:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so2164704qto.0
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AGg4SwuF/fUmcFuevjy4Oec7CBPmZcLEN7jrMsTc54k=;
        b=sFjHiP88Z+15vcb2InsbAMnsXQA9niJkM5jMQtxx78DpVkeVTvI1phw4fHc6BmPpQy
         /BM+y8ICvDR1RyUvM12855znWj69AFYM8jZipmgHodH9seKVufExXKAOeDfmKCX1DB5o
         Zte06xfVR49y4EZabAflvOSox0t2Jz5pnt79JN5LCEVQ80qwJ32UZCIviBJdLB92z6O+
         VXWMxoWCEIFwZpFArlx41Z1e4r6eb0dTOqbPbIR77+TNja9NJm/ugxzpnPSOtmHEdhBj
         Fm0xM0dWthEUFuF64NfGaJWZ7q7XHokuis/+bG2gVCUpn0dEQoz8tAcS/2wJzVS3ix16
         Qhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGg4SwuF/fUmcFuevjy4Oec7CBPmZcLEN7jrMsTc54k=;
        b=c0T+fb6mz18UGA41d9ZfOl7JwgidF1qbCksUFQ8OZeqgU0cvHvi4ommRQz9X+RHVJk
         bma56lSWkW/9d4n3/dfbUAu27UrxRG4+0wb2xc+i6oYvoEOaDC1HC0yBhr75MBQd7aPU
         AWBLIMrHtldipzrov7xmPtyhgzojubXdTXwdziT8JmT1QhJNhzX/GLtL1qG+YJB0PHDc
         hU67SGgAsUCxBjbUICXsxZP8daGXUqlxtpt968bUY+aosw0LQnQNLW5uOLM+962XFxXk
         8BAPPfzxgQ1uS6NsFbzFGkorKEA/l3H912pOww9WsQq8+EJNg9hLfv+2RpvqF2EZg+hP
         ybuw==
X-Gm-Message-State: APjAAAWexbdZ3Fxp3Qffy+vRhqXUPIH8o3/3JQY8kM24+yvk+GMtSEJZ
        lLP9Bpr4f4X/Oy0A4aT3Ch0=
X-Google-Smtp-Source: APXvYqx+4bwXGbQbgiiWGOVeFH8p47tpUs7smZjoVHk4SurvbsEePAK8Z1kyHIJadtMdKK1w1rMRoQ==
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr7753457qtn.156.1581089832130;
        Fri, 07 Feb 2020 07:37:12 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:439:e50b:6e3c:1277? ([2001:4898:a800:1010:b56e:e50b:6e3c:1277])
        by smtp.gmail.com with ESMTPSA id h7sm1494015qke.30.2020.02.07.07.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:37:00 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
To:     Garima Singh <garimasigit@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        jnareb@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <20200207135249.GD2868@szeder.dev>
 <140cf2f4-23d5-09ab-8f23-bbbd397c68f7@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <88c8e5da-72f2-25cc-f55b-f62500c52a24@gmail.com>
Date:   Fri, 7 Feb 2020 10:36:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <140cf2f4-23d5-09ab-8f23-bbbd397c68f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2020 10:09 AM, Garima Singh wrote:
> 
> On 2/7/2020 8:52 AM, SZEDER Gábor wrote:
>>>  * Added unit tests for the bloom filter computation layer
>>
>> This fails on big endian, e.g. in Travis CI's s390x build:
>>
>>   https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647253022#L2210
>>
>> (The link highlights the failure, but I'm afraid your browser won't
>> jump there right away; you'll have to click on the print-test-failures
>> fold at the bottom, and scroll down a bit...)
>>
> 
> Thank you so much for running this pipeline and pointing out the error!
> 
> We will carefully review our interactions with the binary data and 
> hopefully solve this in the next version. 

Szeder,

Thanks so much for running this test. We don't have access to a big endian
machine right now, so could you please apply this patch and re-run your tests?

The issue is described in the message below, and Garima is working to ensure
the handling of the filter data is clarified in the next version.

This is an issue from WAY back in the original prototype, and it highlights
that we've never been writing the data in network-byte order. This is completely
my fault.

Thanks,
-Stolee


-->8--

From c1067db5d618b2dae430dfe373a11c771517da9e Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 7 Feb 2020 10:24:05 -0500
Subject: [PATCH] fixup! bloom: core Bloom filter implementation for changed
 paths

The 'data' field of 'struct bloom_filter' can point to a memory location
(when computing one before writing to the commit-graph) or a memmap()'d
file location (when reading from the Bloom data chunk of the commit-graph
file). This means that the memory representation may be backwards in
Little Endian or Big Endian machines.

Always write and read bits from 'filter->data' using network order. This
allows us to avoid loading the data streams from the file into memory
buffers.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c               | 6 ++++--
 t/helper/test-bloom.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index 90d84dc713..aa6896584b 100644
--- a/bloom.c
+++ b/bloom.c
@@ -124,8 +124,9 @@ void add_key_to_filter(struct bloom_key *key,
 	for (i = 0; i < settings->num_hashes; i++) {
 		uint64_t hash_mod = key->hashes[i] % mod;
 		uint64_t block_pos = hash_mod / BITS_PER_WORD;
+		uint64_t bit = get_bitmask(hash_mod);
 
-		filter->data[block_pos] |= get_bitmask(hash_mod);
+		filter->data[block_pos] |= htonll(bit);
 	}
 }
 
@@ -269,7 +270,8 @@ int bloom_filter_contains(struct bloom_filter *filter,
 	for (i = 0; i < settings->num_hashes; i++) {
 		uint64_t hash_mod = key->hashes[i] % mod;
 		uint64_t block_pos = hash_mod / BITS_PER_WORD;
-		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
+		uint64_t bit = get_bitmask(hash_mod);
+		if (!(filter->data[block_pos] & htonll(bit)))
 			return 0;
 	}
 
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 9b4be97f75..09b2bb0a00 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -23,7 +23,7 @@ static void print_bloom_filter(struct bloom_filter *filter) {
 	printf("Filter_Length:%d\n", filter->len);
 	printf("Filter_Data:");
 	for (i = 0; i < filter->len; i++){
-		printf("%"PRIx64"|", filter->data[i]);
+		printf("%"PRIx64"|", ntohll(filter->data[i]));
 	}
 	printf("\n");
 }
-- 
2.25.0.vfs.1.1.1.g9906319d24.dirty




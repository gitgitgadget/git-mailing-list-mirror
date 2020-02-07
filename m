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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC5C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E427721775
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbNV5F7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGQPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:15:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42451 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGQPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 11:15:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so3330309wrd.9
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9FU8/cbdAQ1B1ZzTlVWewCaR8fMm+oM2/yH7sJGlBfw=;
        b=fbNV5F7IrIbf1Gef9KhXff+jBHqez6H4+lx3vLuggpetFj2/h/mKL9jDGVnuiXwUXY
         8Qc08+RFkmuRvJNQTDOBd6Y9Bp3yi/tTZgfnN5wgsD3WZTjGUEW78bJsRXik1LfCSZAw
         QaUuAq7LdJtbyuoVGNjj6GfgimTdVzYyI5PkWauAo+EmPuXEpPtYVsPV9fu1V8XNpyFn
         Fp0J760xfkHEsd+2ea7dH5Jj3p9faUv4LTgiZxX5VMmq6mDkRf+ualsO/j7RSjxOsYZf
         Wtx/nLJ3vT92aYh8PW7aHq6nFLYx+kIGBXl5Bz2mBemljPmX9/Gy1UAyRtgntSaLwL2I
         NcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9FU8/cbdAQ1B1ZzTlVWewCaR8fMm+oM2/yH7sJGlBfw=;
        b=WYxvpVs8BEKvwCNAP/XmYwyd5fTOj2kGeRbf0L03uG7s3UjPD4s2to/Gb7DoAFJq4S
         T/c7HECpicKDsFdJKoORhcCUQsNBN9ndQ63HKCskCVOyRRR4QLR7yqhyx2DMsfJtiHTy
         OqAVfMp/3Id340TnIS5LOZPPqWnz/ZuLlaKLc943RnQVtNwK2dOGV6LGe7P5TBn8NmGm
         Tdd1q+ZlDDO2kt5LxeHoFFiEUA0fRxDkI0ZyRgMUVf2r9fjAAHgcPijhZQKwaficjzjR
         M/NGP1cZaoUAmUyoUx1twpgyJXoXOEQUxy62Sy/YGh5cu2Rv8zN+BQBOlE3k6BM/FaNi
         RAmQ==
X-Gm-Message-State: APjAAAV3SfcqTO0q0cEMiOkItI59PCl+kQQQlI2xuzEgF3zyvWX8mEje
        QeA5GNAj2OeOBtVHZ8aEwwI=
X-Google-Smtp-Source: APXvYqxeCm8cmiJCs4cs7rcAIeg7CZomDprLuHq+z+7aGDhjgty7FJvhcASDQa+9AUnu+zgXwmdq8w==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr5416308wrq.123.1581092134904;
        Fri, 07 Feb 2020 08:15:34 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id y8sm3820969wma.10.2020.02.07.08.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:15:33 -0800 (PST)
Date:   Fri, 7 Feb 2020 17:15:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh <garimasigit@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        jnareb@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
Message-ID: <20200207161528.GA18146@szeder.dev>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <20200207135249.GD2868@szeder.dev>
 <140cf2f4-23d5-09ab-8f23-bbbd397c68f7@gmail.com>
 <88c8e5da-72f2-25cc-f55b-f62500c52a24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88c8e5da-72f2-25cc-f55b-f62500c52a24@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 10:36:58AM -0500, Derrick Stolee wrote:
> On 2/7/2020 10:09 AM, Garima Singh wrote:
> > 
> > On 2/7/2020 8:52 AM, SZEDER Gábor wrote:
> >>>  * Added unit tests for the bloom filter computation layer
> >>
> >> This fails on big endian, e.g. in Travis CI's s390x build:
> >>
> >>   https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647253022#L2210
> >>
> >> (The link highlights the failure, but I'm afraid your browser won't
> >> jump there right away; you'll have to click on the print-test-failures
> >> fold at the bottom, and scroll down a bit...)
> >>
> > 
> > Thank you so much for running this pipeline and pointing out the error!
> > 
> > We will carefully review our interactions with the binary data and 
> > hopefully solve this in the next version. 
> 
> Szeder,
> 
> Thanks so much for running this test. We don't have access to a big endian
> machine right now, so could you please apply this patch and re-run your tests?

Unfortunately, it still failed:

  https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647395554#L2204

> The issue is described in the message below, and Garima is working to ensure
> the handling of the filter data is clarified in the next version.
> 
> This is an issue from WAY back in the original prototype, and it highlights
> that we've never been writing the data in network-byte order. This is completely
> my fault.
> 
> Thanks,
> -Stolee
> 
> 
> -->8--
> 
> From c1067db5d618b2dae430dfe373a11c771517da9e Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Fri, 7 Feb 2020 10:24:05 -0500
> Subject: [PATCH] fixup! bloom: core Bloom filter implementation for changed
>  paths
> 
> The 'data' field of 'struct bloom_filter' can point to a memory location
> (when computing one before writing to the commit-graph) or a memmap()'d
> file location (when reading from the Bloom data chunk of the commit-graph
> file). This means that the memory representation may be backwards in
> Little Endian or Big Endian machines.
> 
> Always write and read bits from 'filter->data' using network order. This
> allows us to avoid loading the data streams from the file into memory
> buffers.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c               | 6 ++++--
>  t/helper/test-bloom.c | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/bloom.c b/bloom.c
> index 90d84dc713..aa6896584b 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -124,8 +124,9 @@ void add_key_to_filter(struct bloom_key *key,
>  	for (i = 0; i < settings->num_hashes; i++) {
>  		uint64_t hash_mod = key->hashes[i] % mod;
>  		uint64_t block_pos = hash_mod / BITS_PER_WORD;
> +		uint64_t bit = get_bitmask(hash_mod);
>  
> -		filter->data[block_pos] |= get_bitmask(hash_mod);
> +		filter->data[block_pos] |= htonll(bit);
>  	}
>  }
>  
> @@ -269,7 +270,8 @@ int bloom_filter_contains(struct bloom_filter *filter,
>  	for (i = 0; i < settings->num_hashes; i++) {
>  		uint64_t hash_mod = key->hashes[i] % mod;
>  		uint64_t block_pos = hash_mod / BITS_PER_WORD;
> -		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
> +		uint64_t bit = get_bitmask(hash_mod);
> +		if (!(filter->data[block_pos] & htonll(bit)))
>  			return 0;
>  	}
>  
> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> index 9b4be97f75..09b2bb0a00 100644
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -23,7 +23,7 @@ static void print_bloom_filter(struct bloom_filter *filter) {
>  	printf("Filter_Length:%d\n", filter->len);
>  	printf("Filter_Data:");
>  	for (i = 0; i < filter->len; i++){
> -		printf("%"PRIx64"|", filter->data[i]);
> +		printf("%"PRIx64"|", ntohll(filter->data[i]));
>  	}
>  	printf("\n");
>  }
> -- 
> 2.25.0.vfs.1.1.1.g9906319d24.dirty
> 
> 
> 

Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4A6C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65802223D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSfx3Ql0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgIQOpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgIQOdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:33:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71621C06178B
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 06:38:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v54so1829507qtj.7
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6bhYox/ID8gJEo1iJ8GCqIY5xNVAc/8Q70yq7lsVYtc=;
        b=dSfx3Ql0LRlF7AVn5W7XcRyXODAm7UzuKvTycngH6PHcD/z+6sQY1uVpWLKYMBNjBw
         5kt2dKMLUncwReTp4TBmp3kLtY0tEohQrOJCgOI4ZwhISdHMThycTNPyEY1T0X428Wdy
         Mf6OPaYtxY9OtZp9hbmosrqrPxVhkibq3S7AcblijTENn/ICiukDpGsy7wkKSOCREAOe
         pfUmeNitN4xxEabEQnvujz4Nhq6ziltt6kdEHEc3Y4cDBn7nsyjv4tCcSz3sjysrPpxe
         FPtt3klmdQ64VGJzXnZzv8rRQKmj0Or/16/nE12jXtGTx1Jg9lE02/BphrHIu4k+WIV8
         BZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6bhYox/ID8gJEo1iJ8GCqIY5xNVAc/8Q70yq7lsVYtc=;
        b=jLI1uS3Q1Dk0jZ198ZP1dHuY88Ea3k7ISOAUHVMnxXfN69TjRe8htMhl/ffPWC2LTA
         SCujQ7De37mYGHetSlpdXxxSVjGVJ1i26Uy1NM0uM7FVBm+PU+e3sQCm9DXP8OP/MidN
         sG0epj3ZRY9ySXq27mf2oinsRY2jqtWhvurKcJ+A8frSjUARcCXVJMstZswvHBFdkHFo
         DCetEOOaKD0TV8DWjxE8ETBLEQ75J6ULIjNF4y9fNNEIH5DsAXayZfLjhrxqvM3d3EuN
         +XqlHm6tJ2DsaV+4lY5TYIAPUrQ8qrejF26KW26y7eYhdy1PpaRA928gj6K8I8J/f2oO
         O59g==
X-Gm-Message-State: AOAM533p1YZJyD1s5hkjneTKt3FRhh3wlohoyCr0Rylu5oEFukPD4v9m
        qU97oCuipiBzZLX5TB2/ItbpbKHof9C5sw==
X-Google-Smtp-Source: ABdhPJxFHan2aXaYst8WVUf7W+5u+ysaoovRGR6peSe8VK5fQRPKbpWFanqAWfH0jbu0jPIFQuVSHg==
X-Received: by 2002:ac8:711a:: with SMTP id z26mr7881662qto.75.1600349890547;
        Thu, 17 Sep 2020 06:38:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:acfa:efc8:96e3:6e10? ([2600:1700:e72:80a0:acfa:efc8:96e3:6e10])
        by smtp.gmail.com with ESMTPSA id z3sm21188622qkj.0.2020.09.17.06.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:38:09 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] more miscellaneous Bloom filter improvements,
 redux
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        szeder.dev@gmail.com
References: <20200917004518.GA6478@nand.local>
 <xmqqd02ltdzl.fsf@gitster.c.googlers.com> <20200917011049.GB6478@nand.local>
 <20200917133442.GA12879@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5caab572-1ef0-4a68-76a1-828a2f69cb6d@gmail.com>
Date:   Thu, 17 Sep 2020 09:38:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200917133442.GA12879@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/17/2020 9:34 AM, Taylor Blau wrote:
> Junio,
> 
> On Wed, Sep 16, 2020 at 09:10:49PM -0400, Taylor Blau wrote:
>> I should have the patch in your inbox by the end of tonight, depending
>> on how fast my workstation can run the ASan-enabled test suite 13 times
>> ;).
> 
> All finished. This is sufficient to fix the ASan-enabled test suite,
> along with fixing a bug where we wouldn't respect the limit on changed
> paths when loading an existing commit-graph. This has nothing to do with
> the user-specified '--max-new-filters', nor does it mean that we're
> storing the limit in the commit-graph file. Instead it's because we're
> loading the bloom_filter_settings struct from the graph and
> initializing it ourselves, instead of using the default values (which is
> the case when we don't load a graph at all).
> 
> Anyway, let's use this instead of 6/13. Here's an inter-diff that shows
> the fix and test change:
> 
>   diff --git a/commit-graph.c b/commit-graph.c
>   index 33af6c2430..fc6c6fdc3e 100644
>   --- a/commit-graph.c
>   +++ b/commit-graph.c
>   @@ -424,6 +424,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
>           graph->bloom_filter_settings->hash_version = hash_version;
>           graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
>           graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
>   +				graph->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;

This whitespace looks strange in the inter-diff...

>  				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
> +				graph->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;

...but it is correct in the patch itself.

> -	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2.txt &&
> +	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
>  	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
>  		GIT_TRACE2_EVENT_NESTING=5 \
>  		git commit-graph write --reachable --changed-paths &&
> -	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
> +	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt

I appreciate the additional tests to guarantee this is set
correctly.

Thanks,
-Stolee


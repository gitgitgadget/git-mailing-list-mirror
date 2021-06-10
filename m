Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D602C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 18:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786D761404
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 18:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhFJSYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:24:18 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:37764 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhFJSYO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 14:24:14 -0400
Received: by mail-qt1-f180.google.com with SMTP id z4so584829qts.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DCFzyr8H4Dd9uhFhnepw2TGXq7BXBRapdAZ7pPpCNSs=;
        b=UueowoP1yo/KEC5LTNyN9PGHXN5LNEXuIYtpsRGzJAe3QjmU1Pj/AsifgxUSO0xHpk
         Nw4m7JI6KFOC3zT7jdUs8rRaktBU2hAc1AjwpMb2m/kTMrMN3+ElmH56DupPdxUU+cVU
         jySz60hVmSTR+HpSqzFDzsi5xfguIuarA4Cj7YgMJ3/IcgYSenoVXWCPW/wAIxaVAoWX
         dWEaqclV8ma7dA8OL3rlt7VKiIVdbb/KjuJl4RDzENSoLxCq530O511EFYOrxWart0E0
         /MvanaTeetGePQDY3aBjdYMGrDqfvJtPg1S9IwUfydHVzJe791csSbj69DSBqhW17/Co
         u1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DCFzyr8H4Dd9uhFhnepw2TGXq7BXBRapdAZ7pPpCNSs=;
        b=ErCv43HM1OSTEZmseQ8rCV03gGaHJ3jXGYLLCKr6dzjBon8x2ecpgEDDob8Lym3TD+
         IsT6SmlLHu3/X1L1uvgoNGHOWijcY1QehQB+ZKQk91K0IW+pUq0nK8ea9wgjND6m/CSd
         iT/4YqyrepNcIi+e4JlGjkXh2AWg/B27QTqhkILMB2YGASTguCwBdhJlDPu4uapQ2cR2
         AbFPSazV2G4DfV5lYGudqSYSd3cd3G1fuYV73FuTv693DXFSzMT/c8JllvlTR0FjnDpL
         CEY9rurIvxYGS2tXh3WvJHFO/dzNoKkpl+3oz4L6HXiIVaTmL4QmNlFS+LG4WAKZGKgE
         NGbg==
X-Gm-Message-State: AOAM5324vK7wrDQXYbbwdsS3Woh1aXzy9qetBKuqdRqcTHAPBw5jzucv
        FWZdUzZx7uihiCXS2xHIXrU=
X-Google-Smtp-Source: ABdhPJwCflfJkXQSFYgP2gOJfLMuc09y4/IiO3KVO6wSfo1XEEbvPsyZu+ShRGVs/JCxprUn67LwtA==
X-Received: by 2002:ac8:5815:: with SMTP id g21mr110182qtg.266.1623349277636;
        Thu, 10 Jun 2021 11:21:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8dd3:e726:fe78:a0d9? ([2600:1700:e72:80a0:8dd3:e726:fe78:a0d9])
        by smtp.gmail.com with ESMTPSA id y20sm2665391qtv.64.2021.06.10.11.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:21:17 -0700 (PDT)
Subject: Re: Making split commit graphs pick up new options (namely
 --changed-paths)
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, szeder.dev@gmail.com
References: <871r9a2dol.fsf@evledraar.gmail.com> <YMJKcHpN/gL5U6KK@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39a675dc-d6fd-c81c-3d73-c1b1a163f10d@gmail.com>
Date:   Thu, 10 Jun 2021 14:21:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMJKcHpN/gL5U6KK@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2021 1:22 PM, Taylor Blau wrote:
> On Thu, Jun 10, 2021 at 12:40:33PM +0200, Ævar Arnfjörð Bjarmason wrote:
...
>> Reading the code there seems to be no way to do that, and we have the
>> "chunk_bloom_data" in the graph, as well as "bloom_filter_settings".
>>
>> I'd expect some way to combine the "max_new_filters" and --split with
>> some eventual-consistency logic so that graphs not matching our current
>> settings are replaced, or replaced some <limit> at a time.
> 
> This is asking about something slightly different, Bloom filter
> settings rather than the existence of chagned-path Bloom filters
> themselves. The Bloom settings aren't written to the commit-graph
> although there has been some discussion about doing this in the past.

Some of the settings are included, but not the "maximum size" of a
filter. Thus, if that maximum size changes we do not have a way to
determine if a missing filter is larger than that limit or not.
Further, the existing filters might be larger than the new maximum
which means we would need to check if some of those filters should
be dropped.

Here is the spec of the BDAT chunk:

Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
    * It starts with header consisting of three unsigned 32-bit integers:
      - Version of the hash algorithm being used. We currently only support
	value 1 which corresponds to the 32-bit version of the murmur3 hash
	implemented exactly as described in
	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
	in Probabilistic Verification"
      - The number of times a path is hashed and hence the number of bit positions
	      that cumulatively determine whether a file is present in the commit.
      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
	      contains 'n' entries, then the filter size is the minimum number of 64-bit
	      words that contain n*b bits.
    * The rest of the chunk is the concatenation of all the computed Bloom
      filters for the commits in lexicographic order.

> If we ever did encode the Bloom settings, I imagine that accomplishing a
> sort of "eventually replace all changed-path Bloom filters with these
> new settings" would be as simple as considering all filters computed
> under different settings to be "uncomputed".
> 
>> Also, am I reading the expire_commit_graphs() logic correctly that we
>> first write the split graph, and then unlink() things that are too old?
>> I.e. if you rely on the commit-graph to optimize things this will make
>> things slower until the next run of writing the graph?
> 
> Before expire_commit_graphs() is called, we call mark_commit_graphs()
> which freshens the mtimes of all surviving commit-graph layers, and then
> expire_commit_graphs() removes the stale layers. I'm not sure what
> things getting slower is referring to since the resulting commit-graph
> has at least as many commits as the commit-graph that existed prior to
> the write.
> 
>> I expected to find something more gentle there [...]
> 
> FWIW, I also find this "expire based on mtimes" thing a little odd for
> writing split commit-graphs because we know exactly which layers we want
> to get rid of. I suspect that the reuse comes from wanting to unify the
> logic for handling '--expire-time' with the expiration that happens
> after writing a split commit-graph that merged two or more previous
> layers.
> 
> I would probably change mark_commit_graphs() to remove those merged
> layers explicitly (but still run expire_commit_graphs() to handle
> --expire-time). But, come to think of it... if merging >2 layers already
> causes the merged layers to be removed, then why would you ever set an
> --expire-time yourself?

The --expire-time is intended to leave the old layers around a while
so concurrent processes who already parsed the commit-graph-chain file
can discover the layers it referenced. It's not a perfect mechanism, so
there is room for improvement here.

Thanks,
-Stolee

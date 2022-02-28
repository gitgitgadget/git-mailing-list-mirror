Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9A7C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 20:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiB1UZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 15:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiB1UZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 15:25:08 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600D56758
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 12:24:29 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s5so14307724oic.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 12:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S4MN/UPMRvLJTrCwAIoZY2A1xKkfuslaMrhz1qNFHCM=;
        b=avGYWDwS90UoGcfHxQlv0PAwEgXzRchYKQ6yLna4qa08kLUwFbd56iABK8voZJXMM6
         4gYcEPbG/O7E2l5byrwAFx2Yf/tRety7S5hRXZ0ZfXn5BT/jKxwKRYJXXWoCLXTjDJac
         oJlEp+DuTC3XgTTaG8CVC4ZwbU+qxRemZUhVumSJzgN5AqZ8OiiaKtECj8zj12+1EW8E
         C6xwJapykXKW26svOzaEZdkCzXz9abZM+Hffa6qbUwzBK81wjpV4jpKDINJ1+rr92DLI
         bCKkVo50NZci9gz574NJdm+zPGSZNynF8OtYHuUR4VlOAXEODPV1+f3qy4TPaQyS9ktP
         H8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S4MN/UPMRvLJTrCwAIoZY2A1xKkfuslaMrhz1qNFHCM=;
        b=t0Sq+rsOcNvO5oz7Rj70Ul186Jm1ciE5wEhTTO+J4aBtuEojXC5OPsp8xxwRaaF+aw
         l0uQSbtjHv7Jm2XXlaxAffrTkVwGUvXDfVsWU0jDaXW10dVG+cj3BJKkcWdigKCHbyIh
         pCYf+oayUZsa88Ps7AbRAA/OLB7g66dMpwVLpmVZWeSMx2kNvOZGtdsd6avGOdGiZg1C
         mr7alcm3Fkb0vTmH5Ilvzg15olxAXdaQImd1QZA9HnG5251hHLiipbEV4JSVydwr6xFn
         XZxrbkOPnmlyafnkoNKJXoPhcFTr85SDq/49t6K9c4RbY/NF7HVGgb6Zj0soD3IrCQdD
         NdGg==
X-Gm-Message-State: AOAM531o/urX8IGa53eIV6cb1r3P75sMEZZnKAqdCy2eUrbqBrzUGb7X
        Naj8pAxg0l7VSQOrbCPbUalAI4AXL/aj
X-Google-Smtp-Source: ABdhPJybt0iygg/Sj7NZU2BM01IW/FxtTYdqUKFHOfj7hy87JC/kuFya5hXrFgFaddutEhzbFKnYoQ==
X-Received: by 2002:a05:6808:14c9:b0:2d6:4d89:d467 with SMTP id f9-20020a05680814c900b002d64d89d467mr12056748oiw.173.1646079868920;
        Mon, 28 Feb 2022 12:24:28 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bc24-20020a056808171800b002d722aead50sm6551210oib.27.2022.02.28.12.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:24:28 -0800 (PST)
Message-ID: <117ed093-f3e0-ba24-2364-74e43a1306fe@github.com>
Date:   Mon, 28 Feb 2022 15:24:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] name-rev: use generation numbers if available
Content-Language: en-US
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20220228190738.2112503-1-jacob.e.keller@intel.com>
 <e4096124-e566-0842-f17c-366645c3e37c@github.com>
 <15ce47f3-a726-75d1-3d3d-869331b24230@intel.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <15ce47f3-a726-75d1-3d3d-869331b24230@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2022 3:20 PM, Keller, Jacob E wrote:
> On 2/28/2022 11:50 AM, Derrick Stolee wrote:
>> On 2/28/2022 2:07 PM, Jacob Keller wrote:
>>> From: Jacob Keller <jacob.keller@gmail.com>
>>> +/* Check if a commit is before the cutoff. Prioritize generation numbers
>>> + * first, but use the commit timestamp if we lack generation data.
>>> + */
>>> +static int commit_is_before_cutoff(struct commit *commit)
>>> +{
>>> +	if (generation_cutoff < GENERATION_NUMBER_INFINITY)
>>> +		return commit_graph_generation(commit) < generation_cutoff;
>>> +
>>> +	return commit->date < cutoff;
>>> +}
>>
>> There are two subtle things going on here when generation_cutoff is
>> zero:
>>
>> 1. In a commit-graph with topological levels _or_ generation numbers v2,
>>    commit_graph_generation(commit) will always be positive, so we don't
>>    need to do the lookup.
> 
> I.e. once we have a generation_cutoff of 0 we can just completely bypass
> the lookup, saving some time.
> 
> I think we can do "return generation_cutoff &&
> commit_graph_generation(commit) < generation_cutoff"
> 
>>
>> 2. If the commit-graph was written by an older Git version before
>>    topological levels were implemented, then the generation of commits
>>    in the commit-graph are all zero(!). This means that the logic here
>>    would be incorrect for the "all" case.
>>
>> The fix for both cases is to return 1 if generation_cutoff is zero:
>>
> 
> I think you mean return 0? Because this returns true if the commit is
> before the cutoff, but false if its not. (i.e. if its true, we should
> stop searching this commit, but if its false we should continue searching?

Yes, sorry I had it mixed up. Your generation_cutoff && ... approach
will work in that case.

>>> +test_expect_success 'name-rev --all works with non-monotonic' '
>>
>> This is working because of the commit-graph, right? We still have
>> it from the previous test, so we aren't testing that this works
>> when we only have the commit date as a cutoff.
>>
> 
> I can either extend this test or add a separate test which covers this.
> The test failed before I added the commit graph line.
> 
>>> +	(
>>> +		cd non-monotonic &&
>>> +
>>> +		cat >expect <<-\EOF &&
>>> +		E
>>> +		D
>>> +		D~1
>>> +		D~2
>>> +		A
>>> +		EOF
>>> +
>>> +		git log --pretty=%H >revs &&
>>> +		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
>>> +
>>> +		test_cmp expect actual
>>> +	)
>>
>> Do you want to include a test showing the "expected" behavior
>> when there isn't a commit-graph file? You might need to delete
>> an existing commit-graph (it will exist in the case of
>> GIT_TEST_COMMIT_GRAPH=1).
>>
> 
> This test actually is intended to show that it works regardless of
> whether we have a commit graph. (Because in --annotate-stdin mode we
> disable the heuristic since we don't know what commits we'll see in advance)
> 
> Is there a good way to delete the graph file?

The basic way is "rm -rf .git/info/commit-graph*" to be absolutely
sure (there might be an incremental commit-graph which appears as
a "commit-graphs" directory).
 
>> I also see that you intended to test the "--all" option, which
>> is not included in your test. That's probably the real key to
>> getting this test to work correctly. Deleting the graph will
>> probably cause a failure on this test unless "--all" is added.
>>
> 
> Actually both --all and --annotate-stdin disable the heuristic. However,
> I think adding a test for both makes sense.

Ah. OK. They could be assertions within the same test since the
output is expected to be the same.

Thanks,
-Stolee

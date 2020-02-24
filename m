Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D5C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEF720732
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 17:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry7LXXnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgBXReI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:34:08 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42618 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgBXReH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 12:34:07 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so4474527qvb.9
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CbGxu3an7ewKmFzKGOlsSePo6LpbfSUaBsEEOXMgle0=;
        b=ry7LXXnAwAmTkr+p3N32QCcRq2L5T39w0IrP5X1gWW1uE2+XT69m2IBVaZnAPk2Wd2
         f9TAa+ULpuwivaXOoJD1wq+PdXUvy1QC1AWWaJ4rt1EkGy/LQE9zWHkBK2AiT0sACQK2
         b49SJIbljgXHweXUZDU7V7PvBnkKi7Tlkt68VgGW3og6SZvSyQiHwVcxHMYefJbv72px
         T2gmdMP3dLYhFn0337+ObCUBLInxk5loFZ6yaYzfklW1O4iIodHJZU3pNitIJpxDy4VY
         FP0/EWk8Gg2MWOkx2S/Yyk5HdBRDSf4BhzVPJWgOAsb+Y2Wgyyp4JzgV69reBpK8XrJS
         8pOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CbGxu3an7ewKmFzKGOlsSePo6LpbfSUaBsEEOXMgle0=;
        b=ID/4gDx3MMNs+0COrBAMcLYYDKl/XZQn57EYVbx9OmJWF0oKAHTJf13wHzSjt9nB3l
         db5nF0tKd2SuuDa2ajSVCLFsgBFOUv3FuyemVDEkXnjAZ7PB121a0XXZHMnlIN71NpyF
         gmG2MI85mSWMN9cvKVGn6KCrkuFtwZnvH2MDPoGxI0OiJrfbLj0MncTE0gFcFwVuRWqs
         OTdE3P21+4BtnrVvSMtCq8hsz83IWCFLVOZaA39glfMVvL/sm82XvFxzyX8F3oJwyDWo
         7mAdQ1fCwWjnPn5cO2nORiipcQfZTHTWRXrJg7kz9K9ftZh2YS12fRA1sGd1UBoMBfHr
         6hBQ==
X-Gm-Message-State: APjAAAUVizs0/FHLC2EKNQlEYcw7ErXeMbd2r1PL5y7ByjiGo6mjNju4
        biTqkNoaLmqH9oIQQJLT95U=
X-Google-Smtp-Source: APXvYqyUlGBkUr9mV6jGkKaGrPOxU6JhboQ7RremEBwiF9L0wuGnuHpOO/F1I4SBEBamtfgjYxJO7Q==
X-Received: by 2002:a0c:9d4f:: with SMTP id n15mr46543727qvf.194.1582565646325;
        Mon, 24 Feb 2020 09:34:06 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:68d1:9775:6b44:857a? ([2001:4898:a800:1010:1a08:9775:6b44:857a])
        by smtp.gmail.com with ESMTPSA id 123sm6153029qkj.113.2020.02.24.09.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 09:34:05 -0800 (PST)
Subject: Re: [PATCH v2 02/11] bloom: core Bloom filter implementation for
 changed paths
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
 <02b16d94227470059dcee2781e29ae7ae010f602.1580943390.git.gitgitgadget@gmail.com>
 <86tv3qqxyn.fsf@gmail.com> <a6c08b27-18d7-cf30-c076-3f6451a21519@gmail.com>
 <86wo8d8lus.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <8f7a6168-8555-0a37-9945-1dc41d85c50d@gmail.com>
Date:   Mon, 24 Feb 2020 12:34:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <86wo8d8lus.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/23/2020 8:38 AM, Jakub Narebski wrote:
> Garima Singh <garimasigit@gmail.com> writes:
>> On 2/16/2020 11:49 AM, Jakub Narebski wrote:
>>>> From: Garima Singh <garima.singh@microsoft.com>
>>>>
>>>> Add the core Bloom filter logic for computing the paths changed between a
>>>> commit and its first parent. For details on what Bloom filters are and how they
>>>> work, please refer to Dr. Derrick Stolee's blog post [1]. It provides a concise
>>>> explaination of the adoption of Bloom filters as described in [2] and [3].
>>>                                                                           ^^- to add
>>
>> Not sure what this means. Can you please clarify. 
>>
>>>> 1. We currently use 7 and 10 for the number of hashes and the size of each
>>>>    entry respectively. They served as great starting values, the mathematical
>>>>    details behind this choice are described in [1] and [4]. The implementation,
>>>                                                                                ^^- to add
>>
>> Not sure what this means. Can you please clarify.
> 
> I'm sorry for not being clear.  What I wanted to say that in both cases
> the last line should have ended in either full stop in first case, or
> comma in second case:
> 
>   "as described in [2] and [3]."
> 
>   "The implementation,"
> 
> What I wrote (trying to put the arrow below final fullstop or comma)
> only works when one is using with fixed-width font.
> 

Aah. Cool. Thanks! 

>>>> ---
>>>>  Makefile              |   2 +
>>>>  bloom.c               | 228 ++++++++++++++++++++++++++++++++++++++++++
>>>>  bloom.h               |  56 +++++++++++
>>>>  t/helper/test-bloom.c |  84 ++++++++++++++++
>>>>  t/helper/test-tool.c  |   1 +
>>>>  t/helper/test-tool.h  |   1 +
>>>>  t/t0095-bloom.sh      | 113 +++++++++++++++++++++
>>>>  7 files changed, 485 insertions(+)
>>>>  create mode 100644 bloom.c
>>>>  create mode 100644 bloom.h
>>>>  create mode 100644 t/helper/test-bloom.c
>>>>  create mode 100755 t/t0095-bloom.sh
>>>
>>> As I wrote earlier, In my opinion this patch could be split into three
>>> individual single-functionality pieces, to make it easier to review and
>>> aid in bisectability if needed.
>>
>> Doing this in v3. 
> 
> Thanks.  Though if it makes (much) more work for you, I can work with
> unsplit patch, no problem.
> 

Thanks! That's great! Splitting the patches will add some overhead. I will 
try and do it provided it does not delay getting v3 on the list. 

>>>> +
>>>> +static uint32_t rotate_right(uint32_t value, int32_t count)
>>>> +{
>>>> +	uint32_t mask = 8 * sizeof(uint32_t) - 1;
>>>> +	count &= mask;
>>>> +	return ((value >> count) | (value << ((-count) & mask)));
>>>> +}
>>>
>>> Hmmm... both the algoritm on Wikipedia, and reference implementation use
>>> rotate *left*, not rotate *right* in the implementation of Murmur3 hash,
>>> see
>>>
>>>   https://en.wikipedia.org/wiki/MurmurHash#Algorithm
>>>   https://github.com/aappleby/smhasher/blob/master/src/MurmurHash3.cpp#L23
>>>
>>>
>>> inline uint32_t rotl32 ( uint32_t x, int8_t r )
>>> {
>>>   return (x << r) | (x >> (32 - r));
>>> }
>>
>> Thanks! Fixed this in v3. More on it later. 
> 
> Sidenote: If I understand it correctly Bloom filters functionality is
> included in Scalar [1].  What will happen then with all those Bloom
> filter chunks in commit-graph files with wrong hash functions?
> 
> [1]: https://devblogs.microsoft.com/devops/introducing-scalar/
> 

It is not included in Scalar. Scalar will write to the commit-graph in 
the background using the features available in the git version it is working
with. It will update to include changed path Bloom filters when they are 
available in git. We are not taking the Bloom filter into microsoft/git 
until the format is approved and accepted by the core git community.

>>>> +{
>>>> +	const uint32_t c1 = 0xcc9e2d51;
>>>> +	const uint32_t c2 = 0x1b873593;
>>>> +	const uint32_t r1 = 15;
>>>> +	const uint32_t r2 = 13;
>>>> +	const uint32_t m = 5;
>>>> +	const uint32_t n = 0xe6546b64;
>>>> +	int i;
>>>> +	uint32_t k1 = 0;
>>>> +	const char *tail;
>>>> +
>>>> +	int len4 = len / sizeof(uint32_t);
>>>> +
>>>> +	const uint32_t *blocks = (const uint32_t*)data;
>>>> +
>>>> +	uint32_t k;
>>>> +	for (i = 0; i < len4; i++)
>>>> +	{
>>>> +		k = blocks[i];
>>>
>>> IMPORTANT: There is a comment around there in the example implementation
>>> in C on Wikipedia that this operation above is a source of differing
>>> results across endianness.  
>>
>> Thanks! SZEDER found this on his CI pipeline and we have fixed it to 
>> process the data in 1 byte words to avoid hitting any endian-ness issues. 
>> See this part of the thread that carries the fix and the related discussion. 
>>   https://lore.kernel.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.com/
>> I will be squashing those changes in appropriately in v3.  
> 
> [...]
>>>> +		k1 *= c2;
>>>> +		seed ^= k1;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	seed ^= (uint32_t)len;
>>>> +	seed ^= (seed >> 16);
>>>> +	seed *= 0x85ebca6b;
>>>> +	seed ^= (seed >> 13);
>>>> +	seed *= 0xc2b2ae35;
>>>> +	seed ^= (seed >> 16);
>>>> +
>>>> +	return seed;
>>>> +}
>>>
>>> In https://public-inbox.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.com/
>>> you posted "[PATCH] Process bloom filter data as 1 byte words".
>>> This may avoid the Big-endian vs Little-endian confusion,
>>> that is wrong results on Big-endian architectures, but
>>> it also may slow down the algorithm.
>>
>> Oh cool! You have seen that patch. And yes, we understand that it might add 
>> a little overhead but at this point it is more important to be correct on all
>> architectures instead of micro-optimizing and introducing different 
>> implementations for Little-endian and Big-endian. This would make this 
>> series overly complicated. Optimizing the hashing techniques would deserve a
>> series of its own, which we can definitely revisit later.
> 
> Right, "first make it work, then make it right, and, finally, make it fast.".
> 
> Anyway, could you maybe compare performance of Git for old version
> (operating on 32-bit/4-bytes words) and new version (operating on 1-byte
> words) file history operation with Bloom filters, to see if it matters
> or not?
> 

We chose to switch to 1 byte words for correctness, not performance. 
Also, this specific implementation choice is a very small portion of the 
end to end time spent computing and writing Bloom filters. We run two murmur3 
hashes per path, which is one path per `git log` query; and one path per change 
after parsing trees to compute a diff. Measuring performance and micro-optimizing 
is not worth the effort and/or trading in the simplicity here.


>>>> +
>>>> +struct bloom_filter *get_bloom_filter(struct repository *r,
>>>> +				      struct commit *c)
>>>> +{
>>>> +	struct bloom_filter *filter;
>>>> +	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>>>> +	int i;
>>>> +	struct diff_options diffopt;
>>>> +
>>>> +	if (!bloom_filters.slab_size)
>>>> +		return NULL;
>>>
>>> This is testing that commit slab for per-commit Bloom filters is
>>> initialized, isn't it?
>>>
>>> First, should we write the condition as
>>>
>>> 	if (!bloom_filters.slab_size)
>>>
>>> or would the following be more readable
>>>
>>> 	if (bloom_filters.slab_size == 0)
>>>
>>
>> Sure. Switched to `if (bloom_filter.slab_size == 0)` in v3. 
> 
> Though either works, and the former looks more like the test if
> bloom_filters slab are initialized, now that I thought about it a bit.
> Your choice.
> 

:) 


>>>> +
>>>> +	if (diff_queued_diff.nr <= 512) {
>>>
>>> Second, there is a minor issue that diff_queue_struct.nr stores the
>>> number of filepairs, that is the number of changed files, while the
>>> number of elements added to Bloom filter is number of changed blobs and
>>> trees.  For example if the following files are changed:
>>>
>>>   sub/dir/file1
>>>   sub/file2
>>>
>>> then diff_queued_diff.nr is 2, but number of elements to be added to
>>> Bloom filter is 4.
>>>
>>>   sub/dir/file1
>>>   sub/file2
>>>   sub/dir/
>>>   sub/
>>>
>>> I'm not sure if it matters in practice.
>>>
>>
>> It does not matter much in practice, since the directories usually tend
>> to collapse across the changes. Still, I will add another limit after 
>> creating the hashmap entries to cap at 640 so that we have a maximum of 
>> 100 changes in the bloom filter. 
>>
>> We plan to make these values configurable later. 
> 
> I'm not sure if it is truly necessary; we can treat limit on number of
> changed paths as "best effort" limit on Bloom filter size.
> 
> I just wanted to point out the difference.
> 

Sure. Not doing this for v3. Glad it got discussed here though!  

> 
> Side note: I wonder if it would be worth it (in the future) to change
> handling commits with large amount of changes.  I was thinking about
> switching to soft and hard limit: soft limit would be on the size of the
> Bloom filter, that is if number of elements times bits per element is
> greater that size threshold, we don't increase the size of the filter.
> 
> This would mean that the false positives ratio (the number of files that
> are not present but get answer "maybe" instead of "no" out of the
> filter) would increase, so there would be a need for another hard limit
> where we decide that it is not worth it, and not store the data for the
> Bloom filter -- current "no data" case with empty filter with length 0.
> This hard limit can be imposed on number of changed files, or on number
> of paths added to filter, or on number of bits set to 1 in the filter
> (on popcount), or some combination thereof.
> 
> [...]

Could be considered in the future. Doesn't make the cut for the current
series though. 

Thanks
Garima Singh

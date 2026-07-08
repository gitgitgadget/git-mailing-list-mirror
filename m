Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33C3A6B65
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546858; cv=none; b=YAyuT1aGjeDOqerdQPOrPQvX66Wj69tSxoVOOeZe78GrDGPfM45Jnw5mNWOLmpBpF7C8GRmIbZnV8rX+MmUlelh8Yn/7qGH143JPNz6LoMUvjBi6W89pi/VfVJcHpS3NZ2yOoT79b3ySdsULB2dYmNqpqIlFjQVmBnV2AFlEwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546858; c=relaxed/simple;
	bh=mX0NQPiahuYtI1UjuIkygXHR5IgCyLs3SUHAdg0+BzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egl26LK27g+HCBRIj/iVFeZn50KikXbbIKoo+n/XVo94vBHGflmCqStJqgzc8ZXTVzFOoP/zLt2AsFf7XpWRqV13afgHXjwPcbyIB/rTUVFVEexRtRNVV6TDglZPPTNuOlqW2SeducpyQraHXxqCzSbJ5nEzfM/Phga22R5iHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gb+qc7l7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gb+qc7l7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=90wzeeRZadsN8hmpjTDBYteBu0BCGzjiwD+7rTp8flg=; b=gb+qc7l7xe9jChB6nrcQmyt4Cj
	Bu5Ur+FOLHWykWjWRDQg+pxP8Z7U/JCb/XdtYSWiixDcUv5DfWJUMNS7S+lgX7aMYh3NCsxicipX8
	AfD7guwSfsOEIYL4psHGCtPELMd/FId7BeLdT6/dVGwuSXtrSB6Xy1m/jre3+Lc89L1/ZEaicSK42
	0ihA+e541RQ9Fc/BRLQUDkj3ksI2+tSOdTieKhTK8Rz5TaQeusTqPSCc4ooRKnKv0ZrvPEgz53R0Q
	Q9H5cpIII4CQgnxbfH3nIDhDitgG3TwgwO7b+2gyZqXcKIeDLtl49ivw5iEW6ipb9QwenCtVTkmIE
	EsXpywMQ==;
Received: from [91.117.33.88] (helo=[192.168.1.137])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wha0b-00BwXB-SN; Wed, 08 Jul 2026 23:40:45 +0200
Message-ID: <c3bd7389-4650-4e5d-a579-8dcb90ea3c47@igalia.com>
Date: Wed, 8 Jul 2026 23:40:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unpack-trees: avoid quadratic index scan in
 next_cache_entry()
To: Junio C Hamano <gitster@pobox.com>
Cc: Henrique Ferreiro via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
 <xmqqv7aqzdvq.fsf@gitster.g>
 <4c0a31e9-9b20-46c8-8f1f-0fda34515270@igalia.com>
 <xmqqzf01thq0.fsf@gitster.g>
Content-Language: en-US
From: Henrique Ferreiro <hferreiro@igalia.com>
In-Reply-To: <xmqqzf01thq0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/07/2026 21:16, Junio C Hamano wrote:
> Henrique Ferreiro <hferreiro@igalia.com> writes:
>
>> On 07/07/2026 23:30, Junio C Hamano wrote:
>>> "Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
>>> writes:
>>>
>>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>>> index b42020f16b..ed9fef453a 100644
>>>> --- a/unpack-trees.c
>>>> +++ b/unpack-trees.c
>>>> @@ -671,8 +671,10 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
>>>>    
>>>>    	while (pos < index->cache_nr) {
>>>>    		struct cache_entry *ce = index->cache[pos];
>>>> -		if (!(ce->ce_flags & CE_UNPACKED))
>>>> +		if (!(ce->ce_flags & CE_UNPACKED)) {
>>>> +			o->internal.cache_bottom = pos;
>>>>    			return ce;
>>>> +		}
>>>>    		pos++;
>>> Nice spotting.
>>>
>>> Does this trick work correctly even when a path's sorting order
>>> differs between the index and tree objects, which is precisely why
>>> .cache_bottom was introduced, to allow backward scanning while
>>> bounding the lookback distance?
>> IIUC, .cache_bottom points at the first entry that needs to be
>> processed. With this change, that still holds true even when entries are
>> processed out of index order. find_cache_pos() also advances
>> cache_bottom past unpacked entries since e53e6b4433 (unpack-trees: Make
>> index lookahead less pessimal, 2010-06-10).
> That sounds sensible.
>
>>>> diff --git a/t/perf/p0009-diff-pathspec.sh b/t/perf/p0009-diff-pathspec.sh
>>>> new file mode 100755
>>>> index 0000000000..0f1dccfbb4
>>>> --- /dev/null
>>>> +++ b/t/perf/p0009-diff-pathspec.sh
>>>> @@ -0,0 +1,27 @@
>>>> +#!/bin/sh
>>>> +
>>>> +test_description='Tests performance of diffing the working tree with a pathspec'
>>>> +
>>>> +. ./perf-lib.sh
>>>> +
>>>> +test_perf_fresh_repo
>>>> +
>>>> +# The entries exist only in the index, which is enough to
>>>> +# exercise the index scan.
>>>> +test_expect_success 'setup' '
>>>> +	count=100000 &&
>>> You will probably want to mimic how t/perf/p4209-pickaxe.sh helps
>>> testers by adjusting the count based on how the EXPENSIVE
>>> prerequisite is configured.
> I think this comment still needs addressing, though.
>
> Thanks.

Sure. I've just sent v2 with those changes. Note that I used an initial 
count of 1000, otherwise the improvement is not noticeable.


>>>> +	blob=$(echo content | git hash-object -w --stdin) &&
>>>> +	{
>>>> +		printf "100644 $blob\taaa/file\n" &&
>>>> +		printf "100644 $blob\tf%s\n" $(test_seq $count)
>>>> +	} | git update-index --index-info &&
>>>> +	git commit -q -m initial &&
>>>> +	mkdir -p aaa &&
>>>> +	echo content >aaa/file
>>>> +'

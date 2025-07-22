Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C826980F
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198555; cv=none; b=VXjlTwBevUhmkdh2ey2iqlSBGwIbtMfvXzZPgtpU7hvweRrJwLMPisHEua1kbpmPc9MuSgdgbWeq0AiAdlIIdxg51eEoTdKerVLz2XSKP78I19U8lSP5zy/KsH+tQWqAtNMrfiZEjYDeAdVeE0ReRxLZj8lpeYg/u7ACb1u5W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198555; c=relaxed/simple;
	bh=Q1YNsVYD+WILTVR+By6crEmAOL3unuuCc74MqZ2nAD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ob+8/lW9M3Pf8GiAjePdHqT0fM52hqCNVDhDXMgcg+j2YFIy60WGNECavvYv0Elr25o6r5P/Eao3ObJ/2PqjHK8Rz14bHyW6PsnREq7isS1dJnnjt6hkOJx81UeaZLnlJ77efBEh29kDdc5RZV37O9v62QFKgNV0pEU8uMoIZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=RAW25IkZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="RAW25IkZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753198546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu8d64KZ867pbPd/B0OckaXH/Ynx844A+xsu5pzdJmE=;
	b=RAW25IkZ+JgeiJGcnquPHca6j+mVL4PYViVRJ669hCaZoBqEUGokEgvLeHBJ59P7a/5X58
	hHl8ImbfIkxqQSkVep4AyoKnt+pjbNgKQdF8sHYArBY16AAAKbjPZY/HVU2iKpxF05q144
	Y9K6wdrPjvUhWKVvfMfdn8tMSBoW5rw=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Introduce git-last-modified(1) command
In-Reply-To: <aHmJmwvYmAyi3Nlh@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133206.1787549-1-toon@iotcl.com> <aHmJmwvYmAyi3Nlh@nand.local>
Date: Tue, 22 Jul 2025 17:35:34 +0200
Message-ID: <87a54wkzll.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jul 16, 2025 at 03:32:00PM +0200, Toon Claes wrote:
>> This series adds the git-last-modified(1) to feed this view. In the past
>> the subcommand was proposed[1] to be named git-blame-tree(1). This
>> version is based on the patches shared by the kind people at GitHub[2].
>
> Sorry for completely dropping this from my review queue. Let me try and
> give it a read...

No worries, we all got work to do ;)

>> What is different from the series shared by GitHub:
>>
>> * Renamed the subcommand from `blame-tree` to `last-modified`. There was
>>   some consensus[5] this name works better, so let's give it a try and
>>   see how this name feels.
>
> Hmmph. I prefer the "blame-tree" name personally, but I am (a) biased,
> and (b) used to it over "last-modified", so I don't think my preference
> or bias should count for much here.

Well, for what it's worth I like "blame-tree" more as well. But didn't
feel strong enough to push it through.

>> * Patches for --max-depth are excluded. I think it's a separate topic to
>>   discuss and I'm not sure it needs to be part of series anyway. The
>>   main patch was submitted in the previous attempt[3] and if people
>>   consider it valuable, I'm happy to discuss that in a separate patch
>>   series.
>
> Yeah, makes sense.

I might be revisiting this, because recently I've integrating the WIP
command in our tech stack I noticed having this option would be
useful/required.

>> * The last-modified command isn't recursive by default. If you want
>>   recurse into subtrees, you need to pass `-r`.
>
> OK.
>
>> * The patches in 'tb/blame-tree' at Taylor's fork[4] implements a
>>   caching layer. This feature reads/writes cached results in
>>   `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
>>   size, that feature is excluded from this series. I think it's better
>>   to submit this as a separate series.
>
> Makes sense; the caching feature was primarily implemented by Stolee and
> I think for our purposes here can be considered additive and not
> essential to the basic functionality of this new command. For what it's
> worth, I *would* like[^1] to see those features sent to the list at some
> point, but I agree that they are a significant source of additional
> complexity. So punting on them for now seems like the right direction to
> me.
>
> [^1]: My ulterior motive here would be to eventually ditch GitHub's
>   "blame-tree" command entirely and remove it from GitHub's diff to
>   upstream. I'm happy to help however I can with that effort once this
>   series lands.

Obviously. I know how it goes, more code maintained by the community is
better for everyone.

>> * Squashed various commits together. Like they introduced a flag
>>   `--go-faster`, which later became the default and only implementation.
>>   That story was wrapped up in a single commit.
>
> Perfect, thank you. I figured that we would not want to keep temporary
> measures around like the "--go-faster" flag, but I also figured that
> they may be helpful in unpacking the history of this command, hence why
> I sent them in the first place.

I wasn't sure about this. I've had a hard time unraveling what in the 55
patches in your branch was valuable and what could be squashed into
other commits.

>> * Dropped the patches that attempt to increase performance for tree
>>   entries that have not been updated in a long time. In my testing I've
>>   seen both performance improvements *and* degradation with these
>>   changes:
>>
>>   Test                                        HEAD~             HEAD
>>   ------------------------------------------------------------------------------------
>>   8020.1: top-level last-modified             4.52(4.38+0.11)   2.03(1.93+0.08) -55.1%
>>   8020.2: top-level recursive last-modified   5.79(5.64+0.11)   8.34(8.17+0.11) +44.0%
>>   8020.3: subdir last-modified                0.15(0.09+0.06)   0.19(0.14+0.06) +26.7%
>>
>>   Before we include these patches, I want to make sure these changes
>>   have positive impact in all/most scenarios. This can happen in a
>>   separate series.
>
> Hmm. It's been long enough that I honestly don't remember the details
> here, but I agree that this is worth looking into at some point in the
> future.

I've had this patch included in version 2[1]. I'd love to include it,
but it didn't give the results we were expecting. Over time I became
more confortable with these changes. Let me see if I can get more
insights about it.

>> I've set myself as the author and added Based-on-patch-by trailers to
>> credit the original authors. Let me know if you disagree.
>
> I can't speak for the other authors of this command, but I have no issue
> being ~~blamed~~ credited with a "Based-on-patch-by" trailer ;-).
>
>> Again thanks to Taylor and the people at GitHub for sharing these
>> patches. I hope we can work together to get this upstreamed.
>
> Ditto.

<3

[1]: https://lore.kernel.org/git/20250523-toon-new-blame-tree-v2-4-101e4ca4c1c9@iotcl.com/

-- 
Cheers,
Toon

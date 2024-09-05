Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AA61FFE
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548411; cv=none; b=ROLW4q5KMC45QBiKRoCGt6qW3isQKwskOvkx6cyOt/lXm1wgELnDXTLgd8h825bEd8L3aSLTEGaDZ8kYRHQ+PvZOKd3g7HCnQQU2WPy4GHtONSbQjLK8SR1V9S8HKz8aLiJKpTwNTNXedWh1aDswhVkn+4uVWBVSM/v5TSYp5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548411; c=relaxed/simple;
	bh=evRICZPRLaYjm3IxnVn/6S9Rwo5B0+EnKb7g06dYdPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTjeE+qt7LO0Bf2MrD/pRuahbmsXj85DLetmdEi5Jj8GZfMo0Kay85WNqBrAdsMarf17J4yLA0ICk8Le7z9Wv76ydh4ySPN79gGrOg3paD3cJxE0Jzq6OAsQ4epXoASvIh2aauHN3mvKqqtapFuYvSIQSYukxckHXDfF6nQ/42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hgs+9WVX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hgs+9WVX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C61B82B64F;
	Thu,  5 Sep 2024 11:00:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=evRICZPRLaYjm3IxnVn/6S9Rwo5B0+EnKb7g06
	dYdPA=; b=Hgs+9WVXUnZi+icgPmcQj1DyvzQsisUQIyB7y/z4hF3TKwqSbwf3i/
	zptvkeVS7cRYZdrRtHwVU6bHFpTZBtM9yPbuLLj+bQ7nRRKptRPy1PPo1ePYjImv
	mzD+HFgiL6gtn8hs2Kb6HNa5yvf+WpIPRHYofMvFa1a6SxEAdBHeI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 191502B64D;
	Thu,  5 Sep 2024 11:00:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 948B02B63D;
	Thu,  5 Sep 2024 11:00:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  Shubham
 Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] remote: prefetch config
In-Reply-To: <52f6da10-e39a-4a2d-bd9a-5739a49235c2@gmail.com> (Derrick
	Stolee's message of "Wed, 4 Sep 2024 22:08:44 -0400")
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
	<e8232cdc-7a5d-485e-84f7-2c05e17f9907@gmail.com>
	<xmqqfrqf87gb.fsf@gitster.g>
	<52f6da10-e39a-4a2d-bd9a-5739a49235c2@gmail.com>
Date: Thu, 05 Sep 2024 08:00:00 -0700
Message-ID: <xmqqtteu5eof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87EDD958-6B97-11EF-8740-9B0F950A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> On 9/4/24 4:55 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>
>>>> +		# Run maintenance prefetch task
>>>> +		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>>>> +
>>>> +		# Check that remote1 was not fetched (prefetch=false)
>>>> +		test_subcommand ! git fetch remote1 --prefetch --prune --no-tags \
>>>> +			--no-write-fetch-head --recurse-submodules=no --quiet \
>>>> +			<prefetch.txt &&
>>>
>>> I'm happy to see this use of test_subcommand to validate the behavior
>>> of this patch!
>> I found it a bit disturbing that the pattern is overly specific.
>> The only thing we are interested in is that we are not fetching from
>> remote1, so it _should_ suffice if we could write
>> 	test_subcommand ! git fetch remote1 <prefetch.txt &&
>> to avoid being tied to how the current version of Git happens to
>> pass these command line option flags and the order it does so.
>> Looking at the implementation of test_subcommand, it seems that we
>> cannot quite do that (it assumes that the pattern it assembles out
>> of the parameters are to match the full argument list used in
>> invocation, enclosing them in a single [] pair and without giving
>> the caller an easy way to sneak wildcards like ".*" in), which is
>> sad.
> I agree the ergonomics of the test_subcommand helper is a bit poor
> (and not this patch author's fault).

I suspect that we could do

    test_subcommand ! git fetch remote1 --prefetch '.*' <prefetch.txt

which would be rewritten to this pattern

	\["git", "fetch", "remote1", "--prefetch", ".*"\]

if I am reading how the expr given to grep is built by the
test_subcommand implementation.  As long a there is at least one
actual argument after the "--prefetch" one, .* would slurp
everything.

But it is ugly.  In any case, this is a tangent unrelated to the
topic of the patch on this thread.

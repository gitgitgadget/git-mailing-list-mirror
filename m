Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0B1D5AA8
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282665; cv=none; b=qloVTDmNwopfnhyUhkblMh9BANH6PkflNe5CAlEYnsnuUBWOM37P+0Dy0QerFsl8aPdg2fZlPRmN6xdqQNKtgBvfNdugSwydcRgZhefwt4XxnjNotKCdcyHaTBFuad/Te9sLiiF7hTXWs7fW/iSGW4DkE/UQWte6p9cKr+5fNm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282665; c=relaxed/simple;
	bh=dSACRMuiOf+tpUiniXPb5pc0VHTPIRV/e/MjJvHvosc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGR4tMRxpqh2/1R+ddec3a5g3zihgs40dCziV6UO13no9ArYzO1af0ZzgRYVfLQoTIT1bAHAcWf1eS4S4PS9Ye3zGzgmywaz/5r/BPe8B6jU36wU8+P1oKjjAYUdsK7jHX0xMEPyRP+R1JwBv1MOG2BOKd3mOLqIIr0ZfmZxgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k8hVCQE/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k8hVCQE/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D6052CCAA;
	Wed, 25 Sep 2024 12:44:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dSACRMuiOf+tpUiniXPb5pc0VHTPIRV/e/MjJv
	Hvosc=; b=k8hVCQE/7Kx+WQkCPoeN2M22I9y6R4i2MkZnhwLAbvZxaiKoGcHzqY
	DgA4Uh1NkLFRAUlheL41vQxjd5l3zZq4no3nUnE+JGnqUGuibDtZXqa5Bcr2wN71
	j1kCij2rdIHMNFC7grBC2McL2jClTFEA9CORgLIT+9VTQAzEW2mf8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12BAC2CCA9;
	Wed, 25 Sep 2024 12:44:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6ECC32CCA6;
	Wed, 25 Sep 2024 12:44:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  newren@gmail.com
Subject: Re: [PATCH] sparse-checkout: disable advice in 'disable'
In-Reply-To: <5f4290f6-7c9b-47ee-b867-c9904ce0ccab@gmail.com> (Derrick
	Stolee's message of "Wed, 25 Sep 2024 09:48:16 -0400")
References: <pull.1800.git.1727119882901.gitgitgadget@gmail.com>
	<xmqqr09ayv2d.fsf@gitster.g>
	<5f4290f6-7c9b-47ee-b867-c9904ce0ccab@gmail.com>
Date: Wed, 25 Sep 2024 09:44:13 -0700
Message-ID: <xmqqmsjvptsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6690718C-7B5D-11EF-A57D-9B0F950A682E-77302942!pb-smtp2.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

>>> +	grep "The sparse index is expanding to a full index" err &&
>>> +
>>> +	git -C sparse-index sparse-checkout disable 2>err &&
>>> +	test_line_count = 0 err
>>
>> I am not a huge fun of insisting that other code in the code path in
>> which I got rid of an unwanted error message must stay silent.
> ...
> I would say that there are generally two reasons why I chose to check
> that 'err' was empty here:
>
>  1. Using "! grep" feels flaky to me. If we changed the error message,
>     then we could accidentally cause the test to pass because we don't
>     see the old message. This is somewhat mitigated by having the same
>     test check for the existence of the message, so careful use of a
>     common variable might avoid this potential future.

Yup.  Duplicating is probably OK in practice as the eyes of the
developer who changed the message will be pulled to this test when
they notice the failure from the positive "grep" to notice the
negated version you use to replace "The err file must be absolutely
empty", but I agree that a common variable would be even safer.

> +  msg="The sparse index is expanding to a full index" &&
> -	grep "The sparse index is expanding to a full index" err
> +	grep "$msg" err &&
> +
> +	git -C sparse-index sparse-checkout disable 2>err &&
> +	! grep "$msg" err

Excellent.  "test_grep" and "test_grep !" are better choices, though.

>  2. If the output is currently empty, then testing that it stays empty
>     will be a more rigid test. It will help us notice a change of
>     behavior here, even if it is an intentional change.

Such a stricter position cuts both ways.

If we assume infinite engineering resource availablility on ongoing
basis, yes, it may lead to a good discipline.  But having millions
of such tests that will _notice_ changes that are irrelevant to the
thing the test is about (e.g., this thing is about sparse index
expansion advice), we'd be setting ourselves to adjust numerous
tests whose primary purpose has nothing to do with what we are
changing.

The choice also largely depends more on preference and taste that do
not have one absolute and universal answer.  I would personally
prefer avoiding overly specific tests, but I also find it attractive
if we can afford to be more specific in tests at times.

> For the progress motivation, I'm not too worried because the progress
> indicators depend on isatty(2)[*], so would not appear here even if the
> command was slow or somehow GIT_PROGRESS_DELAY=0 was set.

I already said that "progress" was a mere example, didn't I?

Even if we expect we will not ever see unwanted progress indicators
in this code, the general point still stands (iow, progress and
"unsparsifying warning" are not the only things that output to the
standard error stream).

> [*] #leftoverbits: 'git sparse-checkout' commands do not have --progress
> options, but could. The 'unpack_trees_options' structs have a member
> called 'show_progress' that could be populated based on a user option.

Nice.

Thanks.

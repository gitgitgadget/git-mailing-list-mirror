Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04313B7A3
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483337; cv=none; b=sqwFE4a5FLAv+0aXW+E4hPqMu7WlQ/QXBesfinlftsiacuV7KtmtPw+0Uq8nPJ/pchg+tQAy5uI9Kl444jJbyUPKBe3Y0xs2Qn4g8aHs1Owi3sWK2gPOZ0fReQ2rtPVPLFM3w6J+I4uJ2dB85oSwN92cMf6+TEzq+jH87l6K+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483337; c=relaxed/simple;
	bh=Oqd7Dw1VE7xuPu9kVYnv7eMUcFoW2nmYYheoPdy+huM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sABp1uDL7EBm7jnJGiNn6SwFluRE8+fjcWt57L9UrestgA+iUnY+7yOg9HUbEDyyUPMy7XFyviC9HsyHVo6eWBRQbjqoVsLK7wquXS5ZgTaTAWMbYc9W6++q1xbpX0CP/2sVZ+PP/7C8EmKXmRXX6qRRBUhbBrlQRMwkF3kXDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OAS8dM/D; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OAS8dM/D"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79666193D4;
	Wed,  4 Sep 2024 16:55:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Oqd7Dw1VE7xuPu9kVYnv7eMUcFoW2nmYYheoPd
	y+huM=; b=OAS8dM/DrN91bgKJ24mwqp2rvVB6/kHr6rJBXet6ET280tYygBkCUp
	J2OKJdqWtQIGg6kD2HBm+FYpRODs9828TRFHdB++Md0JDegBYBJh6nEBspSRzzVv
	UA9AFHjDwjrtStu7ODsigNZtu0g3V8HbQaAEZ6WKUsVuaba+QaMU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69B41193D3;
	Wed,  4 Sep 2024 16:55:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF635193D2;
	Wed,  4 Sep 2024 16:55:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  Shubham
 Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] remote: prefetch config
In-Reply-To: <e8232cdc-7a5d-485e-84f7-2c05e17f9907@gmail.com> (Derrick
	Stolee's message of "Wed, 4 Sep 2024 16:03:34 -0400")
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
	<e8232cdc-7a5d-485e-84f7-2c05e17f9907@gmail.com>
Date: Wed, 04 Sep 2024 13:55:32 -0700
Message-ID: <xmqqfrqf87gb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 07507D60-6B00-11EF-BBA4-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> I agree that this would also be of interest, but more complicated. Thanks
> for starting with this simpler modification.
>
>> +	if (remote->prefetch == 0)
>> +		return 0;
>
> In the Git codebase, this would normally be written as
>
> 	if (!remote->prefetch)
> 		return 0;

;-)

>> +		# Run maintenance prefetch task
>> +		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>> +
>> +		# Check that remote1 was not fetched (prefetch=false)
>> +		test_subcommand ! git fetch remote1 --prefetch --prune --no-tags \
>> +			--no-write-fetch-head --recurse-submodules=no --quiet \
>> +			<prefetch.txt &&
>
> I'm happy to see this use of test_subcommand to validate the behavior
> of this patch!

I found it a bit disturbing that the pattern is overly specific.

The only thing we are interested in is that we are not fetching from
remote1, so it _should_ suffice if we could write

	test_subcommand ! git fetch remote1 <prefetch.txt &&

to avoid being tied to how the current version of Git happens to
pass these command line option flags and the order it does so.

Looking at the implementation of test_subcommand, it seems that we
cannot quite do that (it assumes that the pattern it assembles out
of the parameters are to match the full argument list used in
invocation, enclosing them in a single [] pair and without giving
the caller an easy way to sneak wildcards like ".*" in), which is
sad.


So, the expected command line being too strit is *not* a fault of
this patch, and with the style fix, I think this half of the
solution is a good one.

Thanks.

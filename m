Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680819F111
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110585; cv=none; b=Vo1Ds1QeqGGJWvgo4sS0FGuS1DorHtSYNcp4cCLB4YUj95i8LubgTNE5aQZqEROCv+vLtVI9yjWogYITwL9wJEo4gi6rAPQ8/8Ppz6Zcv8tGJ22pURAI28Q0BL2ukYEyzcV1+ennOQFoIZEOdiBf/CUl2wJbL1X4O+CgcCQDvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110585; c=relaxed/simple;
	bh=83kL+9Nc8NrlV9/cDwjRCGJpW9ZWDUAK3wJpLRlkTfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jd0uJU/8EB8vfa0bnXgUGXfvfB3eV3HxigHbmX7ZaF2fTVC3EEME81/pCzdYXb2nP7yAu++WtxMtelf227DzeJstpLPQY6lH6Iiecl6NDu019NNyLp8SFNYZHwipCsxcyV8cRhQ/0Tr4fh7RLH3Xy8Lxr4SqM1sBAky10J7tj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vu7zLyoL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vu7zLyoL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58BAF22424;
	Mon, 23 Sep 2024 12:56:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=83kL+9Nc8NrlV9/cDwjRCGJpW9ZWDUAK3wJpLR
	lkTfA=; b=vu7zLyoLEtjQuBbUn9z19B2HZ2QHWZKAkWRJh8kVf4AOa1nSBfmU8P
	CglZ8zNAJjQSrUNEyWAspBEXO68K5lXL6kCeMO/V78zkWpQGatI2JtlOMXtbTiLU
	SwHhk99Sl9H7dZSl93ZDSY6hXGJ6YyJUDyH8WqgHgZ1gtAH3ULuxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5079B22423;
	Mon, 23 Sep 2024 12:56:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAF3022422;
	Mon, 23 Sep 2024 12:56:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Derrick Stolee via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  peff@peff.net,  ps@pks.im,  me@ttaylorr.com,
  johncai86@gmail.com,  newren@gmail.com
Subject: Re: [PATCH 00/30] [RFC] Path-walk API and applications
In-Reply-To: <6b672771-4016-49e8-a045-0a48bc8c1522@gmail.com> (Derrick
	Stolee's message of "Sun, 22 Sep 2024 21:22:59 -0400")
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
	<CAP8UFD0uyVk5WPX12sGhWWXkdQWGpBhG29Q-9EmBxHos1XQ_uQ@mail.gmail.com>
	<53dc17f8-82e5-40fa-81b7-af89f987928b@gmail.com>
	<xmqqplov7cw8.fsf@gitster.g>
	<6b672771-4016-49e8-a045-0a48bc8c1522@gmail.com>
Date: Mon, 23 Sep 2024 09:56:20 -0700
Message-ID: <xmqq4j6648cr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C2A7DB5A-79CC-11EF-9EC1-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> ... I can see an argument for either direction: having a new hash
> algorithm provides a smaller change to get most of the results for the
> full repack case, but gets worse performance in many push scenarios.
> This is the point of an RFC, to get questions like this worked out based
> on the "big picture" view of everything.

Exactly.  We might want to use the series as an example in our
developer docs on how to propose a large-ish effort.

> Perhaps I should pause the --full-name-hash topic and focus on getting
> the --path-walk topic up and running. I am curious to hear from folks
> who are currently running Git servers about their thoughts on these
> trade-offs and potential uses in their environment. My needs on the
> client side are solved by the --path-walk approach.

Yeah, such third-party inputs would be very useful.

Thanks.

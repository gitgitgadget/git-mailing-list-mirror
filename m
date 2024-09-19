Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766221448EA
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782973; cv=none; b=Foqi2Bt1lqMELEhR8McAkWYLwY9afexkARLrGrMOW9MQ9Iwu0Pn64W5GClH+WHD6n3QyunyOunKKZ4cM1Ahr21F1sOjcAzLH0amj2qTrFOKiifhPj9WLvshgv2iUSkshaHItQiV+1tENC/cLLpHATwPY8JYQOBqUX0IKgibcDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782973; c=relaxed/simple;
	bh=t5ThoS1PzMqNSlTzy0Bcxmd+Op4pV5zqZ/t2ZjfmVJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJmvGvdVoGVlJIITCaCHd4pYqBgpNl7AEVwRbBAXUeTaQzc0AKLFa7SteM7QY7IEeXed0sF84Mro3DClct8VWmmfQ/xTV1I4XvSypaMq0J5iueu0T9Ix4cWFAy0BT7b0D5eFMqxOcZ3dwzKxP766j8qMyvbyT6x2gLArllrldWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u/uAto2s; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u/uAto2s"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E6B92CDE9;
	Thu, 19 Sep 2024 17:56:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t5ThoS1PzMqNSlTzy0Bcxmd+Op4pV5zqZ/t2Zj
	fmVJs=; b=u/uAto2s0EZsBZRqm7RV+dvkiFBEmZyjqNQNKsG9AOnWFl47XZm11r
	ovkbMPrjwfJCgSICKwivhDcT0JgzpKVFoJL+Nzzq++R5iBRqvQJx6YoPiF9MudWn
	eq6FLVJSO5ziQV6OWnECQaBPr7NvrdWqhQrrFrFZHjAuHZy7FWXZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 262D22CDE8;
	Thu, 19 Sep 2024 17:56:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89C8F2CDE7;
	Thu, 19 Sep 2024 17:56:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/6] pack-objects: add --full-name-hash option
In-Reply-To: <5f52e2617654946c87fff0744393b984ccaab043.1726692381.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 18 Sep 2024
	20:46:16 +0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
	<5f52e2617654946c87fff0744393b984ccaab043.1726692381.git.gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 14:56:08 -0700
Message-ID: <xmqqh6ab5mvb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA917178-76D1-11EF-A0E4-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static inline uint32_t pack_full_name_hash(const char *name)
> +{
> +	const uint32_t bigp = 1234572167U;
> +	uint32_t c, hash = bigp;
> +
> +	if (!name)
> +		return 0;
> +
> +	/*
> +	 * Do the simplest thing that will resemble pseduo-randomness: add

"pseduo" -> "pseudo"

> +	 * random multiples of a large prime number with a binary shift.
> +	 * The goal is not to be cryptographic, but to be generally
> +	 * uniformly distributed.
> +	 */

Other than that, there is no substantial difference since the
previous iteration; this step looks good.

Thanks.

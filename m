Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB711E841A
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396434; cv=none; b=h96zl4fgPWVD090VAa0TVWCacHbwZ2A5eryxWVzubu8QiYZlNAckAUZu0fSeBrOzov/vaHsk30q0UKeSWTqRnoXryXMHdJ/csr7spVCslB8otNstW3s4DyNrh/MJMBJf2/AeYe/Yu6gFsQ+8rCaDSQ9jnAW0ec+Qi1TgLrh59Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396434; c=relaxed/simple;
	bh=hf5Cb8lJKiAYPFypcx/JiJ+7x6w+TvfgRA9oj31b5gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=At1FAaeSeKsjOiISKM+0lScOIRBG1u+sjYW/cDNFjwSj2djh0iQJX+d9f2TBAReF3H77PHtR1WFdEBtvKBSPnqojZHjBFPTkLnT8k+lOtKkc0cKWB0fnh+8U+sWZMaQyr3SKPQ0sCm2xw5Jdfke08PGholgdxzR01LLgiDEks04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LlZPFmC3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LlZPFmC3"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71B22398EA;
	Tue,  3 Sep 2024 16:47:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hf5Cb8lJKiAYPFypcx/JiJ+7x6w+TvfgRA9oj3
	1b5gw=; b=LlZPFmC3xFGvWJU82c3bvLFkFShrqZYNvmGx+rqTGCN4sy9dttvtMY
	PsHQdz9cRhhDwLbzEaetuIeqrrIcFoe9nI/1Mr1HrFowONXdbDeJLEmYLEe1xwhy
	VqzHAtHmlQZsORufNYdCdOLOFmcm/YeDxUSfIAgTCl5MdyDabQfF8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 683E5398E9;
	Tue,  3 Sep 2024 16:47:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD5DD398E8;
	Tue,  3 Sep 2024 16:47:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
In-Reply-To: <ZtdpFWtWae2r4Lj4@nand.local> (Taylor Blau's message of "Tue, 3
	Sep 2024 15:52:53 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
	<ZtXAhP69zu7cDnsA@tanuki> <xmqqh6awlkac.fsf@gitster.g>
	<ZtdpFWtWae2r4Lj4@nand.local>
Date: Tue, 03 Sep 2024 13:47:09 -0700
Message-ID: <xmqqy148h3ci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B1166B1E-6A35-11EF-978E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I discussed this with brian in the sub-thread where I am talking to
> them, but I think this is already the case. The pack is read in
> index-pack and the checksum is verified without using the _fast hash
> functions, so we would detect:
>
>   - either half of a colliding pair of objects, when reading individual
>     objects' contents to determine their SHA-1s, or
>
>   - a colliding pack checksum, when computing the whole pack's checksum
>     (which also does not use the _fast variants of these functions), and
>
>   - a mismatched pack checksum, when verifying the pack's checksum
>     against the one stored in the pack.
>
>>  (2) devise a transition plan to use a hash function that computes a
>>      value that is different from SHA-1 (or SHA-256 for that
>>      matter); and
>>
>>  (3) pick a hash function that computes a lot faster but is insecure
>>      and transition to it.
>
> So I do not think that either of these two steps are necessary.

I suspect that it is a wrong conclusion, as I meant (1) to be
prerequisite for doing (2) and (3), that gives us the real benefit
of being able to go faster than SHA1DC or even SHA-256.  If (1) is
unnecessary (because it is already covered), that is great---we can
directly jump to (2) and (3).


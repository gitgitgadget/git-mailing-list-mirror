Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84931EB44
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461597; cv=none; b=UUX3/LNlm6/rp9ddVNGC1mO2PWQYb0iMf1+vdDGrkPoyLApac8647NOk939xkeKrd4iU5ehXMvld8Yrodd+3IgXLqekwn7dQJ72NqHW5/pvJnQ12fCr5dAv/CICDalo0kjbHVfEvVI0P1r1st8XjZplhVrWgmAeK2Vz1oRm5nJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461597; c=relaxed/simple;
	bh=pTyA4uUb3hBTyrshkhiYXVU79sHlUF7nwIrrM6Jopuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZGP+9JP4YerKPRqiY88gv7BBYPnflRuYkpOoSf67R/6kpGBzI/l3sX//HxCbB7BSsL4rn5hVh1yt1cVUyWJJhfTr8OmbaHWs52c2oZD8lBfFOY+lEzmDWkMz9yLW61MwsOR9xJUehSkSizBNfipWencDkYaACC3v1OuyOMyVXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nb9rxZxk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nb9rxZxk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF4DD1C184;
	Wed,  4 Sep 2024 10:53:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pTyA4uUb3hBTyrshkhiYXVU79sHlUF7nwIrrM6
	Jopuk=; b=nb9rxZxkutZZXu2xV5ufnaCaBjnX3+KoLTMY30GQb7J0xzBaFJ7im2
	zbcz0SZ49ULEEAOmN3vLJi9Jg+Bcg1X9LOPGYLOBAOVkcqSXEBp4kfG+2fXKcR7S
	xLUXis5AdVya9renmWr4SsSuY8sD9WxEb23rsioJZwM/M49bUerMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A80321C183;
	Wed,  4 Sep 2024 10:53:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A1AA1C182;
	Wed,  4 Sep 2024 10:53:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
In-Reply-To: <ZtgGsNVPRVezNyEp@pks.im> (Patrick Steinhardt's message of "Wed,
	4 Sep 2024 09:05:28 +0200")
References: <cover.1725206584.git.me@ttaylorr.com>
	<6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
	<ZtXAhP69zu7cDnsA@tanuki> <xmqqh6awlkac.fsf@gitster.g>
	<ZtdpFWtWae2r4Lj4@nand.local> <xmqqy148h3ci.fsf@gitster.g>
	<ZtgGsNVPRVezNyEp@pks.im>
Date: Wed, 04 Sep 2024 07:53:12 -0700
Message-ID: <xmqqfrqfeahz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 696B0AC0-6ACD-11EF-8405-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 03, 2024 at 01:47:09PM -0700, Junio C Hamano wrote:
>> ...
>> >>  (2) devise a transition plan to use a hash function that computes a
>> >>      value that is different from SHA-1 (or SHA-256 for that
>> >>      matter); and
>> >>
>> >>  (3) pick a hash function that computes a lot faster but is insecure
>> >>      and transition to it.
>> >
>> > So I do not think that either of these two steps are necessary.
>> 
>> I suspect that it is a wrong conclusion, as I meant (1) to be
>> prerequisite for doing (2) and (3), that gives us the real benefit
>> of being able to go faster than SHA1DC or even SHA-256.  If (1) is
>> unnecessary (because it is already covered), that is great---we can
>> directly jump to (2) and (3).
>
> Ah, so the idea would be to not introduce SHA1_fast, but instead use a
> hash function that is explicitly designed for fast hashing like xxHash
> [1]? When you compare numbers I definitely think that this makes quite
> some sense as XXH3 for example hashes at 31.5GB/s whereas SHA1 hashes at
> 0.8GB/s (if you believe the numbers on their site).

> Doing this for data structures structur is almost a no-brainer if you
> ask me. For packfiles it's a bit more complicated as we also have to
> consider backwards compatibility -- a server of course cannot just start
> to send packfiles that use xxHash.

Yup, that is where the step (2) above comes in.  In the thread,
xxhash was indeed brought up as a viable candidate for the tail sum
for strictly local files.



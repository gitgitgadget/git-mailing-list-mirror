Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EDE1C9DFF
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691642; cv=none; b=mPV86Wc2L4jFgMFGsGXwit1mrJIcymBSSBssOJVPP4x+FVHV4R2P1jI60CAyBvcVnrEchPeAesDJfwFlL9ZJj4wyx2JfeE0NPtVv+l1Kwcp0ZSgtepiOQ3m94doLGCnpo2Hasz/br5sxfyLcDAr+vvDNnrq/NlLdhN1zIy6VhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691642; c=relaxed/simple;
	bh=0lqVm+P/A6ay4cuVjktGkIznAbR0GT3ySNpa1pZ2txM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kf04LvLa+JHtistaa/Y65CXkxzluwcdM03RKpqMzkNABm7PvqvMjQcDTMWUU2Hd98/eYusPeE2f5DH4n1D6u2pVgJ53Cf2Niw17xy3fUpGB+VJ+btdp8Fq5yoVi2SsNwNH+0ATMfdD4UOeDXrEtm+HlK2rOHtrlLdB14Xfn2flU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x6FJ0e7g; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x6FJ0e7g"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 43DC11945A;
	Wed, 18 Sep 2024 16:33:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0lqVm+P/A6ay4cuVjktGkIznAbR0GT3ySNpa1p
	Z2txM=; b=x6FJ0e7gUmtULeCulcLQ8QMRs7ABy6WiLttKBi5Ob411lbHq+7ZZx2
	/Aqk8gDMPVkbafB75le1yvLuTynP54TZ3AorFMoOFkNVBQhmZsik8IeGgyWvxiDa
	whhlQf9Kwz5gi9mtzxqEkYeca6LpFIrxHVrxy5lDfIKtayRBy1iks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C3B919459;
	Wed, 18 Sep 2024 16:33:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2D2519458;
	Wed, 18 Sep 2024 16:33:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2024, #06; Mon, 16)
In-Reply-To: <ZulUa3PL9zh6AqmR@pks.im> (Patrick Steinhardt's message of "Tue,
	17 Sep 2024 12:05:31 +0200")
References: <xmqqmsk7kpfe.fsf@gitster.g> <ZulUa3PL9zh6AqmR@pks.im>
Date: Wed, 18 Sep 2024 13:33:57 -0700
Message-ID: <xmqq7cb8bt1m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 551BB6E2-75FD-11EF-B30F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 16, 2024 at 07:02:45PM -0700, Junio C Hamano wrote:
>> * ps/reftable-exclude (2024-09-16) 7 commits
>>  - refs/reftable: wire up support for exclude patterns
>>  - reftable/reader: make table iterator reseekable
>>  - t/unit-tests: introduce reftable library
>>  - Makefile: stop listing test library objects twice
>>  - builtin/receive-pack: fix exclude patterns when announcing refs
>>  - refs: properly apply exclude patterns to namespaced refs
>>  - Merge branch 'cp/unit-test-reftable-stack' into ps/reftable-exclude
>>  (this branch is used by ps/reftable-alloc-failures.)
>> 
>>  The reftable backend learned to more efficiently handle exclude
>>  patterns while enumerating the refs.
>> 
>>  Will merge to 'next'?
>>  source: <cover.1726476401.git.ps@pks.im>
>
> I was waiting for Taylor's review as he has written the original logic
> for the "files" backend. It came in this morning, and after some back
> and forth on the second version he agreed that the current version looks
> good, so this is ready to be merged from my point of view.

Thanks, both.

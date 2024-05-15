Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8A155749
	for <git@vger.kernel.org>; Wed, 15 May 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787645; cv=none; b=GzZ5WSJZ+qQINUz24dNQMv3MQin0FHY45WNZDosC7taXK/ZmRPin08yL1+uWUZj6oaM/5DvtuwzoxNEIkja7euUuEqlLS9//BH0xFBgkfBodb06PdaRH1Td/nb+1JdpoWNFSHEiVa6OhdIs2XV9/YjHxR3uqhVTek7Of78zmu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787645; c=relaxed/simple;
	bh=JSsAJ55auW5dyNsBNewptiEe6sJO2B72g7RPOZY8H14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rynTTZ8pXiCU8sYh2Cu7RhV0g04/8LFImtipw9k/iSkRD/cxpGGbcoccvb2ep7Pn7L4klG+X+vVzewDNy4bUsY+a00HtWKPpVPTG3J1NCo7Eg6iuy9Y9P1G8qvZoSTx5F6FQEHDQWXV2PajkTdb7wU485M2DI8WRacsRWtd+vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YfU2UUqN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YfU2UUqN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 395E71E13F;
	Wed, 15 May 2024 11:40:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JSsAJ55auW5dyNsBNewptiEe6sJO2B72g7RPOZ
	Y8H14=; b=YfU2UUqNez46FNrCiHjaTHqjdzUNyDZvvNg/spT8dL9sSygLO3DQB8
	sApp+oyzOBTHBcb4fLX3YlgxFeoK5vw82C5ZfygctUXTdUJQYEHczcrVMBj+u+ak
	acUefT9y0uVmbLfta6lbYf62zHZHSezTxyqOAH0E2gbkJbz5INXBc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 319B11E13E;
	Wed, 15 May 2024 11:40:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B14131E13D;
	Wed, 15 May 2024 11:40:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 2/5] t1517: test commands that are designed to be run
 outside repository
In-Reply-To: <ZkTFvVihZAY184Gm@tanuki> (Patrick Steinhardt's message of "Wed,
	15 May 2024 16:25:01 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-3-gitster@pobox.com> <ZkLpTwNgFGFyC4_N@tanuki>
	<xmqqo79877oc.fsf@gitster.g> <ZkSpk3v2kRsdOcbQ@tanuki>
	<xmqq4jaz2may.fsf@gitster.g> <ZkTFvVihZAY184Gm@tanuki>
Date: Wed, 15 May 2024 08:40:38 -0700
Message-ID: <xmqq8r0b13t5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B45EB10-12D1-11EF-B148-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> The tests that are spread across many scripts make it harder to see if
>> we have enough coverage for the out-of-repository operations,
>
> Put this way I in fact agree with you.
>
>> and the use of "nongit" helper does not change the equation, does it?
>
> No, it doesn't really.

Of course the other side of the coin is that having all tests about
a single command (say, "git mailmap") in the same script for both
in-repo and out-of-repo operations is also handy in a different way.

I haven't found a good way to balance the two.  Obviously duplicating
the same test in two scripts (one collection for the same command,
the other collection out-of repo operation of various commands) is
something I really do want to avoid, so...

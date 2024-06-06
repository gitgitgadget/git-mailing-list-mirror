Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C15197A97
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687112; cv=none; b=mXvMGbsreM2S69bhbuqS1PeuYNhinEBcPzYLzO/jHCti8eNXnIX0EDyMEVTM555oLwS3z5Hw8c7wIpvsoxfCt01h+afxtqysWUJL5DEo5ixkorbo1kT7/8tOAWjfZGQLG1gbTFAQsktgBMU1C2+zKADraP06r4g/WLu/8N5WtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687112; c=relaxed/simple;
	bh=2Pac7+ETD33K9Q7/Y/ppBGP/f+xMr38kRBmlOXvL2/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eLGkoDkCv97lMirMdUN5oPIFG72AEeFptq9LwQmIgLR9px4s2ydFrZT4q5yVK36vxLSDOXe5zoDZylL7m+ZLVog4EyEtoY/nEGBI6gIuR9Oas3MfcpCZhHHmZ9y8CYzXw1ctF4c4bYnuOKIdZfe8hvsthTlqxqF4bgZ3PYCCTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MR/Q/EtX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MR/Q/EtX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 061FC237F7;
	Thu,  6 Jun 2024 11:18:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2Pac7+ETD33K9Q7/Y/ppBGP/f+xMr38kRBmlOX
	vL2/8=; b=MR/Q/EtXeLR+RM8ceXQgkmuAzQFE8mnW0nZlb3bh1bQYSwBalTD/uc
	UYGCwuNCnSRAbIE8A8rrPxSLlsewrqC+8s0pDgTGrUMaE9UhI7N+ZaId3WdEv8DN
	cZaq3l9GX5M8xRqtA+T5dCzN7mPyc55jhdqQweLxxTEiN/78dzebM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F20F0237F6;
	Thu,  6 Jun 2024 11:18:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C658237F5;
	Thu,  6 Jun 2024 11:18:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ls-remote: introduce --branches and deprecate
 --heads
In-Reply-To: <ZmGDuThKIbexY-xa@tanuki> (Patrick Steinhardt's message of "Thu,
	6 Jun 2024 11:39:05 +0200")
References: <20240603200539.1473345-1-gitster@pobox.com>
	<20240604220145.3260714-1-gitster@pobox.com>
	<20240604220145.3260714-3-gitster@pobox.com> <ZmGDuThKIbexY-xa@tanuki>
Date: Thu, 06 Jun 2024 08:18:26 -0700
Message-ID: <xmqqa5jyp0al.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06A89188-2418-11EF-A70A-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +test_expect_success 'ls-remote -h is deprecated w/o warning' '
>> +	git ls-remote -h self >actual 2>warning &&
>> +	test_cmp expected.branches actual &&
>> +	test_grep ! deprecated warning
>> +'
>
> It is a bit funny to grep for something that wasn't ever there. But I
> don't mind it much as we may eventually want to introduce such a
> deprecation warning if we ever decide to go through with the
> deprecation.

It is indeed funny.  We thought about adding and then made a
conscious decision not to add a deprecation warning, so this
testpiece serves as a documentation of the status quo, and a
back-pointer for readers to blame back to the message of the
commit that introduced this one, which clearly says the lack
of warning is something we may want to reconsider later.

So, this should be fine (the same for 3/3).

Thanks.


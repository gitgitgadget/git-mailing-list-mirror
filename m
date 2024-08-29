Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122318A924
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944040; cv=none; b=GxWa54RAePIwzTyUv+c/m+csmaV1vCiMGWkHPR4B8SgN+cGUYH5dDbHGS47Y6wGl+zGtiDhS6OqZ/4Xqh4a9VTKd9u+RcAa5n1HkMphW/tKqj+oi/eYgDK1IfRB1Dq0cKbjJQKmTAOmXo0QYMmgaFPHu0HNQy3pK50CvcLcjS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944040; c=relaxed/simple;
	bh=r9tZLgkABqIoNOJjTCaFZggwAoorZNXZwh3Fk5WzCoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=scvh8+o11fCv+azMgTD34BTDIfv0mjO2kRo4gqMNHbxPzElR40h1OKdnN9ZQRFUXW6QNChEkrr2F+h3cncVP+uWshUidrq2fuW3Exg9+tY6ciMwo0Huq5IF/WjkE4qPL+QpvUgd3TRc+BDimVslZh6vCZCRzwldTFJjqbV4b66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aiRSGjJx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aiRSGjJx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE7A8221AD;
	Thu, 29 Aug 2024 11:07:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=r9tZLgkABqIoNOJjTCaFZggwAoorZNXZwh3Fk5
	WzCoQ=; b=aiRSGjJxAJcMJHYEdxWgjDPHDIJzsHShN49qixXKD2T1JZGHavLYvl
	g8LpwDqMk88ju59DFSAWeKVk3A+fy2WMghu0sAMnYbV+aN2lFlF4fcY9oE8Jh6TS
	CkAXTLyV92IOT3EruNIUNeDSlPumDpfvs68ulzvUZnWH5I6o9EmFU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5CA0221AC;
	Thu, 29 Aug 2024 11:07:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D414221A9;
	Thu, 29 Aug 2024 11:07:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  shejialuo <shejialuo@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
In-Reply-To: <ZtAcowXWinP2Iguj@tanuki> (Patrick Steinhardt's message of "Thu,
	29 Aug 2024 09:00:58 +0200")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
	<xmqqbk1cz69c.fsf@gitster.g>
	<20240829040215.GA4054823@coredump.intra.peff.net>
	<xmqq5xrjzzxt.fsf@gitster.g> <ZtAcowXWinP2Iguj@tanuki>
Date: Thu, 29 Aug 2024 08:07:15 -0700
Message-ID: <xmqqikvjxt98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 616A1F96-6618-11EF-9F25-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +* Support for core.prefersymlinkrefs will be dropped.  Support for
>> +  existing repositories that use symbolic links to represent a
>> +  symbolic ref may or may not be dropped.
>> ++
>> +Cf. <20240829040215.GA4054823@coredump.intra.peff.net>
>> +
>>  == Superseded features that will not be deprecated
> ...
> We should probably do the above together with a new check that starts to
> warn about symbolic links in "refs/" such that users become aware of
> this deprecation. We'd have to grow the infrastructure to also scan root
> refs though, which to the best of my knowledge we don't currently scan.

Yup, that is why the above suggestion is on _this_ thread that is
about the "check for curiously formatted symrefs, in the hope that
we can retroactively tighten our checks later" topic.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA8135A75
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018589; cv=none; b=NDNSZY65ricY4u5ObI7wJ1aXGHPQmjEOhr53xFZhZw/+AG7U0npuAEFsVVxdmROe7tVw0DL/4QoT+b8wp5pqkymUUlT9c3fL+D5xwGYcgX+O/tHlGbsOA/nNNLx96GU1hXDQiXuSPTvYFnhac12yH4JO+/SBInkH/qpsgQC1BMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018589; c=relaxed/simple;
	bh=uqvVoj/rqvgl2vE+Y91562xy9Qr7/TFJNTvgJzz/pMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DYrt6kBZGFvmR4x6kLzIaO+QQkD6Cn4as1qmAYX1igbyS+9z3MIglHsHHLAVEoVyMMQ8Lclzmy6DMDos6IXmeLDXTK+mdAdzWQu3Pv5ct4JxsdfGB152IasKWa7/kAwgbIP3VDyjXCNdGXX5CQGDYMqUCHfqyX7sdUvb7eSm3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pD/Ul1U9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pD/Ul1U9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 75FCC1DE2C2;
	Thu, 15 Feb 2024 12:36:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uqvVoj/rqvgl2vE+Y91562xy9Qr7/TFJNTvgJz
	z/pMc=; b=pD/Ul1U9N/JeIt45lLieAB1DAAqNAUMl9bwwzGyiCJC4X43KuCvRDd
	EgVEqyghuhW2Ihd+yqTxjlzH7o7UqFqVRIspfykbt43iXrGzTzXENojGD3ZQa22w
	VImBIA8B9+yfpeBL0ueIIaL5vFkC8N3aJu1q9wMSxJJnmJ0HPdSz0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BC091DE2C1;
	Thu, 15 Feb 2024 12:36:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C06DE1DE2B9;
	Thu, 15 Feb 2024 12:36:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  git@vger.kernel.org,  Jonathan Nieder
 <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
In-Reply-To: <76c62133-30e4-4145-99ea-aeef644d617a@oracle.com> (Vegard
	Nossum's message of "Thu, 15 Feb 2024 15:24:53 +0100")
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
	<20240205141335.762947-1-vegard.nossum@oracle.com>
	<ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
	<xmqqy1bymru0.fsf@gitster.g>
	<b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
	<xmqqcytal01i.fsf@gitster.g>
	<4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
	<xmqq8r3wcjq2.fsf@gitster.g>
	<ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
	<eaf511ff-f9e0-47ac-ae2e-3de0efa928dd@gmail.com>
	<xmqqv86yoot3.fsf@gitster.g>
	<4073b764-ab6a-4b4b-a8a3-2e898620b2f5@gmail.com>
	<xmqq8r3r9biz.fsf@gitster.g>
	<76c62133-30e4-4145-99ea-aeef644d617a@oracle.com>
Date: Thu, 15 Feb 2024 09:36:24 -0800
Message-ID: <xmqq8r3lsk87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE4656E2-CC28-11EE-AF22-25B3960A682E-77302942!pb-smtp2.pobox.com

Vegard Nossum <vegard.nossum@oracle.com> writes:

> On 11/02/2024 18:05, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> On 08/02/2024 17:20, Junio C Hamano wrote:
>>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> It might be worth explaining why this happens
>>>
>>> This is because rebase sets the GIT_CHERRY_PICK_HELP environment
>>> variable to customize the advice given to users when there are
>>> conflicts which causes the sequencer to remove CHERRY_PICK_HEAD.
>> True.  I'd prefer to see the original submitter assemble the pieces
>> and come up with the final version, rather than me doing so.
>
> Thanks for explaining and sorry for the delay. I saw the patch was
> merged to main now, but I will keep this in mind for next time.

Thanks for finding and fixing.  Hope we'll see more of your
contributions in the future.


Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DA824AD
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293425; cv=none; b=MUkPWJNHDg61UUIVKEU77gS7Nup1lTxxklemEkNi5hhTjwFGANPMmU+Y36XjCVljRZLaKo+/r1CpW8tICQVa5TzC01Z+/0z5qIWL2xCfwtLUR7RfcWgrnAXdDV/a0HAZSzx19L7Ejyb8DJbH/Z3ncs0jEdzSBZoQ703EQ1s9fU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293425; c=relaxed/simple;
	bh=B5ifxVmWSL3osQQR50dMrtEkWUDW20Iq2OPzRq6Hb40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqQnxPJB2I9bmZGA4I3toankN5L1w9q+dAb1vraTUQ5x3xITRiCN5ZuXGe/wV9mC/+7/M1Aunk38yi3fM1QPG92ZRFJPof1vxByUCCYn/kOxbvGyeM3UbAIQCX7LZ8lfasQFV7QdcVIbQTxraY/1tMnEW6PYfikmDIL6tfG3qLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GQsmJ2Sm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GQsmJ2Sm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F12F2F5F2;
	Mon, 29 Jul 2024 18:50:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=B5ifxVmWSL3osQQR50dMrtEkWUDW20Iq2OPzRq
	6Hb40=; b=GQsmJ2SmMQlwi4lJwfdPADGca8uqMUKa5LLC/XKxJ6dLSci2p9j3WU
	GIWuUx/wBvy0r4WAMXA9IMLx/zyS1khweWG+wRDkJwqgM6XdN9LrzXYzZB7AghwT
	3aPc1oxN5gbXJ6A2Ql/sgBwhlkQka5+E72y4Caz996BKj0xHjtuek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 87D662F5F1;
	Mon, 29 Jul 2024 18:50:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E70F52F5F0;
	Mon, 29 Jul 2024 18:50:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: David Disseldorp <ddiss@suse.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] notes: do not trigger editor when adding an
 empty note
In-Reply-To: <20240729235333.513eb1d9.ddiss@suse.de> (David Disseldorp's
	message of "Mon, 29 Jul 2024 23:53:33 +0200")
References: <20240729151639.19192-1-ddiss@suse.de>
	<20240729151639.19192-2-ddiss@suse.de> <xmqqed7bhobk.fsf@gitster.g>
	<20240729235333.513eb1d9.ddiss@suse.de>
Date: Mon, 29 Jul 2024 15:50:17 -0700
Message-ID: <xmqqa5hzhkye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EDDDE054-4DFC-11EF-A142-92D9AF168FA5-77302942!pb-smtp20.pobox.com

David Disseldorp <ddiss@suse.de> writes:

> On Mon, 29 Jul 2024 14:37:35 -0700, Junio C Hamano wrote:
> ...
>> I am tempted to squash in
>> ...
>> to make sure that all three options mentioned in the proposed commit
>> log message are tested.  It is not too much more effort to do so.
>
> This looks good and works for me - feel free to squash it in.

Will do.  Thanks for a quick response.

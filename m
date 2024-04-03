Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B431465BD
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162464; cv=none; b=cmK59Pt15+ATC+KdvnvqVPJ0pudt0V/VbWCK9LRohqESFRg3QJYd1wpZ/ww7Octl/qCSzy/2wa47OFT/fihHyb1ypaZL3VU4IQZPRkF03Jtq1YOrFbDIWgD2PBT7CnPOtbyUULPivdrxhsWjaE57MM8Q+DbY7h/N98tr0PTji5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162464; c=relaxed/simple;
	bh=i7XE+XywW1GFHFiAgD9+Z0pi2QZ3hykcYYHOznH/SqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uA8u8yWpoqufShVaP3Wu9Kz9dyU15cdX64rRWLj113e/4dakSNYzaPYfS6dhuxoDSIlXESQbzWFLd0llple5aAXJMvnQF8m26pYP8KbMc5DjP30SbEtyUZOaiUQAIF45+lumvQp7VaZQsozoO89/tesheEtx01M80T7mw1TRuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gROWy72Y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gROWy72Y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 589C11DB2A5;
	Wed,  3 Apr 2024 12:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i7XE+XywW1GFHFiAgD9+Z0pi2QZ3hykcYYHOzn
	H/SqM=; b=gROWy72YuX5WdbFwoSTsyceShyX3WqfO/84tP8DA41ywCgcZWqY6A9
	eTYjLMzi1RDANPB1ezIzjPpkedpbnIzWDfsH8McJQexSOobHCRBEh6rbUQYsJbji
	n5sLEAuwD0pdcMzNZqSYJ/lrcm3A9RoxlL4+nNasowwPS/9ofOTkE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D9061DB2A4;
	Wed,  3 Apr 2024 12:41:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87F261DB2A2;
	Wed,  3 Apr 2024 12:41:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,  Justin Tobler via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
In-Reply-To: <Zg0tEa7DDEuub09Q@tanuki> (Patrick Steinhardt's message of "Wed,
	3 Apr 2024 12:18:57 +0200")
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
	<pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<Zfzd8YdAwzYRYkA3@tanuki>
	<CAOw_e7az+S4nkG1HKDcqXkK0BOhs6cBpkb=QEGBoZW8MSEEvGg@mail.gmail.com>
	<Zg0tEa7DDEuub09Q@tanuki>
Date: Wed, 03 Apr 2024 09:40:59 -0700
Message-ID: <xmqqo7aq8kmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F41BDB68-F1D8-11EE-8597-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> But I'm definitely supportive of lifting it out of the reftable library
> and into the reftable backend so that it is specific to Git, not to the
> reftable library.

Absolutely.  Thanks for bringing up a good point and a nice
solution.  I do think it makes sense to handle the environment
variable on the Git side.

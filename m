Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB51481BA
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715381439; cv=none; b=aXM5BlDAa9hWrbesFVI3Sc9+NZZTJGF4NIg1/6LdmM948mIVsl55HRDkpJbumo2fPTFLxxDEiXDwoUmavaqPnGAvs8qWRnWPfH8h61kQC9UdAHKTtUVL5t12F20uckScyfaLF4nf13ob+NCW1HBiEKInMxRPZhrzx8lmTH729ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715381439; c=relaxed/simple;
	bh=8uZCbU9ldY0ZywAurtYxHi6+Lei1wN6WvEdv34HIKq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dad/IsuYZ08yj53SaInwjE3lH1HgDOJCMA6nRJwTl+XcnyNJQxHTwywVysCXPYs3/w/Ozjcwbl11Qu/1+UkQc+Z+mBpl6ojO3/x7mVRBPMbCkW6zXZ/2HYhpXb7HkgVkMpr74u3fy4YUtM3Px8uSxdXuCRxP+UBXAG45FGQoMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yrj4h+m6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yrj4h+m6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2717534733;
	Fri, 10 May 2024 18:50:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8uZCbU9ldY0ZywAurtYxHi6+Lei1wN6WvEdv34
	HIKq8=; b=Yrj4h+m67JHwt8Ba/z/bLYFEr0o16RorLiWveyrRSBc8e4B8UeRyLN
	LF+fNHnZVKeWtMHQO8rI36NRjqlaZs6BbH6jBdL+RGWfEU+8R7Nd734TERIXqRyl
	PUMJGwSGr7yysEYkaYswAi7QEBvgjokbQ9aiE10e2WjYpYW/6aVWI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FE6834732;
	Fri, 10 May 2024 18:50:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D5903472F;
	Fri, 10 May 2024 18:50:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Bo Anderson <mail@boanderson.me>,  Koji Nakamaru via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
In-Reply-To: <20240510220920.GC1962678@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 May 2024 18:09:20 -0400")
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
	<D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
	<20240510200114.GC1954863@coredump.intra.peff.net>
	<xmqqh6f54czm.fsf@gitster.g>
	<20240510220920.GC1962678@coredump.intra.peff.net>
Date: Fri, 10 May 2024 15:50:35 -0700
Message-ID: <xmqqo79d1dtw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B72C4382-0F1F-11EF-A246-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I do think brian's suggestion to use state[] to pass it back means that
> the decision is then in the hands of the helper. So "credential-cache",
> for example, could decide whether to refresh its ttl or not, or we could
> even make it configurable with a command-line option for the helper.

Yeah, I read your discussion with brian, and the state[] thing all
made sense to me.

Thanks.

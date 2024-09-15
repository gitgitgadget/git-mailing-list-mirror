Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBD1C7B87
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416797; cv=none; b=ZHOg4uUzkMfyCO58upPp1EmFOxu1lvZg1VDiuHglh8MBRdR3ponccAk4V+m4/MLAH0M6ZnYYdAbJrvT3dNDpuY5PE3fXbHTIyL6b9hQC9LTjTe98/XOrXCNQTMH82a4WXrhLfo8o/WShxu1q2oStNujJKIkcc/8bFLzlsI4Svh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416797; c=relaxed/simple;
	bh=uYvTt38MsYHWpnrw/U3xagrU7hi7LhSFHWQIRovOeOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAKdyoTmqO1jEvaY/8WAFcNBzfP6O8A+JHnfKeXBPFQEt8MF3NQl3HCKePwQsgUsSOOTZJNXmxMVoFKgNZa893MiqpL2vEc/B+pkjP90npcx9MVHGZoUaoHEtF4sSvbT6O5J72Yb3fMqmzT99dKOHif0O5oADgbSgMReYVt7EvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mR8nKTPo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mR8nKTPo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EDDD29609;
	Sun, 15 Sep 2024 12:13:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uYvTt38MsYHWpnrw/U3xagrU7hi7LhSFHWQIRo
	vOeOw=; b=mR8nKTPotnffTZ0OUeW0VxVTsIVPuSn8cR/QTX22gy5cfqC49pveE5
	6om+mrTt0g2ddPAZDa45H43QDNQ3Ln8rgC1mPTQg9NYXDJtnvpJcjmsenqBXMkzQ
	Q62VpqRB1dyP9Sd0lDt2Bp0R32zYE5s0gTnKOIKRet/L8iFPhvFFI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9742929608;
	Sun, 15 Sep 2024 12:13:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0963F29607;
	Sun, 15 Sep 2024 12:13:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] t5512.40 sometimes dies by SIGPIPE
In-Reply-To: <CAPx1GvePRNzt_LFJAf+_-abdt--075LG8-DA=2YW_0R1soXz_w@mail.gmail.com>
	(Chris Torek's message of "Sat, 14 Sep 2024 16:27:50 -0700")
References: <xmqqmskbwe1a.fsf@gitster.g>
	<20240914064130.GA1284567@coredump.intra.peff.net>
	<CAPx1GvePRNzt_LFJAf+_-abdt--075LG8-DA=2YW_0R1soXz_w@mail.gmail.com>
Date: Sun, 15 Sep 2024 09:13:12 -0700
Message-ID: <xmqq5xqwsxnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68F1FB04-737D-11EF-A490-9B0F950A682E-77302942!pb-smtp2.pobox.com

Chris Torek <chris.torek@gmail.com> writes:

> It's more complicated than that (and varies on MacOS), but it's true
> that the Go runtime wraps all OS-level write() operations. The reason
> for that is that Go has its own internal "thread" (g/m/p things, really)
> scheduler and does *all* I/O as non-blocking calls. Anything that
> potentially blocks an actual OS-level thread has to be handled
> specially. It's quite messy and You Don't Want To Go There (no
> pun intended) if you don't have to.

That sounds like a fun hack ;-)

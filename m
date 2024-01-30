Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AB7B3DD
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644834; cv=none; b=SLZ5CBY/VLsBnd4DMDQzm8z2Z47iQb1PrD2vbZMMBaRAg67blAQmdpySRQkx+A+hRsP/b5k84dzGJ5zu2+/TmaHYiQZeQFeqNioQZteQTVHaJ085xU0MCXabnTvzYUkdeTRAHP9yidC1C084j+lGAooQ6kWRibDY/NsAG8CoI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644834; c=relaxed/simple;
	bh=1oL8kduk8ZOJMjS6/NGbhyIV5bvxFKnUtKs1arQMx4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fMX8wFTeSzngnw40rTAFkOPzhw5mnoLqGMjPcEPERhFsuqoz6V7pCBZ64SvDp5jX6+NBHz8GCPbEtrn13GzvHlQSaTHClWjBpDAyuUW2fuuvf4la9GRVHuqz8NUOImz8D5jt+DXBY5dNjZUAZFEQG5p0XRcvC7H4hMH+WljeseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=drRR+yAp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="drRR+yAp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAA331E18E8;
	Tue, 30 Jan 2024 15:00:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1oL8kduk8ZOJMjS6/NGbhyIV5bvxFKnUtKs1ar
	QMx4M=; b=drRR+yApKDwa7vd7v/JZPAIRzTb8Hr9F8CTQ54xVcY8aVekWTkYgjy
	XRXcMA4Ckn32wUxruzkUPY6vEdQLCpo1ufhUSMxRgqs7FGt6FlXpX0gFRT/eKtWj
	8V95W+Xs0Y3oQ270RrzZgGwKFnkltiqjdxqhtUmuQo+yinlXt9Vcg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2DA41E18E7;
	Tue, 30 Jan 2024 15:00:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1352B1E18E6;
	Tue, 30 Jan 2024 15:00:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] t0080: mark as leak-free
In-Reply-To: <20240130055333.GB166761@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jan 2024 00:53:33 -0500")
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
	<4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com>
	<xmqqa5onhjm4.fsf@gitster.g>
	<20240130055333.GB166761@coredump.intra.peff.net>
Date: Tue, 30 Jan 2024 12:00:24 -0800
Message-ID: <xmqqr0hya8x3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 35AD77A0-BFAA-11EE-A49F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> Setting the flag now just makes sure we continue correctly on that path,
> rather than getting surprised near the end of the road that t-basic has
> some dumb leak. Plus it avoids the script popping up as a false positive
> when checking for scripts which can be marked.

Alright.  Any such "dumb leak" in the "basic" would hopefully be
caught by the real t-$other unit tests exercised under the leak
sanitizer, I hope, but it is not worth our time wondering if it
makes sense to special case t0080 specifically.

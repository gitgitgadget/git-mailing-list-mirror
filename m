Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7F1C2A3
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720304136; cv=none; b=WrLXUPAiTZb+KRvykix6RMRqkAs0+W34VP9sxTqM54Y9x3ZnPtqWYWJzEGAMVjf4BbRHi0IW/GNucNokvz2uAdLLOACMIkBnsxd8GMUX3sSemx4KX4yoy3c09aNlLFf6MF8facK4/F/wKmG/JGyNXe1mLO8o+P89/pRkzwCMLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720304136; c=relaxed/simple;
	bh=pUwtKdPdApjswnLiXe7B4saZeRZ9w+m2I0T9pwGPVq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOzEInn12x1hqu6GiiXJlRpm5I3Mwfv+7m3fslXlVtV9mzfp+sNgI/9nujFwos7280bJJApT79IjOPPy2ryKNgOfxbe9KEbKZtXpvFmlGoeef2ao4DGYcOMalO+XHb8yBitjeGrfiFWGfcoFFCv5OUeNRP2OZS9EcZFpIcL01zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D31uw4Ql; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D31uw4Ql"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 22D7C33B40;
	Sat,  6 Jul 2024 18:15:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pUwtKdPdApjswnLiXe7B4saZeRZ9w+m2I0T9pw
	GPVq4=; b=D31uw4QleI3RMIGzGo9EHqCO75nIRIpekW5zVXisoDn5IXhRKAtxwW
	X0ECtJfNB9klroUa3agWQbORcG6nf9XuVPDITeHdnFe3MfMO+gqQ8jzD030NiF+x
	RkmrO2Zo/HpgUaD2BALi45nxKe5pCOXCKklpIFWzkRYSnBHPwmG3I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B2E833B3E;
	Sat,  6 Jul 2024 18:15:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80D5733B3D;
	Sat,  6 Jul 2024 18:15:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <ericsunshine@charter.net>,  git@vger.kernel.org,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
In-Reply-To: <20240706060143.GD698153@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 6 Jul 2024 02:01:43 -0400")
References: <20240701220815.GA20293@coredump.intra.peff.net>
	<20240702235034.88219-1-ericsunshine@charter.net>
	<20240706060143.GD698153@coredump.intra.peff.net>
Date: Sat, 06 Jul 2024 15:15:32 -0700
Message-ID: <xmqqr0c6makb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 435C1B6A-3BE5-11EF-A6AE-965B910A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> I'll post some patches in a moment:
>
>   [1/3]: chainlint.pl: fix line number reporting
>   [2/3]: t/chainlint: add test_expect_success call to test snippets
>   [3/3]: t/chainlint: add tests for test body in heredoc
>
> with the idea that we'd apply your patch here on top of what Junio has
> queued in jk/test-body-in-here-doc, and then these three on top.

Would the final form be to have Eric's preparatory enhancement to
chainlint and then these three first, and finally the "here-docs"
conversion I queued from you earlier?


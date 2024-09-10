Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBA2837D
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982938; cv=none; b=Jh36KBeKqLsxwpVKx4gspk4DQTWyfPZh4EnrsRreVqlOl2onmuKFeKtH2yc2h6rl/KbghPLLa8jNT4ZV9FngAi6chW/PCgdfuKy21b6d8Gf+nSZJWLYdqkUC4bfR0Hr3ksrfxa+JAgS0+ADAMsNTHvoH0WYfNPCCg2MHh7R8ldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982938; c=relaxed/simple;
	bh=h2bYx5/QObe1oOUdDZEI3n1kW3zmUSfgLMUTP+o9+a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOuMNSP4p9gWx8rcsf0I84wQn3jbPl12YmXc9mXcNfSbkJQmJhs+GHD66pqNX+w04JGlKGL1TO/QhHcFcVj80rXeRdYN7YlHHynyDIwuxJGx7tRd7I15NsOi/3hUehy9R80z293HUWu7Izly9gpuWybnD4piKnn3SxvBablGwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l1spa52f; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l1spa52f"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B1F03876B;
	Tue, 10 Sep 2024 11:42:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h2bYx5/QObe1oOUdDZEI3n1kW3zmUSfgLMUTP+
	o9+a8=; b=l1spa52fMr3346D2NYYooj8dwaoZwVOpIY8fmCO4jhEIjv/HKOr8xm
	HlihAuTQwogABO1qw5ntQK0Ek48xS2Hw9Y6bEddXSWQKKiPSgC1DxhG3VYqt13sn
	6kJf8KMzsbbMf1up5OY3rUKoPc8HI/z1P4mseogPFqsGnAicjpN/s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7130E3876A;
	Tue, 10 Sep 2024 11:42:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAB3738766;
	Tue, 10 Sep 2024 11:42:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <ericsunshine@charter.net>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 3/3] chainlint: reduce annotation noise-factor
In-Reply-To: <CAPig+cQZhrG+0BJkDbmKY11jxSspod2Xp8tSQq-DGOO9qMbR_w@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 Sep 2024 04:14:38 -0400")
References: <20240829091625.41297-1-ericsunshine@charter.net>
	<20240910041013.68948-1-ericsunshine@charter.net>
	<20240910041013.68948-4-ericsunshine@charter.net>
	<Zt_5zMiu4QRka5x3@pks.im>
	<CAPig+cQZhrG+0BJkDbmKY11jxSspod2Xp8tSQq-DGOO9qMbR_w@mail.gmail.com>
Date: Tue, 10 Sep 2024 08:42:12 -0700
Message-ID: <xmqqjzfjms6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4025E19A-6F8B-11EF-A2C0-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> One thing I don't like about this is that we now have different output
>> depending on whether or not you happen to pipe output to e.g. less(1),
>> which I do quite frequently. So I'd propose to just drop the markers
>> unconditionally.
>
> My knee-jerk reaction is that the "?!" decoration is still handy for
> drawing the eye when scanning non-colored output visually (not using a
> search feature), so I'm hesitant to drop it. However, on reflection,
> I'm not sure I feel very strongly about it. What do others think?

Unlike ERR, LINT is distinct enough, even when mixed with snippets
taken from the test scripts that are full of words that hints
errors, checking, etc., so I'd expect that new readers who have
never seen the "?!" eye-magnets would not find the output too hard
to read.  For those of us whose eyes are so used to, we might miss
them for a while, but I do not see much upside in keeping it.

Thanks.

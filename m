Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5751C42
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505457; cv=none; b=P0wzqi60OR2TqvpCW/PXk2jn9MB9Z2whGX5REVcJ2QzAAFTzVNSGFqinjuATcy3We+M1G96nI/lWlk6coL8kpQfibZn3UnJNa/5boW5V0OD5fYG57wzKRJ0ednD5xziPasqPbrnXrV0wErxyw/YGi1rTRwSJ2cpDICJ57YC0A8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505457; c=relaxed/simple;
	bh=vfOFDqF8v2pFg4kHV1mh6CC0N+YW+kfihBhQ6NKt9G4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6WL0euKHnxem7wzg3rLcAIoMmt0HRPCELbqIVso7oAWMWZbDdUuhWkm96NpEJxs2+IRM2xfbXJNQ5K/I3aB5tnt/7z5k+D1RVeOg7/Awv4+5Ae5srbanU+7k+c5wBNHwpsBAv/cWcEX0wc2a5fr1WE+wouaLwyRhWz4i0Mw1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WK+F+mJC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WK+F+mJC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E18F234C6;
	Thu, 23 May 2024 19:04:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vfOFDqF8v2pFg4kHV1mh6CC0N+YW+kfihBhQ6N
	Kt9G4=; b=WK+F+mJCflcH2C7mvsbJMsqaVUoppvLLA0MO2Mq6Qytk6pRmnrsmOU
	6v2XVklIrmo5enUslJ63xT1oQe7KwKWyEBfnRgHeNr0kZsygRYG+ANU4kiaeye6x
	kFW1r9PrHV2qAT30RTkG+9BtSE1FFN4v/BS0FCwvwTzd0jegy0YJI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64F3C234C5;
	Thu, 23 May 2024 19:04:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE7D1234C4;
	Thu, 23 May 2024 19:04:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <261636d461e58ac8a16180c4cd6e0460@manjaro.org> (Dragan Simic's
	message of "Thu, 23 May 2024 16:18:03 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
	<xmqqh6esffh1.fsf@gitster.g>
	<ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
	<20240521070752.GA616202@coredump.intra.peff.net>
	<5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
	<20240523090601.GC1306938@coredump.intra.peff.net>
	<xmqqjzjky6eo.fsf@gitster.g>
	<261636d461e58ac8a16180c4cd6e0460@manjaro.org>
Date: Thu, 23 May 2024 16:04:12 -0700
Message-ID: <xmqq7cfkqger.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C5D4E0D6-1958-11EF-BBE8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> And for usability, perhaps giving a specific command would change
>> the default program a bare 'P' invokes for the rest of the session
>> until another specific command overrides.  Another usability hack
>> may be "[interactive] pipecommand = less -FX" configuration variable
>> gives the initial default for each session.
>
> I think that would be way too complicated.

It is modelled after how "less" and "vi" remembers the last pattern
fed to their "/" command.  You once give, say, "/test_<ENTER>" to
find one instance of "test_", then "/<ENTER>" takes to the next
instance.

As I expect our target audiences are used to such a behaviour, I do
not think I agree with your "way too complicated".

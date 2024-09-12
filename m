Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C1A5F
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172896; cv=none; b=aTHFQq5ov3FYjXngDQ/FF8O7v2FjTXEojliYMHWH/JbsrqewRS8u84psQlSLf/6j+J6avJM9NccPJ/8X2grvTvexolA6zJ3cdXnAbof9hnXPSPPUJwpyLF0/R8tFmDWBMgnCcAEoY5Swops685Lx4WxhYreNjYA/7HadB1OcLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172896; c=relaxed/simple;
	bh=mFESX8Piu3/lcEipTdMH1tee7Dm9V1TZyk2JEqwaf8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCbdHvH7qIs/0tyNTt14XMjc2M2mBB04wUTSFn6CoQ41GRP6EQ9VUWZlihA7Gt3H6DdWQM9C7so97wrzaIVQaJqPsVmc0BBUuJbmvpYm+7N3R4xkr7Tqp0em9k4BXlSkQCuF8Ic3ueq9lEbpvOM77TSYZgy11Ghn5MX5I4B0wP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HqHltXi3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HqHltXi3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 477C7300CC;
	Thu, 12 Sep 2024 16:28:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mFESX8Piu3/lcEipTdMH1tee7Dm9V1TZyk2JEq
	waf8E=; b=HqHltXi3xcJJMBLvGLSTGNP/DqXieKldoWzdWHt7m14Y/Hgl9Mm6wG
	fEUVBAtkFGXaC+1RV6/0ENiaQJR2ylNrlF5zy/KyK8JjXPp88cKZooNF6Sc9ZJFE
	CxuxOt5ck4vcVT9S6tsfzFmBCTRj6pelIaQAtTgzsS6OFwwOM0uao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39E0A300CB;
	Thu, 12 Sep 2024 16:28:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0DC7300CA;
	Thu, 12 Sep 2024 16:28:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 5/9] i5500-git-daemon.sh: use compile-able version of
 Git without OpenSSL
In-Reply-To: <20240911061257.GA1538490@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 11 Sep 2024 02:12:57 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1725651952.git.me@ttaylorr.com>
	<bfe992765cd562b036cb235dfdddb78f5e662812.1725651952.git.me@ttaylorr.com>
	<20240911061009.GA1538383@coredump.intra.peff.net>
	<20240911061257.GA1538490@coredump.intra.peff.net>
Date: Thu, 12 Sep 2024 13:28:09 -0700
Message-ID: <xmqq5xr04nxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87660902-7145-11EF-98BE-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] imap-send: handle NO_OPENSSL even when openssl exists
> ...
> But we can observe that we only need this definition in one spot: the
> struct which holds the variable. So rather than play around with macros
> that may cause unexpected effects, we can just directly use the correct
> type in that struct.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  imap-send.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Neat.  Will queue.  Thanks.

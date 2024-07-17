Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB8181BA0
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230568; cv=none; b=pc/7LTQksS4j4ZKwL9Hebcv4ZMNav4jtCd5vMcwJcHCa7QbSZHnGEIZeshKFb9e2PIjrMSWOG91IXK8nps8JGihgoIpexwG2UTe/NiFEgQ8hw8GkeoqdhcYFQYuQ5bnrRdpIhxQZSkF+Z1IeDNLXerwMFraZXdK8StKZgcIgL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230568; c=relaxed/simple;
	bh=JS2s8ZHUpr70NUS5fZh/3ajOq/kwBaBN6MH+rlQMM1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ppgcaDz6fj+8yCoNxPdd/lPAkV1lSrZ/vk9RpqZEpbUTB+b3rFlVe85HGPoDrUXi3KabH/Wg0D3dtDwlnxNts4vpCG81kSV5p74F5bbZkNPO6rpilqtQQ79VGWES3d2lIrFqXzzx90WhFcfxrFoB+bZNCFwblwuoulnJzAFnmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sTb9gIzN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sTb9gIzN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4BE82021A;
	Wed, 17 Jul 2024 11:35:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JS2s8ZHUpr70NUS5fZh/3ajOq/kwBaBN6MH+rl
	QMM1E=; b=sTb9gIzN1c4rR1buYV1T6TirlgArcd0Lm7mI2ShunahpqHMTyCy2SW
	dTgOAO7wOP0M4F9p/QWAChcJECLPwM+/1bIB57BbvdAFqrMyrdGyJkHzXMExLp2B
	a+UMHQvF4LFQqzLdP2eFZDEyUO9mhoXm7Fvg1cBoEqQVOubeMebTY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C622520218;
	Wed, 17 Jul 2024 11:35:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 258D020216;
	Wed, 17 Jul 2024 11:35:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: [PATCH] t4153: stop redirecting input from /dev/zero
In-Reply-To: <20240717070050.GG547635@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 17 Jul 2024 03:00:50 -0400")
References: <024201dad543$877221e0$965665a0$@nexbridge.com>
	<xmqqv818aezm.fsf@gitster.g>
	<20240714070558.GA575927@coredump.intra.peff.net>
	<20240717070050.GG547635@coredump.intra.peff.net>
Date: Wed, 17 Jul 2024 08:35:57 -0700
Message-ID: <xmqqjzhk58v6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 44100BE6-4452-11EF-8551-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> But we later dropped the use of test_terminal in 53ce2e3f0a (am: add
> explicit "--retry" option, 2024-06-06). That commit dropped one of the
> redirections from /dev/zero but not the other.

Ah, it makes sense to drop that other one with this patch, then.

Will queue.  Thanks.

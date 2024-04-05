Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63E1175551
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353767; cv=none; b=m3HucACdamD20n/n6EwZVE0LjZOb9+IglO4MWt98Zcst0RTMfZY+t+IZoHplojzFRk/gF+uLZjLf3UvtdGpz2m7mSl0cmzoqSqdeW4/mmig5dqHFqIonsTKyXYQJInZGELpIhiUunnvQkomGL5cr/n9zukeSThLUuzo+0UcBjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353767; c=relaxed/simple;
	bh=gfP2Oo9OF3b+lfptJ/Jl/sgAQI28zQgxV82KtvBBqwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GiZfI72Ut9fieEXehHyeo+tpo9xh0OxRWIyU93xPyvmHxms2qBizHSO5K4BFA+0IjRiHYx1dVTGnI4zviMP/galeQU7wGDmH9R45djj5I2rU7yNpn+CfDeuNjkBM/nVNV2t+vLl3bIw8dLgOq6shvV0Z4WB3bYEY3QLMWyIrWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vu7m75fm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vu7m75fm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C0591F1AB6;
	Fri,  5 Apr 2024 17:49:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gfP2Oo9OF3b+lfptJ/Jl/sgAQI28zQgxV82Ktv
	BBqwY=; b=Vu7m75fmeMcTzfvwsId6Q1tPxIBYp+bHiwJ7iTq6rfvp7OUDET8tTO
	U/xg8Eu1WiU3X7O8FlwUCIC1/+kW9n7B56X/XK4A/piGlh7Roi1ARDIzEMOPUgsw
	U03e3yWbiQ74iUQK26Q1Fuax7BMNlms2gN3+FKX5q/WByX3hLU18k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6121E1F1AB5;
	Fri,  5 Apr 2024 17:49:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAEB91F1AB4;
	Fri,  5 Apr 2024 17:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 3/2] remote-curl: add Transfer-Encoding header only for
 older curl
In-Reply-To: <20240405200451.GA3700566@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 5 Apr 2024 16:04:51 -0400")
References: <20240330000212.GA1261238@coredump.intra.peff.net>
	<2n7sn76-p413-5632-4o2s-o5n2p1rqnr5@unkk.fr>
	<20240402200254.GA874754@coredump.intra.peff.net>
	<20240405200451.GA3700566@coredump.intra.peff.net>
Date: Fri, 05 Apr 2024 14:49:22 -0700
Message-ID: <xmqqle5rtr8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5DB4C88C-F396-11EE-8A08-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> ... And as a bonus, it serves as a
> reminder that we can eventually clean up the code as we bump the
> supported curl versions.

;-).

The way git-curl-compat.h lays out various features/workarounds and
the lowest version that needs them makes it very easy to do that.

Thanks, will queue.

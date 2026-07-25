Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A2305674
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784971318; cv=none; b=FdiGEP65uQBN6a61OBxbj5KpxvMmLR2rIsMbLcWZl1oT3ZXl/KXDhhoLefFkMuFhnkivv1w09lTx9hvr+REDuXaa0DMBKUB1AoOn+bs+ADR6wxxLcPCMvcJsO8/4g/JgWAy5Yi9wVwguahIuc9KrZEn61EYS667SYb4jRpEmV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784971318; c=relaxed/simple;
	bh=PV12WShlFZ2ZJ7XRb31ciQN04yRHuUbyN2Ey7VvLhoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT5GIdos/Vc2lHdrhIhhKgsl1qmkzF4PBWYkQ9ctYhE7OwVH/DCSEt4z9MY2EN0JtAZAmjXhKgdq83rCV/0nx2C3jaR1vUgISA3r7c6wXbNVGnNJ/k/1jYaJotSzIkjcDwsvV3lt144vVOUkCkJ+2jXnoOFbv45pAs/6178ZSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CtRDW+zE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CtRDW+zE"
Received: (qmail 45621 invoked by uid 106); 25 Jul 2026 09:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PV12WShlFZ2ZJ7XRb31ciQN04yRHuUbyN2Ey7VvLhoY=; b=CtRDW+zEvTYmMySDig10XrDdCaaBIwfwiKnotwivSkfJqkepEWRxy2ViaVh/3r0dSQ51WMPEn1hC3YzFaDlsGYQ2DiNiFV8m1t4pguaKnxkjM0c9Z080MrGmdWP3Wnt9f5b4lKBq0oHDJCq/uujMh0W23tvbUvFE/VkqQhdjNG8HBo8k44q2XBT5uTnfKRieXhYl4JgcWglitwL6xIimuWzX6Ey20BCQBx62S9tWmLR13MXA3QM/uHmHAC470LsG207iYsa1hzlEwWHlADtLCR1wmD9QsGjsyV6HP1Vop4zu16m9ieC8KyMxsm8MYFqawIonXNBq8iT+E+wZshUYcg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Jul 2026 09:21:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 45126 invoked by uid 111); 25 Jul 2026 09:21:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jul 2026 05:21:59 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Jul 2026 05:21:54 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	me@ttaylorr.com, ps@pks.im, karthik.188@gmail.com,
	sandals@crustytoothpaste.net, avarab@gmail.com
Subject: Re: [PATCH v3 0/3] packfile URIs: support concurrent downloads
Message-ID: <20260725092154.GA1925154@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <cover.1784676106.git.tnyman@openai.com>
 <xmqqldb19evx.fsf@gitster.g>
 <20260725090910.GA1438796@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725090910.GA1438796@coredump.intra.peff.net>

On Sat, Jul 25, 2026 at 05:09:11AM -0400, Jeff King wrote:

> So from the perspective of the server process, everything is fine, but
> curl complains that it didn't get all of the bytes. Weird. The strace
> shows both writing the first 1MB as expected. It's like the connection
> gets hung up for some reason, but I can't tell why or by whom.

Hmph. I tried stracing on the client side, and we indeed see an EOF
on the socket:

  recvfrom(12, "", 16384, 0, NULL, NULL) = 0

I'm really puzzled why that is the case, though, as the server side did
not close() or exit.

I do wonder if it would be possible to write this script so that it
triggers via apache, like the rest of our http tests. Doing our own
socket handling here is a potential source of bugs.

-Peff

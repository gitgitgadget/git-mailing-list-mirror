Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6E2441B8
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027847; cv=none; b=UvV/RzEu09enfPq10N7UXxodGDS57Xdt1dCWexpgdYKxWpjRVuobA4WmlMCOqL+OC6MLCZvAA4i6iGroh8fXPq3RPi3JClE8l31Hj8PXJL82fM6aznMeFJPBUEbkg5NHhWKF6Zs85pC40IhnjzP9tBoYmrdguomJjuXSnmprq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027847; c=relaxed/simple;
	bh=8oJ0B2dHeUT0ou8GNlpaG8LcyWcoV8yXc9f0pEmv1yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3d2eGALeISE/YjDbMO36f51tr524xgIWSky3yjbCQ0PVzHINTJIG2Y98iCmbbIdqmuQ0PaBD/IQ/odnlpr6s/GmAYU7pk12YC8uvRmi5KuWPgDYfoqi1kaptUzIvb4UHdm1AuCWlEozK5Je2U8nEkULOdGiOGAcjzNxgoeSzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AfsdxvSb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AfsdxvSb"
Received: (qmail 88892 invoked by uid 106); 2 Jul 2026 21:30:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8oJ0B2dHeUT0ou8GNlpaG8LcyWcoV8yXc9f0pEmv1yw=; b=AfsdxvSbw8ZX0VnlM7AZbBof36ov2v1I2uP2p3lSMMiMTu43QGVFQ8KyQZSid5e0l8Ybh/kKcV2ZLUB+ODa1V0RoGW7lbe9HB6hyIq1/NJHUeeSyaaVOsRelqAKXAF51g7at3v9Cm0PkHhof2r7QifcwieHy/usQ7Q7jHlMW2fwgqYn/61dZ9R4KS7IpItduQQjjoPIjEuQZSQwRfhhr6rDAfJepOfqT57F2Gv8UANOwzcSFAWrq84xrXNn3acDGf2H/k+4viP1XYix2kc1CDgzTHx3TL+jKoB6YwEwdVKgh0lrHyj5DLx0/sqNMFwuWME32G6VxHoAN9kRipZANSg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 21:30:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 188101 invoked by uid 111); 2 Jul 2026 21:30:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 17:30:44 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 17:30:44 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/9] t7900: clean up large EXPENSIVE repository
Message-ID: <20260702213044.GD2051171@coredump.intra.peff.net>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-6-76b4d7bab3d0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-6-76b4d7bab3d0@pks.im>

On Thu, Jul 02, 2026 at 02:00:59PM +0200, Patrick Steinhardt wrote:

> One of the tests in t7900 is marked with EXPENSIVE because we create a
> repository with 2GB of data that we end up repacking. We never clean up
> that repository though, so we occupy the full 2GB of data until the end
> of the test suite. Besides clogging our disk, it also means that all
> subsequent tests may have to repack this data multiple times.

Hmm, I hoped this would drop the time to run t7900 with --long, but it
takes about 1m40s both before and after your patch (vs ~6s without
--long). Just looking at the script, I'd guess that it's because the
subsequent repacks are mostly incremental or geometric, so they don't
need to write the big pack.

Oh well. It still seems like an obvious improvement, though, both in
terms of peak disk usage and avoiding unwanted surprises when more tests
are added later.

-Peff

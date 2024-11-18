Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD3190468
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923913; cv=none; b=Fnknn5D1/VCYMPyyzNtaiR5DOYqR7nPQU/3zLvMdbd9MpSRuNACqfOTY5UcDyeFbnHFi533efv882K0cSMfAmXnY4RSGUUGtfVN5XAottjvyuyGV4Pn5m/BpK7t5kVeNlKysnsN6D/paI7X5K4W+OTROBWiAhCfSAxh1C4HOXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923913; c=relaxed/simple;
	bh=shqxYJnImWj/v82EA02o2r4I6A5eCrI+2uM84TvxhJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTcbzU5oaaK9euX9dBR1JRATI2qnfOpbnTIQPUrTpxPBDT0bVEgHjAP4ruxfcwN0FScwDxQnRK8Jcz72jXVtAxeZHPNR4Yd7s9AgDI9Mg6Rcs63azx3kP63HwGc2v+hDpF7r2BaYpwnN9XW2Wc2b52XfB88Wysdln74WLuxI0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ns5CXdWW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ns5CXdWW"
Received: (qmail 22538 invoked by uid 109); 18 Nov 2024 09:58:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=shqxYJnImWj/v82EA02o2r4I6A5eCrI+2uM84TvxhJ0=; b=Ns5CXdWWrF2D1JBbplsLcnPtdZuXkcMUkpj6sxlH7RjJVWvJQUYEswaSe3apPACEJ0yMgoUQOhTcsccPxzS+tkTjf9hMdY94JYEJGBp1Mn2ugQzdFVobKWnSGY0ZTLvWhnhJ4IVqqwONKhaXbrgZ3q89zzUU4Xm+MStkhM8N7zngfRcjJVvVa3ocRVfRrdZBk25wqMR2DGuS4j/tkzinhX/4WlSGCNUxcfJQymRW8tL+FH7y6LfLcO3JVcM2IY/5OGQYiS/aWLUFmPkMiMauYeNXmL8OKJiUAckOe81eFtnKqRWlboz7phiBAI1rRMj2GUHvYIuHx+X+BUtoQ5CuVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:58:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18345 invoked by uid 111); 18 Nov 2024 09:58:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:58:35 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:58:30 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 0/2] C23 compatibility
Message-ID: <20241118095830.GA3991628@coredump.intra.peff.net>
References: <87ed3apy2u.fsf@gentoo.org>
 <20241117013149.576671-1-sandals@crustytoothpaste.net>
 <Zzrwf2B36RgbhxEa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zzrwf2B36RgbhxEa@pks.im>

On Mon, Nov 18, 2024 at 08:45:03AM +0100, Patrick Steinhardt wrote:

> Both of the patches look obviously good to me. I was a bit surprised
> that this is required in the first place as I thought we were passing
> `-std=gnu99` to our compilers, but that is not the case with our current
> Makefile. So I must have been misremembering.

We do for DEVELOPER=1 mode, but it wouldn't make sense to pass something
unportable like "gnu99" for the general case.

-Peff

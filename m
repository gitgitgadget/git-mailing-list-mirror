Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72174A06
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077608; cv=none; b=KeZtH5c0rZWq7vNFPXQlYZHSTzuvNsm42/U31CIESChPszY6167ToaSi1Fz/wQjkgchSSQq0Sxicwys7cjRbqs2l8elcim6D7iIZ+u4SatRx8kqbd3DTg4hN1nXRtYwBgH9df+PwjogOt98eA94t/0qVD7I3Abq2+NFF/Dccve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077608; c=relaxed/simple;
	bh=CAlQjeGH1U6jPtwHkaUbMeYgWcA9nXZFoqoJs78a1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg9rKZMR/TR/2UsU2CbMObMvmshjExfPLyIgSNuGfMKZI0NDr3VkF9I8ZaFYvIkFkcXMW3qNXsb1bkMwc4hKcBAA1JSfhTULbYzfyD8M1fngKMb2GTLyr7XWp21uWO/M4gRr5JirgwI94/BL8OLkZeSbcNrIiG6dgtvHHnR68JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B7tj2G9c; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B7tj2G9c"
Received: (qmail 182427 invoked by uid 109); 10 Oct 2025 06:26:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CAlQjeGH1U6jPtwHkaUbMeYgWcA9nXZFoqoJs78a1Dg=; b=B7tj2G9ch235bK9rfjlhc32Jrwzcqns6ZVAObdOKXg8ds1rckkkwkCN33wRGdbMCocCGTqgdnLhtMOgj+x1zsCvRVKgViwTEvQTEkDFXpbu42Ha63d/PtFsne8NLTZhTQ7cLh/bGB3NZws0zY9i7HJN6OJqq3QRZCFawiTdq3vsvZKuuchEZlI1Nu9TdxGlVXTFqq6vr10yAdqbD9ZBrFT2+m2B01ZIqlC1zAA7yU07J8BN1L44Omnx6QkAm+fA0eWIJeTEZFHp69GuVehCUwtcGQih5GSKaR1g1WlP4uCOefHMSmDMkC1vlO3Uj41JqQqXOd3JmeDUqF1xGBl76Yg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 06:26:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283700 invoked by uid 111); 10 Oct 2025 06:26:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 02:26:44 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 02:26:43 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <20251010062643.GI1965904@coredump.intra.peff.net>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
 <aOdRsR-k77uTWJRb@pks.im>
 <20251009063956.GA1622884@coredump.intra.peff.net>
 <aOdjM8F6WvTEBIo_@pks.im>
 <20251010051242.GC1897715@coredump.intra.peff.net>
 <aOiYFPTNLL1Fgz5V@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOiYFPTNLL1Fgz5V@pks.im>

On Fri, Oct 10, 2025 at 07:22:28AM +0200, Patrick Steinhardt wrote:

> I think I'd like to avoid doing such a swap in this series, as it may
> easily cause confusion and create problems for any in-flight series.
> From my point of view I also think that neither of these names is
> clearly superior over the other.
> 
> So to move forward, how about we land this as-is and I promise to follow
> up with another series that:
> 
>   - Renames `struct ref` as proposed.
> 
>   - Introduces `struct reference` into more of our APIs?

OK by me. I am also OK if we just leave "struct ref" as-is. I like the
name "ref" more than "reference" (since that is the name we usually use,
and what the API is called!). But changing "struct ref" now may be a lot
of churn. So I will not hold you to your promise. :)

-Peff

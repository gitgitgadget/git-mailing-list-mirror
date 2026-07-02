Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21636A01E
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982704; cv=none; b=PxwgW6wlMCzBdjVcjY4+ZqOhMtkrL0JOzKE/JM15Z+tnppSSs23tzFcPvro7WSyMLXf4RjjFno8Oz6s+fRjK+96I26S9b4xjCUSj2uYDp7pn0HBEyhGE/G+FHFbCfRb5DggReqcLOko73Uc0sZ2HWVhoOAmcAT3r0xr/kEFALEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982704; c=relaxed/simple;
	bh=hE+wVuMxhi9HCyJlerQEZDFrVaeBgnnRGUVlJRQxg5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrTOafXLof1em7qCATOxDM54PxKniZQmuK+1hYGHfY8vvDGZ7TxxQUpFW2KY2wPLDrQlOAULEu3VtaJTYOkY7B2eraL8LDx3bvgqqJycmJGITfPN9JOJgJT2iaOr5qCw/aLb5Jrr6cPMXvQZcgAe2TBBHlSpzgh73T/uXQsN0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ODTF4fkF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ODTF4fkF"
Received: (qmail 85943 invoked by uid 106); 2 Jul 2026 08:58:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hE+wVuMxhi9HCyJlerQEZDFrVaeBgnnRGUVlJRQxg5Q=; b=ODTF4fkFWpwxOexzz3lL18YHoObJJY+LyuynyVC6ProU8m56vm8l81zrDyMFhqvbQgwqCj3tWYm4/BB96Qyydobybchimtltcju9E576UGN36uLL8QrMBiODEp5iRxDPG/w+orqfJImiv64qLBkLOUhiEKxtSdxR/VBY5Xb8WcS5JqemHNJ/HWqzMXaYv0tL7p3VNQ5LOY4IE+Z2Dffi1K7Au4Dj5wHIyu6dYp9SkI22F5O+AXFh8dLlXKuI1pbEy2XvcFE1eJCMmlKKfOkmSotUVyp7i4qNT5yBRDbLHxWx2M3Ivy0Uv5MtQgJwR1+p9BCJVE0Ct6VE2+y8xu6/vw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:58:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 179788 invoked by uid 111); 2 Jul 2026 08:58:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:58:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:58:21 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <20260702085821.GC481298@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
 <20260701081358.GB813310@coredump.intra.peff.net>
 <akTS_rPV7JaGHKRq@pks.im>
 <20260701084733.GA814472@coredump.intra.peff.net>
 <akTXYoY7mSQUM33P@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akTXYoY7mSQUM33P@pks.im>

On Wed, Jul 01, 2026 at 11:01:22AM +0200, Patrick Steinhardt wrote:

> > > linux-reftable or linux-reftable-leaks? I think it would certainly make
> > > sense to drop one of these and merge it into linux-TEST-vars. The
> > > linux-reftable job doesn't provide any benefit over its -leak variant,
> > > so that would be the candidate I'd personally merge.
> > 
> > Both. Fold linux-reftable into linux-TEST-vars, and then drop
> > linux-reftable-leaks in favor of a new linux-TEST-vars-leaks.
> 
> Hm, okay. I guess that should be fine. Do we also want to do a similar
> thing for macOS and create a macos-TEST-vars job that exercises all of
> this?

It could be helpful if we expect the interaction of macOS and those
test-vars to be interesting, but I'm a bit skeptical. Most of them are
about feature selection. So I'm doubtful it would turn up anything
useful. But who knows.

Likewise I find the dual clang/gcc jobs to be overkill. Compiling with
both is useful, as they have different warnings. But have we ever seen a
case where running the tests showed a different result with different
compilers?

I dunno. I guess there is an argument for CI-maximalism; as long as the
jobs run in parallel and they're "just" CPU-minutes. But those minutes
eventually have a cost, and I'm not sure I've gotten useful data from
most of the jobs (i.e., failures that didn't also just happen somewhere
else).

Anyway, that is all a big tangent/rant. Mostly I think it would be fine
to cannibalize linux-reftable into linux-TEST-vars if we want to get
more coverage without increasing the CI cost.

Note that I did find some leaks that would only be hit running
linux-sha256 with a non-standard backend like OPENSSL_SHA256=1.  But
that is getting super specific now (even if we ran linux-sha256 with
leak detection, would we want to do it with openssl and not the default
backend)?

> Also, while at it... I really think that job name is just plain awful.
> While at it, we might rename it to something more sensible like
> "linux-changed-defaults".

Yes please. Every time I see the all-caps TEST in the middle I think I'm
having a stroke.

change-defaults is OK but not super descriptive. I might call it
linux-exotic-flags or something. That's not descriptive either, but is a
little more fun.

-Peff

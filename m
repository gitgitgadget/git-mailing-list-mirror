Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001644C4FD
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192795; cv=none; b=gWkXLMEQ70Vn0S1YzwjQfv+kS3k/QO6jk83S+bfOfLemijQrAXD0gw4g1IyrWnwmG1OBhWqkp4Ms/8jyvhA65Ap7j3zJRTmyN1z5IZsEarDtKczEqnMrxWD921kopMu8DIgTcytWobRpwnB1cIdPg/FfTkuz7M0TkXnX+/MMr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192795; c=relaxed/simple;
	bh=WGJ0WxWTtufyiQyJZlZQM5PA/tbI1ZWSDyANxMNwl5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3uda7KeUa20QIpI9mUTPtfwQ5j9NZX3uLbvSDYsmsyo/i5yd0F6gUDwP5encxqTWp7lcTXieEZtZUWwuwIoDc9Gpyr0y1Gnhdja7Ray2lletc5dCHaOVfV/iWCGp9zFQ+dR7IPBfDOoJbAAphaP/MiulFqdSayJ9uNtkJUtVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d/aM/GCs; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d/aM/GCs"
Received: (qmail 35553 invoked by uid 106); 23 Sep 2026 19:46:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WGJ0WxWTtufyiQyJZlZQM5PA/tbI1ZWSDyANxMNwl5E=; b=d/aM/GCsvbCHAqKdigw3cR8btGSCaR7WzHjtJb8M3ePBTgT2mSRu/T1JBoxMuAFVVJLLljpviyTlJ8QRzso15QcYbzFMaIM2iPuxDOnB5nn4nB21B7sGvsjSuM75rhFAzDLGPKfXEm6UWIUfw4NOlA1otWWzC0t/LK8FRhbimSMLxNIBmvQ4IXwyyJlcbLEL1HhKGg+jFBPP4o90WOcD8IOmpbi6QVBSfrREzK1oPODP9XbbsTbyDkB3hPQXndJvq1B9FNnoc1mL9nurTUdQ2TfklOUC0UA2KDE31r32DZ4pK3O5SqqtJgH7UCpY4jln/keUCHrwjJd7tstf4wZRkA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Sep 2026 19:46:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 183302 invoked by uid 111); 23 Sep 2026 19:46:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Sep 2026 15:46:29 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Sep 2026 15:46:28 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/6] [RFC] Create a 'safe' strbuf API
Message-ID: <20260923194628.GA44327@coredump.intra.peff.net>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
 <9adb1d94-c72b-43f2-aa02-004e3e476eb1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9adb1d94-c72b-43f2-aa02-004e3e476eb1@gmail.com>

On Sat, Sep 19, 2026 at 04:23:41PM +0100, Phillip Wood wrote:

> > The goal of this short RFC, such as it is, is to get some feedback on
> > whether this is a worthwhile direction to pursue or if I should abandon this
> > idea of having this definition of "safe" for some APIs. This decision may
> > also determine if we should abandon ds/trace2-tolerate-failed-timestamps or
> > leave the existing behavior as-is.
> 
> I think having APIs that return errors rather than dying on allocation
> failures or overflow is reasonable. The xdiff and reftable code already have
> something similar. I'm not sure "safe" is a good description for those APIs
> though as it does not describe how they differ from the existing APIs.
> Instead of talking about safety I'd rather the documentation talked about
> returning errors on failure and the function naming somehow reflected that.

Yeah, I don't love the term "safe" here for two reasons:

  1. It implies the normal strbuf functions aren't safe. The flaw here
     is the "malloc failure is fatal" scheme, but that's just fine and
     shared with most of the rest of our code. I think we usually
     reserve safe/unsafe for things that you should be extra careful of
     using (like refs_resolve_ref_unsafe, or the unsafe hash algos).

  2. There are many types of safety, and this is just implementing one
     of them. ;) In particular, for the use case in the trace code we're
     looking at, I'd expect that we would want to avoid calling malloc()
     at all, because it relies on locks. So this new code would not be
     safe to call from a signal handler, for example.

So what I had imagined when seeing the initial subject lines was not
strbufs who report malloc errors, but rather strbuf-like functions that
operate on a fixed-size buffer (with either a static max-size like 4k,
or perhaps a per-variable max-size recorded in the struct).

You can still run into errors, of course; we might run out of room in
the buffer. But we'd see those cases deterministically for a given
input, rather than occasionally when races or other external factors
cause malloc to unexpectedly fail.

> For the strbuf API having to check for failure on every function call does
> not sound attractive, I think having a sticky error bit like the stdio
> functions so that one can build a string and check there have been no
> failures once just before using it would be a nicer approach.

Agreed. I think that is a good approach for the static_strbuf idea
above, too.

-Peff

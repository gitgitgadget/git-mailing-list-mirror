Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480352F4A
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024100; cv=none; b=Pg4m+eoWm6dvrhMJ3JXA74RIaWQXtXDJeR5sHQfPYgjLbJ36BLO7c52CGpASZUYYK9Rkrt5z41l2GyEhaf/dzY5PAyrE+NBV3WDeXYBZnFrS/MQuHY7CX+TZUPIRkVjHnyOKw+ApCR5O5qKl1pidbkibdWJBeilf6D1Un6r6bLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024100; c=relaxed/simple;
	bh=vXQ/F+eQqP8VxWxHiLQyXFe6qDXBZ5dpRXNAvGwkQuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8UNGNIGzkAtxhXa8kqpFKVzfyluBaaIYQJaO/Zg+P9rGkfaKDz/F8CsirTNcw0RTMtdRizIo4PImCBMagWXF3+B7NtpTu3CQgQDOyz/uJ2eO4h3lnQFKthlsA8jUtLbKD0xZ+3wkSj65zkOJ8VFjw3/nGcyknhEtxwtJfB4ltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g3CTSlfi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g3CTSlfi"
Received: (qmail 17895 invoked by uid 109); 9 Jul 2025 01:21:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vXQ/F+eQqP8VxWxHiLQyXFe6qDXBZ5dpRXNAvGwkQuc=; b=g3CTSlfiWl4XFyu1ViYBlPcbhgknFvxYKl9P0A6FFYhMy+GrW1Da/4TzGhXpvzLN4MzbQ5J9wd0Q1NWCBl9+bstG+kU8wmlZoW6fNMyC6YSliy6nAxWknlTdlIa11d4nIaDk0LyWVDXr6c6usRb/xTllPg8xpkKF1FCuh68Asucoc62yy5BIZSqJSTBNv3GIrMwfwcGLrosg2tWlNOYTJerD3+mk2beJyGB2SZcbx6cNOQECgDEs8cXKvVsIjozx7w+U7+4l93nCcXPLVZpATJJTfdbubTdIJkOtt+kM9wCf53KdgfZGs/zMpnJprn8bT9EtCSuHHMDcge+RFEwhrw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Jul 2025 01:21:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32410 invoked by uid 111); 9 Jul 2025 01:21:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jul 2025 21:21:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Jul 2025 21:21:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Per Cederqvist <ceder@lysator.liu.se>,
	git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
Message-ID: <20250709012134.GA1185474@coredump.intra.peff.net>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <20250705165750.GA1951664@coredump.intra.peff.net>
 <20250705185842.GA2496172@coredump.intra.peff.net>
 <aGuP3Q5xykmRNp0m@pks.im>
 <20250707202801.GA3115893@coredump.intra.peff.net>
 <xmqqtt3n3e7g.fsf@gitster.g>
 <20250708225946.GC1180568@coredump.intra.peff.net>
 <xmqq5xg2s1n8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xg2s1n8.fsf@gitster.g>

On Tue, Jul 08, 2025 at 04:28:43PM -0700, Junio C Hamano wrote:

> >   [trailing underscore: mostly a_, b_ in comparators]
> >   $ git grep 'void \*[a-zA-Z0-9]_' '*.c'  | wc -l
> >   30
> 
> Only a single letter followed by an underscore, which may be
> followed by more letters legal in names (like a_bcde)?
> 
> A more fair pattern may be something like
> 
> $ git grep 'void \*[A-Za-z_0-9]*_[^A-Za-z_0-9]' \*.c | wc -l
> 52

Doh, yeah. No wonder it mostly found "a_" and "b_". ;) Yours is a much
better pattern.

> > Although I think we're all a bit lukewarm on the concept, I feel like it
> > won't hurt anything, isn't too much code, and disables a potential (if
> > somewhat rare) footgun. So probably worth doing?
> 
> Even though it does not cover all cases, at least those coming from
> "git remote" will be able to avoid surprises, so let me replace with
> this version, wait for a few days for more inputs from others and
> then mark it for 'next' if nobody sees any downsides.

Sounds good, thanks.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083129A5
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751771623; cv=none; b=dNX0du5jFcB3GK9RhAYtyvAg0eqTE6o/9x7ozUOalcollrpGsqoHAUYDqsJINK+10tUc1V4mZSfDK6nwUJEpqvo8KqU/qPDzSxxRhAoOS+1K6GsFZ0pSmyQixpJODQWt+g3rOZxC5VmUMihqZgKfQ32+wjHa9FkIr8Rtv7XFD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751771623; c=relaxed/simple;
	bh=i9p4IRdvwNReL3jJWRz5BSMHUngLK1jJRNhDuEt0Mfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR/00U9p1m2B8gI/J/GhDM1wDp4lTsLvaQIQTN4KHNbljb1TJFH3z9ii2/lcAZ9m0I5wG+/OFbKJIr8TKCTVHK2ap6s9QNsf7fyYAbj/gRB0xvVZ9QmOvNS2V2SAO4iRBk1lCJeLxHInnBrbow7ed6F1tWmP1PIuzp+wNbR+DCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y4SVQ5Ev; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y4SVQ5Ev"
Received: (qmail 26389 invoked by uid 109); 6 Jul 2025 03:13:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=i9p4IRdvwNReL3jJWRz5BSMHUngLK1jJRNhDuEt0Mfw=; b=Y4SVQ5EvZMcPqKyNRcIiBNgdZdOeXnRTiDxEjWq8jpvjURvsbiCJG6XZYVyn4nNkt72QXk4ciTl9+E8AdUouWe34V/TMvJqkrvOioOAxSpXy6hKKClYFSsK+9cFUHiJ2HQCB8YYv7lytYWmrVELWQjFYKIl0jiTCAfGVddknRuex/9ybNkd3UJy2+IEIyHTPAoS3wBmlZAUeSaHb4jCKw3LDfMkYfwhPDxCI6spNTzGawrlvfOVyYzm7MSSL3gIOi2+TrJ+bl5n9I5A6GzBxysDwqAd+61lxLwr76cnPkoV1EtPcW5ts+BUKsjd7DjDYb1HG0yu9Npqk45XXtBuNMA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 06 Jul 2025 03:13:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11314 invoked by uid 111); 6 Jul 2025 03:13:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jul 2025 23:13:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Jul 2025 23:13:37 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: redoste <redoste@redoste.xyz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
Message-ID: <20250706031337.GA3041790@coredump.intra.peff.net>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250705192113.GB2496172@coredump.intra.peff.net>
 <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
 <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
 <aGnDO3HIAQgsRbnJ@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGnDO3HIAQgsRbnJ@fruit.crustytoothpaste.net>

On Sun, Jul 06, 2025 at 12:28:43AM +0000, brian m. carlson wrote:

> On 2025-07-05 at 22:50:43, redoste wrote:
> [...]
> > Since I knew that the Linux kernel changed their documentation to remove
> > the use of "real name", I thought it was more common and didn't relly
> > think about it a lot.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> > 
> > I'm sorry, I should have read the git documentation more thoroughly.
> > 
> > If it's really an issue I don't mind signing off with a different and
> > more distinctive name.
> 
> No, I think this is fine.  You weren't obligated to explain that and our
> policies should gracefully handle this situation regardless, but given
> what I said before and this context, I think the name you have is fine.
> Git unfortunately has poor support for replacing names and I would't
> want you to have to put your deadname into our history for all of
> eternity.
> 
> I'll send a patch to fix the policy.

Ah, I hadn't heard about that change in the kernel. I agree that it
would make sense to loosen our text to match.

Thanks (in advance) for sending that doc update, and for your earlier
comments in the thread. I agreed with everything you wrote there. FWIW,
my personal inclinations lean much more towards allowing privacy and
anonymity, but as a reviewer for the project I wanted to make sure we
were not violating our own policy in a way that would eventually bite us
in a legal sense. The notion of "identifiable but pseudonymous" you
brought up seems like a good middle ground (at least to my layman's
ears).

And thanks redoste for your patch. ;) Sorry if bringing up the signoff
issue caused any hassle (but hopefully it will lead to an improvement to
our docs).

-Peff

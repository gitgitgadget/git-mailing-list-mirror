Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA0343D8F
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790990718; cv=none; b=sC5/GtTSuuXzu6joIUUxYeBMUWZ0rwQyu9CrpXkpzy9ehkzsEf+3bfhRGjcJUty/jVHF5XqqBqP9hSf+lmJHNdfT4/RmXhlF0tLBW7wCDpUVc9EkLHjcAHxvFiyZJtXUyoXkqNMPDPXHm6wgqj6rR067Pf1ZFxyma+sGLbXya88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790990718; c=relaxed/simple;
	bh=pAGGHHHT7oUOV8oGaHtN3tlbIhlWaPEV4L9x3ew4qns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7UMQb7EXGCqziDELWnJhAJ8dWHmiP7kbi7sNrJN9bIjYL2c+hOn5Y8yTvDiahk3jIiZgZJVH+x3Mbr9Jx5gq7XxB6jw/W0s2+kPNBZvyxu8yZDuUsBP5/wf1yJBjv9avFxjbEmZ+rPdxv4bFRLpXAtPdVOo/3Mb+Ok9P7RpWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hKq+fF3s; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hKq+fF3s"
Received: (qmail 17243 invoked by uid 106); 3 Oct 2026 01:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pAGGHHHT7oUOV8oGaHtN3tlbIhlWaPEV4L9x3ew4qns=; b=hKq+fF3sFixQD62f1D/aRIOT1jAQQ/yZG1q+MGwhAkZc7Jix8irFG//Q2ZgdhnOZnFhLbHZxQB6SIWt/ApJOaJl+vd/X7PbGnNqR25IitIqnXIZcYnWiThPf8EiuZiiwM9BD6v2c22dfEKcLkxWZlvEp5J/6zOtoRKhrnVCh0uGtvuLZse+kCA7cwzFIkNdypugvdDfet/s0uTWywWvbFTA0dxQY2l/8eugdvw3ohWswxI65B6O3omItqJ/NkQ7ew1SQkYyIjvkqTl4svRl1QmxcTCd9J1mqK67slHAyC9Le9TVhHroHyA9WQKwNQyMtswaHs7/+IJE9AJpK7b5uGA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Oct 2026 01:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 50729 invoked by uid 111); 3 Oct 2026 01:25:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 21:25:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 21:25:12 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: a "limbo" object-format state for empty repositories?
Message-ID: <20261003012512.GA1324483@coredump.intra.peff.net>
References: <20261002224400.GA834158@coredump.intra.peff.net>
 <asBVY1WniGUo6bQS@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asBVY1WniGUo6bQS@fruit.crustytoothpaste.net>

On Sat, Oct 03, 2026 at 01:07:48AM +0000, brian m. carlson wrote:

> > But I also did just think of this idea, and haven't implemented anything
> > (nor do I have immediate plans to). So it might be half-baked. But I
> > thought I'd toss it out there and see if any body has thoughts, or feels
> > strongly enough to try implementing it.
> 
> That is definitely something that could be added, but it's also
> incompatible with every existing implementation.  Specifically using the
> `object-format=limbo` approach means that no existing client from 2.29
> on will work with the repository since `limbo` is not a valid hash
> algorithm.

Yeah, that is a problem. It breaks older clients (that are at least new
enough to understand object-format=) worse than a mismatched format
does. I was thinking we could solve that with a new capability, let's
call it "magic-limbo" for a moment. Older versions would ignore it.

But then what do we put in the object-format= field? We have to put
_something_ valid, as even if we put nothing that is an implicit choice
of sha1.

So I think the best we can do is advertise magic-limbo, and then new
limbo-aware clients can always do the right thing. Clients which are new
enough to understand object-format but don't understand limbo will use
the server's object-format unconditionally. So the choice there does
still matter. But if we don't switch to sha256-by-default until
magic-limbo is implemented, then anybody who has a local sha256 repo got
there intentionally, and presumably knows enough to configure the server
side to match. So the sensible protocol advertisement for a limbo repo
is "magic-limbo" plus "object-format=sha1".

> There is some support for multiple `object-format` directives, but I
> don't know how well it works and I seem to remember that we had some
> sort of crasher bug in the past.  That would be the best possible way to
> advertise that, though, if older versions support it.

Yeah, I thought about emitting multiple but it seems like that
introduces other weird corner cases. I think we really need a new
capability so that new versions and use it and old ones will ignore it.

> There are also going to be some policy decisions, for instance.  Some
> organizations will not want to allow one algorithm or the other, so
> Git will need some way to allow that behaviour to be expressed.  Or more
> likely, Git needs some way to allow the fact that it's in versatile
> mode to be expressed and that it's safe to rewrite the config on initial
> write into the repository (which, to be clear, need not be a push; it
> could also be a commit or add).

Those parts seem outside of the scope of Git, or at least its protocol.
But yeah, I'd expect a forge like GitHub to let you say "do not allow
the creation of sha1 repos in this account/org", and the object-format
selector for a new repo (at the forge UI) should be a tri-state: sha1,
sha256, or limbo. How that translates into Git commands is TBD: whether
via config, or more likely, that you have to select the limbo state
explicitly with a command-line option to git-init.

-Peff

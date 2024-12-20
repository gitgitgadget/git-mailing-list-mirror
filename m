Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9E19ADA2
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685536; cv=none; b=ZaBsfmvANUbqkZAoRaPWRzxGi0pVXjQBaIXA/6KxNlbrmnc37jJ/4vnyFBQYjr/3UT7xQpyEP0L8BxtzG+QhT0Da4+EO6raJfCFhUcvnmLEz25DI0+fbjWBixpSM2oEJbW7c/Fxuute+pbMTpDHIPf+i9i0S5JL2YROpMfomPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685536; c=relaxed/simple;
	bh=Q2scwSaoTvMHPDTe9yAllYWwpRTv9QrgFKaDowasJvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md9np7XbKfDHBHfaNVmjS9OyiyHhYcuc+xrJtp62s0fQiVhDFJz6yUtRX5u17ajPYWeGgD07WzBNosvVDGrIFm1bGMdVC1MhBjevDz6GJ+UDZcOfbrfm9E7zR99yQ4m0qDSvmW3yY4u1yU7bIDpEWnZmFi/r036GGp4IH6GGbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eBjIVK36; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eBjIVK36"
Received: (qmail 8681 invoked by uid 109); 20 Dec 2024 09:05:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Q2scwSaoTvMHPDTe9yAllYWwpRTv9QrgFKaDowasJvg=; b=eBjIVK36jgNfgekELoM/owvX2pNGNcWTbq/AMa6V63ilRuQk+TIm0EmS/aNZcI52EQirA0CRzCl2h8SDTD7ty6XLK4k1dlpSrqBJFQ+dHkJTsxDY5YO8lpgqV1costUPNCOAI6o0kIF3YzEeAYsBhMWUkuSYIy+rjivwvDVKXrgLEhQ6LOQblCi2qSidbSqOcd710B8nB8/+k0dk/4fRIOZWh6lqr6uNPtWYkLnWyb960p0lGRZDFPH0MsmU8bFj3zuu7+hZndUdv+Ja7u7Ju4Ubmzz/mzT2rcbO845+7pckao5xLnWBTCxdDH/Swe4F0NE909vVDbHCHR5MyK7Qcw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 09:05:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14458 invoked by uid 111); 20 Dec 2024 09:05:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 04:05:33 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 04:05:33 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Boomman <boomman37@gmail.com>, git@vger.kernel.org
Subject: Re: git gc does not clean tmp_pack* files
Message-ID: <20241220090533.GC133148@coredump.intra.peff.net>
References: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
 <20241219054222.GA2310556@coredump.intra.peff.net>
 <CADMKT28cZcdW8UJ59vZHoMa0WEbyAccx4A10-jk3MiBkhZLxEg@mail.gmail.com>
 <xmqqmsgrncr6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsgrncr6.fsf@gitster.g>

On Thu, Dec 19, 2024 at 03:17:01AM -0800, Junio C Hamano wrote:

> Boomman <boomman37@gmail.com> writes:
> 
> > Yes, if the behavior in case of running out of disk space is to just
> > leave the malformed file there, it stands to reason that cleaning up
> > those malformed files should be the first operation to do for gc.
> 
> It is misleading to call them malformed, isn't it?  When a Git
> process creates a packfile (or loose object file for that matter),
> they are written under these tmp_* names.  When the processes die
> without finalizing these (either removing or renaming into their
> final names), they are left behind, and it would be better if we can
> remove it _before_ another process wants to consume more disk space.

We usually automatically clean up our tempfiles if we encounter an
error, but don't do so for partially written packs. I think this is
mostly historical, though occasionally it can be useful for debugging
(e.g., indexing a pack coming over the network).

It might make sense to register them as tempfiles in the usual way,
possibly with an environment variable option to ask for them to be kept
(for debugging).

That's not foolproof, since a process can die without cleaning up after
itself (e.g., on system crash). But it would mean that a repeatedly
failing "git repack -ad" does not fill up the disk. And the decision of
when to clean up tempfiles in git-gc is less important.

> But the issue is how you tell which one of these "malformed" files
> are still being written and will be finalized, and which ones are
> leftover ones.  You want to remove the latter without molesting the
> former.  And you want to do so in a portable way, possibly even
> across the network file systems.

Yeah, I think there are two issues being discussed in this thread:

  - when to clean up leftover tempfiles

  - how to decide which tempfiles are leftover

The second one is what the OP mentioned for locking. But not only does
that have portability questions, I'm not sure it is sufficient. Would we
ever write tmp_pack_*, complete our process, and then expect our caller
to do something with it (meaning there's a race where no process is
holding the lock)?

I'm not sure. We definitely write "tmp" packfiles via pack-objects and
expect git-repack to move them to their final names. I think we use a
slightly different name ("tmp-<pid>-pack-*"), but arguably we should
consider cleaning up stale versions of those, too.

-Peff

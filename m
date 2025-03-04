Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B51F5826
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070592; cv=none; b=VkBQWGSx/uz7a92wtvxmRq65LCBHb6PkKMzKYTawTkVmhD8gaaL8Er+ssc+oY2ssa7TWWpL2FSP9iBH6Ki4hWlL3nKOcieM6tivuG+bHZXRBqQ8tDwpLDil34mCi/+uDlJCBHjOAV/EQJAuBc4t1pkP3Z6xlIChGSdsCFK0jNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070592; c=relaxed/simple;
	bh=eagM+6oVa0QsuVOp067S82bI2olOJYPMOm9ItCTLoZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvMhH/iwDbR4C4wgE7D89WcZTDuJJMB8H/OApTroy9LClcK63xvp1zY3+2QihqZAKb/npF8rNqKYtDVppIy+u/m9lWYGZjWuWgViwtL4WP5NvgAeAp7PvIQkGCRkuyKjVC2mG/cyfof6lKoTfJmiaQuGGOdrpBlz7h4AXE0K9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DTktck+Q; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DTktck+Q"
Received: (qmail 9134 invoked by uid 109); 4 Mar 2025 06:43:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eagM+6oVa0QsuVOp067S82bI2olOJYPMOm9ItCTLoZc=; b=DTktck+QmnIYu5l28TWxYBsajWOp46jW/viKPMaydgEDSmQO1Du/n/KmucVre75k3Y3nwobk+9M2VhqFmCDgYaQB9Ag8G529X8PKcPQhG6XbNLKo5HofcafP8RQHdEyXY7qyJ7FQplbgbqjX0HBpHXp6fUHuQCi60AVNQVBx6xrvZidSqHGmrecUlk1r5oRwV3txBQek0+xk1x8/fpHtNmSJglzOrV7/WKxtoYufWYWK/lzX0Tv67j+2Lw3e2ZkxXG6lC6iRCusnJePUibj9usRs5jelTIj+sqa3VvKFalLtccqj/8etGXydGw4eeL2KNtsEo3XU+DRwR4w6arhwgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 06:43:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22166 invoked by uid 111); 4 Mar 2025 06:43:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 01:43:09 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 01:43:08 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/10] loose_object_info(): BUG() on inflating content
 with unknown type
Message-ID: <20250304064308.GA1283901@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062824.GA1293961@coredump.intra.peff.net>
 <xmqqv7sxh3xv.fsf@gitster.g>
 <Z8EAXIHB4dVYS9t/@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8EAXIHB4dVYS9t/@nand.local>

On Thu, Feb 27, 2025 at 07:16:28PM -0500, Taylor Blau wrote:

> On Tue, Feb 25, 2025 at 05:47:56PM -0800, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> >
> > > It really makes me wonder if this "unknown type" stuff has any value
> > > at all. You can create an object with any type using "hash-object
> > > --literally -t". And you can ask about its type and size. But you can
> > > never retrieve the object content! Nor can you pack it or transfer it,
> > > since packs use a numeric type field.
> >
> > Correct.  IIRC, the "--literally" support was mostly for debugging,
> > and as you noticed, is very much limited because it can only create
> > funny objects that are loose.  And the debugging was not really about
> > adding more object types, but was more about "what would our code do
> > when we see an object that is corrupt whose type we do not recognise".
> >
> > I personally think the "--literally" should not survive the Git 3.0
> > boundary.
> 
> It is quite useful for testing intentionally broken objects, like
> commits with malformed author/committer lines, or trees with
> out-of-order entries, etc.
> 
> Perhaps we could replace that with a test helper that is only accessible
> within the test suite that acts like "hash-object --literally" and
> remove "--literally" from the plumbing interface? I dunno.

I don't want to get rid of --literally. It is great not only for testing
and debugging, but also if you needed to recreate a slightly broken
object (e.g., to recover from corruption). Hash-object will complain
about objects that fail fsck, even though they are perfectly usable (and
may be embedded in existing history).

But this unknown type stuff is not and has never been usable. So I'd
propose to keep --literally but always reject unknown types.

-Peff

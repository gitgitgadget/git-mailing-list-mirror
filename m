Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D3613D53C
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767340145; cv=none; b=TSWCQlpvE9CXxk4c0UJI3caFjdHwr+/722jdUYwQSI8Y3ZH86HszQlE8zWuZm99j2xsx6fAfsvFUiHC+p48mPwp0/sUG5RNxIVW/E2BlsjWCHmbD222POgKIDWW0CxNF0MDVJmKnv4Wow072p2LAQKVUtI/nK0BEddlI3KhGypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767340145; c=relaxed/simple;
	bh=7R5dIpseuO6wu6GN6Ws+bz0Dln33rUAqLu6tQJHBjsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWyAK8aoZIadidFVVc6NLsYahxs/QHRMdJZgFTHA0VJpqe9IH42tEr6XNlancLFh7qxJK6tO1sZJGf21UFRtCkr1Z4Xa5XhFbrD5cBER3bfjAhRamSPrmO3LT2/EqA/4OJKS5ktr/XSYFMdDBohIN9GCkdBHzqSR5R87hLqANvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NYsOsijh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NYsOsijh"
Received: (qmail 553210 invoked by uid 109); 2 Jan 2026 07:49:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=7R5dIpseuO6wu6GN6Ws+bz0Dln33rUAqLu6tQJHBjsU=; b=NYsOsijhs5QitjQchD2C4lWUCUhkKtl0bDBFH7vfe+l+orL0vxByQ1abuNz3Vs1W5RbMMoZDvHG/GNJTHUYU8QecfoVgHYuMJMtgcxkzaHklGquaqM4O1eUSoDAasUQ88hwhfhW5W7YTtq7hUGQFV65hHeG090yByGfEzO3Rd17g/nYgnaxINuMnbAVgSsfnG6/B+JBZfiAkdvuUR8vsSRnJCA/R8wZ5jBHrFkemj4UnWa6SetBQPtHGXvjb1whN/wAD5RmTfOM3DE83vtQthE+JmemEf5OGSdyhk4vIKwBJh1KZSSXHDa/bMArZdjW78iFNK8zWx8Xm7amTTTbGkA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jan 2026 07:49:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 719831 invoked by uid 111); 2 Jan 2026 07:49:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jan 2026 02:49:06 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Jan 2026 02:49:01 -0500
From: Jeff King <peff@peff.net>
To: Martin Fick <mfick@nvidia.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <20260102074901.GD2581074@coredump.intra.peff.net>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>

On Wed, Dec 31, 2025 at 05:48:11AM +0000, Martin Fick wrote:

> >> I think this is from `should_pack_ref`:
> >>
> >>     /* Do not pack broken refs: */
> >>     if (!ref_resolves_to_object(ref->name, refs->base.repo, ref->oid, ref->flags))
> >>       return 0;
> >>
> >> So Git is going to need to verify that the object at least exists.  I
> >> don't know why we would need to _open_ them, however.  Perhaps someone
> >> else has ideas.
> >
> >The packed-refs file stores tag-peeling information. So pack-refs opens
> >the object for any newly written ref via peel_object(), which has to at
> >least read the header to get the type. That call happens via
> >write_with_updates() in packed-backend.c.
> 
> Thanks, this makes sense. However, since jgit needs to peel these
> objects also, it doesn't make sense to me that this would be the
> bottleneck unless git is doing something terribly inefficient here. :(

I'd expect both git and jgit to open each loose object once. I tried
running "git pack-refs --all --prune" under strace on a test repo. It
does seem to open the object once. Then I tried the same with jgit
(though it does not understand --prune), and got the same results.

So...I dunno.

> Except for the fact that repacking objects made it faster, my
> observations make it look like it's the writing that is actually slow,
> not the reads. Could there be too many small unbuffered writes, could
> this write path have missed being optimized (it likely isn't used
> elsewhere)?

All of the packed-refs writes are through fprintf(), which should be
fully buffered. You should be able to confirm with strace (I get
4096-byte writes on my system).

If writing were slow, I'd also expect that to scale with the total
number of refs, not the number of changed refs (since we have to rewrite
the whole file, but only new entries need to be peeled).

-Peff

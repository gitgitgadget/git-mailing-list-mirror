Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DF10E9
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563328; cv=none; b=CzDIPDsLvRMBr/IkRoi3i3xmQTpBYiK+IyKjPadQQWL9CH0EiJ9OpJV4v/v0tPSouPHWu0aSTVNtGXACPiWI47h0WDdwlJzN82iNeCICgPR6k/dckjz9yY3Qaq60rA1ImB/fYs0cOl66FcJMVMRBhYCLxmPIMzmMGnNZfOyBbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563328; c=relaxed/simple;
	bh=SI8vq2P94DHMuIU++/lW0bbEuc795olKj5ApGY/0LZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi5IVzK2H4wr2Y7iwbybszRnOylvzNczT0WDoc5N/hYsewebFUqCbd7UZ2aL/mUCXw6d6/wz/Q3DrqAgwykEe/+Qx3Xr5hb3CALALwWqO69QMJlZwYGeslTCn9qh52DJXbHYper+XIxGn8iNi16qDYtKrR6wGJDXE3GM0zEJLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HwOIarwM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HwOIarwM"
Received: (qmail 10110 invoked by uid 109); 11 Jan 2025 02:42:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SI8vq2P94DHMuIU++/lW0bbEuc795olKj5ApGY/0LZI=; b=HwOIarwM6nR9fOIjieO+SizSLjumrYTh5y0S7Sliu+kD6DxkJzRSfNSBdlajEDomgQj0zHfT53Z8eTlTLVUD96HSINa/ZVvEncpp9YXwSjqNhydIX/xOCuaSbm16FGRqli58kBx7bavDDPux5ynpEwckywHATdaw15/+EKEsRxr6FA1hLmxZtdj87ctZwgSybiXnloS6ds9Tp7FkpIqHKTqqf2h2nYnpsyd3rFKPrOaHQNKLLaa9VafcD1JVEOyHQJmParEJBUREZFGuhQMtrYb9Y7uko2zlJyymLsW7UKjJKgPbcHm8bol+Y/ElKewKNEoQFtoTsVS2mReuc7dDXA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Jan 2025 02:42:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16575 invoked by uid 111); 11 Jan 2025 02:42:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 21:42:04 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 21:42:03 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <20250111024203.GA590176@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <20250110104106.GB1014709@coredump.intra.peff.net>
 <Z4GRQvAIsSIeQuYd@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4GRQvAIsSIeQuYd@nand.local>

On Fri, Jan 10, 2025 at 04:29:38PM -0500, Taylor Blau wrote:

> > I didn't see any response to the review in round 1 about the pointer
> > dangers in patch 3. What do you think of using a separate
> > git_hash_algo_fns struct, with the one-time conversion I showed in the
> > subthread of:
> >
> >   https://lore.kernel.org/git/20241121093731.GD602681@coredump.intra.peff.net/
> >
> > ?
> 
> Oops. I must have missed those messages; and sure enough when focusing
> my inbox on this thread they are indeed unread :-).
> 
> That said, I am not sure that that direction is one that I'd want to go
> in. Part of the goal of this series is to make it possible to mix safe
> and unsafe function calls on the same hash function. So doing something
> like:
> 
>     struct git_hash_algo *algop;
> 
>     algop->init_fn(&ctx);
> 
> in one part of the code, and then (using the same algop) calling:
> 
>     algop->unsafe_final_fn(...);
> 
> should be impossible to do to. The benefit of having only a single set
> of functions implemented on the git_hash_algo type is that it is
> impossible to mix the two: you'd have to use a different git_hash_algo
> altogether!
> 
> So porting the above example to your and brian's git_hash_algo_fns
> struct, you'd still be able to do:
> 
>     algop->fn.init(&ctx);
> 
> in one part of the code and algop->unsafe_fn.final(...) in another part,
> which doesn't appear to me to be safer than the current situation that
> this series aims to solve.

I think what that proposal is doing is orthogonal to the goal of your
series. You'd still have an unsafe_hash_algo() function, but it would
return a git_hash_algo_fns struct, and that's what struct hashfile would
store. So your patches would still remain.

The advantage is mostly that you can't confuse it with a regular
git_hash_algo struct, so it avoids the pointer and hash-id issues.

I do think there is one gotcha, though, which is that the hashfile code
probably still needs the outer algop pointer for things like
algop->raw_size. So you'd have to store both.

It's _possible_ to still confuse the two, but the idea is that you'd
have to explicitly call algop->fn, to get the wrong one there. If we
wanted to make that harder to get wrong, we could start making it a
habit to never use algo->fn directly, but to ask for the safe/unsafe
git_hash_algo_fns struct. But that would be even more churn in the
surrounding code. I think just doing it consistently within hashfile
(which is the only unsafe user) would be sufficient.

-Peff

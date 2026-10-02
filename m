Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F539D3EC
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982148; cv=none; b=TDWgOwqkPKzaFzFWOCrLPf/5ETMQo/jXs3W2uvDofdm77FVUUW/Eo8WsFi2ftm7ry63i4wQEM3XNEzfVijbbQon6JYnu6m24ZV+vpzAEPJcR+Q5RDCnB94KFwmSQnSlXyzYVyHq8btZ5/oh38MzWq53VX4e24XCFLU8Fr+vsHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982148; c=relaxed/simple;
	bh=jBQzfE1eAfJApZ7xgRKwPFU3Ik9jwOXj9JXMW/IY6fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgZpBG4SmT9BaFHu8dYxE+LYU5oexmGAg8HJ0q++Z8LT32+bMaalwNDgU1aRoRKQs2HYST7iKd/c++pkAOqngdR8OoZWvYhIWNJSh0daNzbJf5egB4Rqj0LEWUM4In9JmvoPLLZS/YQL4ZHYGlgrnjpauCza2cU0bakTkAKH7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Beorjb0n; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Beorjb0n"
Received: (qmail 16768 invoked by uid 106); 2 Oct 2026 23:02:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jBQzfE1eAfJApZ7xgRKwPFU3Ik9jwOXj9JXMW/IY6fc=; b=Beorjb0nLH45aQg0PF2WIkgi+EtPilHUIMxdYkI+nWSATn5sPseTx1FQv1EBhuzNfnf625U/3KoFs8Ifd+k19u6/wvUArKanNztXSA9A0/7PLihDHmWjFp0lf5slqDUQIYGfANQUMgn8swUYcaOjjSZqhrO0oUgfQ/r9+xItIKdoU646/pA4kVek2/RhHSadKDqnti2ZdYqO6MwoxguZaSmWjKKIQzpk57bRMsx8LHy7NoPUbpLggUUAFP31plJ3Kj4dM3QozlCFC1Xk1SFJKGLQ2Qf2YoKOe/cHJXaGehtfG6VmYBLqKKDwA8h75ObJoeGMwcl7anyTAhDAkzSOWA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 23:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49044 invoked by uid 111); 2 Oct 2026 23:02:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 19:02:28 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 19:02:25 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <20261002230225.GA834759@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
 <a78a38ca-b08a-4194-b17c-b8802e4d43a7@gmail.com>
 <CABPp-BHE662t9aaNcZ4DZ+2AU_C7jR7_VyHZwt2Tm8JSPE3JZw@mail.gmail.com>
 <ar8AJLYZVb6sCIO-@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar8AJLYZVb6sCIO-@com-79390>

On Thu, Oct 01, 2026 at 07:51:48PM -0500, Taylor Blau wrote:

> On Thu, Oct 01, 2026 at 04:22:11PM -0700, Elijah Newren wrote:
> > With the oid_array and parent-first pack order, the blobs are visited
> > as sub/a and sub/b, so sub/* -delta applies. With the oidset, the
> > subtree is visited first and the blobs are seen as a and b, so one is
> > delta-compressed. When the root is processed later, the subtree is
> > already marked SEEN and is not revisited with the sub/ prefix.
> >
> > The oid_array does not manufacture parent-before-child ordering if the
> > input pack itself has the subtree first; this path information is
> > explicitly best-effort. But it preserves a useful order when one
> > exists, whereas an oidset discards it.
> 
> Sure, though as Peff and I discussed elsewhere in the thread, there are
> also situations where you can produce a sub-optimal pack even with
> oid_array. That's because the namehash you get for a given tree object
> depends on the path you took to get there.
> 
> So you can certainly come up with examples where the ordering of tree
> objects in an array of extra roots produces a lesser-quality delta
> selection than the same objects permuted into some different order.

Hmm. Yeah, it is not a 100% solved issue, for sure, but I think Elijah
has a point. Even though yes, we may see trees in weird orders between
packs, or when visited separate from another commit, the ordering in a
single pack _is_ useful, because it puts root trees before subtrees.

So even though these are a few objects we're rescuing out of a cruft
pack, we'd expect them to be correlated. E.g., an update to "a/b/c/file"
is going to have four trees: the root, a, a/b, and a/b/c. And we'd like
to visit them in that order. Which is the order in which we'd typically
write them in a pack.

One thing I'm not 100% on is if that "typically" qualifier applies to
cruft packs. We might be throwing objects in there with a little less
thought, because the point is that they're _not_ reachable, and we
didn't get there from a traversal. So I dunno.

> The other thing to keep in mind is that, while there are clearly
> trade-offs as we have discussed here, the oidset ensures that we don't
> allocate memory wastefully when the same object is listed multiple times
> as an extra root.

Yeah, that was my thinking when endorsing the oidset earlier; it is
better bounded. It can have worse memory use in practice, though,
because it's a hash table rather than a vanilla array. So if we don't
expect a lot of duplicates, then the simpler array may be more
efficient.

-Peff

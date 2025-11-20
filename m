Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251B26E161
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625929; cv=none; b=RVL8ntM0BEXcDAPztpcpC6DXA5KG6m8zjZ4PyJ2EgfkMeK3P5wjc9pV85djk55BZo/PE7KvdPe3cCd7EWBwbVYfHq2tdFD+F7DBVtIm+jgjF30BRdapKCffFnwDSHtzyTkHZWkfdbop+Th5r6WCI3uX+Qer8rUopwMnZmPW87FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625929; c=relaxed/simple;
	bh=+CTksfJ4142eeh9PpRFRdeqjhqXAfslsSo90fyKQfuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS66cBtNty8qe6I1SaalBgA8U7xbObbV4bslV4BXQzb3o3SPyFdptoIotFkhCw9Iu8nmYIeNGWMFQsIcAXWnFUQUA2Vhm70vvm/bSeyj0YCy+Vdq6+6d+FG9lARcBKlOPEYgfT0V1vEdUYGYXA2W/SF0dAgT4AZ9Qyk938cu+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HeNfZg23; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HeNfZg23"
Received: (qmail 41585 invoked by uid 109); 20 Nov 2025 08:05:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+CTksfJ4142eeh9PpRFRdeqjhqXAfslsSo90fyKQfuY=; b=HeNfZg23HH88kSabkFzp+7c5ZV3YmRRv5cetVsfDi6Spu52CnlkNadFK43xlrHy6ztxo9sqS72vW7uIRR622X9+6nlR8H37NWgzjJK/2MHNWWmnKRODtKPuUa8Gvf0B8bvQcdhBM1UZYoFjIarjH16GIMCk/D3bAXSUHNLxcbzlJ8byYAdHuJrvVhCxP6GGYZEDr6jKLhoeKXZ8PM6rMRwrwoMN5PnLhW1twtw2WBZS4GD9E3OZeQdNwunNFUk368dkpex+hfC0Ag2C4Q122z1bfgjp+HTFr11QpCQBy2kexr8ZNJj/uQs3wacTwkmX0uq+wI73de2Uc6PxqW/VpCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Nov 2025 08:05:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 62251 invoked by uid 111); 20 Nov 2025 08:05:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Nov 2025 03:05:30 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Nov 2025 03:05:25 -0500
From: Jeff King <peff@peff.net>
To: 'Ben Boeckel' <ben.boeckel@kitware.com>
Cc: rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <20251120080525.GB1283645@coredump.intra.peff.net>
References: <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
 <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
 <xmqqediq2j0g.fsf@gitster.g>
 <032d01d9ed80$5e569670$1b03c350$@nexbridge.com>
 <ZQ3ggxA7KOysXrba@farprobe>
 <033201d9ed85$991c6af0$cb5540d0$@nexbridge.com>
 <ZQ3leoLhljc+P5wP@farprobe>
 <033c01d9ed8a$c6916f30$53b44d90$@nexbridge.com>
 <aR6BlHflRVLN8_XO@rotor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aR6BlHflRVLN8_XO@rotor>

On Wed, Nov 19, 2025 at 09:48:52PM -0500, 'Ben Boeckel' wrote:

> So I finally found some time to go back to this. The actual fix is
> actually rather easy (patch attached). However, as guessed at previously
> in the thread, the performance is in the tank without an up-to-date
> commit graph ("instant" with it versus "minutes" without). On the other
> hand, it is *accurate*. It does fix one expect-fail test case already in
> the test suite (also included in the patch).

Minutes? Yikes. Let's look...

> +/*
> + * Topological comparison: always return parents before children.
> + * This is reverse topological order: children before parents.
> + */
> +static int compare_commits_topo(const void *a_, const void *b_, void *_unused_ UNUSED)
> +{
> +	struct commit *a = (struct commit *)a_;
> +	struct commit *b = (struct commit *)b_;
> +	if (repo_is_descendant_of(the_repository, a, &(struct commit_list){ b, NULL }))
> +		return -1; // a is descendant, so comes before b
> +	if (repo_is_descendant_of(the_repository, b, &(struct commit_list){ a, NULL }))
> +		return 1; // b is descendant, so comes before a
> +	// fallback: order by hash for determinism
> +	return oidcmp(&a->object.oid, &b->object.oid);
> +}

Ah. So you are doing two full traversals for each comparison. That is
going to be expensive. You would do much better to walk all of history
one time, marking the generation number (distance to root) of each
commit, and then comparing generations here (if A has a lower generation
than B, then you know that B cannot be an ancestor of A). Or if we have
commit graphs, just use the generation numbers they already contain. ;)

We do all of this already for the "--topo-order" option of the revision
traversal machinery. If we have commit graphs, it can output in
topographical order in a streaming way (see init_topo_walk() in
revision.c). If not, then we collect all of the commits up front and
call sort_in_topological_order().

Sadly, git-describe does not seem to use the traversal machinery, so it
is not as easy as just setting revs.topo_order. Either we have to adapt
to using the regular traversal code, or those same concepts need to be
applied to its custom traversal.

-Peff

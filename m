Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AF425897
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800279; cv=none; b=O8n9nRbiOiNf/HYRx3w3WM1lqptpnZd2YH2HXVI9GojSuJFRMTcqawtACWNf4sM7/tLVqaHaXbPgfQKgNH07RNtIiahHnKNPdasD93uqA+/Ro9tmehbjSrpBGqFXNadI8Ntk29qNZRUfcULsUx93axQSOf56+Ty16N8Pp/aUcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800279; c=relaxed/simple;
	bh=0Hcfu1jg1Dh2aDhcHgmgAggkYvSWf7/PxzZOqjRmt5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAQPMNptwkMpZHyqls4qy5sn2OnGLtTGP5kYiW6H7z/irw6NYfMLdQb7bAnxbHy6BWDCnr8lz4ZT6emnNx/gYUWP9Dj+AHE/rTzu4y7RxHfOaodkG4IwSWsM+i4Vch5dbWcbSQHEZiSaEHzcSDusLDZZ15M+SVWlIovqiXC8iuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QB9Za2vJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QB9Za2vJ"
Received: (qmail 7503 invoked by uid 106); 30 Sep 2026 20:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0Hcfu1jg1Dh2aDhcHgmgAggkYvSWf7/PxzZOqjRmt5A=; b=QB9Za2vJrIP/ShJENcBMNGzSNvF4lBRuQwSTn6yJwbrwDECwx6bRZX5trgF4F2p+syyzGg7XFibDZD9naK8ggLboXTOGp6FeI97bbZoHEYMrJUGSqieeXvYb50btsAN5dmAnZkQYVBFNi52gUk4Twk56OZoVqw+SBfnVfbIlYZQGPP66PyX/ZfAmtt3Nn7sxJzkmtmnLKE6jyCjv6kwrxhcmKgqeNh0zlNe1WJp8DWmPe/oLXbr1foXFx5/Ie/OVOGMR9r4tmAyWrH3kolusP0TBrw03BW4f4ToJkLHz5P2sbAwUk0lLIpjLOGXt8vbMOoaziZDk2aWePLW7Izxn0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 20:31:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18624 invoked by uid 111); 30 Sep 2026 20:31:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 16:31:10 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 16:31:08 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <20260930203108.GA747209@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>

On Tue, Sep 29, 2026 at 08:28:49PM -0500, Taylor Blau wrote:

> In cd846bacc7d (pack-objects: introduce '--stdin-packs=follow',
> 2025-06-23), this behavior changed such that whenever excluded-open
> ('!') packs are present, the walk stops at objects in excluded-closed
> ('^') packs. Geometric repacks use '^' for retained packs already in the
> MIDX, relying on the indexed object set being closed under reachability.
> 
> However, the walk introduced in cd846bacc7d starts only from commit
> objects. A geometric repack can therefore produce a MIDX that does not
> maintain reachability closure for lone trees (that are not reachable
> from any commit otherwise in the closure).
> 
> A later walk with '!' packs can stop at that tree in a retained '^'
> pack even if a new commit reaches it. If the cruft pack remains
> excluded, and the bitmap selection picks one or more commits which reach
> that tree, the MIDX cannot generate a bitmap for that commit.

OK. It took me a minute to grok this, and what I got hung up on is "a
later walk". I thought you meant a later walk within the same process,
but you mean "a subsequent repack / midx generation".

So we fail to walk in an earlier repack, but we might not fail there
because no bitmapped commit happens to require that closure. But we've
set up a timebomb for that later repack, because our pack which is
_supposed_ to be closed (and thus gets marked with "^") is broken.

So this fixes the initial generation of that timebomb. It doesn't help
us deal with existing bombs, but presumably the solution there is a full
repack (and we would not want to deal with existing bombs, because the
point of "^" is that we can trust it and avoid lots of extra traversal).

Not really asking for a change to the commit message, but just
documenting my understanding (which hopefully matches yours ;) ).

> Add trees and tags from included and '!' packs (and loose ones with
> '--unpacked') as roots in '--stdin-packs=follow' mode. This rescues
> their descendants even when no input commit reaches them. Walk these
> roots after the existing traversal, preserving the `SEEN` bit to avoid
> redundant traversals. Ensure that the walk takes place *after* the
> existing traversal so that we don't lose the path prefix used for trees
> and blobs wherever possible.

OK, that makes sense, as we should treat them the same as commits.

> @@ -3846,6 +3847,9 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  		 * list after checking `want_object_in_pack()` below.
>  		 */
>  		add_pending_oid(ctx->revs, NULL, oid, 0);
> +	} else if (ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
> +		   (type == OBJ_TREE || type == OBJ_TAG)) {
> +		oid_array_append(&ctx->extra_roots, oid);
>  	}

And this is the interesting part. What about blobs? I guess we don't
care about them because they are either there or not. There is no need
to walk them independently because they can't reference anything.

Why do we need a separate extra_roots here, rather than just using
add_pending_oid()? I'd have thought we'd add it all to the same
("--objects") walk.

I guess that is explained here:

> +	/*
> +	 * Trees and tags need closure even when no commit reaches them.
> +	 * Defer adding these roots to revs.pending until the commit walk
> +	 * finishes. Otherwise a subtree may be visited and marked SEEN
> +	 * before its commit's root tree, using "a" instead of "sub/a" for
> +	 * a blob's namehash and delta attributes.
> +	 */
> +	for (size_t i = 0; i < ctx.extra_roots.nr; i++) {
> +		const struct object_id *oid = &ctx.extra_roots.oid[i];
> +		struct object *obj = lookup_object(repo, oid);
> +
> +		if (!obj || !(obj->flags & SEEN))
> +			add_pending_oid(&revs, NULL, oid, 0);
> +	}

but I'm not sure I buy it. Don't we always visit the commits first in a
walk? So a single walk with all of the proposed objects would be fine?

If I understand this subtree claim, you are worried about the
(single-traversal) case that we manually queue tree A, and then later
visit commit C, which eventually has A as a sub-tree. So we queue A
again _after_ its original, but that second visit (that we skip) would
have had more interesting information (like path context).

But I don't think a second walk clears you of that possibility. You are
queuing tags, too, which might in turn point to commits. So you might
get the same commit traversal within that second walk.

I think you could fix it by putting tags into the first walk. But it
will always exist to some degree (you could have a tag that points to a
tree and queue that tree, but also a commit that points to it). 

It's not clear to me how big a problem this is in practice. We know that
the "path" of a tree or blob in a traversal is subject to context. There
might be multiple commits that point to it at different levels. I guess
it might be more common if we are adding random trees from a pack
without context.

I think the more complete solution there is not two walks, but that the
traversal machinery should queue context-ful trees ahead of low-context
ones. I don't think we want to make the queue a stack (that would change
the output considerably), so you'd probably need to keep a separate
queue of low-context objects, and drain it only after the high-context
ones we get from traversing the commits.


I certainly think this patch is a strict improvement, and should fix the
main bug. It can't make anything worse for these extra trees and tags,
because we weren't even including them before. ;) But I think the subtle
side-bug here is not a complete fix (though I do think it is strictly
better than doing nothing).

So I dunno. I'd probably be OK proceeding with this as-is, because I
fear that dual-queue thing I mentioned above might turn into a rabbit
hole that would derail the much more important fix.

-Peff

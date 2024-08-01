Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF94187FE0
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503996; cv=none; b=LS+dkRvB3eWAqU8rcBh5JJZ0U7RitI+suBBQPoiyA9Tb9xWMKFhowXZizLToFU4YEFW3+JjKPeWk51J9FCfB+O/vipl/lVaL3e93TKQKIkofB/Y9CcUsWr5G5ITLRka4wxtnNhV7Vzlna65I2ypZ3fmMFTCrV98UqM6WP5uE99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503996; c=relaxed/simple;
	bh=4tR8ODo1dieYi3w/P7nsnRT1rDeJP1hp8K5sxhDP33I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZxsyEnJybNkZjE2C9xhu6H27LKfdaKlwbFK1AgIPHgtm88KhMuhgGLilFkIVryYGUuYxp8WhKZyVHO86t4hubTPKQhi9ycViI9jE9xZtsrgDfWO6ASX0GzwLGi9fjLBSR8o/Zay0wZmTBrtrpRCF9C/dTGhxBkmBqmuy+Zwq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17712 invoked by uid 109); 1 Aug 2024 09:19:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 09:19:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30038 invoked by uid 111); 1 Aug 2024 09:19:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 05:19:57 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 05:19:52 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/19] Documentation: describe incremental MIDX format
Message-ID: <20240801091952.GA1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <014588b3ecf2e32a6ab1af8e77234dfb2f9ea75a.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <014588b3ecf2e32a6ab1af8e77234dfb2f9ea75a.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:11:58PM -0400, Taylor Blau wrote:

> +Each individual component of the chain need only contain a small number
> +of packfiles. Appending to the chain does not invalidate earlier parts
> +of the chain, so repositories can control how much time is spent
> +updating the MIDX chain by determining the number of packs in each layer
> +of the MIDX chain.
> +
> +=== Design state
> +
> +At present, the incremental multi-pack indexes feature is missing two
> +important components:
> +
> +  - The ability to rewrite earlier portions of the MIDX chain (i.e., to
> +    "compact" some collection of adjacent MIDX layers into a single
> +    MIDX). At present the only supported way of shrinking a MIDX chain
> +    is to rewrite the entire chain from scratch without the `--split`
> +    flag.
> ++
> +There are no fundamental limitations that stand in the way of being able
> +to implement this feature. It is omitted from the initial implementation
> +in order to reduce the complexity, but will be added later.
> +
> +  - Support for reachability bitmaps. The classic single MIDX
> +    implementation does support reachability bitmaps (see the section
> +    titled "multi-pack-index reverse indexes" in
> +    linkgit:gitformat-pack[5] for more details).
> ++
> +As above, there are no fundamental limitations that stand in the way of
> +extending the incremental MIDX format to support reachability bitmaps.
> +The design below specifically takes this into account, and support for
> +reachability bitmaps will be added in a future patch series. It is
> +omitted from this series for the same reason as above.

It is nice that you added a bit of a roadmap here about what is
implemented and what is not, and that the design takes into account
future directions (especially incremental bitmap generation).

It does feel a little funny to say "this series" in text that will go
into the repository (i.e., somebody reading the checked out file will
say "huh? which series?"). I'm not sure how to word it better, except to
maybe just say "in the future" and "it is omitted for now" (and
obviously it's a pretty minor point).

> +In brief, to support reachability bitmaps with the incremental MIDX
> +feature, the concept of the pseudo-pack order is extended across each
> +layer of the incremental MIDX chain to form a concatenated pseudo-pack
> +order. This concatenation takes place in the same order as the chain
> +itself (in other words, the concatenated pseudo-pack order for a chain
> +`{$H1, $H2, $H3}` would be the pseudo-pack order for `$H1`, followed by
> +the pseudo-pack order for `$H2`, followed by the pseudo-pack order for
> +`$H3`).

OK, that makes sense. It's how I'd have intuitively assumed it to be,
and most importantly, it should allow appending to the chain without
regenerating (or even translating) earlier bitmaps.

> +=== File layout
> +
> +Instead of storing a single `multi-pack-index` file (with an optional
> +`.rev` and `.bitmap` extension) in `$GIT_DIR/objects/pack`, incremental
> +MIDXs are stored in the following layout:
> +
> +----
> +$GIT_DIR/objects/pack/multi-pack-index.d/
> +$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-chain
> +$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-$H1.midx
> +$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-$H2.midx
> +$GIT_DIR/objects/pack/multi-pack-index.d/multi-pack-index-$H3.midx
> +----
> +
> +The `multi-pack-index-chain` file contains a list of the incremental
> +MIDX files in the chain, in order. The above example shows a chain whose
> +`multi-pack-index-chain` file would contain the following lines:
> +
> +----
> +$H1
> +$H2
> +$H3
> +----
> +
> +The `multi-pack-index-$H1.midx` file contains the first layer of the
> +multi-pack-index chain. The `multi-pack-index-$H2.midx` file contains
> +the second layer of the chain, and so on.

Makes sense. How does the chained multi-pack-index.d interact with a
singular multi-pack-index? Generally we should not have both at the same
time, but I'd imagine they both exist for a brief period when moving
from one to another.

I assume the rules are the same as for commit-graphs, which use the same
on-disk structure. I can't think of a reason to prefer one over the
other but this might be a good place to document what does/should
happen.

> +=== Object positions for incremental MIDXs
> +
> +In the original multi-pack-index design, we refer to objects via their
> +lexicographic position (by object IDs) within the repository's singular
> +multi-pack-index. In the incremental multi-pack-index design, we refer
> +to objects via their index into a concatenated lexicographic ordering
> +among each component in the MIDX chain.

How do duplicate objects work here? I guess there aren't any duplicates
in the midx itself, only in the constituent packfiles. So from the
perspective of this section, I guess it doesn't matter? And from the
perspective of bitmaps (where the duplicate issue came up before), it is
business as usual: the midx revindex gives the bit order, and we'd
presumably concatenate the individual revindexes in chain order.

(Mostly just thinking out loud; I'm not sure there's much for you to
answer there).


Looking good so far...

-Peff

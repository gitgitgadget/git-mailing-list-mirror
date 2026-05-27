Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9973B5F63
	for <git@vger.kernel.org>; Wed, 27 May 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878374; cv=none; b=kzPfR9cUzT10hbcFJ/Cug/uF1oZNaEPgjCnz2QODWcWwWth5kKoWKBq19lJlZFBmB2+3TzXHqnQnY+53/ex060IkhBol9gHSnX7bB4wbgVfHxJTvmJCj1sKuAe02g6QlXbLjFR6BnmzjMXVQgefwY2JUu4OussQYDYcC9T+ZPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878374; c=relaxed/simple;
	bh=yqtyw4s8hgHJ6UvLK7WrU2aodwzzBNv4/gyKS3+qpi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COJsrx9M/ui+4DJ2I5hFXAg30jRf5IuC5OT/cBF9aF0imTVGa4aU/bNi1bDmBzVBohyCx1OJ4b9jSAfgdk5GjicVa8PvtxlzetwOAo7LIEdXR6qhC6CKxOc+x/9c+6t3KpEXWSAjOCqyeYefGixq36NLMJpaGcimUKSMZ8vB0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=flkfhL3k; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="flkfhL3k"
Received: (qmail 29333 invoked by uid 106); 27 May 2026 10:39:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yqtyw4s8hgHJ6UvLK7WrU2aodwzzBNv4/gyKS3+qpi4=; b=flkfhL3kHOXRzXT/usBJpweVM3uqT1HpWllZl3Bdg5jyg+poWwkhns0RkgayHIYoJ3PSDIoZOX8l0TKrPbSwkgnHD3fqKIGO5aVL2fmqdm6XRNcqI/195USJTwkb2LvSYeMmDDzYfjjX0oRc2DUpkA5L8yWpz5ho7z61GEFrQ0onNag/EYwO/s3E3jZCIQochuElN7tvCuYMWY+EdCkBVKHLh7OwiWshofCk+z6qKH1xDEv1uygOA1U8/fbDJAFNcL1KGpZd9ABA+GnxessGnzOemem1DnyWMvvs1mnimG5GWg5yAlLsBHSqjycxt5BUjQZN+HuACBtVaxfIdi6MFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 10:39:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 73517 invoked by uid 111); 27 May 2026 10:39:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 06:39:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 06:39:30 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] fetch: pass transport to post-fetch connectivity check
Message-ID: <20260527103930.GJ981444@coredump.intra.peff.net>
References: <pull.2123.git.1779625693328.gitgitgadget@gmail.com>
 <20260527083216.GA981444@coredump.intra.peff.net>
 <CAL71e4MrVqC1=AR6x0_8S=8kVqPdDkhgCZRb4etFsxTzd6s_8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4MrVqC1=AR6x0_8S=8kVqPdDkhgCZRb4etFsxTzd6s_8Q@mail.gmail.com>

On Wed, May 27, 2026 at 12:04:19PM +0200, Kristofer Karlsson wrote:

> You're right. I dug into this further and realized the problem is deeper
> than just the flag not being set in builtin/fetch.c.
> 
> Even if we add:
> transport->smart_options->check_self_contained_and_connected = 1;
> to prepare_transport(), the optimization still won't work for fetches.
> 
> The optimization is fundamentally clone-only.

I have wondered if the transport could do the same thing for:

  git init
  git fetch ...

When we do not send any "want", then we'd expect the pack we receive to
be self-contained.

But in practice that is not that exciting, as it is a special case that
does not come up that often.

I suspect there's some hybrid mode where we could save some work. It is
easy for index-pack to come up with a list of "edges" from the pack it
got that point outside of the pack. We just need to know that those
edges are reachable from existing refs. So really we could be checking
the connectivity of those edges, rather than the actual ref tips.

Would that be less work? I'm not sure. It saves walking over the
newly-fetched history, but in practice that is probably not that
expensive. It potentially saves a lot when the edge is a ref tip; for a
true fast-forward we'd see a ref going from A..B, and if index-pack
tells us that it just needs A, we can skip the traversal entirely.

But index-pack isn't really thinking in terms of commits, but rather the
whole object graph. So you're going to find that commit A is needed, but
also all of the tree entries in the existing history that weren't
touched by the new history (e.g., B touched path "foo" but not "bar", so
it gets a new top-level tree, a new blob for "foo", but still references
the existing blob for "bar"). I guess you could speculatively load A^{tree}
to cull the list.

So I dunno. I think there is some room for speedup here, and in many
common cases you could skip the rev-list invocation entirely. But it's
not trivial, and I think is far afield from what your patch was
originally trying to do. ;)

> I was unable to reproduce the benchmark numbers from my original commit
> message.

Yeah, I wondered where the numbers came from. It is very easy to fool
yourself with fetch benchmarks, because even "fetch --dry-run" will
transfer objects, and under the hood we try to optimize out as much
object transfer as possible. So you really have to start from the exact
same on-disk state for each trial.

> The patch as submitted is indeed inert for non-clone fetches.
> It looked like a simple improvement, but it's clear that it was incorrect.
> I'll drop it, and I apologize for the noise here.

No problem. You've been generating some interesting optimization work
lately, so I can't complain. :)

I'll probably have more comments on your other topics, but I'm out of
time for tonight.

-Peff

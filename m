Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A283E51C2
	for <git@vger.kernel.org>; Mon, 25 May 2026 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702910; cv=none; b=MnlyH9XjWfKQ6PLOkmgZX9pxMc9seLuayA5q1U9tWXxq5E1l5JDbiK7T8gy6bE+HC+lckWtc1N65lrxUl6Ce/I+X5sqeN3yzhjJiryh3wmj2a/yaSlb1Zh2R/lnybwP7LMDpXzxFetZEqOiJNWVXUG/Xn6lw8XQpy+dYP8YUMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702910; c=relaxed/simple;
	bh=1GinVoZ2W9x1hThC8PJeYyvXDK1MzqJpr4Xv2Cy1yks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgGbCaAkddNFDt6+VCOqKTZm2YitDZT5gHG4n6JuhS6OlHPtIAM1bGLgresAjIQDLLkTRPBt05hymrX/yGQ/lAVwzLVc+7QyReuP2Miz3gp69uk45VKo/lBlbiM2u3Hkmx87SN9C/QZ96kKQM6c3c8ddJMwYAWlkW57LLbPgp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WGOs/w0I; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WGOs/w0I"
Received: (qmail 11167 invoked by uid 106); 25 May 2026 09:55:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1GinVoZ2W9x1hThC8PJeYyvXDK1MzqJpr4Xv2Cy1yks=; b=WGOs/w0IjLZala/CeA5iCykpJYW6oR6e5TWsWKxvniO2tKFuI/J6D1QpCWAdnBxU09g5PgqQdktPX4Ca76iebU8oY7A03lS7n24l8aVOYjdMlyIRp6GBfk599yJBKVCdVjNOdl/tq8q39rCYGAAlBHMdfd4W0l9RuDeM8hYq+fAQCHTE8vUjsyxhwK8sFBMk0T2tu/PHvSrlJ7Ui3ES1F70a0XWtERfSEF8j3k90GLoftpIKggrIdwyCYlGvKEp+LPWM4SBVRQFZHoLdJ3dxAn+3nbG3YMFDhC4h6r4Ka+ck66T/tr3LrED2gJQJUeHHYCRF4jA5Swlzwy07MERWFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 May 2026 09:55:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15109 invoked by uid 111); 25 May 2026 09:55:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 May 2026 05:55:12 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 May 2026 05:55:06 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/3] commit-reach: replace queue_has_nonstale with a
 counter
Message-ID: <20260525095506.GA3868724@coredump.intra.peff.net>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <20260525064755.GA2737798@coredump.intra.peff.net>
 <CAL71e4MOH2iPve19dKixLHSgpC3ZAZz59zLWEWRoxW1a7vhMwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4MOH2iPve19dKixLHSgpC3ZAZz59zLWEWRoxW1a7vhMwg@mail.gmail.com>

On Mon, May 25, 2026 at 09:59:59AM +0200, Kristofer Karlsson wrote:

> That's an excellent approach! Much cleaner in general.
> 
> I benchmarked it against the counter on a monorepo with wide-frontier DAGs
> (2.4M commits, component import merges). Using merge-base --all to bypass
> the early-exit optimization from kk/paint-down-to-common-optim:
> 
>                Baseline    Cache   Counter
>     import(A)    8079ms   3686ms    3723ms
>     import(B)    5498ms   3993ms    4038ms
>     import(C)    4350ms   1748ms    1766ms
> 
> The cache performs on par with the counter - within noise on all three
> cases. No new flags needed, much simpler diff.
> The amortized O(1) is just as good as true O(1) in practice, and it avoids
> the ENQUEUED flag and counter bookkeeping entirely.

I'm not sure if it's technically amortized O(1), as I think in the worst
case we are still quadratic. That would happen if we've cached some
non-stale X, then pop it and put on some new commit Y. And then the next
round we have no cache (X was popped), but have to walk the whole queue
to find Y.

So I think it's more of a "heuristically O(1)" or something.

> I went with back-to-front scanning as you suggested

Out of curiosity, did you also time it front-to-back? What I wonder is
if we might commonly hit that worst case for back-to-front when we're
continually popping and inserting one new commit at the front of the
queue. If there's a bunch of stale cruft in the back end of the queue,
we'll walk over it repeatedly to find the new commit, and our cache will
never (or seldom) remain valid. (I know it's a heap, not a real queue,
but I think the far end of the array will still tend to represent stuff
that is further away from being popped due to the heap property).

Whereas looking from front to back, we are likely to cache something
that is going to be popped soon. But in that case we find it quickly,
and the longer we search the more likely it is to hang around in the
queue and remain valid.

> and also clear the cache when the cached entry goes stale.

I think this happens naturally when we call into queue_has_nonstale().
We only use the cached value if it's still non-stale. If it's gone stale
then we either find a new commit, or if we can't then we return false
(everything is stale). I guess the stale commit is left in the cache in
the latter case, but it doesn't matter because the loop ends anyway (and
even if it didn't, it is OK to repeatedly ignore the stale commit, as
doing so is O(1) and we have nothing better to cache).

That said, it is probably only one line to explicitly set it to NULL in
queue_has_nonstale(), so I am OK with that. ;)

If you're proposing to notice when we set the STALE flag on a commit
which matches the cached value, I'd prefer to avoid that, just because
it muddies up the code.

> I can rewrite the patchset with this approach and add you as co-author or
> suggested-by? Or I think I can wait for you to push it yourself.
> You did all the work here, and just didn't have enough data points to
> motivate it?

I think testing and writing the commit messages will be more work than
the code. I am happy to live on in a trailer if you will do those other
parts. ;)

-Peff

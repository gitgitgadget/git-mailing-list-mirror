Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705FE357CE0
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790984520; cv=none; b=kLFOW5pOCQnlDx4dYtgTIpT7W42APFu7JEZLob1OehZO/JlDNwpppazFNUOPM8QaRJ/ei75ggrmDjzQnAWpHrx4UN8gwCowvReeecR5uX9I0H3U362o1m9Avv5o/zPjrvk52a3I7V+crE4vIslYHDKGY+xxZmvt4jsM9AaQQJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790984520; c=relaxed/simple;
	bh=pVfxz9axJX7qy+ypiustUtK6Wzxcl2tF45YI6suSVdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdDpL1O/px/ZTxzBukGAVxjHmNANfpcLUMF2q1gvNOIIQ55w7qRN1yVqw1ttCkOECR77S/EgYzIK1fJYQZsbsdineEYOrXjYKdQSvZ2OeomYKNPCIeUGNuKPU4zE5HyKFZdd4ylPj/jQod4/U/9LxAy8xD4OQ2hitWdUOsvDZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CfA6to26; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CfA6to26"
Received: (qmail 16912 invoked by uid 106); 2 Oct 2026 23:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pVfxz9axJX7qy+ypiustUtK6Wzxcl2tF45YI6suSVdk=; b=CfA6to26ob/hnoae4vQdkLnBoWGZMHmiUXPsG3iuvpGF8vaqvBzYpp/JUGwrU6e0UE3lmgxCKRAL4o+9txZHrhiQd3ZQzwL8HvpGrU7cGhr60c+RJu6HDtWhA4c5WZ49QeRH6PNto634ou6PeBRvMxsqVonuoFWlTjbaObzAwAawtrx7pISTmVUJnZsz/o9P/hMWdmzurTzbUhsJ8Ebk4PM1xEoQmkJUN79/3Wgw4UCzTE+wlk8eSuuHnttiA7EfsSxq23Ua/kzPYZjnrW8UkUdueNXHqACSGsOTU1qWevlh+qLNh7MliP05jJsWlIrsAkgzNKN26QmQA6DfmsIfAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 23:41:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49507 invoked by uid 111); 2 Oct 2026 23:42:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 19:42:00 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 19:41:57 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 8/8] repack: include required packs in incremental
 MIDX writes
Message-ID: <20261002234157.GF834759@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <a42f775cbe27b385bfc8ff38f33604b3913dc340.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a42f775cbe27b385bfc8ff38f33604b3913dc340.1790827875.git.me@ttaylorr.com>

On Wed, Sep 30, 2026 at 11:12:05PM -0500, Taylor Blau wrote:

> The geometric plan from 1da62fb5c86 (repack: implement incremental MIDX
> repacking, 2026-05-19) can omit kept and cruft packs, since neither
> necessarily participates in the geometric repack. Such packs can also be
> lost when replacing a tip layer that contains them. Neither plan
> consults `midx_included_packs()`, so the rules for retaining cruft in
> ordinary MIDX writes do not protect incremental writes.
> 
> Use that selection logic to add missing packs to each plan's write step.
> Skip packs in retained base layers, but include required packs from a
> replaced tip. Count added objects when choosing which layers to compact,
> without changing the preferred pack.

I admit I had a hard time following this patch. I think the point is
that we're going to include some packs in the midx that were not covered
previously. But it was hard to see where that happens. I think the magic
bit is this:

> @@ -557,17 +604,20 @@ static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
>  					 size_t *steps_nr_p)
> [..]
> -	for (i = 0; i < opts->names->nr; i++) {
> +	midx_included_packs(&include, opts, m);

where we rely on midx_included_packs() to do that selection.

So I _think_ this is doing the right thing, but my confidence in my
review is kind of low. To some degree I'd just rely on the functional
tests here.

-Peff

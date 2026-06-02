Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67997377017
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382722; cv=none; b=esIGVtI9H6l0mWTLFlag2zrPoBasaAlUNkcM5WjIkYt7y717sNhslGA5gPzjqiFzomEayeGBnrDQAcAzDGqtWJ2Z6yQq4IyfYQRrnKMHBHhXTeY2ORt3X0KLV6b5aEFil7KRkHE+MtS0bDCzfdkkPM6Cg3Cf4tQlif37zVEaT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382722; c=relaxed/simple;
	bh=iGCh8RFiF1hpYEI1oEvKDsEEjalJkHClk5+ANxaVZ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXyctu2lQ73GRp0tpO8w57CxjrgnCkAZMjGiIPgs5DoZicAs1Kq9YQ9sPfhnWKY56q5cuA/3m8batWc5H2b79CfIrKmOxRrkJVOWFzFcoXEEInfBfbnsPc/5o+UL49P2HvRe6U2ohze8ERv4LCt/SfaJrGqbj74wql05S17OUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D1WCkgzT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D1WCkgzT"
Received: (qmail 30704 invoked by uid 106); 2 Jun 2026 06:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iGCh8RFiF1hpYEI1oEvKDsEEjalJkHClk5+ANxaVZ6g=; b=D1WCkgzT+yAfkAK4/04V43Mr59cj2ZyTQT7xglJEeX79InI2ZTPso+nX4I5QCCu3VRZYbCV5DHGXfTE7n6XSgR5isH4mIbYfN9ii1q81miBnsYEaRpIhT7c/VezccI+NMVf/vQz4tITejhRWZuxO0U2GrbPzq+NYeu4Uc9Su6A/zChJioomKRbjZ1Snrl1Th0Ft4IoWkLtc6C+KJRp40ONvUzTyNccG2WUJsnHOA3QdAu5ox278cJ3XvLKHAkM19mE7RcX1i0gv0TRPT8h3lbWengvV8R4OnwLSHhUXtRsfGmUIZym3WKKISqAaMDpZeVEh+mY/wOO4EcuMsLOXyGw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2026 06:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 76122 invoked by uid 111); 2 Jun 2026 06:45:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2026 02:45:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jun 2026 02:45:19 -0400
From: Jeff King <peff@peff.net>
To: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Arijit Banerjee <arijit91@gmail.com>,
	Arijit Banerjee <arijit@effectiveailabs.com>
Subject: Re: [PATCH v2] index-pack: retain child bases in delta cache
Message-ID: <20260602064519.GD695568@coredump.intra.peff.net>
References: <pull.2131.git.1780070763044.gitgitgadget@gmail.com>
 <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>

On Mon, Jun 01, 2026 at 04:13:21PM +0000, Arijit Banerjee via GitGitGadget wrote:

> When resolving a delta whose result has children of its own,
> index-pack adds the result to work_head, accounts its data in
> base_cache_used, and calls prune_base_data(). It then immediately frees
> that same data.
> 
> This bypasses the existing delta base cache policy and can force later
> descendants to reconstruct the queued base again. Let the existing
> delta_base_cache_limit pruning policy decide whether to keep or evict
> the data instead.
> 
> This does not add a new cache or increase the cache limit. The object
> data is already accounted in base_cache_used before prune_base_data()
> runs, and the existing pruning and base cleanup paths still release it.

That explanation makes sense, but I'm left with one question/concern.
Dropping the data for a base makes sense when we are "done" with it,
because we know we won't need it anymore and it leaves more room in the
cache for things we do care about.

The problem here is that the current notion of "done" is not correct.
Imagine we have delta chains "A -> B -> C" and "A -> D -> F". We are
totally done with A when we have resolved both B and D, but if I
understand correctly, we currently throw it away after just resolving B.

Your patch never throws it away, and just waits for it to get evicted
from the cache due to memory pressure. But could we realize the moment
when B and D have both finished using it, and evict it then? That makes
it more likely for us to keep something useful in the cache when there
is pressure.

I'm not sure how hard that would be in practice, or how much it would
help (the base cache works in list order, so I think it might naturally
be a sort of LRU?).

-Peff

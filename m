Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF13A383A
	for <git@vger.kernel.org>; Fri, 29 May 2026 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034445; cv=none; b=UXZRf4SdeTvM2yZKRDpztnGWGORql8ihXre4MSfNFlc24XiuRvSLiLi0Th9G3IdpB/tAvcmgZ83uShZX2cYitGmrp/gAvP7Wm+jWWdi3eWJGigAKar5o3XAAVxRXs40YZrOAl9A5umlGYu0doeFrwapmcl8aEJwdS47YeWTNOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034445; c=relaxed/simple;
	bh=jUanLIghu4Y46PI4MNUTFUM76xvjVZcOStu9uybQ040=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grfXl/1dg9WeMJ8fIoaOQPQYIkLQgEOaXa1etcpuLWlsIyeOfNXdph4+7cDFRfp5BXQFuDb8UaJ9mYWTVt/x3eq/lmgcgwdQk2cpBOv59SrlZURxBRzz8rNFkyMqJelgScTD6dBiESIo4uCMjMmMUhvcl7mnH8O+DqV7jYW4HJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LV5/7mFI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LV5/7mFI"
Received: (qmail 3987 invoked by uid 106); 29 May 2026 06:00:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jUanLIghu4Y46PI4MNUTFUM76xvjVZcOStu9uybQ040=; b=LV5/7mFIzOcoBGE3I4Dw3OGDMI4fS+9pZ0MxzRaR/D/BZnIGhg6+K5MXWStYyzbafJKSD4ObL0kzVggTm52U3bzCTbt+H8vL/WgcSO3VzYsqCC5UL1ZGQKN2yXyiZLlx+W3qa32oA3I9uNuURKQB3XKTt6bO5kst04APfnmIvXw52UA3A66yDXGARQxYHrBvUozr8gD+FAhGw90AjdpTItamcHFE/KtDVz8Z/rzeNdJ0LavtYX5Vp2pb4T9wbJhsOYOJ609P4xczzizW6TZYBz/z0riwDSG3XOwWjdPSPOBK5xRz9w6LqBa/mfP8AkswkYEyiw2ARFfP0PmnVQxQZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 06:00:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7473 invoked by uid 111); 29 May 2026 06:00:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 02:00:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 02:00:42 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/8] pack-bitmap: reuse stored selected bitmaps
Message-ID: <20260529060042.GA1106035@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <6e1f6bef5f641481a6a875bc215b35fc56cef80c.1779207127.git.me@ttaylorr.com>
 <20260527092412.GD981444@coredump.intra.peff.net>
 <ahcCX+xAKFOL8HcW@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahcCX+xAKFOL8HcW@nand.local>

On Wed, May 27, 2026 at 10:40:31AM -0400, Taylor Blau wrote:

> > > Teach `fill_bitmap_commit()` to notice that case. For non-root commits in
> > > the walk, look for a stored selected bitmap and OR it into the bitmap
> > > being built. If one exists, skip the commit, its tree, and its parents.
> >
> > I feel like this _shouldn't_ be necessary, because the idea of the
> > current writing code is to go from the roots up, following inverted
> > parent pointers, and passing the bitmap up as we go. So whenever we
> > visit a commit we should in theory have all of the ancestor's bits set
> > in that bitmap. But I remember that the simple-and-stupid approach ended
> > up being too memory hungry, so we pick some focal points in the graph
> > and then fill them independently.
> 
> It's sharing within the non-first parent history that is killing us
> here. I think what you said is true in a completely linear repository
> with no merges. But since we only pass commit masks from commits to
> their first parents, we don't reuse any already-generated bitmaps for
> common points in history not shared between commits' first parents.

Ah, that makes sense. I had forgotten exactly how the maximal-commit
selection worked, and what we compromised versus the original naive
"build from the bottom up" strategy.

> Yeah, these were for my own curiosity as much as anything. I had written
> them as a temporary measure in order to write the "[...] there are 1,261
> commits selected for bitmap coverage, and 1,382 maximal commits induced
> [...]" portion of the commit message above.
> 
> Once I had written it, I found the result useful enough to keep around.

Makes sense. It might help us (or even some very clueful user) debug or
fine-tune parameters down the road.

-Peff

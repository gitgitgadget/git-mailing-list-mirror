Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4731B126
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526417; cv=none; b=tnLX/LJig/MNH/wEXrDMCHPp4ORhN+W7KTfdnL2wOCevMkhauHeHtoXyRXkSf2XmrhhMSdiP3o9lfIdPXtIV+qob687oC7tJ2WdLBbfkaNerJSSf/bK0rMAoasMX1vr1SWcCQy3mwYhtPodZkdI50Gt5oicBmqNo9+OJxHG95fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526417; c=relaxed/simple;
	bh=0DfUEOxnLLW6uYRVjzgFBxgYMKMHSe0QXWyS+8pj+0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBm7V0Vs0LehfGP8uwF4u+awamzUZhKCHNheYgEsxCzDtJ71eMyIiwQSYlrD1RkXG9CqlFdL8EeoY0A4L/ItS9ojkjPEVomLOBRS3VC1etXzMECP4RP/CXACkZyJefFZ5VemNcp87D8igYhtcuNA7+diXayD+G57wXof+Uooo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PZmnsnH0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PZmnsnH0"
Received: (qmail 226900 invoked by uid 109); 15 Oct 2025 11:06:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0DfUEOxnLLW6uYRVjzgFBxgYMKMHSe0QXWyS+8pj+0s=; b=PZmnsnH002KxpBvBvNgHdM7ffUSyniTUaBICNadzVz5Zqs3LFs4XY+KtNeLQRdd7ughy8gsZ/2SHN6Upsa6oKaDq8xBP5QUvAo1IltXS+n3eIi2yugtIFGSVx7eKGLOULUWr/hi4ABF+Tj7vphS+hKxgRYzER1u9QsVSu9qGWAg7LiknmiTsJpDXGApScMFTihnpL0cVXDnKOJl5c2aeNVJ+6HWRCznqkj9SNj9eBZ8uvZv5fNcK+5Z9ljUeSE3FjIwilRVPpyY06pQ4cZ27S39OMGWoVyp+J+NJAve77YMiT//ZgTXZMk/YBgPCkCBg3wAl5XAOwTk6MDhay90LAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Oct 2025 11:06:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 363589 invoked by uid 111); 15 Oct 2025 11:06:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Oct 2025 07:06:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Oct 2025 07:06:53 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 00/49] repack: prepare for incremental MIDX-based
 repacking
Message-ID: <20251015110653.GG2250228@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <20251010062913.GJ1965904@coredump.intra.peff.net>
 <aOmTqt4m/R/YrOGg@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOmTqt4m/R/YrOGg@nand.local>

On Fri, Oct 10, 2025 at 07:15:54PM -0400, Taylor Blau wrote:

> > I've read up through patch 37. My eyes were starting to glaze over at
> > that point, and it looked like the patches were starting to get more
> > interesting, so I've saved the rest for another session.
> 
> Thanks for the review thus far!

OK, I've finished reading through. The remainder was actually less
complicated than I thought it might be.

I left a few comments, but there's nothing really important. It sounds
like you're doing a re-roll for minor fixes anyway, so you can take or
leave my ponderings as you see fit.

> Yeah, I think we could probably go on for quite a bit longer polishing
> the naming, interfaces, etc. I tried to strike a balance in this series
> to change as little as possible while still ending up with a
> halfway-decent looking repack.h ;-).
> 
> As you noted, the repack code is extremely fragile/brittle. That is a
> big part of why I both (a) took such an incremental approach as in this
> series and (b) tried to avoid making too many changes as I moved code
> around.
> 
> I think that (b) especially leaves us with an opportunity to clean these
> interfaces up after this series has landed, and I intend on doing so. My
> hope is that this series gives us a solid foundation to make those
> changes on, as opposed to further hacking up builtin/repack.c ;-).

OK, that all sounds good to me. I think even if you never circle back to
clean up further, the end result here is a net improvement.

-Peff

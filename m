Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849035A954
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425078; cv=none; b=Z/K+z9lwbBdeOAYN4AicZaUzBuJwfCQd/2dFSBvKjKMDZEhr9z0cfoMOHtYHXdQ6DPUreubDjhx971k5ur9vBx9FZnHex9WjmFbbT+XFaXptQXm89DfwXNQbmcz03A3YhqItONPHwo/xsJ8w5AjXE09kKjvF+3QNg/UrSQMs8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425078; c=relaxed/simple;
	bh=j2PEdHi0fULs1AqGa2MmCNQyrMzCYDAv+HyiDS3PnRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh6bbrehPr06fBfCcI4tJhNg/0aAt7+wLpDGRQUZnPbCJn94gsTTmoGMJzK+rs434lcwRERGyQgN9gmV2IqhO8TAWtoEmFR4O9+yluYLttypdTC7W40LXxl/bqVrHoQMD+KdVWQNk4sjO5qwz5qUXOb0c+byPmb8XBp2MZsO8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b50cGgc4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b50cGgc4"
Received: (qmail 41737 invoked by uid 109); 14 Jan 2026 21:11:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=j2PEdHi0fULs1AqGa2MmCNQyrMzCYDAv+HyiDS3PnRI=; b=b50cGgc4Uh6Nge5yHG/hov5n+O11FYdzoAiNUcgvaMc3UkipOV4GhM7g6589FCSRfBJ0sTR+L5B6v1T7yMecGJ0WWKfY4o/OOXIeRPXNUUJ2/5R3RhFxH9fyuoNvfshyolftUpvgVe2VN7bvTxBl/sczc/gcs8cwTwJLZg3Ke+LpmYKrJsPX718ney5+chdBCG5aR/EV1HNsXXpmPM+4IPknmJhIqO/nxgSW/TifgGP3dSwZuveGcgI3fG2B35LB1hvGbnS3Q86A1/D0JL3bPa3xwMwIxaqAJG9mBwNE+0zgPY62KU0dX43ukDRl1lKdYoLpWCMbDItDU414FgseEA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 21:11:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 69947 invoked by uid 111); 14 Jan 2026 21:11:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 16:11:17 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 16:11:15 -0500
From: Jeff King <peff@peff.net>
To: Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Git push sends too much data unnecessarily
Message-ID: <20260114211115.GC1008851@coredump.intra.peff.net>
References: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
 <CAOLa=ZT4fQdHqG+1AeviYuLUR5VG33voJk_DU1y0MzhUKBQvvw@mail.gmail.com>
 <xmqqh5sof61i.fsf@gitster.g>
 <CAGe2LO3t3B1g1ARH-LQ9V0UoGmToO-Z9XYpeMOTKkaSQvCpaRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGe2LO3t3B1g1ARH-LQ9V0UoGmToO-Z9XYpeMOTKkaSQvCpaRA@mail.gmail.com>

On Wed, Jan 14, 2026 at 05:39:43PM +0000, Rajiv Sharma wrote:

> > This boils down to how Git negotiates between the client <> server
> 
> I think that's the crux of the problem here. I don't think git
> negotiates in the push path the way it does in the read path, i.e.
> there is no process of client-server communication that involves
> gradually arriving at the common base (in this case it would be C3).
> The read path does this quite well (using something akin to a skiplist
> IIRC?) and the common base is found in a couple iterations in most
> cases. I am unaware of the historical context behind this difference
> but I assume the server sending unnecessary extra data during the read
> path would be much more expensive than the client doing it hence the
> push protocol is kept simpler.
> 
> This kind of negotiation _could_ be added to the push path but it
> would be a breaking change. I read somewhere that there were plans for
> Push Protocol V2 (in the same vein as Read Protocol V2) so it would be
> great to see this improvement making its way there!

I think you may have misunderstood Junio's response. We do have
push.negotiate already. It's just not the default.

Did you try your example with "git -c push.negotiate=true push ..."?

-Peff

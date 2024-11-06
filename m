Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA420968E
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920960; cv=none; b=LfolnlX1bA/qyy1O36ZEusTtjMorP/+Sj/kJmtVGoCJ5xBL/6qZ5HyFUatUmmtSbzfx1VdxxJoPU7S0CFOzzApcy7+v8TkN/8kh0ZLtsBSGYB0x77EfeTZ0eUnp0HL9fKogL0M//40Zqzbwh2qQRXzp9o+Y1WvLQjY6SkaTPdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920960; c=relaxed/simple;
	bh=OCGfyBIRB1z5UqtdgppBuUWU86lWW+2HjwOMSSjNGPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouChd3th4gFD9ia5/Ug60wdTL7nY+RqQetNa0Xwalaz92FtbZMsJVTxpzKgJBW2g4dliwVsrkdA1MeV5XyIp/k4pToMqxEMyVrO5BTKez5jMzMbvpn6zVZSxwYoz+Rnod5kJ01lcPHSJZ5ByioI8FUArbZAwCZESK78vRb8I9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K9ddRES4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K9ddRES4"
Received: (qmail 14390 invoked by uid 109); 6 Nov 2024 19:22:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OCGfyBIRB1z5UqtdgppBuUWU86lWW+2HjwOMSSjNGPM=; b=K9ddRES4vLuNisKk+sajO7dM4GOXRhND4JGYsz0wUG5g9DZIw1C1BFjn/DHwqocCGzST1w7AupG+E9kh/hUgsejkhDiA88Xjq431ZEKRXoWHgQEuTre0ASQqRYMy7ixigmfz1AOGNl279zQETtwmOnDOZqPtuloGwpEqqj0Xfbg9+LMPEYzKPzDvOW3cLBDvcZ7o46OVlUUYvjxp4YFp1pQw5aQejgkouAqvpV7kybuDu5X50iCRLyOa8fpSixXmUyZ7bAo8YsUEw9QIqHJy8dat5cxSCBvy2oi0fs4oFBaWmFEPwCXXOOW3zPedrXmWH2AtfyYrk+TNzoUEtgzaFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 19:22:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7289 invoked by uid 111); 6 Nov 2024 19:22:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 14:22:36 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 14:22:36 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benno Evers <benno.martin.evers@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/4] perf improvements for git-describe with few tags
Message-ID: <20241106192236.GC880133@coredump.intra.peff.net>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
 <20241031114210.GA593548@coredump.intra.peff.net>
 <20241031122456.GB593548@coredump.intra.peff.net>
 <20241031144351.GA1720940@coredump.intra.peff.net>
 <CAEQVFRFWT02QTL7PTf84p6AAferijHx8L_Tu6ON1H7U=iEdb3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEQVFRFWT02QTL7PTf84p6AAferijHx8L_Tu6ON1H7U=iEdb3A@mail.gmail.com>

On Mon, Nov 04, 2024 at 01:37:27PM +0100, Benno Evers wrote:

> I'm afraid I can't offer much wisdom, but a few thoughts:

Thank you. Between this response and a bit of pondering over the last
few days, I think I have a firm understanding of the issue and possible
paths forward.

So here's the series I came up with, which starts by adjusting the tests
to be resilient to the later changes, but also to show the existing
failure mode.

And then the rest of the patches add the performance improvements we've
been discussing in the thread.

I'll drop the kernel lists from the cc since I think this has gotten
well off topic there.

  [1/4]: t6120: demonstrate weakness in disjoint-root handling
  [2/4]: t/perf: add tests for git-describe
  [3/4]: describe: stop digging for max_candidates+1
  [4/4]: describe: stop traversing when we run out of names

 builtin/describe.c       | 17 ++++++++++-------
 t/perf/p6100-describe.sh | 30 ++++++++++++++++++++++++++++++
 t/t6120-describe.sh      | 15 ++++++++++++---
 3 files changed, 52 insertions(+), 10 deletions(-)
 create mode 100755 t/perf/p6100-describe.sh

-Peff

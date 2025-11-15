Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CE1E0B9C
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172843; cv=none; b=CS5BxIdcQLjy/EIexJLjXJzCxa3DlcYx1gX8L8yYIYsSwDHC6ntCirGtXomY+JEHfd0On1F7lTj2E5v0wck37sTx/QCaJaNk0E5Xs/Rji3qNpeU6GoGlg2dFPjsxA4nw25KG+X32lujUN9XEphuvNDbXwMbON0UoB/V8Z4ZLN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172843; c=relaxed/simple;
	bh=u06X3tRWFxyhqp9ymiQB3HGQtdVeWkk4PUQIDUCbwck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTOivTXexM2S0LwWwq3wRi0Ts6FODcJnPWfa6XBKyeGq1U42WjqtWuGIgXcXyAx/1aBup20BYZqdseE4kPni1+6XOop13Fw2W3FFhXg7/mkcYfLaceIz7tGkCnJlcY3VgSBJDlRTgk1EthSq6osxzfGwDkysUmul0debJKiRKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gA31v48o; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gA31v48o"
Received: (qmail 522550 invoked by uid 109); 15 Nov 2025 02:14:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=u06X3tRWFxyhqp9ymiQB3HGQtdVeWkk4PUQIDUCbwck=; b=gA31v48oggH8nugbkdD8SAgqVJhbW+UE6pXg/XrLy1A4zyaqL7TfgIoFHjIaLiOu4NmfPniiRHGeab4F/siR1yegasi1bek9zYmP5bMHRRF9rydWmQC2I19kYxl+zTRmKOrFC7pu+kwwmyNFUMAti6N0mEa9GcR7OzXkSJpN0ChLdCpSKe9UdZTsATI0HFzdsD4QvC1A9lakVy0C2a/HG8KR682KqhG3okOUrCJg9vL4z37cqbOlAwbx9fA59aWbiIkX+safO7VE0h6IbZX4LoifysVaQUxyhrDq5Hu4FdYFG4HuQVRDCSedR2i0ut0cq5Y1DPFz5EuZuLvtyprzkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Nov 2025 02:14:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 827968 invoked by uid 111); 15 Nov 2025 02:14:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Nov 2025 21:13:59 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Nov 2025 21:13:59 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <20251115021359.GC3499607@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080215.GC979063@coredump.intra.peff.net>
 <aRRu1cxpIzd60AoU@pks.im>
 <xmqqfrahq4j8.fsf@gitster.g>
 <aRbToFLhzewwBaSv@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRbToFLhzewwBaSv@pks.im>

On Fri, Nov 14, 2025 at 08:00:48AM +0100, Patrick Steinhardt wrote:

> > Do you two want me to squash this into the Makefile patch?
> 
> I feel like there's going to be a revised version of this series anyway,
> so that's probably not necessary. Thanks!

Yeah, I'll re-roll (but probably not tonight) and will squash it in.

-Peff

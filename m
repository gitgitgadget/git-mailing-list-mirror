Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E628399
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681130; cv=none; b=N4p3ojn9lHBNSIb+2uQbeQ1VIMr6LeBIqgdxpjaHIJFf4KhriUu8wnSTzcZW99s/6B0vFUFMKLin1b6eqkNyBJsVj+Qs/T7L1z4uKGiAgc4Q/gE3VdDyMdfUo7z0UZakiYXEFj9uLvl2Te4jpqA88ei7FyQHPNpLIkAed9rMKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681130; c=relaxed/simple;
	bh=6RFxE3QLPTTSiog804+uE3aElL9UQr9qqlZOE56YR/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLOoyGf5giBNCxFD0iWSY/YqOFnrzMbGSkquyMcfAzw5j00QUEfSDKRodxBh+pDLwBnKVbT6cmJtTSbqHj6AHsKXoa/RUOV/xlEDqJVbQM0w2auHGXK/UCl8k550jP1BRCcTQgh49W1PBFUDKAJ9JzPQ4K+U7f5PW8izw9ZMe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UZvIpKHv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UZvIpKHv"
Received: (qmail 28959 invoked by uid 109); 4 Feb 2025 14:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6RFxE3QLPTTSiog804+uE3aElL9UQr9qqlZOE56YR/o=; b=UZvIpKHvsLHwbXLJ7NFa+jMysx2lC/sXQxmbSxwwlPXTUblhe9CD/ImGLMgON6sH5axz8w8K4KhwQVBjzcmLaQzwF0BDMq2ZfO/yBf4PuRA3kjSE7hgVCKKzXxFIAYCRhX6Gxm4tdTtHvq+xyPpM2g6QgnmQ965/jYk3X01GV1X4aE0ghFun/TXF+avGV6Eol2v44zSUeH2P6NQggsn3vUnzkpxG5ZQbIoxMAhVG/CbswcsVOcPZEt6xWag1RbGCA2OkoW6lQF20M2UM4vI9wuk7CdYwsB1EGdPonnf8r7jxy4tnOg7xKVhkMs+0zg/L6PXLcVVbr1T0xXOb1vTHJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Feb 2025 14:58:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5683 invoked by uid 111); 4 Feb 2025 14:58:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2025 09:58:44 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Feb 2025 09:58:43 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
Message-ID: <20250204145843.GA620055@coredump.intra.peff.net>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-2-7c4d69c5072c@pks.im>
 <20250204030157.GC23954@coredump.intra.peff.net>
 <Z6G7LTVqw3l-b7lN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6G7LTVqw3l-b7lN@pks.im>

On Tue, Feb 04, 2025 at 08:01:01AM +0100, Patrick Steinhardt wrote:

> On Mon, Feb 03, 2025 at 10:01:57PM -0500, Jeff King wrote:
> > On Mon, Feb 03, 2025 at 02:06:55PM +0100, Patrick Steinhardt wrote:
> > > Fix the bug by splitting out the "--pack-loose-unreachable" and only
> > > making it depend on the second and third condition. Like this, loose
> > > unreachable objects will be packed regardless of any preexisting
> > > packfiles.
> > 
> > Makes sense. My only question would be whether there are any gotchas
> > inside pack-objects about using --pack-loose-unreachable without
> > --keep-unreachable (since the two were up until now always used
> > together).
> > 
> > It was added by e26a8c4721. And looking over that patch, I don't see
> > anything that would let the options be used independently. So this seems
> > like a good solution.
> 
> You probably meant "I don't see anything that would *not* let the
> options be used independently." But yeah, they don't seem to require one
> another.

Whoops, yes. Last minute rephrasing strikes again. :)

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FB2DF136
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669993; cv=none; b=TEH0DjNrOjFw3WS2azQXLdzQ+BSQKqzFzYDL4tKnqc8pjEqk+3jH9cUWwltBkpdf0ajQ/z9UnNaKI1VF0HodAd6ysZPlS+ZyvQBIrDHprxRWTnZM1hdErgGMFgilVvmgTfRZcmHXSQ+yRFaHV4XtKu9/5xvaPqIR5ZSLmHgVAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669993; c=relaxed/simple;
	bh=WkcgVtUTwSWHKMcqIrE0qLzUzA0X+XIg8Cxf+dIUmaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvzg1TKS2J1XnwrGs0ewoGDoJdRtXoecqth5ey6oXQ8XHrYRhB9cgjtunN7ziD6jJOloLMWAL4Aj6DbCWaGgPjEjREL0v40jug7VfMVLckvVHQfSdMmUaUc6ay2i4UPQ124XHAUeCyW1M0GSiJzIPl6LMLwTpPBetJ7Fj/r0BSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zt8ITF0A; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zt8ITF0A"
Received: (qmail 284005 invoked by uid 106); 8 Apr 2026 17:39:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WkcgVtUTwSWHKMcqIrE0qLzUzA0X+XIg8Cxf+dIUmaU=; b=Zt8ITF0AM+tEZz8T/CJGViQ2rhPnkDXh1G233xb/aIdjrRUDVlt0xl94WZY71IBAhrwOyvAXPbCgnCuB/xcVcfBHAdwD1skHsKr+YHnky0+4NGG9lgrCDyEJo12fjJdD4o/l0YSuym49uJE3oZVCup/0C/gkvwBgJIxlfCRuh5pPjdEJuZoV9SrO1m5SkmYlyylEiqxCLtZ7/00l4LZOBFoKlIEZVRWVbq3FFo70pK2F4mRN95HYNzjRn8pL97jSn5/HtoDynjRyF/ePLKnAhLvt0rFnJ28DIdgtZW2bCFnvn/9I25leE4mFifE2szxXC56fWO4wU0IwaRqVZiluGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 17:39:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 466457 invoked by uid 111); 8 Apr 2026 17:39:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 13:39:50 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 13:39:49 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260408173949.GB2850002@coredump.intra.peff.net>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
 <20260408041716.GA1324339@coredump.intra.peff.net>
 <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
 <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>

On Wed, Apr 08, 2026 at 12:25:47PM -0400, rsbecker@nexbridge.com wrote:

> This is also impacting t5608 and t7700. Anywhere where writev() is
> used, seemingly. We went through MAX_IO_SIZE issues years ago, instead
> of using ssize_t as a basis of how big communication is. I think
> writev() is not valid. It worked on Lunix, but had issues elsewhere.
> This broke the compat layer.

I wondered briefly if the problem could be that we're violating
MAX_IO_SIZE here, as our use of writev() does not respect it at all. But
the only spot that uses it is feeding pkt-line packets, which max out at
64k. So unless your MAX_IO_SIZE is smaller than that, I doubt that is
the problem.

-Peff

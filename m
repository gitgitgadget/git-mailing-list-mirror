Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269012F399
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845013; cv=none; b=p/rslvZkI1UCZ57euzoqfJLlho5Gr9j0GKcsdVX/n+kbFJs2fTydBLIqkAJOWjjpzPrUXyDx2JIBzX5bngfpjICNVDsZKEThfZhgUmOGqmV6yWJkGrypE9nCGLnQKN50gxOAtSeH79A1c+qMXIL1HjfqsjCbhARgCC88ZLg7p4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845013; c=relaxed/simple;
	bh=3Z2RS4tGSi3FqjNLx9whTzi+PuEUe4Z+ITfTYfmt6sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr+x3YJGug7AQh7TAg1zpECf6wVV2qmMLQd/VGZZ4ZwGoxUnCBdDWt0xSYUg5Xt0CmC52vDJ18Sn2nMKDCFMMsHk920r33Wc6ee4y1zKcvMbTYOZbaKVYm7meULl28ce9DT4oYn8GhqoNg8jYa+alYlihr0KV4ddI0t+D9JNyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZB6azRJe; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZB6azRJe"
Received: (qmail 21030 invoked by uid 109); 13 Mar 2025 05:50:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3Z2RS4tGSi3FqjNLx9whTzi+PuEUe4Z+ITfTYfmt6sQ=; b=ZB6azRJe3vtWx7s1FZYSEpIkQoUR618id7JSekW3R0czjVe+589lpdNA3mUyzYlYJuBRT30KtlOEz1Cqch5A8lubOu4I7WR05uMHdcnmPVcu8fKhD2cLArqSSbyKkcwWAQirZ2KS/P6cbTbTHhabOaxqcbRJsv69KPOljcrOcEOCIivLHLuAcmXxwkbRjIlc8Wo669KLd4hr7fOlZdvttdW1Jl9B/+nA4Woc1DRRIIY4QrWA10qjYEIzGa9TZmz8WRBkBAtIOliDj/HKPmx58vVMSogCnGUsdg9LbVIl0krP4cq1VPJkJvkKa+f6etaCHtL/E5B+H4qOXbp+UG/2Lw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 05:50:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11817 invoked by uid 111); 13 Mar 2025 05:50:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 01:50:10 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 01:50:10 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 0/9] fetch: further ref-prefix cleanups and optimizations
Message-ID: <20250313055010.GG94015@coredump.intra.peff.net>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
 <20250309030101.GA2334064@coredump.intra.peff.net>
 <Z9H8uKevHUxasE4S@nand.local>
 <Z9IBZmh4Cr2jq7E4@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9IBZmh4Cr2jq7E4@nand.local>

On Wed, Mar 12, 2025 at 05:49:26PM -0400, Taylor Blau wrote:

> On Wed, Mar 12, 2025 at 05:29:28PM -0400, Taylor Blau wrote:
> > >  builtin/fetch.c        | 46 +++++++++++++++++-------------------------
> > >  refspec.c              | 22 ++++++++++++++------
> > >  t/t5516-fetch-push.sh  | 12 ++++++-----
> > >  t/t5702-protocol-v2.sh | 44 +++++++++++++++++++++++++++++++++++++++-
> > >  4 files changed, 85 insertions(+), 39 deletions(-)
> >
> > Kidding, of course, I am looking forward to reviewing it now.
> 
> This looks great to me. I left a few minor comments throughout, but am
> unsurprisingly on-board with the overall approach as you and I discussed
> this off-list a week or two ago.
> 
>     Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks. My biggest question is on patch 8, and whether the existing
set_head() feature really ought to be more aggressive about pointing at
stuff we didn't fetch (and that could even be unborn on our side!).

I don't have a strong opinion either way, but it would mean adjusting
the idea of when set_head() kicks in (e.g., should we do it for every
fetch, or should exact-oid fetches continue to optimize out the ls-refs
call?).

-Peff

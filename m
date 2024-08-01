Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615B16DC03
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507298; cv=none; b=sECwgLRjqe5jfDRCY6To3IvIE979ZFNeYtZZA9gMHAUlyiqxVRd+lt8fh2fVBCN+XMToRSwH2999vP6J803hINvkXGspT/zkt8GG4PNlVgiToAMjSZ1vSq45ycsahJ6ZdNiU8A3a/xJNVL28bgy0vBVf0wh76Bh+MkTZOCw2tDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507298; c=relaxed/simple;
	bh=3+43ESKhmEm2Q1LVtSmZKQheiH/US3BjVoMc6NQZRqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVfQzbbe+Di03UEgcZW5aIoRqGxk49guO2S9ouoeH+7Wax4udA+2JdlWLGWzyTMDIJ/zUz9wCIIV2UVYIhN91UHTCQDmCybIAVGii0vcQ8Q6xIirTf0gx+ThUpsYs8P8P+YTQVxPoqdXkRUhzpwCbQ1ioyJFZjQfRDFYhqlgO/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19008 invoked by uid 109); 1 Aug 2024 10:14:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:14:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30478 invoked by uid 111); 1 Aug 2024 10:15:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:15:00 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:14:54 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/19] midx: remove unused `midx_locate_pack()`
Message-ID: <20240801101454.GK1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <22de5898f3fec0cfff4289660b5f52aa31533fe1.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22de5898f3fec0cfff4289660b5f52aa31533fe1.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:29PM -0400, Taylor Blau wrote:

> Commit 307d75bbe6 (midx: implement `midx_locate_pack()`, 2023-12-14)
> introduced `midx_locate_pack()`, which was described at the time as a
> complement to the function `midx_contains_pack()` which allowed
> callers to determine where in the MIDX lexical order a pack appeared, as
> opposed to whether or not it was simply contained.
> 
> 307d75bbe6 suggests that future patches would be added which would
> introduce callers for this new function, but none ever were, meaning the
> function has gone unused since its introduction.
> 
> Clean this up by in effect reverting 307d75bbe6, which removes the
> unused functions and inlines its definition back into
> `midx_contains_pack()`.
> 
> (Looking back through the list archives when 307d75bbe6 was written,
> this was in preparation for this[1] patch from back when we had the
> concept of "disjoint" packs while developing multi-pack verbatim reuse.
> That concept was abandoned before the series was merged, but I never
> dropped what would become 307d75bbe6 from the series, leading to the
> state prior to this commit).
> 
> [1]: https://lore.kernel.org/git/3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com/

Nice description of the history. I wish all patches which said "eh, this
is unused, let's remove it" went to the same trouble to make sure we
aren't missing something subtle.

-Peff

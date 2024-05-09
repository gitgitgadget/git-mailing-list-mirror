Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719484C8B
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273761; cv=none; b=ijnAF/Mlgz5Z/WaCBr0HZG0Xp+BOVbalagfKjMPZ4CcxFdmavx0h0jZ2tVSOf2LMABJXQnlRPkc/0RMWP3CMrmG3nQfSjP0T0bcrJ2WCt+ncKkk5PAAtuuhDFOLIlA+7HE6Mk4ydC2ZcUfEx5qv5eQqAXqYUrSadFwbczVKCdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273761; c=relaxed/simple;
	bh=HAdnWshZXHSElU4D+XkHOvRAgF/qT/Tr2P46pjb5hqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuN4xEY/gURQsnKETAr2AlaMKpyXq4bEKwDqfTVo2uOVN/Q39PPWSvik62KwSns3YktYDbaaQRs3fXu9JjmNkqO9PBTy/sHXg3Ab74LGGA4JW7JsZh1tFpN5d1sVLra6ilW3k+UDyzPoKluBnaEBq5RNUrilmEhgG7jCdsCJf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7045 invoked by uid 109); 9 May 2024 16:55:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:55:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31466 invoked by uid 111); 9 May 2024 16:55:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:55:59 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:55:57 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <20240509165557.GD1708095@coredump.intra.peff.net>
References: <cover.1714717057.git.ps@pks.im>
 <xmqqikzu95cf.fsf@gitster.g>
 <20240503173553.GC3631237@coredump.intra.peff.net>
 <xmqq7cga7nzo.fsf@gitster.g>
 <Zjh8XWwJKp_I1dwE@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zjh8XWwJKp_I1dwE@tanuki>

On Mon, May 06, 2024 at 08:44:45AM +0200, Patrick Steinhardt wrote:

> On Fri, May 03, 2024 at 11:24:11AM -0700, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > Though maybe an even more radical proposal: now that read_ref_full(),
> > > etc, are gone, and we have only refs_read_ref_full(), could/should we
> > > shorten the latter to drop the "refs_" prefix?
> > 
> > I view it as a good longer-term goal.  But I also view it as an
> > orthogonal issue to the transition.
> 
> Personally, I'd prefer to keep the `refs_` prefix. This may be personal
> preference, but I find it way easier to reason about code when there are
> prefixes for our functions that clearly indicate the subsystem they
> belong to.
> 
> It's also in line with how other subsystems behave. Everything relating
> to strbufs has a `strbuf_` prefix, attr-related code has `attr_` or
> `git_attr_`, mem-pool has `mem_pool_`. So ref-related code having a
> `ref_` prefix just feels natural to me.

I'd find that more compelling if all of the ref-related code had such a
prefix. But try reading refs.h sometime. ;)

That said, if we want to move in that direction I am OK with it.

-Peff

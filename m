Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC2258EE9
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102204; cv=none; b=W4riVbYhri9HT60LQgRyhNA7ASY82WGGKX25XoA5y5dv2jxdsUFZ6NwuHXnAUaqjAeaaXu7fMaXg3qqP5Dosqe+CjWOYluEGLoNkIr7DLRy8pfb3LGGQYXtDr/o4BdOwlrRkkFiyNNxsSmGb1GBcPfdr3u8xeyh+9x9BJQ35N4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102204; c=relaxed/simple;
	bh=EDFCr5cUMzY6seJ1ETzJGW/PMMsiz/1lAAiVAH4/yuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCNnXt9Mx5SW42K53PY9fauzVNAD0Apw3+8aOfWJWyrnch9FLwpGa0ZuJ5a+EKBGLzyhkgVTt6qQPNoJ/po6OQDV6Rh8Ofea3daqp1LuY+bA4RPUhbFwwbpKq/fEVusWMKRupdD3rHYCES07v2u787t4wEIfRhpeburhRGpw2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DmN1TOz3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DmN1TOz3"
Received: (qmail 218582 invoked by uid 106); 2 Apr 2026 03:56:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EDFCr5cUMzY6seJ1ETzJGW/PMMsiz/1lAAiVAH4/yuU=; b=DmN1TOz3sWmHIMRf/hKXPPiJa30CAuFfAChN4PJvYzbNZEjWbaMKW6osvy0XzIsmKHkHtMp5Zt4By8Hsq+xFm+DfpbqwPp1sVlm1T9X0jxtlToJAr7rR0fdnyfgcHqyBqjiqH0gdjoHqDM1UnaQKfiaCd91V3xs3XAoJM1gfV06brBWYTOa57U0HO4C+749iDKTcP2tt5Z9rKY+7lj1WSHUL0E6eNiMf1zljyDYQwzc9i66DvjNJCi7ZE67XDli16skF3u+RIPkmHI9y+R9ZmEBTt1uxOd1mFN9+RqxpsRoWVa+ULgzSULssda5p8j/c9UY7IBDT7jlxbQPme8sbJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 03:56:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349491 invoked by uid 111); 2 Apr 2026 03:56:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2026 23:56:41 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Apr 2026 23:56:40 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 12/12] refs/files-backend: drop const to fix strchr()
 warning
Message-ID: <20260402035640.GC3492642@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235341.GL2328529@coredump.intra.peff.net>
 <ac0h0xwqLdX5u51v@pks.im>
 <xmqqzf3mtj5z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzf3mtj5z.fsf@gitster.g>

On Wed, Apr 01, 2026 at 03:22:48PM -0700, Junio C Hamano wrote:

> >> But there's a catch. We derive that source pointer by parsing the line
> >> with parse_oid_hex_algop(), which requires a const pointer for its
> >> out-parameter. We can work around that by teaching it to use our
> >> CONST_OUTPARAM() trick, just like skip_prefix(). Note that unlike
> >> skip_prefix(), the function is not inline, so we can't just wrap it
> >> using the same name (otherwise the actual definition would expand the
> >> macro, which breaks compilation). So we rename the actual function with
> >> an "_impl" suffix, and callers will all use the macro.
> >
> > Fair. In fact, I was a bit torn with the other commits whether it's nice
> > to reuse the same name. I guess what it buys us is that you cannot
> > accidentally call the wrong function without the guardrails. Even though
> > that's quite unlikely with the `_impl` suffix.
> 
> I share the sentiment.  If I were deciding the design, I'd even go
> forcing the _impl suffix to everything, including the inline ones,
> as I found the earlier "strip_prefix()" example already confusing.

OK. I think the _impl() is ugly, but the idea is that you never have to
type it outside of the macro anyway. I'll switch to that for the others
for consistency.

-Peff

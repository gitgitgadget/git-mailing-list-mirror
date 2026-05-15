Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6B4BCAD5
	for <git@vger.kernel.org>; Fri, 15 May 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863863; cv=none; b=sbv8364Hcnkmpv4DgJ1Xv2Jxqjxw5B4SxkUQ9ceHZGj+k4ekdsuMFXFEdy6UCmLmRl1+r6vh6XJXA4KOKfJFUnx55YGruHicJSF49GUWZTm9M4o4FJSSkGjwx83chutAC8WHEYP6h8i2tU/lYp3JnGX8laS3wIAlI9Ov6vl/ujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863863; c=relaxed/simple;
	bh=qHvHFlIeyPUQNjsNztfQ847i+nGT3OupFpDuvsmExt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrdio3Upb6I9I/zcREPanM34uuMFhYVifS36nxHZ2IAGwocL7iN78K30XmCAypAbB1oSKwU2PASMj0ektQOQUc2DiGMFKaSKpDZhaE3GjmjRkIUeFQZvaQ+yewA1YONY2FcwVa5mBikA8Y3hyTaIMyWikilApwzMrZq8T3U6qEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aUq77AiJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aUq77AiJ"
Received: (qmail 55977 invoked by uid 106); 15 May 2026 16:51:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=qHvHFlIeyPUQNjsNztfQ847i+nGT3OupFpDuvsmExt8=; b=aUq77AiJbPKjcWKGMJrV9tpLWJE4lOHL8AC/8axil0kKr0+yK5OY0puzfhuX8w1dDQTyJLl/JhKNDX5sxoP4aP11mo+ayd61oqy8oq3TQBd1yzy3tmeh5NODGU968kThlgQPL+5Q/hddrC2fYZARA+cDuEci1pr0eY9iWzx1TeyuWDjnwOVBBEijp2sDVgHsTspkDYUcQ6Dh5WVG+wp/czmZZHHJnjE06MUborW994m0Ky/TIHDcKGkhmumFbO+B2jHbaVNlJn1V0gs3JyigPBJdt6+HtwrwnhkL7zp0l9PkynvoBWahlU6h4NNMkuLj+RiBipKGcK9/CpCcMpmpsw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 16:51:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 103963 invoked by uid 111); 15 May 2026 16:50:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 12:50:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 12:50:59 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] strbuf: use st_add3() in strbuf_grow()
Message-ID: <20260515165059.GA88375@coredump.intra.peff.net>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <xmqqo6ihg690.fsf@gitster.g>
 <0c3b4e94-b56c-4c92-a4d8-0e4364f1257b@web.de>
 <20260515043606.GA83595@coredump.intra.peff.net>
 <459f5f2b-2565-4dae-9f9f-8848a5cb9d94@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459f5f2b-2565-4dae-9f9f-8848a5cb9d94@web.de>

On Fri, May 15, 2026 at 04:30:34PM +0200, René Scharfe wrote:

> > That's all assuming that no overflow happens before ALLOC_GROW() gets
> > the values. We also tend to do unchecked computions for the "nr" field
> > there, but it's usually just "nr_foo + 1", so the same logic applies:
> > you'd have to have an existing array consuming the entire address space
> > minus one byte to trigger an overflow.
>
> The use in read-cache.c::do_read_index() looks odd.  Has been present
> since commit one.  Is the point that it over-allocates to have room for
> additions right from the start?  For read-only commands this only wastes
> memory, no?

Hmm, yeah, that is weird, and unusual to use alloc_nr() directly. We are
presumably picking up istate->cache_nr from the on-disk file, so it
could be anything, and that alloc_nr() could overflow.

We'd store the too-small value in alloc, so we _know_ it's too small. So
later when we use ALLOC_GROW(), the problem would be resolved as we grow
the array. I'm not convinced the initial load might not overflow the
array, though.

-Peff

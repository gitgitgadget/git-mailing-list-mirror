Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F934B68C
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300491; cv=none; b=I1lgZHavMa6FQlWTrXXucSCVFZ+nmvQoxRq2MuRXIGuhXW8Xf975UQNgEWEV6FqIoC3WqSOCe/SVNFaSwPEnh9a1c+x9NvXqJ9MbqLDq1Wb00YdP8ijM7cKmTO2PCY1hAuW4b61VeRCA4BbqB3rkdefWUPNPe22jRZfxZRB9lKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300491; c=relaxed/simple;
	bh=YhyqgcXmw8E1AE2ER5EBJwU4N8WPfqVnlNmfUASx2Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLa1pDiG2prVe8Ye2pjOY8/A8S7143kfYGFFFK4ZO31slAD30Qtg0svcBcEK0EwC6mLJFinQP2c7Zhoygj4sAqZ0KF1rzn+O8NcIDNKkgk1CV50oozJ/rJnX5M7n7+ou+/QYrVTd5UPqM6d5Hd46iUZu57IyIx95XdgDsCrCHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZL6c9yw0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZL6c9yw0"
Received: (qmail 431662 invoked by uid 109); 4 Nov 2025 23:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YhyqgcXmw8E1AE2ER5EBJwU4N8WPfqVnlNmfUASx2Ys=; b=ZL6c9yw0qe2LGeLZuQlHRo70WvseeN6s+78EOU9g+hQC533muImohOFn4QWgLp0uBcr3Wy1hif3aYELtc7Ff2vHKzs0/TaOHl4kPbKgVHiAB514WuniK2DQ6csQJnieompOmREWmjjbC5PpovGYMfzLGlprxU+Ms8g6cCyvlzYyc+n1mTNLk5u0MRX0CMAo/Oy+aLW+c2uD3uEG5pUBbjrGb1l3LMfd038u1r2F5qLPxGqyKhK3Qh3qx/QTZzrgDCbDY13O+KKo488xkywYWm+SsXfxIWj8J78fAYzMux20fETOCNTYWxRq1FbTdIbNfBn75CeUuQk1b9hwdcZOJQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Nov 2025 23:54:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 679457 invoked by uid 111); 4 Nov 2025 23:54:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Nov 2025 18:54:46 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Nov 2025 18:54:46 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 14/14] ref-filter: parse objects on demand
Message-ID: <20251104235446.GA3667@coredump.intra.peff.net>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
 <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-14-2be68ce82c9a@pks.im>
 <20251104220748.GA2638011@coredump.intra.peff.net>
 <xmqqcy5xnz7e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy5xnz7e.fsf@gitster.g>

On Tue, Nov 04, 2025 at 03:40:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Oct 23, 2025 at 09:16:23AM +0200, Patrick Steinhardt wrote:
> >
> >> -static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
> >> +static int get_object(struct ref_array_item *ref, int deref,
> >>  		      struct expand_data *oi, struct strbuf *err)
> >>  {
> >> -	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
> >> -	int eaten = 1;
> >> +	/* parse_object_buffer() will set eaten to 1 if free() will be needed */
> >> +	int eaten = 0;
> >
> > This comment is surely wrong now, isn't it? It will be set to 1 if
> > free() is _not_ needed:
> >
> >> +out:
> >>  	if (!eaten)
> >>  		free(oi->content);
> >
> > -Peff
> 
> Wow.  Is it just the comment or the updated logic is upside down,
> too?

I think the logic is fine. The meaning of "eaten" did not change. It's
just that some code paths will not bother calling parse_object_buffer()
now (if no atoms need it). So we need to default to "0" (the buffer must
be freed) for those cases. And if parse_object_buffer() is called, it
will always correctly set the value to 1.

The new code does mean that if contentp is NULL, we will always call
free(oi->content), even though nobody would ever have set it. But
presumably it was initialized to NULL in that case and the free is a
noop.

-Peff

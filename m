Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3A40DFC3
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127912; cv=none; b=VK9hnzZvPkKqb7NHI5A6lB/3a45yT3v0+o8Otk+iBOyOslbo6EWvd7CcJKjnHQcOvqCqpnCeSVgqyPkbUrXlXk1hBZ4ueZKexlv+/FGZ9OBR/PDA6AZTDjS6gvWKH7cxfl96OUU7JFEFc/OnCBo8zuoS0M3Ed2hbC8V3ne5cw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127912; c=relaxed/simple;
	bh=9EY31y58ViHg99pqB9rFrzbHs5ytZd63xOEH7UHHRA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMpaZLKlyAQhAjreEu6jetsUHJ2/9j9jPvtS+3F9/f9ogEQRKrTHG29kzFsxVKpE74qI1eyqm3EC90dKaSPGuvV1Vqtb6OY8joFg+z5yabzb69r+jegDO3hrG46dIfKAJsHp+we8iyUIEHJsj8ZqofWprXpCQBYJ7IWzjoG10AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NgsaK6JL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NgsaK6JL"
Received: (qmail 89137 invoked by uid 106); 21 Mar 2026 21:18:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=9EY31y58ViHg99pqB9rFrzbHs5ytZd63xOEH7UHHRA4=; b=NgsaK6JLpGbm8Zf+ArSV5xSaOgLo+4Ywf09izLfPeJNOuHF23S2ulaSI+T9bTsLfC9xXw7q4gjSAFLfQzwXvzrOWXQUqrA2T4kHbTwtSBvdjhiACgoTSrXbxlUvcPT99iZSPqVzFBEesBN3KJvWgyT6gluJwT7YoP/8bhlHFl21Vq2ZgHGY6oipxEnSzuGm4CgCyNrh8grwx7iTuxh+sf7srjnouP/sxZF1oVrklejzNxrklsIw3c4PdmXQ3StZLDHzPzaPIw8Z4+xdkj+s+yk08T2WQWYTUsObRjGfnZM767tFmySdf6r0EfzkSQeCwnAt+TF/sfvvypvrQ6a9yTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Mar 2026 21:18:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 123534 invoked by uid 111); 21 Mar 2026 21:18:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 17:18:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 17:18:28 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260321211828.GB736981@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <3e387439-c066-4e45-b28b-43f77c8824d6@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e387439-c066-4e45-b28b-43f77c8824d6@web.de>

On Sat, Mar 21, 2026 at 09:47:18PM +0100, René Scharfe wrote:

> And yet this function can turn an empty strbuf into an allocated one
> without rolling it back on error, leaving code similar to this silly
> example here leaking:
> 
> 	int copy_one_line(FILE *in, FILE *out, int term)
> 	{
> 		struct strbuf sb = STRBUF_INIT;
> 		if (strbuf_getwholeline(&sb, in, term))
> 			return -1;
> 		fwrite(sb.buf, 1, sb.len, out);
> 		strbuf_release(&sb);
> 		return 0;
> 	}

Yes, I almost pointed that out, but I think it's mostly a non-issue
in practice because you'd generally call it multiple times (usually in a
loop, but sometimes just multiple individual calls). And then you have
to release if any call ever succeeded, which means either doing so after
the loop ends or in a cleanup block.

Grepping for 'if (strbuf_get.*line', the closest I found was
get_mail_commit_oid(), which reads a single line. It doesn't have an
early return, though, since it has to clean up the FILE pointer anyway.

So I dunno. I don't think it's been a problem in practice, but I'm not
opposed to future-proofing if it's easy to do.

> Some strbuf functions restore the original state in such a case by
> calling strbuf_release(), strbuf_getwholeline() doesn't.  If we are OK
> with that then it could be simplified by growing the buffer upfront:
> 
> 	int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
> 	{
> 		ssize_t r;
> 
> 		strbuf_grow(sb, 0);
> 		errno = 0;
> 		r = getdelim(&sb->buf, &sb->alloc, term, fp);

This causes two allocations, but presumably only the first call of many,
so not a big deal in practice.

I feel like there's a lot of discussion in this thread but we're not
achieving anything practical. If we do anything, I think it would be:

  - drop the feof and reset at the top of the function, which are
    redundant

  - make a noop read on an unallocated strbuf retain the unallocated
    state (your example above)

Could the function be rewritten differently, or maybe even made a little
simpler? Perhaps, but who cares? The function has been largely untouched
for a decade and the behavior is fine. And there are a bunch of pitfalls
that a rewrite risks falling into.

-Peff

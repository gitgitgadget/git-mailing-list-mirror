Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71326738B
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459361; cv=none; b=R61ANlfPbbpFYPFa0qOsFXpWJNGTtMsvN1c5Udh+aFQqKLiPFzaUC7WZjay6gT05Z7kCaE8M8R4BAS698aF9Xw0A/pKVw5nZ1Kpy9cv6JkyRV+LMrEzjtXou9ieBK7jgyQmsi2yn2YFtm9AjZKB+LSmEQHU2t+w9a6h9tP5DzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459361; c=relaxed/simple;
	bh=2S78CQZVyrum862VWjNgN6mTn1AGhcNjlauVlqEalPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eipt2jRLjWu6Hp88iDdsghw4TA+vAgfEsCzcTcd7qAx4d0gxOzNZjSnSQB/E8i6G8JDKPpVDS2188uXWeI2O2D9gyRLpm8aqfU+QzIpksgih4bcTtrCEEUBIIvnRxfCLxEK8ugZhUCwsuCY4C4bJKjINoCDC6yx4lavD0xCGmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KzBGzoS7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KzBGzoS7"
Received: (qmail 20231 invoked by uid 109); 18 Nov 2025 09:49:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2S78CQZVyrum862VWjNgN6mTn1AGhcNjlauVlqEalPQ=; b=KzBGzoS77hb2rh+af/NJAchYfctfyNmC9jfSCwPXND2XcLIPYcBM9t41QYQpzEBgcWqLf7OHmoOdf73yS20r3ci11Nho7hj/7qKaPuGEX6jhgh4usERXZv1g1tjkeWyBlMuIqZib77wcv0xYHhZJ0hozfNZhkhrPkEjcnI33/6++s5OxGbyNc2vRBAhdXFjfECIhjTjD7IuTux2tKZqkIr2PNrZTc1abblcyHO+I4hQvo1syNEhlIrMjnFK6AoFwMrTbM1ysH+zjGU7JQ6K5KfFuR4ofTwePZ963NqN4EluOrwxvI5ugx2tpQtNKhG2R0hWhkcc5LKWff8eaoIwIWw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:49:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27841 invoked by uid 111); 18 Nov 2025 09:49:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:49:23 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:49:18 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: avoid the comma operator
Message-ID: <20251118094918.GC530545@coredump.intra.peff.net>
References: <pull.2007.git.1763412374866.gitgitgadget@gmail.com>
 <xmqqy0o4gv99.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0o4gv99.fsf@gitster.g>

On Mon, Nov 17, 2025 at 02:16:34PM -0800, Junio C Hamano wrote:

> >  	/* only these flags are supported */
> > -	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND))
> > -		return errno = ENOSYS, -1;
> > +	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND)) {
> > +		errno = ENOSYS;
> > +		return -1;
> > +	}
> 
> Good riddance.  It indeed is somewhat hard to read, especially
> because it may not be apparent to readers how "A = B, C" binds
> (answer: B gets assigned to A and then the whole thing yields C).
> 
> I wonder if
> 
> 	return (errno = ENOSYS), -1;
> 
> is accepted by the compiler, but in these error handling we do not
> have to be cute, and updated code that is both simple and stupid
> reads very well.

Agreed that we are best avoiding comma operators when we can. There is
one spot where we use it, though, and I haven't figured out a good way
around it: in the error() macro wrapper.

I guess it does not cause the same compiler complaints because there is
no assignment in it. So if nobody is complaining, we can just avert our
eyes when looking at the macro. :)

-Peff

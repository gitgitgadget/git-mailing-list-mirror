Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329AAD4B
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989161; cv=none; b=DOF35QqIIZZHPWSHvaz9mFcH16bmEDKwO7zum4H1YdAG6XS9pOQQ6cc9vEzyucPDUUzBs7T+4xfTPKGTXmts3A+yG1etEDKL9iFiTFjajAzfOpVd5GvNm/0g2RUjqJ9haxoLbuAKDIdYNSQp6Q972uY0vZCngx2BHMCm0gzHQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989161; c=relaxed/simple;
	bh=corcgbk0jkWJYSZO2kMWxRrFSSVgtq4przFYid8TmYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5olsbl1EPRgBIuTyExIbI9w+p9zZgGz1YC2QwLSCrFTId552qETBJvFQGMGIuxIf1qGrhZOUP2XypqTnhKxX9rYWfFwGTWcqIyPL5NQgfmwpwa6dq54uylpkKNStNupsoSr/058X6cow8yZ7OTYln2h8tqQ03pRrpn5HP5GkVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FNpoA4Sg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FNpoA4Sg"
Received: (qmail 174562 invoked by uid 109); 9 Oct 2025 05:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=corcgbk0jkWJYSZO2kMWxRrFSSVgtq4przFYid8TmYE=; b=FNpoA4SgdRFixA8p0uGmQMa7htV498mq2l89pqUpwQCVEAnGiBtk0CjR9cNpgLWbueEdive6xuc4NpgkMJunpImOtMoPRvO9dKr0lMne2a6LrAPvbG1yoU2yTWZQMNzu5n166fa1ntPiGfS4abwQpY4XXRCl1XYEPvHvfIAlu18/HNAF+rhFthwAc5qCD7iAsIopIEIMbjsVRn+nh4kYSn8Clycf8p4Dmp3v+nyuRzWneaywBCUnCpVyssblqXEL5hFvVLGtCpIoeP6IlPuZ99XnnQKGQp2wDkBn8YPw1agV4GFnkrO4Z204NuNDLMF0GIbGRz0SD838lasqzwO2Lw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Oct 2025 05:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 265663 invoked by uid 111); 9 Oct 2025 05:52:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Oct 2025 01:52:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Oct 2025 01:52:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <20251009055237.GC1614343@coredump.intra.peff.net>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
 <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
 <xmqq348dovi3.fsf@gitster.g>
 <20250924053601.GC1173044@coredump.intra.peff.net>
 <xmqqwm5om1gy.fsf@gitster.g>
 <20250925025040.GB3202669@coredump.intra.peff.net>
 <xmqq5xd6irmu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xd6irmu.fsf@gitster.g>

On Thu, Sep 25, 2025 at 06:33:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, but it's much harder to wrap a size_t, especially if the code is
> > allocating as it goes (e.g., a loop expanding an array). Because if
> > expanding your allocation from "n" to "n+k" items will overflow, then
> > that implies the current allocation is within "k" items of filling up
> > the entire memory space.
> 
> We'd be protecting ourselves by noticing that n+k wraps around with
> st_add() and friends, and relying on malloc() and realloc() to
> notice and signal an error.  Use of size_t to count the number of
> things that are getting allocated is not making these any easier to
> do compared to the case you were counting in "int", no?  Either way
> we'd need to be careful.

Yes and no. I agree it is probably good to check for overflow as a
general principle, even if using size_t. But it is also easy to miss
such spots, and I do think using size_t (or something similarly large)
can provide some backup safety.

If you are getting values "foo" and "bar" from the user and computing a
length like "size_t len = foo * bar", then the size of the type will not
help you, and you need to do checked arithmetic. But I think those cases
are relatively easy to spot. The much more insidious ones are those that
append to a data structure one item at a time. With a type that is close
to the practical size of memory, you will fail to grow your data
structure before you hit the overflow. With a much smaller type like
int (on an LP64 platform), it is much easier for malicious input to
cause funky wrapping[1].

If your position is "it would not matter if we were properly checking
for overflow", then I agree. I just think it's hard to catch all of the
spots. But maybe I am being overly pessimistic. _Most_ of that should go
through ALLOC_GROW() or similar, so the checks could be centralized-ish[2].

-Peff

[1] We have had (and I'd wager probably still have) bugs where an
    attacker can wrap around to negative int. We get saved from a
    vulnerability here because the negative value is eventually cast to
    a gigantic size_t to allocate, which fails. In that sense I think
    "unsigned int" is the _most_ dangerous type to use.

[2] I think there are some practical implementation questions here, too.
    If we use st_add() etc in ALLOC_GROW(), then we may get caught by
    accidental type promotions, where those functions say "sure, it is
    OK to increase this len", but then return a size_t which is
    truncated when we try to stuff it back in an "int". So to make
    ALLOC_GROW() type independent, we probably need to do some more
    macro hackery with our checked arithmetic to make sure we are
    operating with the same size type that the caller is using. Not
    impossible, but something we'd have to be careful to get right.

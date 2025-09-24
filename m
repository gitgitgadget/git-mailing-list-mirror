Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA12206A7
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758692167; cv=none; b=EiwdcJpsNPU5ErgYjlgypYABC4j+dFQc9Y55oL6F3wepsbwyjHGjKwfN5flmx3u/NGVlbvcupEbD+UejHq36cfSEoaV4VZJqDtu5O+xyKDvcCBdaTleOIeDcS0qDKcNkGBSoiBYxYYJEQS3TWVGsNg9BF6+haNvosn3A2LfmSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758692167; c=relaxed/simple;
	bh=hfcQvG0EPYpwn1PC1qeCZb2W2GXPaPNNprRbuGRuDdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYPkZV1i+LsgGC/MQW06kyBGxfR5eiOeHbFkeUYCkBRTBv9aHdb3cRhJTHdTl0H6jaUCOn96OZsrHZHBaeQldMZ/FGJ9D7dRugaJ+na1GxjKk4GMSC2bkQ4xH+hbtnUPE1lvWe/DduOLuFnV+3LPLkHpPn0ZmnAVjArkc5gjQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GEq8rls8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GEq8rls8"
Received: (qmail 12842 invoked by uid 109); 24 Sep 2025 05:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hfcQvG0EPYpwn1PC1qeCZb2W2GXPaPNNprRbuGRuDdg=; b=GEq8rls8oi5za/HrxFytW1/HyYwZS/Q0tysT4gYAQ/LoFj25tEhrq+eOXXFPaLCF5cHxX9uWlLHwm4cmFAFNU3GggRHEPqewr43fCePzVPAiRL4xs6FHoSza+X3qTPyxEhvoCaJd2PkfwG9VPYFXCsttoykiuoYPRf5gxdz+nT2MIShaH7l/CbmZ+lmMuu+wB0aE4O9Y5xnC95ctsfABZx2afgoEesngNPzHkVb7GChXnc24DctA3WiOTM0dm57heu86pHvOauliG41GxZkOUo4Rj/395rpogz2UnpLrdtNEcCItNcsJvb/Sy68Do+/GcTzWVA5yExbsskdo6mT7OQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Sep 2025 05:36:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19335 invoked by uid 111); 24 Sep 2025 05:36:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Sep 2025 01:36:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Sep 2025 01:36:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <20250924053601.GC1173044@coredump.intra.peff.net>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
 <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
 <xmqq348dovi3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq348dovi3.fsf@gitster.g>

On Tue, Sep 23, 2025 at 11:48:36AM -0700, Junio C Hamano wrote:

> >> 1. It prevents us from using the full range of size_t, which is
> >>    necessary for large string list.
> 
> It is a disease to think that countable things must be counted in
> size_t and it needs to be somehow cured.
> 
> It is a type to count the size of memory allocations, nothing more.
> If you are holding 1000-bytes per the stuff you are counting, you
> would not need the full range of size_t --- you'll ran out your
> memory way before you fill size_t with the things you are counting.
> 
> When there is no external constraints (like you need to specify
> exact size to describe a file format to be interoperable), the most
> appropriate type to count things in is a platform natural "int".
> You wouldn't be handling billions of strings in string-list anyway
> (and that is smaller than half of 32-bit size_t; 64-bit size_t is
> much larger).

I agree that size_t is much more than one needs for counting most
things. But the problem is that "int" is much too small, if you are
worried about malicious input causing integer overflows that could cause
memory access errors.

A nice property of counting everything as size_t is that if we are
storing even a single byte per item, we will fail to allocate before
hitting an integer overflow. So no, we do not expect to store billions
of strings. But it is not that hard to convince Git to allocate billions
of items in a list on a 64-bit system with 32-bit ints. And it is nice
to know that iterating over them or trying to extend the array will
never hit an integer overflow bug.

I'd say the "right" size for preventing overflows probably only needs to
be 58-60 bits or so, since usually we are storing more than one byte
(plus overhead). But 64-bit is the natural machine word size that
matches what we want. However, we should _not_ be worried about losing
one bit to making it signed, especially if that makes it less
error-prone to convert instances of "int" to use "size_t". I would be
surprised if an attacker could convince a program to truly use up half
of its address space.

> >> 2. Using int for indices while other parts of the codebase use size_t
> >>    creates signed comparison warnings when these values are compared.
> 
> The other thing may be (mis)using size_t when it should not be.  If
> they were also using "int" that would also squelch the warnings from
> "-Wsign-compare".

So I really care only about truncation and overflow above. Sign issues
can cause bugs, of course, but the real issue is the size mismatch
between "int" and "size_t". And while -Wsign-compare is sometimes an
easy way to find those mismatches (because of the sign mismatch between
them), it may bring more hassle than it's worth.

I didn't participate in the count_t discussion a month or two ago. But I
think it could make sense to have a count_t that is really just a larger
"int", but is still signed.

-Peff

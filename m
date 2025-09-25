Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E702E62AF
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758768644; cv=none; b=EP4CISAQ6uPKnGaG0F9+0mDO1T7xf4K6jEdMyoSHowuaKjFNL2cjmfs3O2oLe1VDCejGqZ6qT0WJniSZZmD4404pwzerk77SMnCbtDclsMLsPUIQKv+yjzWb8Oz73SDZ+zRssHvOKJGjsilI/iH67T8F6jmUWBv4CddiY6GYzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758768644; c=relaxed/simple;
	bh=UyimzEudSUffd+xX+nYmeRMGoV01BYDe5pLZchS4n0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7Jo7PKbp2m1XgZmZIirjqzFPMMkUt4A7r4v5d/CXYs5fNFUeJ164sG73Q6fhxzzaqdLRQdHqgWj/M8xrq+s3EibkF/CuCGFjQ3jmqo5iI2Va87fr/bDCMXFPoPs7dBrlImfKOelYySrXed1vt5AYHm26HjSv5JCP/Z/B/7h9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h7u2dViD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h7u2dViD"
Received: (qmail 22438 invoked by uid 109); 25 Sep 2025 02:50:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UyimzEudSUffd+xX+nYmeRMGoV01BYDe5pLZchS4n0Q=; b=h7u2dViD+Uhr0zhiubhFB+CPzAhDi8EMcNVaxt7YUr1GfkNRq5SFQJ6Mvh+ewEdcTG1DclQel3+QC1uTPKTgwgAhCHBUP/0yKZVRMSmAtcqL9BNdPVorniLqDxpJ/RCmGDevIjS+FyjeHupOtm+kS3bk/B8lI2DKcCEqlTJ2JXw8WQKiUJfVuUlSp94+Pf/L/7iPfllOgAYFInjczd478S7XwsXiXfPFCnPZTQAAoILbUjQl01uOmy/RMbTDYLCzul5QdjmBp+6Msgp6MNDb25EKEcjqnbU7bRDHxZDoLnhyw444UN+3I2MELdFJKJEkiSXf5pCSLCV4f0xjfCVTdg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Sep 2025 02:50:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30919 invoked by uid 111); 25 Sep 2025 02:50:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Sep 2025 22:50:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Sep 2025 22:50:40 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <20250925025040.GB3202669@coredump.intra.peff.net>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
 <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
 <xmqq348dovi3.fsf@gitster.g>
 <20250924053601.GC1173044@coredump.intra.peff.net>
 <xmqqwm5om1gy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwm5om1gy.fsf@gitster.g>

On Wed, Sep 24, 2025 at 06:20:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree that size_t is much more than one needs for counting most
> > things. But the problem is that "int" is much too small, if you are
> > worried about malicious input causing integer overflows that could cause
> > memory access errors.
> 
> Well, a malicious input can cause overflow/wraparound size_t while
> parsing, so I do not think that is really an argument.
> 
> The code need to be protected against such overflows either way.

Yes, but it's much harder to wrap a size_t, especially if the code is
allocating as it goes (e.g., a loop expanding an array). Because if
expanding your allocation from "n" to "n+k" items will overflow, then
that implies the current allocation is within "k" items of filling up
the entire memory space.

In many cases "k" is 1, or a small-ish number (like the size of a
struct). In cases where the size is computed purely from untrusted
input, we do need overflow checks (and have added them over the years).
We do those checks in the size_t space, since that's how we count
allocated bytes, even if the thing we are storing is not 1 byte per
item.

If a data structure uses a smaller type (like "int") to do book-keeping
for its allocation, it risks the case where the smaller type wraps, but
is still valid as a size_t. For a signed type and a small "k" this is
often OK (if you wrap 2^31-1 around to -2^31, that ends up as an
implausibly large size_t and the allocation will fail). But there are
cases where you can wrap straight back around to "0", underallocate, and
have an unexpectedly small allocation.

I don't _think_ we have any cases of those anymore, but it's hard to
audit for. And IMHO easier to reason about if we use size_t for
book-keeping.

But if we use size_t inside string_list, say, and you do this:

   for (int i = 0; i < list.nr; i++)
	printf("got: %s", list->items[i].string);

Now we have another problem. The string list can store more than 2^31
items (even if we do not expect it to). And at some point you start
looking at list->items[-2147483648]. It's at least an out-of-bounds
read, rather than a write, but it's still rather ugly (and a clever
attacker can often stuff buffers to convince it to read whatever values
they want).

If the iterator is a size_t, then overflow in that loop is impossible
(because it implies we've allocated the entire address space). And ditto
if it is a signed 64-bit value (which would implies we've allocated half
of the entire address space).

So yes, I'd agree we need to protect against overflows, and that's what
I'm advocating for. But I think consistently using integer types that
are sized along with our memory is an important part of our strategy
there.

-Peff

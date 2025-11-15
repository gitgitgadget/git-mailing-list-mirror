Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BD4502F
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763171995; cv=none; b=EOUwiQzs9yFZCuqBkyAVqP3xlb5PfKGkZkxgdZ4v6GpC8cxUnG8cFlYq8NigdxgQI/6v3aFBHhsLkEY8QJhck8oX4hWUYZCTYzMADRHyuPK5lm2DSNQQPGkqImldB4byy33IL0l1laInHpH5tvjnDDuL9bttHvBwNkSLW0u/QsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763171995; c=relaxed/simple;
	bh=Vmk5e9l2rQcCl9J7pcCLEKkkzuP2CaGMPr4Tt668dZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kglhtizYocV5eAQV3/SRn873b0Tpmd+MfbwfjhvM4sPGQfsuRr6y6zUiVqY7JyDG5FOCM2vDLt9HI6Hx/fmVBqLtiKu5DxCLVzgB2Yrs8rimGp/fG2AaRSTdP0fxtMHO3pO2WbdAy6rP/slDcNg0cGUbGYRS+MJ3cIXdMM3/o6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bkhqhn+L; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bkhqhn+L"
Received: (qmail 522260 invoked by uid 109); 15 Nov 2025 01:53:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vmk5e9l2rQcCl9J7pcCLEKkkzuP2CaGMPr4Tt668dZA=; b=bkhqhn+LO4XxCd1H1vmPDuqMCjz0BXZEIan/gMHma6vBgzKykHsi1HVEi7H8QAQ51hBlZq5+CapynJaplBGrekryvxQeR8TrZx19LCEyE9+kj88AsS7Jsl8UOemuA4aBwW3z44esom8Y6DI0Luigw7og99kMmrO0rYVEpeDXpsnESsHf9xs714ZJCeSKSXFOHXRG9Iz1yXjVU29l17E4d/Rghvjr1wQOJDhyy5geaZDsOeKhU7ftIO6mzDHIlE3tvz9+McgauWNRxtqWDJWLGt4hEpf0CnutmKkU2Ocwo3ifxeglsWVQaSxeaRwfFvjwu5Rt6HiG5JG6p3+5rT0ktg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Nov 2025 01:53:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 827681 invoked by uid 111); 15 Nov 2025 01:53:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Nov 2025 20:53:10 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Nov 2025 20:53:10 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>, Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH] object-file: disallow adding submodules of different
 hash algo
Message-ID: <20251115015310.GA3499607@coredump.intra.peff.net>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <20251112235434.1499699-1-sandals@crustytoothpaste.net>
 <20251113032619.GA1739649@coredump.intra.peff.net>
 <20251113035614.GA1758009@coredump.intra.peff.net>
 <xmqqjyztq4kz.fsf@gitster.g>
 <aRe6l5YRCzLAxeuB@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRe6l5YRCzLAxeuB@fruit.crustytoothpaste.net>

On Fri, Nov 14, 2025 at 11:26:15PM +0000, brian m. carlson wrote:

> On 2025-11-13 at 16:29:00, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > So this is what I'd propose on top of your patch. I can hold onto it for
> > > later if we don't want to muddy up what you're trying to do.
> > 
> > I do agree with both of the above.  The patch below makes perfect
> > sense to me, and it is more about the quality of implementation of
> > this codepath in general, than the primary theme of Brian's changes,
> > so there is no strong reason they have to come in a single series.
> 
> That's certainly true, but it still applies cleanly on top of my revised
> patch and I'll just include it in v2.  I'm running tests now and should
> send out the series later tonight.

Thanks, your v2 looks great to me!

-Peff

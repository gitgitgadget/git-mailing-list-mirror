Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A11B4F09
	for <git@vger.kernel.org>; Fri, 16 May 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410176; cv=none; b=QoTxHH4kctjl2oEqu84gg3DufC1w4qvYB7xeo9mPvuE/g+AGSDI1QCP79fXcPEtBnj0Ju3rlQA2KjeyGXR10uMjLlpgkrCL1Q1XKFnZMku+KAoGsbzZhMzbJ056/ED+xZqt815JctjpORz6mm3S3+SsxcCXMMnLMSOJrfihX1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410176; c=relaxed/simple;
	bh=/3ByuIebFUYxorPvwSc31A5K7Y7aZO+Nksw3oEcajXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyX4PdA2vKlS1U6yxV+fh3gLw5GuCuLhdAXo/P20XPnZ1JHZ+7cuwmoij5Wb2zegD+zSoZCEp0rjhF++7vUTTC++rNavBfknsM2hZfV6leDYmdwKPi0kDk1Qxr+mFUhIRmFx1aYKqFL7/o1/Gvkn0M308mhbTtveGYqXqY9RpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CzxurWy9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CzxurWy9"
Received: (qmail 9289 invoked by uid 109); 16 May 2025 15:42:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/3ByuIebFUYxorPvwSc31A5K7Y7aZO+Nksw3oEcajXw=; b=CzxurWy90eTmVxewGPrb8mHqQZnUNU2A+lyozrWrsYHSu5aDvzc3X679tPHNFBc34D/8uKWaOklxEgxaX3FQ/ll5+mxnPrCRgQw8AxBAYuzjnx/5eEmGVn9El1GMOPCIXGYYoGxxTaWMHGrhjbqBOOVBAEv6tBo3OEQNIMz41Fdeh7alRcM/3bhvLASsSP1aWChl/J8oeooRkxLbrxw6Q49Wc9kYWhi+p5twZkHpC6pIp+wnMlcXKOtlQD75SpugHbbqBfZXW0kECvKa+CzXbCiITk4L/IZcDEqKVJovBc0FZS+0XQICrV9sVr4NkOwWe/Xrz/ELv4uu5l6X4EeGGA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 15:42:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12187 invoked by uid 111); 16 May 2025 15:42:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 11:42:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 11:42:50 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH 10/11] bundle-uri: avoid using undefined output of
 `sscanf()`
Message-ID: <20250516154250.GA26009@coredump.intra.peff.net>
References: <694d8e62-486b-43d4-966c-4fa1e5a95061@crinan.ddns.net>
 <20250516134054.217202-1-phillip.wood123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516134054.217202-1-phillip.wood123@gmail.com>

On Fri, May 16, 2025 at 02:40:54PM +0100, Phillip Wood wrote:

> On 16/05/2025 11:11, Phillip Wood wrote:
> 
> > I had a similar thought, though to make sure that we parsed 64 bit 
> > values correctly on windows so we'd need something based on strtoumax() 
> > I think.
> 
> Perhaps something like the diff below which adds strtoul_u64() in a
> similar vein to strtoul_ui(). I think it's debatable whether we really
> want to skip leading whitespace so we could perhaps tighten things up
> by replacing "if (strchr(s, '-'))" with "if (!isdigit(*s))" though
> that would mean this function would behave slightly differently to
> strtoul_ui().

It feels like we would had to have dealt with this before for other
large values. But poking around at a few obvious suspects (e.g.,
packSizeLimit), it looks like they are all constrained to "unsigned
long".

So yeah, we probably do need something new. IMHO we should probably have
repo_config_get_u64() or similar (with the appropriate underlying
helpers as well) as use it here. But I am happy with any solution.

And I do agree that we should consider banning *scanf(). With numeric
placeholders I don't think they're a security problem (though they are
easy to get wrnog, as this discussion shows). But using them with "%s"
should generally be disallowed.

There is an fscanf() in builtin/gc.c that uses "%s", but it is careful
to construct a custom format string that limits the string size. Yuck.
The usual thing in our code base would be to read into a buffer and
parse from there.

-Peff

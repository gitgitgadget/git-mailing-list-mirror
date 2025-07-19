Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608968821
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752907456; cv=none; b=DCxw204BhCcnCnk+K4NxIYJ22HM98cCXPA4EguAcUdp5MDmmM0Ii6jH+IHhBrCpcwfAPGR/7cweu8+6VIGfK/l5UH/6F0tyFuTD/TL/l+Ana2pi9Yhkqp3C3MW1/7ZflvXRRDvBW/lQikiVusPkab0kTaXYN2VWDzpRfldYuOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752907456; c=relaxed/simple;
	bh=kEl/63FmWh26etH1tofgsg5GxgdP/M56OuxOppf/25Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDta9wwe1hD1j91gNYTNAodPxGSzJYUvpkLaFsRzE/DdVPyemkNlJsqlk+lBeNRvZJFYsotsQtqHzR2Qc2C43Nn9u5471o+zWAlWZwRNkxrewfRl4OmC0jQCY/I6pCoQS96fxjeOks+svsJaRnz7yuthVT+qqiyFpHdYu33+f6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZLT516Kt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZLT516Kt"
Received: (qmail 27148 invoked by uid 109); 19 Jul 2025 06:44:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kEl/63FmWh26etH1tofgsg5GxgdP/M56OuxOppf/25Q=; b=ZLT516KtbJNJF43zsn9ARC6tQJVvPI3PbGzjJHtBxXVCjWPnsIXqHekAZNBJ5LevQFbheLQBr6G0IFT5F0BHiYAfovYm10+JZYD4E7dTEyWJ5gceA0Cv1e3MF1xUA7f6j6bRjTXpToqxpBwfqCUuXU8d7yZx/y5vs7pkOEGi/HYhtWBTtNaqjfWwMlX3A+l3asMue7Q7mHxCydxe4YgbpOvLk+ktqPQfVIi1tipel6UjXrDf+ismpe5G1yw7YyGL4H9lFegD8deV2RBzm91AdC9W6B4hYVyreQrSRvuvB0Z5RhfdZNjobC2+7Cwa0giKm8iEyqNUk9pPFwvFCu6BQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 06:44:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4390 invoked by uid 111); 19 Jul 2025 06:44:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 02:44:17 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 02:44:12 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 1/6] last-modified: new subcommand to show when files
 were last modified
Message-ID: <20250719064412.GB705356@coredump.intra.peff.net>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-1-toon@iotcl.com>
 <aHmPHcNQYlhGo8JB@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHmPHcNQYlhGo8JB@nand.local>

On Thu, Jul 17, 2025 at 08:02:37PM -0400, Taylor Blau wrote:

> > +	/*
> > +	 * Is it arriving at a version of interest, or is it from a side branch
> > +	 * which did not contribute to the final state?
> > +	 */
> > +	if (!oideq(oid, &ent->oid))
> > +		return;
> 
> GitHub's fork writes this as "if (oid && !oideq(oid, &ent->oid))", but
> the commit that introduces the "oid &&" portion of that expression
> doesn't provide us with any clues as to why the change was necessary.
> 
> Since you have spent more time with these patches than I have recently,
> perhaps you can help shed some light on what's going on here?

In the version from tb/blame-tree of your repo, the caching system
calls mark_path() with a NULL oid. But none of that code is in Toon's
version here. The only call to mark_path() in this series always passes
a pointer to a real struct.

-Peff

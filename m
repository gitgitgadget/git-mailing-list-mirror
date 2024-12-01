Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338D376F1
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088999; cv=none; b=OZd8yWSVCdPyNwiqQG4KsVLuMtyRIl1kM7OQ/VPC+i+24ojqfaCMrJhQs3QvbxFt7fQ2TVwtYYYUT7vzq1Mnf9P7VOYT8Lzcgyo/SE2adAsKDskvxNAgWApFE2AsEGsKWAN9hZWVb1Zlq4kmSwj3SgqfH+me4mCrT8VAI/sX2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088999; c=relaxed/simple;
	bh=brhFfGo2574K3bRbkazWFIAYsUvv+t2ith42eQcIJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBQ8TKeJKoS0EdZP955h+BoHP+Yg9SqG444tHoRe9DLCIdrzQ5g2PEycCQHFyt7Igja72EwJcCqc6viEcOy7yXQD/eWgYb28sxBr3TnPd668wNX7L2Y+ToduCWwq/0v8phGLZLwiA/si6wol/uO1kOBirOylqCTU2HN/XM5dbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VXbcPrCK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VXbcPrCK"
Received: (qmail 3603 invoked by uid 109); 1 Dec 2024 21:36:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=brhFfGo2574K3bRbkazWFIAYsUvv+t2ith42eQcIJEM=; b=VXbcPrCKCo6KHCRQbBa20kFl1OdFBF3wlwugwfQ3OBt+QE7hOzKrpMeDM/nugGlTbhlMCmCHDvcAin4XJgeNdCfqVW8MtojsK5Irvkr/S2klL4Rb5RUSqDGqf1R+pLSFiH0yXDcn89tc2pjA8U44L/HdJL2ZmQn1d3Zfn5ztp4RonGcjpty9IMbSfYdPmEG8wlK40PXgEIRHTzX44PkRVN1V0O1cSzXpXCdjEf1zgL4BMf2WmFhF5i+xaZGpM3cUqg0+zNDsrVaiWpjhiMMecBjfo5UbA+0pvWXnLuqtHNoWCh9zVjdvg7+TqPpKJRhI5fBAw7mit79IjPfFrJHRfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 21:36:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13866 invoked by uid 111); 1 Dec 2024 21:36:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 16:36:36 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 16:36:36 -0500
From: Jeff King <peff@peff.net>
To: Dmitriy Panteleyev <dpantel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
Message-ID: <20241201213636.GB145938@coredump.intra.peff.net>
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net>
 <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>

On Sun, Dec 01, 2024 at 10:17:44AM -0700, Dmitriy Panteleyev wrote:

> > > I attempted to upgrade git to v2.47.1, with the same result.
> > >
> > > I then downgraded git to v2.34.1 (the version for the previous
> > > distribution release) and the error has resolved.
> >
> > Can you try bisecting between v2.34.1 and v2.43.0 to see which commit
> > introduces the problem for you?
> >
> > -Peff
> 
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [04fb96219abc0cbe46ba084997dc9066de3ac889] parse_object(): drop extra
> "has" check before checking object type

That seems like an unlikely commit to introduce the problem you're
seeing. And how did we end up with 0 revisions left to check, but no
final outcome? Did you need to do one more test and "git bisect
good/bad" on this commit?

Or alternatively, can you share what you're doing to test the bisection?
That might help us reproduce. I kind of wonder if the results might not
be deterministic, to end up at an apparently unrelated commit like that.

-Peff

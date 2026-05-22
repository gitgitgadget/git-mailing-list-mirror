Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1F3101A6
	for <git@vger.kernel.org>; Fri, 22 May 2026 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425707; cv=none; b=UTj/b7zPk6gi1lpuLUcRiRbSFRu5qCbJRg+k2mcmn/305seP60dRAQBREwRFiRWTy5tDVp4aC1aPUaQJYOcrzqDtEkECF6XBOsjijWzWIQfGz5JdWQk6E4t8PVjkiYkTr3MhOinpRA/HwytD407W7VYyHuapfAbGnRh5Ti3aV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425707; c=relaxed/simple;
	bh=fv+4awjyGduox81zemW2nMHYlW4TLruxLZqOVG5pdBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuoCbklpZyIUp5/XOaI+mrOU05CtXTKTpFPhF9Bmces3We4S4s/EKwZ9iD+lEvanuDhkhGqplXgO7d54ihsL9shYDlJyGsNElCw79m7rHGaDqCoqUi1D+gVEtOIH7ZFC6UXFoNxCE//b2bKg9wWaQlc6w+kTgefCZzbJ4Eqa3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TTeZcgoM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TTeZcgoM"
Received: (qmail 46997 invoked by uid 106); 22 May 2026 04:55:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fv+4awjyGduox81zemW2nMHYlW4TLruxLZqOVG5pdBg=; b=TTeZcgoMRAwn3bMqp+2Hd4XluD3CdLeGOS78gHO4d2JzVPWp6UvmY4vNKm6IiLeeUhRDTNGeHw7Sra0bDGS6dPO7q/RwtLXQC855hOIOq9ghBcYqNzM0cKToembw/l0oDbBZ0A/aOEQA4VasbU4JtaXrEYA/fkeRZ39ALCusaTrG01Hkosia9fXGqX8Fj0+ZAm9bPX1805J27jYF8Lc+g6wKdd3m1gSBRNvJbKmJPkPff2Jin3TY1FddR3hGBsPjDLklMljgbeEOnRPkuHmZ6gmBABgR1LidWZM4JbUz379h3YTwM+LVbrHYRAdf7VDuLcyeD4IdmswKOUl+gkzoaw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2026 04:55:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 98833 invoked by uid 111); 22 May 2026 04:55:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2026 00:55:08 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 May 2026 00:55:03 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	slonkazoid <slonkazoid@slonk.ing>
Subject: Re: [PATCH] http: handle absolute-path alternates from server root
Message-ID: <20260522045503.GB861761@coredump.intra.peff.net>
References: <20260512162619.GA69813@coredump.intra.peff.net>
 <xmqqo6ikjeqp.fsf@gitster.g>
 <20260513185825.GB147423@coredump.intra.peff.net>
 <agbOEsZ8NmE8SyfV@pks.im>
 <20260515170134.GC88375@coredump.intra.peff.net>
 <ag7xbkTF11N22waX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ag7xbkTF11N22waX@pks.im>

On Thu, May 21, 2026 at 01:50:06PM +0200, Patrick Steinhardt wrote:

> > Packfile URIs help with the actual pack generation (even if we're
> > blitting out bits from the disk with verbatim packfile reuse, we still
> > have to handle gaps and compute the checksum over the output pack).
> > 
> > But it doesn't help with the server computing the set of objects the
> > client needs in the first place. IIRC, packfile URIs work by the server
> > saying "oh, I was going to send you object XYZ, but you can get it from
> > this stable pack instead". So the server still has to compute the set of
> > objects (and send any that are not mentioned in URI packs). Bitmaps
> > help, but there's still non-trivial computation and storage on the
> > server.
> 
> I guess it depends on the actual server-side implementation, but in the
> general case this is of course true. A server could decide to for
> example overserve objects in case the client does a full clone, or it
> could arrange packfiles in a special way that allows it to serve at
> least some kinds of requests efficiently.

True, though you still have to receive the client wants/haves before
getting to the packfile-uri phase. The alternative is for the server
send URIs during the ref advertisement. But we have that, too, these
days: the bundle-uri feature. (Which I completely forgot about while
writing my earlier email).

So I do think that bundle-uris can probably be an adequate substitute
for dumb-http in terms of reducing server load. Though...

> Packfile URIs definitely need some love to become feasible, yes, and I
> don't think they have evolved much since their introduction. I still
> feel like they are the better mechanism for offloading traffic compared
> to bundle URIs though, as we already have packfiles around anyway.

...yeah, I agree that storing both bundles and packs can be annoying for
a server, depending on your setup. In theory it would not be hard for a
slightly-clever server endpoint to store packfiles for regular Git to
use, and then generate the bundles on the fly by cat-ing the bundle
header and the packfile, both of which can be sent out as raw bytes
without further processing.

Anyway, we are far afield from the patch that started this thread. ;) I
do agree with the general notion that we _should_ be able to get
smart-http close to the server-side expense of dumb-http with a few
tricks like these.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D823D283
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275749; cv=none; b=sdVv8V3h0bIv4yCXm1cWR+cZxrg3AaWjyIuJ57KXPoETmsAbGAtI43cO5itDXVJN7cEAMVUK4FDZIhC7HDCvsZV9E2ozQUz/9TRdk4cq7lzPq3YiPOStzSu2gPZCylTdvtTRzzvP8LeWYFDRdHciKiMoA4ZA4j/3ZCWQR+vNVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275749; c=relaxed/simple;
	bh=iiQ00Cz1JDtR8wkuqwmKIL1HXZ9cTTHkuQCIO0uZkAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0QjJCdc1OKndLEIAHzn8um0jlkIuKjtcIFsUfXIUD79aBG/BJv0+YF824sZgn6A+hrh3x+UoNN3AuJ0OAHR0X8hAAHhm5FBgct1fcXFkpQlkhtpcYB1nTqFIS7siX9KJByifKKeqgJdWT6BIGMxlwOTQtFSkWbl5fHG2OyCOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OR2FoQd2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OR2FoQd2"
Received: (qmail 51997 invoked by uid 106); 17 Jul 2026 08:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iiQ00Cz1JDtR8wkuqwmKIL1HXZ9cTTHkuQCIO0uZkAY=; b=OR2FoQd2hyGQdOozKE0nniy2Xpyo43P6IJS8gesD3MqAj2Pvu8lk/vs6BCuFjhBY1hqOENoNoc/aULSMFZoqc1jBCHLkZL257rUJTmy9U1Jltgo6CfDXuofs6n2Zzb4IOTR7orQGGGIY3EQ44P+KFuszKxF5OXP5rgkkLwKFotL3n+PvpstWbnu81lfKpD3Uw9Fwr0MGgRoJQig8BJ1Lybw91nP8Uy/e5ts/dR3WelUOIZ9rd9YigdHdaWIZlag6r7B5a3aAnUajcSvTGyOitzVAUvxn+wF4pGNUHJmDLwguQIuTPUp/6qALzohjkt4bbraJ7ejPBfAoiIimWznGZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jul 2026 08:09:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 92340 invoked by uid 111); 17 Jul 2026 08:09:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jul 2026 04:09:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jul 2026 04:09:05 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Gusted <gusted@codeberg.org>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: git-last-modified(1) slower than git-log(1)?
Message-ID: <20260717080905.GC1832790@coredump.intra.peff.net>
References: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
 <20260716042808.GA1151612@coredump.intra.peff.net>
 <87se5jf9f7.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87se5jf9f7.fsf@emacs.iotcl.com>

On Thu, Jul 16, 2026 at 01:42:04PM +0200, Toon Claes wrote:

> >   - more timing exploration; e.g., might it make things worse if
> >     doc/langref were touched in 99% of the commits? Probably not, but it
> >     might be nice to check timings against a few repo shapes and request
> >     depths.
> 
> Maybe, I tried a few things.

Yeah, I would be surprised to find a practical case where it makes
things slower. Checking one bloom key is cheap-ish, and unless the
subtree being queried is touched by almost every commit, it's going to
be a net win.

> Personally I'm not too worried any use-case would be at least equally
> fast.

So yeah, that's my gut feeling, too.

> > +/*
> > + * revision.c already has this functionality, but it is not public
> > + * and it looks up the filter itself. But probably some refactoring
> > + * could make it available at the right level?
> 
> I assume you're talking about check_maybe_different_in_bloom_filter()?

Yeah, exactly. We already do the first half (getting the commit's
filter) ourselves. And then most of the rest is just trace2 accounting,
which we don't necessarily need to do.  So we're left with just that one
bloom over the keyvecs, which is fairly trivial. Mostly it felt weird to
be looking at the innards of rev_info, and the logic for what those
keyvecs means should remain in revision.c.

> I was working on a fix to simply make it public and call it, but that's
> a very valid point you're making. I'll change my plans.

I was just thinking to split it into two (get the filter, and then check
the filter against the rev_info) and make the latter half public.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4041FBC99
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538086; cv=none; b=IoKsGrv9mJe6osrWBOxvUnhFe9m6MKmAXSEutwQ7PixpZTQszlhljLK5ZpbPFNs3SHwpmMP4Cxi6lIDpMTKL8Oy8wwsdB7YAmKsL7nCnc1R7PxBAzfrjzNwmYZKvRH2NRs8FYV0yaBfStRatXR7YPHPv8phBzy2UX10wzVrIdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538086; c=relaxed/simple;
	bh=uD5QfvcQKC0Abkidd/OYSdDiLtH8CvZRWRFdZK/meDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lltvfygkCNA12WGVHusez+rjvQj6Gz6S8OYdMchU5mxholvgsZrZij/SmhddCmLZn0xvNn6nUA1KVtMfiY25PxSVfWUphJHJ5R8IWXVvKI1z2pp+RrZSPBb20FTfccrRvFhb/myyhAcq/+V6YAufSZiTe44ThNiaKBzjm6hskTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NnZRYCti; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NnZRYCti"
Received: (qmail 19574 invoked by uid 109); 21 Oct 2024 19:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uD5QfvcQKC0Abkidd/OYSdDiLtH8CvZRWRFdZK/meDg=; b=NnZRYCtiDSvFA4dtnQTY9CQG8cNiwER7qwZT8b1ybJamtE+B5yAkop9G6C5095fkedvtQP7DxgERgKxY5E+7DV64MgoPw/vrRtsWzlLGpelAe2KS3ZRPH2Ym+xbAevjtAtcLmkS0yZOSstuq13cD5o8WT/bUGMru94g6n+1Ob8NKdbw0EtGBaS0O94T59XYjxPGlx+PT5GDB57E3DOXAQHtzVJfRcOHXXn4J33pjox3ScCxLT/l/I6NmwK44+BdNrOZS32Tt+IepedXBaIQa0nZi/emvA9aLnAA6quJGWsa4xO4LDMr51ytI+xYn+UfeERj2kvnwdGxgbbPVqE68ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Oct 2024 19:14:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31788 invoked by uid 111); 21 Oct 2024 19:14:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2024 15:14:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 21 Oct 2024 15:14:41 -0400
From: Jeff King <peff@peff.net>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Message-ID: <20241021191441.GD1219228@coredump.intra.peff.net>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>

On Sun, Oct 20, 2024 at 11:42:38PM +0200, Bence Ferdinandy wrote:

> I basically use it for two things:
> 
> - variations of `git log remote/HEAD..` for which I currently have an alias
>   with "origin" hardcoded. E.g. I'm on a feature branch I'm reviewing and
>   I want to know what commits are new compared to origin/(master|main|trunk),
>   but I use HEAD, because I never know (and don't really want to pay attention
>   to) what project uses what. And although "origin" is usually ok, but not
>   always if there are forks in play, so @{upstreamhead} would make it agnostic
>   to the remote's name.

I'm a little skeptical that this is useful. If a local branch has a
particular remote branch configured as its upstream, then shouldn't your
search for new commits be against that configured upstream branch, not
whatever that remote's HEAD happens to be?

In many cases, of course, I'd expect that HEAD to also be the upstream
branch. But then you could just use @{upstream}.

And in some cases, you really want to compare against a known base
point, regardless of the configured upstream. But then you should use
the full name of that base point, rather than the remote half of the
upstream config.

It sounds more like a band-aid for scripts that are expected to be used
across repos that may use other names for what is effectively "origin".
In which case I question whether we really want new lookup syntax,
versus having those scripts learn to query the remote name.

E.g., I think you could do:

  upstream=$(git rev-parse --symbolic-full-name @{upstream})
  git log ${upstream%/*}/HEAD..

And possibly we could make it easier to just grab the remote name with a
single command.

-Peff

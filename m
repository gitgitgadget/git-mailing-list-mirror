Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A126AF5
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735226637; cv=none; b=rCvzSLGFw10GZvkERCbnE2xUf25PpKAGNjOXgOVbQSIR2nwhoNGnuNvDkSJ2DGnvVALJ/24L176KZyvDQE1mlZYBcFnGkXFddGEG7ASNjbUoieyxNBS7bPBI5TFH6//zvzDbX/LSCvYCSlJFNyFIYWpOUieZ9GbLSklsb4zuTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735226637; c=relaxed/simple;
	bh=5qd8hkKmAJUo5WKmxlxUHawiwgcAkiAAte6wDYzSWhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf8eB8k/oZYSe7ZuIv/Husb4xkQ/aCainfO8E63SE8hIRU/d62I5Wk+OrboU/msm7N+HndExjS03gbmLnGaGdw1aIBgsecX1rqH500UZDJ11AbcCk+Uml7YGtOZi1P6q0ka7ksjklp4TeUiK+4p6mkQSIvUyFOyObTMaGMDc96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NoOBfHDW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NoOBfHDW"
Received: (qmail 25384 invoked by uid 109); 26 Dec 2024 15:23:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5qd8hkKmAJUo5WKmxlxUHawiwgcAkiAAte6wDYzSWhI=; b=NoOBfHDW2a4DlS14hGtgyXoLjUlr+S0xla+33nfb8skh2CM+Teq544qKX1+Os9bGvkXN+fIuiihT4BDLvoHBVt4G3BCGziRTwcStM/0R5p5vlp5YqoUS0iPdFPMjOkzF7278Lq5dBQm/W9BbcA6T6UwOUqZyyKtu8SEjqIwNRrd+9NVH9jk0VCb2DqLQXpx+37EK/sfhB1DP86sj9DkSmRElymjhTAGEc76LilKut40G9bGWrUuPZBWEtDfWaRN69MQBwGRRLU1PeGDdL9GQnZs906eU18sn2v+ln7OsE+2rafyAkc72Hr5DcEtVcnMUqnymoVtTpbmeQJ1NwCdMlw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Dec 2024 15:23:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1691 invoked by uid 111); 26 Dec 2024 15:23:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Dec 2024 10:23:47 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Dec 2024 10:23:47 -0500
From: Jeff King <peff@peff.net>
To: ZheNing Hu <adlternative@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [Possible Bug] --cruft option not work with git gc --prune=now
Message-ID: <20241226152347.GA68791@coredump.intra.peff.net>
References: <CAOLTT8Q0cH3Q=yPnTYKAwn8bC+iDW7onibsLF=bzVr8tGw5J0Q@mail.gmail.com>
 <CABvF+3ZU=96jQBmGw3eWmAQ4DjCdcm1VT7fHMVz_MxvW2xxPng@mail.gmail.com>
 <CAOLTT8TraRjBObcLotNr7+a9Ap7Fy8VVy7HjHLLWwEB_LvBrUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8TraRjBObcLotNr7+a9Ap7Fy8VVy7HjHLLWwEB_LvBrUQ@mail.gmail.com>

On Thu, Dec 26, 2024 at 02:19:56PM +0800, ZheNing Hu wrote:

> Okay, I know that gc doesn't have an --expire-to parameter,
> but here I was hoping to use git gc --prune=now --expire-to=<dir>,
> where expired and unreachable objects would be stored in <dir> for
> easy recovery in case of repository corruption. Moreover, it's more
> convenient compared to using git repack + git prune
> (isn't a single gc command much simpler? Plus, most users are
> likely familiar with gc rather than repack and prune).

I don't think there is any reason that gc _can't_ support --expire-to as
you want. But any patch to do so would have to adjust how it calls
git-repack.

Up until now, "--prune=now" meant it was fine to run "repack -ad", since
that would just discard any unreachable packed objects without further
consideration.  If we're keeping any objects, then we have to tell
repack what to do with them (which traditionally was just passing
--unpack-unreachable, but these days can include --cruft).

With --expire-to, that logic wouldn't be valid anymore; even if we are
expiring all objects, we still might want to tell repack where to put
the expired ones. So I think you'd want to adjust the if/else in
add_repack_all_option() to pass --cruft, etc, when you see --expire-to
(but still continue to "repack -ad" otherwise to keep the traditional
"git gc --prune=now" as cheap as possible).

-Peff

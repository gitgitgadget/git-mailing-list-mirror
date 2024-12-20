Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C71A0BED
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685751; cv=none; b=Odt4cX8nS1YQ8QvIO28Rc0I+ZEDxyoAumotzdHxQdf/ezQLV1F9nSuXtTW0rYXn5qOdGphYNl52JMQ1JXKYUrQ9+M3xqC3y5OpdicSSSQyXjl5QOFro/XCOUsqI/dOdfeELsyrqDWMYR2/oR4Gh1v8TaMoYdt+b7vArL+hljb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685751; c=relaxed/simple;
	bh=BDffkG8Xwg4cEOGwCRyKlffyZGAZQiu8EcXq0kBu6xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgRqwcjTEwOAb9tQC95B14A2m5yGZpKJL9Zbd9p+2pfvwDtA0282LBH+7fR1PWgUS3tj6uByMpe5M10DAj3v7NV+exxOS5FUB35L+07kkJmfSvi8nlCcmrS33DkzxFCm0hZI6tGU1OPppMlGHJqcqVYFtQ6zGFEmN9bvyG/rFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Wkn3Nlw2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Wkn3Nlw2"
Received: (qmail 8799 invoked by uid 109); 20 Dec 2024 09:09:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BDffkG8Xwg4cEOGwCRyKlffyZGAZQiu8EcXq0kBu6xc=; b=Wkn3Nlw2OQLLV33wTbRTr71Q6uDc9HoMJ3nAfhS6qpekiJjtZKrIY1YsWxiH1CReMgKWllKE6TbmUa+iq2O3GnsK24HnSxmA7FKqYuN4FhATZRDP/q8TLBbVpIoMnb7zYNTSam9tSIdot6EqEb3lSQ9cPpJ477KifxGSqW0xvWXWgAdfbjSode8+VkRCBkp1Q1MVEoRo37Q8wkByJMvS6kxwWptLoBjXuTXR75kbv0Phoy0GRn1Yvx+tnUaCqkyAPpJ2RcCu28jFfnQ3C8xDdbpyOjuUsYPyy9/BQ8yxbzhfnDY53o+lmYMK3+5ywROjdkU3mdnKEGQbtRSCFzqYkA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 09:09:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14471 invoked by uid 111); 20 Dec 2024 09:09:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 04:09:09 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 04:09:08 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241220090908.GD133148@coredump.intra.peff.net>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20241213081211.GA1443203@coredump.intra.peff.net>
 <xmqqv7vnevjc.fsf@gitster.g>
 <20241213103850.GA1456983@coredump.intra.peff.net>
 <xmqqcyhtaecy.fsf@gitster.g>
 <xmqq5xnladwi.fsf@gitster.g>
 <20241216111112.GA2201417@coredump.intra.peff.net>
 <xmqq5xnj7fre.fsf@gitster.g>
 <20241218113927.GB594795@coredump.intra.peff.net>
 <xmqqv7vhujo4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7vhujo4.fsf@gitster.g>

On Wed, Dec 18, 2024 at 06:53:31AM -0800, Junio C Hamano wrote:

> > Whether it's unusably inefficient depends on what you throw at it. IIRC,
> > the performance difference for pack-objects on git.git was fairly
> > negligible. The problem in linux.git is that besides being big, it has a
> > deep(er) directory structure. So collecting all of the attributes for a
> > file like drivers/gpu/drm/foo/bar.h needs to open all of those
> > intermediate trees.
> >
> > So I'd be inclined to leave it in place, in case somebody is actually
> > happily using it.
> >
> > GIT_ATTR_SOURCE suffers all of the same problems; it's just that you'd
> > presumably only use it with a few select commands (as far as I know,
> > pack-objects is the worst case because it's looking up one attribute on
> > every single blob in all of history).
> 
> Ah, OK.  So your "caution" was about the underlying mechanism to
> allow attributes corrected from the specified tree, and not
> specifically about using "attr.tree" to specify that tree?  That was
> what got me confused.
> 
> If that is the case, I do not think the documentation patch that
> started this exchange that adds attr.tree to where GIT_ATTR_SOURCE
> and --attr-source are already mentioned makes anything worse.

Yeah, I agree it's somewhat orthogonal. Your patch made me think about
it because it is advertising the config variant more widely. Somebody
doing:

  git --attr-source=foo diff ...

is probably OK, but:

  git --attr-source=foo pack-objects ...

is less so. Using attr.tree instead means you're going to do the latter
whether you intended to or not.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9CC8D7
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836553; cv=none; b=Zzpo0WZZ2bX0WzjygRw91Uu9igVq6UrzmCa8uCfrLQbBgj/c7GUOPG1M+o1539hboTP+u4yRTMHsonoPMi2IJY0fcecE/XK3hzQn19Fe6i4YpO5kx20zd85z1d06EcyBArw45VICNo0GFYfBYv/4/27nlgJmh/MLiEo74reD7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836553; c=relaxed/simple;
	bh=jt5zeDY7e1UvGLItEPosmR33fYfj8ndX+u96Hrh6T90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrFMXLexHiNP10LjU/+gRBmmPQk9dQuVRn0tkF6xpkBuAB59Lg6SDHpJIQu7LZKs4d+LiaQ7bs6vFwqP92tyZ7gaj/Udnhwta6WxdPL0L59esmS2ocsj+48nKcpQ7ZrapW2H3kApwZZ2/skuMtsce9VDawWUtFmG5lbX1Ie9ZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7495 invoked by uid 109); 8 Jun 2024 08:49:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 08:49:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28720 invoked by uid 111); 8 Jun 2024 08:49:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 04:49:08 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 04:49:10 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
Message-ID: <20240608084910.GC2390433@coredump.intra.peff.net>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717662814.git.ps@pks.im>
 <bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
 <xmqqplsum2cz.fsf@gitster.g>
 <ZmKalkqR3GqCXfqz@tanuki>
 <xmqqikykd22p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikykd22p.fsf@gitster.g>

On Fri, Jun 07, 2024 at 11:45:18AM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We're unlikely to break existing workflows though if we name this
> > variable something like `OPTIMIZATION_LEVEL`.
> 
> Yeah, being more explicit is always good.

One of the reasons I used the very short "O" for mine is that I often
specify it by hand. I actually leave it as O=0 by default, since the
majority of my builds are about developing and debugging (so speed of
compilation is much more important than speed of the resulting
executable). And then when I am interested in performance, I run "make
O=2".

So OPTIMIZATION_LEVEL defeats the purpose. ;)

> > We could also generalize this a bit and introduce `CFLAGS_APPEND`
> > instead. Optimization levels are last-one-wins anyway, so people can use
> > that to append their own flags without overriding existing values. It
> > would also mean that we can avoid repeating the CFLAGS that we already
> > have in our Makefile in our CI scripts.
> 
> Yup, Peff's $(O) cannot serve as such, but my $(O) is already being
> used as such.  Naming the variable that gives additional CFLAGS as
> such is probably a good way to go.

I have something like this in my config.mak, too. ;) But I call it
EXTRA_CFLAGS. That seems less grammatically awkward to me than
CFLAGS_APPEND, but that may be entering bikeshed territory.

And you can tell from the length name that I do not use it all that
often.

-Peff

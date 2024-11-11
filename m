Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD87F477
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363003; cv=none; b=Z9Ktm56h6bGm3X+/mV+PRoKITrJNMpSw5lGEsaANDqKHWGwwMhRYiQv6cuCHYRu12qoVVMLUYso7CAr7gjNfdv67+ds6l3auWDB/BnQ8crMaZFsh5iFEMxjl6vhbYYOMBvLH9i9Vc9lKZ0lcDRMKWA22u959P/lidPzJ9uOIq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363003; c=relaxed/simple;
	bh=ALiXX0Ttq/x4uhhP7Fc54RGZd/FcNHyQ2/DZnINN03Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STVThL8jxeapK8IkXnkWnf6TSAAgERVeTp97GnDony4jRL9zfDd8+rfXjEVxuN7VFrJnYDxCG+eKb79KK6w8F/wh3OV1m8aj2saXVAMimZe9U6jaBWq+whLqWxOUxBSuQTfawXLTti6HsSvUj/WaGKYKOOleiumqXxmWiru+5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BmePk2wL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BmePk2wL"
Received: (qmail 22032 invoked by uid 109); 11 Nov 2024 22:10:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ALiXX0Ttq/x4uhhP7Fc54RGZd/FcNHyQ2/DZnINN03Y=; b=BmePk2wLI5ojbt/NoKro03sB5ze4ww6v6AhNuE8815nns+uEA5z+XjecGQMm6dDO2hM0xuNYjdiyyGwn2l2eLWLdZxAV+FtcXOjHsppYIIxl0fAgk1aRNZ9wWJ2/AMCCI4UHpE9wqHQu5tu1TuFEZhAtPoR6gR4JaSAljZY1SubuE6paIUUJvGgCPB4lWZ5v+obTPIINrEoBOYXIqmDgdBr/RJhF9skasok/t7N9X4TI2pTDROhInv3WFf49reC5mS95gAslcNtb1QDwvnWVwlOlK09+05ZmIbMe/r5Zcb0QTuaH5LgKde1GY8q2hu6BNjPl4OZU/rE5OsDidA+ZGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Nov 2024 22:10:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20628 invoked by uid 111); 11 Nov 2024 22:10:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 17:10:01 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 17:09:59 -0500
From: Jeff King <peff@peff.net>
To: Simon Marchi <simon.marchi@efficios.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/difftool: intialize some hashmap variables
Message-ID: <20241111220959.GE5019@coredump.intra.peff.net>
References: <20241111162148.337375-1-simon.marchi@efficios.com>
 <20241111205453.GA5019@coredump.intra.peff.net>
 <09bf8815-320b-494a-87c4-34bb0df08595@efficios.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09bf8815-320b-494a-87c4-34bb0df08595@efficios.com>

On Mon, Nov 11, 2024 at 04:22:26PM -0500, Simon Marchi wrote:

> > The fix makes sense. I wondered if this had been broken for a long time,
> > and if so, how we managed not to notice it. But it looks like it is a
> > recent problem, via 7f795a1715 (builtin/difftool: plug several trivial
> > memory leaks, 2024-09-26).
> 
> Are there tests for this specific scenario (no diff between the two
> versions)?

Presumably not, or they'd have been segfaulting. ;) So it may be worth
adding some to t7800.

> > I'm not sure if zero-initialization is being a little too familiar with
> > the hashmap internals, though.
> 
> Up to you.  In other C projects I worked on, it was typical that
> zero-ing an object would get it in a valid initial empty state, properly
> handled by the destruction functions.  This way, a big struct containing
> other objects could be initialized simply by zero-ing it, without having
> to initialize each component explicitly.

We often follow that rule in git.git, too, but have been increasingly
moving to macro initializers. They make it easier if we ever need a
non-zero state as an invariant (e.g., STRBUF_INIT always points to a
dummy string). In this case, it does look like HASHMAP_INIT sets
do_count_items.

It's not a bug in your program since we still hashmap_init() over the
zero'd state, but it does feel a bit weird to me.

> Please let me know if you want a v2 or if you are just going to merge an
> updated version of this patch.

That's up to the maintainer. IMHO it's worth using HASHMAP_INIT, though,
and perhaps adding a test.

-Peff

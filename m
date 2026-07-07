Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AB420867
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455198; cv=none; b=ZLWGsHCD+ttTlyuLpQb35rgHilNeAWXwlU4kasPOrFha+My1fSEEB7CpXLlt4xFrpENFLFkKEMRyrnyfyiNm9Dn0VG/j4ao4T0FgYqZemOi4GC8mg83nEc9Tcf33r3uEEF3mesBrBruhNXP4DWb4CqB8jRicSL7xFMReS0NDQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455198; c=relaxed/simple;
	bh=qlccupxXuiN4APzupC0zdnzbcpWhxnBeK4kfHl5rqRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn7yhvyfNrWmsQ9HJ4SfMW4t2SsFwxGqesO207QKh5ZKzXDQmsp4yMq+o6hDUOhT9LyKo5ES3UEk0fg+cafD7CVg9CLPeDHzCjcYOqEP8+LNF81HcxTTFxL3FPnuPre1oyK1ufL4YrH4mI8DzzBlkx3/Zg1dnbJYGH2nYVu808o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bF8DE7yX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bF8DE7yX"
Received: (qmail 22810 invoked by uid 106); 7 Jul 2026 20:13:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qlccupxXuiN4APzupC0zdnzbcpWhxnBeK4kfHl5rqRc=; b=bF8DE7yXLdpP/1Ru7eFk1+2axYl5mpbpQXRmz3RwY3lo0pQ/eM5CeQkKIM0oE+TBzRm5pHqcqkxcgROQ3MwpTfIM/suEJNFXLn/dHDOhtAjjpjmmkEOScgVN2vhMzov3oAYQ6w808lrcfVRqnnG+/MMdQm7cMC5kpU6C2z74Pg2YmGvU5awzq2IvTSTDv8HRq6/ofB+sHrktX//4DIZMYwGe0ZVUFAbzHPHUT7qq83BovPnuf0EgwLd/hy0zpjXY5Z9htEgvE6VBwwsN4XHNoSbCL9zmaRnxs9JDOAEGHtF2MxE4IpuyqG3VA3m1rPofWQplNl6OBBLJu5B9ysKTBQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 20:13:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34207 invoked by uid 111); 7 Jul 2026 20:13:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 16:13:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 16:13:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/7] hash: use git_hash_init() consistently
Message-ID: <20260707201315.GC11780@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050141.GA1288294@coredump.intra.peff.net>
 <xmqq5x2q984j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x2q984j.fsf@gitster.g>

On Tue, Jul 07, 2026 at 07:39:24AM -0700, Junio C Hamano wrote:

> > diff --git a/object-file.c b/object-file.c
> > index e3c68cfb66..f292683c2d 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > ...
> > -	algo->init_fn(c);
> > -	if (compat && compat_c)
> > -		compat->init_fn(compat_c);
> > +	git_hash_init(c, algo);
> > +	if (compat && compat_c) {
> > +		git_hash_init(compat_c, compat);
> > +	}
> 
> For example, it is a mystery how Coccinelle decided to add a pair of
> braces around this single statement.  It should be obvious that the
> corresponding single statement in the original did not need one.

Yeah, I noticed that coccinelle was eager to add braces in a few cases,
but I'm not sure why.

I had actually removed them, but either I missed these two, or more
likely I ended up re-applying the semantic patch a final time before
committing (I did a lot of "reset --hard; make hash.cocci.patch && git
apply hash.cocci.patch" while testing various refactors of the patch
itself).

I'll drop them in v2. Thanks for reading carefully.

-Peff

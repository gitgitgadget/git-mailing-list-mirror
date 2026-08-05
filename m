Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88635298CAB
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893121; cv=none; b=lb3StA81X+VVNU6MkJCOQwuflRgq5WKAv0xMQ1H4bvVQBwK8ZYXfW2Com+GXSBfrKVTuYFhEMGJ4meDIcfS2pJ53663dYU6l+JW7+KFuuGBBH6ruwoVpV8CrupRpss6SjGqql8xLH4pQXNVZOvxaRhGqugX+sNZTl/r+KppGt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893121; c=relaxed/simple;
	bh=mWo2eDOS3jTXqde1CpkMQNxm8hZaCgUXLZ2dNOsKwP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THduoCDsabqc2h20m8EIq6pZ5eXgp1AE5OgOhE5b9EXSTvEhpRsslT8E8WsMzdcREL8pVBPZejDI2cQ9LQcIYWhGqfK819Zd2+/KnGflLl5rhKv/quLZ/C0BgJa0uDHNqfg/UlArcfBU+N2/dCN7254Zd4FjbLAHf6cdBpv5jHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DBSQ2cuV; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DBSQ2cuV"
Received: (qmail 46975 invoked by uid 106); 5 Aug 2026 01:18:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mWo2eDOS3jTXqde1CpkMQNxm8hZaCgUXLZ2dNOsKwP4=; b=DBSQ2cuVXG1SZ09qgHesuuP7lPyS0/bNSqgi75t37eQEwT9P+Mqs0fnAxxUVkeFjr284MFS3tNoy7vWv6pFnkwQkD7mehvcRLgsFRLa+lvozOzQnQ+30Dm2noRLG5HAP9yQG9KwIdOStPtgh4bMSok9At+6B2KWC8gZOnxvxMHoR0D22Zh/X0bFYiHnKSvpItjlMoi9W7L7wOR9vM+GBgcUSuGoBIm9HhSr8fWviyho/nGVTzmlIyGWip5SYcFyI5OeshwstSTOJQV6QX5y7fnesdxLtKGBdf9zP9/hS4CLk5hn07rFriilCV/+b6p4qJqq55inrXICkBI+7H9WXng==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Aug 2026 01:18:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 69334 invoked by uid 111); 5 Aug 2026 01:18:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2026 21:18:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Aug 2026 21:18:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Message-ID: <20260805011835.GA954960@coredump.intra.peff.net>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
 <87a4rp1l65.fsf@emacs.iotcl.com>
 <20260718081407.GC22588@coredump.intra.peff.net>
 <xmqqzez1sf3m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzez1sf3m.fsf@gitster.g>

On Tue, Aug 04, 2026 at 03:19:57PM -0700, Junio C Hamano wrote:

> > It's mostly academic, as both of the pointers (if not NULL) would always
> > point to the same setting that ultimately come from the repository
> > object. But it feels cleaner for them to keep their own pointers,
> > because that pointer may also signal "do we have usable bloom filters".
> > We are a little lucky in dodging a bug here: last-modified uses the
> > pointer for that purpose, but if revision.c did so also, they'd
> > conflict.
> >
> >   Side note: this is really a repository property, so it would be nice
> >   if we could just do:
> >
> >     repo_bloom_filter_contains(filter, &ent->key);
> >
> >   without managing the settings pointer ourselves at all. But the cost
> >   to fetch it from the graph linked list is not totally trivial, so we'd
> >   probably end up having to cache it somewhere. I don't know if that's
> >   worth it (plus last-modified would still have to keep a boolean
> >   somewhere to decide whether it is using bloom filters or not).
> 
> So what happened to this discussion?  Are we happy with the set of
> patches in v1 after all, or are we still thinking it over?

The bit quoted above is mostly quibbling about some refactoring, and I'd
be OK with or without my suggestion. But the "--show-trees" issue that
Taylor raised should be dealt with before moving the topic forward. I
think the next step is probably a re-roll from Toon with a preparatory
patch cleaning up the --show-trees output.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676C3DB315
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541484; cv=none; b=i9Xp2LTa5Lrr9Mu6+BxSQOcqjO0FZJ+ZgJ9wp0+VHeM0emZuCg4sHPP/y+s3S2OsKD+3896PuAayZGc9f2ESMsEchNea/gzaC7Y1KHM31BaYtBfU/AGBN1Rg7WiRyBUhyX/2MDulYaHbK5e0GXfPlvIAT4K7QQe8X/zjvA1bgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541484; c=relaxed/simple;
	bh=A0zxE7WOizNv9yaDDhGc749mqrT+LcTLYtvhg1NTpFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQq7O7CEg3I7tytHLmraF+Eg0Q5aWqMS0q1ilouHbrBYmiQrBVVWEr/F3CrZwq0yql3fJ4q5TrqdgP1WRu8DLhpAmKJTOHBzTBj2P6ccUglh6VmZ/ocnBmIdiOvZ69raCDb88aBRWlXmeLEplAJaxsdGtdBGYWOx92fQwpJ9P8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bgP9CpRH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bgP9CpRH"
Received: (qmail 82346 invoked by uid 106); 20 Jul 2026 09:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=A0zxE7WOizNv9yaDDhGc749mqrT+LcTLYtvhg1NTpFM=; b=bgP9CpRHUuUfa+XMftEKVkQA55DCm9YQMkISJLUGPyQHugxosS86HXGrxChcToOflOWYV0ibHKKc87Qk+4YAT4CF07edPxgW4mthFLNVjWf/UCT7HmEYR9aB1obuKe2lfy7HnMxXNs8RYeMV7IuygcWZ+/oEVyNmcjwkx2HlSgSw2bdwnamRvvAmrclU9WygDg96gs+DwkwV2uP8ZjZb/SQvavfVhCfMhrqN2OA9PtoNW2kjnfsjqYBEEKkm8B0RN/jzJkt/tVUMT9ZUUsiK1Bh0B8eEcpihuJCCFmM+g9KsncEfgemHqYroMp8pz4iJL9JQFiZEn2k9m9tQuvrhBQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2026 09:57:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19980 invoked by uid 111); 20 Jul 2026 09:57:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2026 05:57:54 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 20 Jul 2026 05:57:54 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] send-pack: introduce a `no-ref-delta` capability
Message-ID: <20260720095754.GB681989@coredump.intra.peff.net>
References: <alQ7U8TOWjhasaWk@com-79390>
 <20260714074506.GD4058320@coredump.intra.peff.net>
 <alaxDPps6mg32C0g@com-79390>
 <20260718090527.GA30873@coredump.intra.peff.net>
 <alvp8KsZPKqCyqma@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alvp8KsZPKqCyqma@com-79390>

On Sat, Jul 18, 2026 at 04:02:40PM -0500, Taylor Blau wrote:

> > The problem there is not REF_DELTA itself, but the fact that REF_DELTA
> > allows you to place a base after the delta which depends on it.
> 
> Exactly.
> 
> > If _that_ is your main concern, would it be worth a tighter capability
> > advertisement that insists that bases come before their deltas (if they
> > are in the pack at all)? We already generate packs that way by default,
> > and it would really just give the server a license to reject these
> > non-standard packs.
> 
> That would address the ordering problem, but is weaker than the format
> restriction this receiver wants. Even a backward REF_DELTA requires an
> OID-to-entry lookup, whereas the retained pack's reconstruction metadata
> is addressed by offset alone. Supporting that is possible, of course,
> but adds another way to locate a base.

Yeah, but I don't think it's that much more complicated. You are
collecting the oids of the stuff you index anyway (since that is the
point of indexing), so it is just a matter of storing that in a
searchable data structure.

But what _is_ more complicated is the data dependency. Imagine you have
a pool of workers waiting to do delta resolution and hash computations.
You want to hand off each new object entry you parse to one of the
workers. With OFS_DELTA you know where the base is immediately, and if
its resolution is still pending, you know which worker you handed it off
to. But with REF_DELTA, you don't know which worker is processing your
base until it has finished (since that's when it reports back the oid).

That might or might not matter depending on your caching strategy for
intermediate states. For example, if you're trying to maintain locality
in what you hand to a worker (so if you have a delta chain A-B-C, when
you find C you want to give it to the worker who computed B, because
they may have that intermediate result at hand).

I do think in general that the intermediate-state caching is going to be
the trickiest part of a streaming resolution, though. Even with just
OFS_DELTA, there is no way to know in a single pass that the object at
position N is worth keeping around because N+K is going to reference it,
and K can be arbitrarily large. With Git's pack-objects implementation,
you will generally see delta families grouped together, but that's not
guaranteed.

So I'm growing more convinced that asking the client not to send
REF_DELTAs might open up some more opportunities for optimizations, but:

  1. It would be neat if we could see those optimizations in git.git's
     receiving code. ;)

  2. Without seeing the whole scheme, I am still unclear on how some of
     these other complications aren't much worse/harder.

I don't think you're asking for a lot of support on the git.git side, so
in that sense I'm not really opposed. I'm just not excited about
carrying protocol additions that wouldn't be used by git.git itself,
especially if we later find that the capability isn't a perfect match
for the optimizations we want to make.

-Peff

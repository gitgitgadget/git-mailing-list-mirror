Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978133C53F
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863933; cv=none; b=pugB9At0tCfch8r/z7GAg7AEIWp0nuItFyzTqZoSy8M/yi7Kncjh5Vrmibc5x8bcgrR/1skvRip0iOGrqapVUWbdZFjqRj1TtWLzktOHruLZ4DCAf5X++wQputO+SzxV7XQ6xV0EC8J/+MCFLYboOXiIg0U83dFoNc/naApxU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863933; c=relaxed/simple;
	bh=LViI6GGgf9rbv0stPaLpXUeTMtlXJ9tcdLXwhm4gpMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnciEtxYp4jJXtXwFYxKOQz+kaqf6oAIHtDf2SRiGUoIlcs5uiljoVbvgKMn0PAHf61Cwq/BDzq305v5aYl+ihlZBzOTYDldZUf4LFunWLjmn0R1nVKZZpC8S5XAJQVudrSyM8i5Yyexme0FCD1Qwd27aL0pSKMT6kOYuUAT6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zug+KtVF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zug+KtVF"
Received: (qmail 74614 invoked by uid 106); 30 Jun 2026 23:58:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LViI6GGgf9rbv0stPaLpXUeTMtlXJ9tcdLXwhm4gpMA=; b=Zug+KtVFHYRV6BqzHYPuJxlH3efdTIxkkylXAh2W606Gx1oiVIsjUJOcIskLZhCO4ecqcG3rCBQet8qwRQ2K1ot9zTixcn2rfhNxTu8crKlRWkbD2x73JOpkxGUiya0Sy6ESvmWz+t/oasnKEmx1VhHgYG16UOIH44MRsVLxCxQDM3ZeLGX7znEBviD4MkTFMd0EHO0Bby6rmtOSZkL9H/WnlwVPPUsewzaJcgLaecBtdT0CoS81WUfyRMZPjzhCELW86VZtaso+1XS/eE1SDvDrCu9wy+ZYiWcG1JaVbIftXkzJch83/vI4wAkFj3eeJyxDBUW5+35ZY3mVlC1Wsw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 23:58:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153464 invoked by uid 111); 30 Jun 2026 23:58:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 19:58:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 19:58:50 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551: pack
 refs after creating many tags
Message-ID: <20260630235850.GB3759976@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
 <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net>
 <akOG0oMu2KTqqyW7@pks.im>
 <20260630234702.GA3759976@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630234702.GA3759976@coredump.intra.peff.net>

On Tue, Jun 30, 2026 at 07:47:02PM -0400, Jeff King wrote:

> There was one other oddity I didn't quite resolve. You may notice the
> gross reftable.orig stuff in hyperfine. I originally wrote this as:
> 
>     git for-each-ref --format="delete %(refname)" | git update-ref --stdin
> 
> but for some reason that causes the subsequent update-ref to loop
> infinitely on merged_iter_next_entry(). It does so reliably, but I can't
> reproduce it outside of hyperfine. Super weird, and I'm sure I'm missing
> something obvious.

Ah, maybe not infinite, but probably quadratic. The key is that you have
to delete a lot of refs and then try to insert them again. So with this
script:

  nr=$1; shift
  rm -rf .git
  
  git init --ref-format=reftable
  blob=$(echo foo | git hash-object -w --stdin)
  seq -f "create refs/tags/foo-%g $blob" $nr >input
  git update-ref --stdin <input
  git for-each-ref --format="delete %(refname)" | git update-ref --stdin
  time git update-ref --stdin <input

I get results like this:

  nr   | runtime
  ------------
  1000 | 0.125s
  2000 | 0.454s
  4000 | 1.811s
  8000 | 7.091s

So for every doubling of the input size, the runtime quadruples. I guess
it is iterating through some deleted tombstone entries, but I'm not sure
why.

That's probably a more interesting and productive performance problem to
work on than micro-optimizing out the last few microseconds of writing. :)

-Peff

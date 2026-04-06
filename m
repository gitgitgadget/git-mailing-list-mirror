Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C01EF09B
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506021; cv=none; b=ngUMukpTEjIP/ZCMuCji+bfXlN9xApl+INbnpTf6ET9B3E1tVGXTuLQiXG89XTC+08vdHkwp2GIBRSi+GuzhPLUwPREG/JjYJeSMKg9kDJTi8GhiAquC4908+GgZkvKX7xQwYFHdJeIyg5J02rcROsMvJFNA7mPXIR1sy1+rpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506021; c=relaxed/simple;
	bh=YMrTAsZAUKbm1BeAQnL2jkNTgFuGvt1UIi+55DswauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEc7yIKusY/vLaPdHzqhOWXtHl9lj0YvHqOoTulZDq16YcRvwR7WHBMMY4iw5JatRGGLa/KZOGyW3aUlUuBfoW1bwivHJETcygzsKbh+Q0BMNhAHRWYQE2JgwiaOURwaFSUkJ+IVAjWh0iy1bHINwxPu7LsXmWTxYZ+9dkjnbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KWe8XRFU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KWe8XRFU"
Received: (qmail 265357 invoked by uid 106); 6 Apr 2026 20:06:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YMrTAsZAUKbm1BeAQnL2jkNTgFuGvt1UIi+55DswauE=; b=KWe8XRFUyVJKO2m1Fite8yfYHyi4pVFEIys20GTDNdJzNLoU8jAAWgO8BefHe2BzaDikediW/TckQZ5dYObZ5R2a628/ilodSrcVlwvlyZfg3g5ncYuNfRgmzNDomKP/j/1CLrbhEsbRC7Xdl26kK9RXobPfGhjcX2c2Eb8SuZQDWDj1S17SRDCMhHxs/NapncZG3AxOBaIETlD/ArfxVnseEbRlAVvWL9kSU+YkPwaKNz9AcPHDKFXPzYJ6774cdRVZL916qMPoqQ0mvrrWYjJOrI6CPzBPTqRGBHIgLEsLrkytgyJtbXUEHtKnlNMfVncum1+GlL/8ArYo7TtnUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Apr 2026 20:06:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 434484 invoked by uid 111); 6 Apr 2026 20:06:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2026 16:06:51 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Apr 2026 16:06:51 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, git@vger.kernel.org,
	cat@malon.dev
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
Message-ID: <20260406200651.GA26091@coredump.intra.peff.net>
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
 <20260405064651.GA1452907@coredump.intra.peff.net>
 <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>
 <20260405191750.GA1525850@coredump.intra.peff.net>
 <adP0hnV7Gl08qqqf@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adP0hnV7Gl08qqqf@denethor>

On Mon, Apr 06, 2026 at 01:17:17PM -0500, Justin Tobler wrote:

> On 26/04/05 03:17PM, Jeff King wrote:
> > But I think the actual code change in your patch is the wrong thing, so
> > I also don't think we'd want to just squash that test in. I'm hoping
> > Justin has some insights on how to do a more complete fix.
> 
> I agree with Peff here that the correct fix should continue to use the
> object streaming mechanisms. To avoid this segfault, we really should
> avoid using ODB transactions when there isn't an ODB in the first place.
> 
> I replied in another thread[1] with how we could go about fixing. To
> summarize, it just so happens that I already have a patch[2] out on the
> list that appears to resolve this issue.
> 
> For the use case here, git-diff(1) is only interested in generating the
> hash for the "large" blobs and not actually writing anything to the ODB.
> This patch introduces a separate "hash-only" variant of
> `index_blob_packfile_transaction()` and is used to bypass creating an
> ODB transaction when object writes are not needed.
> 
> If this is the route we want to go down, I can extract this patch from
> the current series and send it as a separate fix. :)

Yeah, I think this is a good path forward. I took a look at making the
transaction begin/end conditional, but that's not nearly enough anymore.
The transaction object stores state which is used under the hood by
index_blob_packfile_transaction(). So we'd really need some kind of fake
noop transaction that understands how to stream.

Just having the caller divert to a "hash this without having an odb"
interface is way simpler (especially since this is the only spot that
needs it, so we are only paying the price once either way).

I gave a cursory look at the patch you linked. For a maint fix like this
I think we could probably slim it down a bit: introduce the new
hash-only helper but _don't_ actually rip flag support out of
index_blob_packfile_transaction(), so we know that we can't accidentally
break it. Though maybe that is being overly cautious; it only has one
caller, and that caller would no longer be passing in any meaningful
flags.

-Peff

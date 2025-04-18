Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D53155C82
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970570; cv=none; b=F22ijS01S5E3NdJlWCZ5PahewvTkERjft3VfjrVY+qK+ElhYrVzHPwdA7aecGSbpPmH0sqIlwQOW2n9MvXtZUlIdQjvwTVq61oNIIGe2PFLnnzAK/C5dOa8eCJJ4UG0BzE8fFo9QmsjZgXNx60JwNbuIIWYu+qUNd9bZXsYWtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970570; c=relaxed/simple;
	bh=URqpJkE/fteXn+XMQ6QiBaOgvdvkXDp7Z3C569YFldM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs9Ej+GsqZx59HnxW/3kx29mIlV7/OdtQKKqTxjXg/MS3dcdSOo1Mw4RHQhedzUUBF2ufEbVluOWwl004Lde9KinO8UWSp4JJA4PQHo3m6elP+22PAg9ACU+sBcAnVxQEeWJ/q0TGRW45Be+i4HrF3WSi8M/Tp7mij769Kaz9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Rjm59Kyn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Rjm59Kyn"
Received: (qmail 16528 invoked by uid 109); 18 Apr 2025 10:02:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=URqpJkE/fteXn+XMQ6QiBaOgvdvkXDp7Z3C569YFldM=; b=Rjm59KynyAqB/3rKughSkdcxNT2zOXoY/tHg5KChbD0vfHpB3/hzAHJ2fDbls4x/bovTXPyrkA6PLPTN+Fn9Jcu7B6LXW3OyIib+B6EQnt1mJGs1ageJhLYT/IUTefQrs9qlk7wPHpjFwcA08O2017+NYbNPrzaSVLX/EKaam36Y4vZe6WdtGQ4+ab013j+7YKAu/ShBQ/rW6bdzyXy72CdVBZQMRyu+qChLaFWObzgelyBTMF324vbHYLQtwjeZcid5Fua01UYi44ZuRSyiew3UHhgXuhPjbumFPsL8JQBwufeDvJYHJEQW4v7tZWLelPrxbT9jD9+fmTVQmbUmnQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Apr 2025 10:02:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31597 invoked by uid 111); 18 Apr 2025 10:02:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Apr 2025 06:02:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Apr 2025 06:02:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/4] t/perf: avoid testing bitmaps without lookup table
Message-ID: <20250418100246.GC10441@coredump.intra.peff.net>
References: <cover.1744924321.git.me@ttaylorr.com>
 <8cc5952e594b78ffb2ba4bcaabd62a8e5b8fe72a.1744924321.git.me@ttaylorr.com>
 <xmqqcydae8fg.fsf@gitster.g>
 <xmqqzfgeaygh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfgeaygh.fsf@gitster.g>

On Thu, Apr 17, 2025 at 09:24:46PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I somehow have a feeling that removal of these "performance" tests
> > is less worrysome than removing correctness tests, but as long as we
> > claim to support both configurations (i.e. with and without lookup
> > tables), it feels a bit premature to remove tests for one of them.
> 
> In case the implication was missed, I was hinting that in the longer
> term, once one variant proves to be better than the other variant(s)
> in any and all aspects, it would be a great move to remove the other
> one(s).  It is exactly what is happening on the recursive-ort front.
> 
> Once we become so confident about correctness and performance with
> the configuration with lookup tables that we are willing to lose an
> escape hatch to operate without them, we can obviously remove these
> tests for configuration without lookup tables.  If we are not there
> yet, and still rely on the "escape hatch" value of the configuration
> that does not use the lookup tables, we want to make sure that the
> escape hatch still functions, right ;-)?

I think the perf tests differ from the correctness tests in that a
single run is not all that interesting. You can see how long something
takes, but that's meaningless without a baseline.

The interesting results come from comparing two versions. So in this
case:

  - running the simplified test script comparing an old version (where
    lookup tables were not the default) with one where they are (i.e.,
    one with the first patch from this series). That will show off the
    perf improvement from the lookup tables (and in a better way than
    the original, because we'll actually compute the time difference
    between the two versions, rather than showing them as separate lines
    which the perf suite does not realize are related).

  - going forward, comparing two "new" versions will show us if the
    operations regress in performance, using config both from Git's
    defaults but also the repo.

    So most of the time, you'd be testing the default case, where we do
    generate the lookup tables (because they're now the default). But if
    you have a particular repo or config setup you care about, you can
    provide a repo with pack.writeBitmapLookupTable set as you like.

That does create a blind spot if no developers running the perf suite
ever do the "you can provide..." step. But I think that is the tip of
the iceberg in terms of repo and config blind spots in the perf suite.
There are so many possible combinations, and it's expensive to test them
all. I don't think we have any particular reason to think that the
non-lookup-table code path would significantly regress in performance.

You asked earlier how much these tests cost to run. It's basically
doubling the cost of each script, since we're running everything twice.
So p5310 using linux.git, for instance, just took ~10 minutes after this
patch. And that's with PERF_REPEAT_COUNT set to 1! The default would
have been 30 minutes (and thus prior to this patch, 60 minutes total).

That's a lot of minutes.

-Peff

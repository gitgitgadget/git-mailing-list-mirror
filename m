Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2017C79
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944061; cv=none; b=etLaLvIsx6pXQmJNHa3/e3AnaDe8Wn4N60sboO754nnJSpZfn8kY3WknMLHJ0jgoLgyJaJ2DsD/LW1nCYhTHBAQMqnPAuG+5Mmw5CrH6crHTSW50w33KvpfqDR+bsHO2Oxh+5jSKNFz8SGLwWYQ7dJPkeggUl/f22lNNBeHCr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944061; c=relaxed/simple;
	bh=GdR4moFLkC+1HmtlzzsoT1g0yhfba1WqU11IHLyrntM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQD4zf3kcuwqcZsoAr69JnLp57iOvnWRTuHptgl5qPwzYGep0Ed3FsNMvy/peM+M5BCsn+yNSsp3QWYITSEmVBRobLAR6WGluaYB/8fn/7/WPYBbpmO9UCXg0oBKSlpILFyujPIvGmLYUvbnavgIhKmCh8x6+llUa4fUxwF8b3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RKCZMoEb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RKCZMoEb"
Received: (qmail 17461 invoked by uid 109); 7 Nov 2024 01:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GdR4moFLkC+1HmtlzzsoT1g0yhfba1WqU11IHLyrntM=; b=RKCZMoEbDu8oKxXK1mbYQwYbcYpilhEx3/7MhrntZUgRaXmt28DUvY6LpQpieGDmtvjVehAmImV9DVtRoyWaWLO+GdEaMu80p1krwLa+BIbqG8rVYps+K3bR1jUMzGwp8HbkCGnbr+tUKOrZvfKosBNNx0AI9ZSYZA4P7MV5M+G317ogQ0WeXH/0suLwfRkRdADtv9tDssGp5UHEm7+k9cMF45NlCk5xoBY6Fmo3LiArWizve3UTC1izFmX/F7f37F9fO6KSalIRHxbN2lAaDtwSPVvpAGQv8beAE4VwTckdth0NolEnhmBS2K375OXyPUY9kcRA+I6X47+g5xOI3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Nov 2024 01:47:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10277 invoked by uid 111); 7 Nov 2024 01:47:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 20:47:37 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 20:47:37 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <20241107014737.GB961214@coredump.intra.peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1730833506.git.me@ttaylorr.com>

On Tue, Nov 05, 2024 at 02:05:10PM -0500, Taylor Blau wrote:

> This series implements a new 'sha1-unsafe' test helper, similar to
> 't/helper/test-tool sha1'.
> 
> I have found such a helper to be really handy when debugging the new
> SHA1_UNSAFE build knobs, e.g., to easily compare the performance of the
> safe versus unsafe routines, different unsafe variants, etc.
> 
> The first patch prepares us by setting up the existing cmd_hash_impl()
> function to be able to conditionally use the unsafe variant. The final
> patch introduces a new 'sha1-unsafe' test helper which calls the new
> variant.

I think this is a useful thing to have, and I didn't see anything wrong
in the implementation. I did notice some oddities that existed before
your series:

  1. Why do we have "test-tool sha256" at all? Nobody in the test suite
     calls it. It feels like the whole test-sha1/sha256/hash split is
     overly complicated. A single "test-tool hash" seems like it would
     be simpler, and it could take an "--algo" parameter (and an
     "--unsafe" one). I guess in the end we end up with the same options
     ,but the proliferation of top-level test-tool commands seems ugly
     to me (likewise "sha1_is_sha1dc").

  2. You modified test-sha1.sh, but I've wondered if we should just
     delete that script. It is not ever invoked in the test suite AFAIK.
     If we want correctness tests, they should go into a real t[0-9]*.sh
     script (though one imagines we exercise the sha1 code quite a lot
     in the rest of the tests). And it starts with a weird ad-hoc
     performance test that doesn't really tell us much. A t/perf test
     would be better (if it is even worth measuring at all).

So I dunno. None of those are the fault of your series, but it is piling
on yet another test-tool command.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB213D296
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461665; cv=none; b=lx5j3XHCf34qYiGQmYKXVNOzItYEbwn/f+f3cJqHS4H0E/KmCFP0DerJnTNz/2hZ6+SXwmj/MFlRvEmOFwHcPDOcGlPd2/Rc+i+QgOU5fCXzMZmyeKZ8FZEr+pM4Eyk3o7EpW96GLExFBlwqM8qiHaWZOuurgNkFFpCIz8MWpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461665; c=relaxed/simple;
	bh=lQ+v3woZAgzk0TI+yofbVV0po3hgUF5WocUjv8+UHEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2zh4oEop0S8Ps9ZNoruaA5rQZGeRUZJCt6n6Ogvr+rcQM6R5ntxGzaIGQpuTpS0/vvSOIky4bJ/po6/0WHRA8fMbWiSpV/S2Q3bihTY7nTwlLx2g1t/qsjouN1in6Rwvtb3N3lvBe8qVVcnB24qICzNok9XZDmpB5k3/nP3XAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31379 invoked by uid 109); 23 May 2024 10:54:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 10:54:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29340 invoked by uid 111); 23 May 2024 10:54:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 06:54:28 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 06:54:22 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 30/30] t/perf: implement performace tests for
 pseudo-merge bitmaps
Message-ID: <20240523105422.GF1308330@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <6a6d88fa512ba344543f5f0df33d5a61e406f3db.1716318089.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a6d88fa512ba344543f5f0df33d5a61e406f3db.1716318089.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:03:17PM -0400, Taylor Blau wrote:

> Implement a straightforward performance test demonstrating the benefit
> of pseudo-merge bitmaps by measuring how long it takes to count
> reachable objects in a few different scenarios:
> 
>   - without bitmaps, to demonstrate a reasonable baseline
>   - with bitmaps, but without pseudo-merges
>   - with bitmaps and pseudo-merges
> 
> Results from running this test on git.git are as follows:
> 
>     Test                                                                this tree
>     -----------------------------------------------------------------------------------
>     5333.2: git rev-list --count --all --objects (no bitmaps)           3.46(3.37+0.09)
>     5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.13(0.11+0.01)
>     5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)

That's not a very exciting result. I have a feeling that your git.git is
not a very interesting test case. We'd want a lot of refs, and ones that
are old and have bushy history that is not included in the more recent
branches. So something like a bunch of old unmerged pull request heads,
for example. ;) Do you have more interesting numbers for something like
that?

-Peff

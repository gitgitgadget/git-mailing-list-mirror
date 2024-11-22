Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20813AA38
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264089; cv=none; b=MyQdD79dGtjpVi0mZXQIEzrh5yp6cuNNgy1ERUD0Xa5OM6scLTBkOg/6m04uLN/uZHziZzS9ggY4Ii2dbXNuNsDqQWfkgvNSrZbiirNDh19HfhcxtFlsfZsnk85Q/oGybJKFNmlJQJbmKez7yTu8WJG+vOissortmh0j8qgbR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264089; c=relaxed/simple;
	bh=7AvK7v3NtLug/pQYlMvExQNdVc7duR4Op0BBmT6kOew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdg7ju13HBxOIoUauTS/DaNch+BAA+MCmBLn64sXEqhrJqH8X7ds4+31XWdFlXreQqXMkHb5hlPvJ35s3F4IRo93/wAo1ZZUoVYR85goPyF5x+sOKn9GeCR7td3jNXWKgMybqmBQAdBq8UqZUGO4RPwxdj1rUrzRYLbr5HBMVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RqwGCkXm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RqwGCkXm"
Received: (qmail 10093 invoked by uid 109); 22 Nov 2024 08:28:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7AvK7v3NtLug/pQYlMvExQNdVc7duR4Op0BBmT6kOew=; b=RqwGCkXmv+acBuyxmHQGc/WBVrREkMeRo/smsSEJHJSCdic6BLk38vqb40gfTzQD2Dbmw9gv9SXUzEAGdAZLvMgCdTIlAdouHnjT9t92uQPMZ0bt3AU6viNyVMDpgXBV/GKNkATJDnfStygtvRTZnxzx6WCt2zyvc4MlQE3dA4c0nDVszUL/S6JPx0Jrw80YDJ/oqEnkHVEkxpvLa2291qlhERuqAJ0k+EsAXR5NTigopBnBJGfJGKAhAx1OuF58t3OUW2Mf4VJ4Nzy3rHiOpQHSX12mU75YE/D34T9nsWJxQpDJZznDoH4CrQK3P5Z/SnA/veX8//EgRAkxb0Xrxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Nov 2024 08:28:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1729 invoked by uid 111); 22 Nov 2024 08:28:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2024 03:28:10 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Nov 2024 03:28:05 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] t/perf: use 'test_file_size' in more places
Message-ID: <20241122082805.GC1179306@coredump.intra.peff.net>
References: <50c1368630684f235548d2e9a68d4de3745b5fe6.1732220875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50c1368630684f235548d2e9a68d4de3745b5fe6.1732220875.git.me@ttaylorr.com>

On Thu, Nov 21, 2024 at 03:29:24PM -0500, Taylor Blau wrote:

> The perf test suite prefers to use test_file_size over 'wc -c' when
> inside of a test_size block. One advantage is that accidentally writign
> "wc -c file" (instead of "wc -c <file") does not inadvertently break the
> tests (since the former will include the filename in the output of wc).

The use of "prefers" here confused me, because I did not think we used
test_file_size at all yet. I am certainly OK with arguing that we
should, but I was just confused on first read. Maybe you mean "s/perf//"?

Also, s/writign/writing/.

> I noticed while reviewing Stolee's --full-name-hash series that he added
> new test_size tests that use the test_file_size helper instead of "wc
> -c". I thought it would be good to clean up the existing uses of "wc -c"
> in the perf suite as a result, which is what this patch does.

Perhaps we should also touch the one in t/perf/README, which points
people using test_size to using "wc -c" in the first place?

-Peff

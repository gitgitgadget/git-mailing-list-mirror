Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03F183CB8
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508149; cv=none; b=XhvP2DKDjQAn94wdUMZgebVqK/Ng9RufaZZX0ofiTS+Sy97l+pH557v8nJH4rFplPwGKc7WqU1FqE9uK5xLOraWznoya+wMLixJSVSjwmLictmNBhZ/GN5sL8QycFiLGoh1hX0zpqmFVkSrixDqvdsx6pQ58fUGOIoIIzyW9Sq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508149; c=relaxed/simple;
	bh=u0b9sJIiNYhfHiAK9w7ZqfzqShHzgdvhFG63rn2TeNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkijOsQnH4NrJqlbCaiDAgJBDRtYTvUaR+Yvyo0ZTDYcpsOP9TGA1KW8NZkedRJDNE+55SCPTxMfApc7P3+JXf4buVjorFOy5rQNmwNKk3XQBza8ypeY25BeMgyh4wJ5hmVtDk6v3BGREvuTQ9TlMcy6jBqIxhx+hzo5UNwasBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19167 invoked by uid 109); 1 Aug 2024 10:29:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:29:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30674 invoked by uid 111); 1 Aug 2024 10:29:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:29:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:29:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] midx: teach `midx_fanout_add_midx_fanout()`
 about incremental MIDXs
Message-ID: <20240801102906.GN1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <594386da10bc3f3d6364916201438bf453b70098.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <594386da10bc3f3d6364916201438bf453b70098.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:38PM -0400, Taylor Blau wrote:

> The function `midx_fanout_add_midx_fanout()` is used to help construct
> the fanout table when generating a MIDX by reusing data from an existing
> MIDX.

I'm not sure I understand the original function enough to know if we're
doing the right thing. But I notice that after your series, we can only
get into midx_fanout_add_midx_fanout() if !ctx->incremental. So is this
code even used for an incremental midx?

Or is it used if we are writing a non-incremental midx, but trying to
reuse data from a chained one?

-Peff

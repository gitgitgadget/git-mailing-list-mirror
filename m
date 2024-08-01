Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE81607A5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506935; cv=none; b=bFjQxbkbRU4gOdccLe8woY0UzvwJaVnJmXeDaipem1ecCPgL2++o2uxqluV0jLlSeimVe0yQxKEph747u8kXrs0ABPyZQSnkbbRAQzcTtlcUFFmIVLbEnl6ULdRaiMq3CFN8RceaiVVSlkacqhEBThjzzkyA1Vv8iHU/bim3gVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506935; c=relaxed/simple;
	bh=A1hPuaoQ+vVIh4C0wcUeMxZyLrzclGJnG181qn74BI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzUwkqcFjmYmPcktFWE7zW4rhTWXGtK5CU9sC9fo+Ucf3ORMcArBZ9S9JjND0yAbi6BVdcaeDAIfE86Jl71kCN+2LUy828bhHd37WvEYC+YV+9NRnTWRfom1+Hw1yBdGE0jkRtQe4Yo68vpLwrj3VRgygFBLTuEshoZLoBA6bE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18944 invoked by uid 109); 1 Aug 2024 10:08:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:08:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30423 invoked by uid 111); 1 Aug 2024 10:08:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:08:57 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:08:52 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/19] midx: teach `nth_midxed_offset()` about
 incremental MIDXs
Message-ID: <20240801100852.GI1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <342ed560331d95fb0a1d86743dbb999ec7327313.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <342ed560331d95fb0a1d86743dbb999ec7327313.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:22PM -0400, Taylor Blau wrote:

> In a similar fashion as in previous commits, teach the function
> `nth_midxed_offset()` about incremental MIDXs.
> 
> The given object `pos` is used to find the containing MIDX, and
> translated back into a MIDX-local position by assigning the return value
> of `midx_for_object()` to it.

Makes sense.

> --- a/midx.c
> +++ b/midx.c
> @@ -368,6 +368,8 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
>  	const unsigned char *offset_data;
>  	uint32_t offset32;
>  
> +	pos = midx_for_object(&m, pos);
> +

"pos" reused again! :)

It certainly makes the diffs nicer to read.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31BF1990D9
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575348; cv=none; b=eMhKzHbb8QZr5MkiouA8nFdrYP8NZUw8wDDCspmA5qfkyYvxLnYPxM/2kulFOIq8Jq0LCI/hJiPgkrpGeCjxR+7xMfNUmlxvsbZNNugIQ2aud61bfcN2M5xQrn4amlGPEspJqPh2xTybOVZ73Z0CIh6X2cuRsGrB4/+0cO3VA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575348; c=relaxed/simple;
	bh=2M3wb+N/Csta7uDnes9VVozJgKLWotPIT+/3bpUz74E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csgni3m66L94vRcRQid9Mb1vRgqiwc+ihOj9x8dEsL+SAyIoHdQ2FXTxPxk7kyNfoYYe1jD56bWIl7GarV98+Fj95T0V5R0L2uwmD34PBCOEKsu+P0JHvg9N8/Av0YsGMAyI575m4ezrRRr8PhjQOkGrtSLuNhWDiT30WX2dwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E5xipBeW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E5xipBeW"
Received: (qmail 357674 invoked by uid 109); 27 Oct 2025 14:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2M3wb+N/Csta7uDnes9VVozJgKLWotPIT+/3bpUz74E=; b=E5xipBeWU2rrZowf5yNkW95A/9/Y2dFpKFAaG67kZTnMuOpgDgLo9jRFgQYrJjxBT0BjVskGfYxq9Vh6U52jCcIuW5FBeYo4PjPI87FxgDUb0MicQW+/G0KF0Je6QSTVp8Iw5iH2rARiNGnY3TvryDJOxfiVTKi9s+RvyFF+h4ox+DcAenBlZoql/rFeVwGLakDPp83+A2mXXQ+1EwTg5IsXVIgEDh+wt2pI+UXURLeunje7fvCgKpP23Vi27s/BWHvHMRQoGRssi/vD9sdJrD8KQ7jmxPuNX9YDuNvMGCfa31GTXobj2+dxf55MG53FAU6n9aIqocGWLajX0sbNPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Oct 2025 14:29:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 556307 invoked by uid 111); 27 Oct 2025 14:29:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Oct 2025 10:29:03 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Oct 2025 10:29:02 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <20251027142902.GB2758515@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
 <20251026152614.GB2095501@coredump.intra.peff.net>
 <xmqq7bwhmecb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bwhmecb.fsf@gitster.g>

On Sun, Oct 26, 2025 at 04:29:40PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also wonder how expensive that memcmp() is. ;) Obviously not very, but
> > if the point is that we are trying to save fnmatch from looking at that
> > one extra character, we already pinching pennies in a mostly
> > un-measurable way.
> 
> I added the "limit to known bad case" in the illustration not for
> performance but for correctness.  This was because just like we
> weren't convinced that the "**/" may be the only case that breaks
> the existing optimization, I was worried if stepping back by one
> byte may somehow make a pattern that should not match mistakenly
> match.

Hmm, I hadn't really considered that. This is mostly hand-waving, but it
feels unlikely to cause issues because we're giving fnmatch() more
context, and never less. We know that the stepped-back character matches
in the name and the pattern. So we are asking "o*bar" to match "obar"
instead of "*bar" to match "bar", which seems like it should never be a
bad thing unless there is a bug in fnmatch.

BTW, there was another bug mentioned in that original issue around
backslash handling. I didn't investigate it at all, though. It didn't
look like it would be related to this optimization, so I think we can
just consider this fix independently.

-Peff

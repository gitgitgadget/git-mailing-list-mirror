Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E86149C6F
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563506; cv=none; b=Hl/squEcjVcMcWrQBeE/B9xvMT4eySvtEHjbJ/SOnMLJ4Rr3tXNq8PF8nOvlBlQHEK45cL4LPV627rKW/7yz0adq3gJV0I1TjayZiKKjTToY/LmReDMr38vlzcdBsmo1DYFPhns76ptToHrRMBR1ndE4iqnq3p3DobQsAP1y8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563506; c=relaxed/simple;
	bh=vAY2XzMli3/KX8MX9GLKYcL92xw2G/JxkJy6bS5IvCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEETWtAaLe4dJOiGvKcty6+NSYDHu13l+i3Fm835n7h/VP2LoytikTHoZ7dOJ9yAFwZV2zsL8OuiQeqjjShbWNGGFls68MzkvEtj8VWjWtMlI+4ZJbfpg347JCAiOTPMq8lotwbYfpHHJUjVouwXsxTLTRx3a9MFMgOBNGu6Qjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RHCL4THz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RHCL4THz"
Received: (qmail 10132 invoked by uid 109); 11 Jan 2025 02:45:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vAY2XzMli3/KX8MX9GLKYcL92xw2G/JxkJy6bS5IvCM=; b=RHCL4THz1BRnzNg23RCBrT16b6DfvjmOnF7r61SdxigARLglh7Y8Q+soFglg1dT2YtzGHmoY1uADby/iHSPUCKDX643yAlhGPwxISUiZ2s26LfjAK4EtpuxI1Sfn5aW0PelErqqM9v0PQ0nUndO515vQAhycLX+2WHC8YtWeaGMg/jTVI3vGCxpEuUy3X+lp9Qk2t3xQG47c9cYW0y27lR4R1htizFvXxSMy2voOQ4KHAa4ONwv2SGIPrnJkS3PPeYMs4vaSXEHuY852TJa+5qZo0YwPf/OK8Ik2ev5bn5nW4llKfG4j6EOwWEwv48SoHXq6iJ2Q1NLv7tj+zytTog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Jan 2025 02:45:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16628 invoked by uid 111); 11 Jan 2025 02:45:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 21:45:02 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 21:45:02 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/6] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <20250111024502.GB590176@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>
 <20241121093731.GD602681@coredump.intra.peff.net>
 <Z4GTcKTVFOFmSsgO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4GTcKTVFOFmSsgO@nand.local>

On Fri, Jan 10, 2025 at 04:38:56PM -0500, Taylor Blau wrote:

> On Thu, Nov 21, 2024 at 04:37:31AM -0500, Jeff King wrote:
> > If we don't care about the speed of this function, then an
> > implementation like:
> >
> >   for (i = 0; i < GIT_HASH_NALGOS; i++) {
> > 	if (p == &hash_algos[i] || p == hash_algos[i]->unsafe)
> > 		return i;
> >   }
> >   return GIT_HASH_UNKNOWN;
> >
> > would work. I'm not sure if that would be measurable. I was surprised at
> > the number of places that hash_algo_by_ptr() is called. Many low-level
> > oid functions need it because we store the integer id there rather than
> > a direct pointer (so oidread(), oidclr(), oid_object_info_extended(),
> > and so on). But I'd also expect the loop above to be pretty fast. So I
> > dunno.
> 
> Concerns about the speed aside (I agree that the for loop is likely to
> be very fast, and will probably get unrolled by modern compilers), this
> looks good to me with one small tweak.

It should definitely be unrolled. The big change against the existing
code is that it has branches. But again, I'm not sure how much the
performance matters here (I would have naively said not at all, but it
does get called in lots of low-level spots).

> We can't use `hash_algos[i]->unsafe` directly it might be NULL, so the
> function as above would change the behavior of hash_algo_by_ptr()
> slightly when provided NULL (it would return SHA-256 instead of
> UNKNOWN).
> 
> So I think you'd want to write the loop like:
> 
>     size_t i;
> 
>     for (i = 0; i < GIT_HASH_NALGOS) {
>         const struct git_hash_algo *algop = &hash_algos[i];
> 
>         if (p == algop || (algop->unsafe && p == algop->unsafe))
>             return i;
>     }
> 
>     return GIT_HASH_UNKNOWN;

Yes, that works. Or maybe even just:

  if (!algop)
	return GIT_HASH_UNKNOWN;

at the top to cover the special case.

-Peff

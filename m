Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547601AB6DE
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757377; cv=none; b=M8nFUt6SU8DKYujoH3gyVtWQcFevtm/Oun2ZzAYzOGUzYoME+uu3mjCwhJjZoG1ZFH6twiF4/yllcsNNl8gGQdGEetdSsZjqsheGjFNf/i9+1FLgkirNfPf4vq/2RpIjRr5vgjWEDbh82EHimRnAeF8GxQ1ZYmdOeqm735ea+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757377; c=relaxed/simple;
	bh=xeULbtMm0J1Pe/ynE0yKgEVgO2tC3LNeqTN559GWPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1IUZwSLJN+89PVusl2Tjc7tBzj1ksKTk4HKazjaiO3yEAazEBuJVQ7FWqK8Uz0mb5tHaa20Ae+eH9jIyFoUewfG5Hrn4h7OmnFzx3wCHtLZ0Bdi+UmKJd4BSXNHqg8L3aQeAenMgl7d126/1gpTa6dvfZEj0G5dg3exE8a9xIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gT3ePzkf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gT3ePzkf"
Received: (qmail 27987 invoked by uid 109); 4 Apr 2025 09:02:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xeULbtMm0J1Pe/ynE0yKgEVgO2tC3LNeqTN559GWPcM=; b=gT3ePzkfGkqIEvTLAdeZg0cBdqf7DO9PpiJ85noQOd+0KZNgA8hozvjGcsCwdMLASxW1BdDkZWZgdptCLev9XTiXaLcO5ERqu816r08ktsyaQ5ocZARJ01l49UjGZN5BZKdYcb3kd5tQmsFwsty/8iRyyrfLgOc/2rlahJ6z2/zEaukx9eNt66Ax8prStliO+L3xvtYEwL2VPzCD8agjEGtxqpBh6bjpepMl4hfNmA2IPcJbmezzO/ZczmdOELSTnzykcH6nj1OxPJ/dAeLVPCRdin7laCOPS9HKluB3EEGP5r8e3SiSv3pcn90Jphb3c7JdXGrPMZCTR3yFQ3ky/w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Apr 2025 09:02:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2291 invoked by uid 111); 4 Apr 2025 09:02:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Apr 2025 05:02:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 4 Apr 2025 05:02:53 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: jk/zlib-inflate-fixes, was Re: What's cooking in git.git (Mar 2025,
 #07; Wed, 26)
Message-ID: <20250404090253.GB772404@coredump.intra.peff.net>
References: <xmqqiknwhsdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiknwhsdz.fsf@gitster.g>

On Wed, Mar 26, 2025 at 05:46:00AM -0700, Junio C Hamano wrote:

> * jk/zlib-inflate-fixes (2025-02-25) 10 commits
>  - unpack_loose_rest(): rewrite return handling for clarity
>  - unpack_loose_rest(): simplify error handling
>  - unpack_loose_rest(): never clean up zstream
>  - unpack_loose_rest(): avoid numeric comparison of zlib status
>  - unpack_loose_header(): avoid numeric comparison of zlib status
>  - git_inflate(): skip zlib_post_call() sanity check on Z_NEED_DICT
>  - unpack_loose_header(): fix infinite loop on broken zlib input
>  - unpack_loose_header(): report headers without NUL as "bad"
>  - unpack_loose_header(): simplify next_out assignment
>  - loose_object_info(): BUG() on inflating content with unknown type
> 
>  Fix our use of zlib corner cases.
> 
>  Still being discussed.
>  cf. <20250304065501.GB1283901@coredump.intra.peff.net>
>  source: <20250225062518.GA1293854@coredump.intra.peff.net>

I don't think there's any more discussion happening here. IMHO it is
ready for 'next'. The message you have in the cf. is about further
possible cleanups for cat-file, which I think are out of scope.

I think you and I also discussed getting rid of support for these
non-standard headers entirely, which would obsolete some of this work. I
think that's worth doing (and I started on some patches towards it), but
it would be a bigger change that breaks backwards compatibility. So I
think we'd want these fixes in the meantime.

-Peff

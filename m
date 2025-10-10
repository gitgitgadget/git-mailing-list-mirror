Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5922A4F1
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760075675; cv=none; b=cSioxAf9C0Fp/3YeSEQOTsDYP4ABeUqgJiXou3N/jMY5Xf3FBdn42kM3RDUhbA56y3ILR2BETyzt4aKRwFburMic+Kj5F2PIBQZQSGTYbQ8p10ur68dm6ji+04KmEGS528d5r1uP9Xt4VZtab7rw71JIatrN/D3Vlv+pFCYfqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760075675; c=relaxed/simple;
	bh=ON0spWzmRyXKyPbuv/LM7KLAyciGt5rbhRx7LMeKAlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYBpPPhW0K3XyFqdZv/lZeJDeCeIAPsDbRzOJwLfNwrC+hl5jPgnHweHQ3U90Mid4GDprwi0CUFl81DJiVXSyC9k28LyUp7csHP5++X91E6WQ1NK5R9T480PMREs3AL0YhZaG01kX1GE2F8dFd8HrjdhHfdDh8QmFV8JT5scIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SYRzOVxc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SYRzOVxc"
Received: (qmail 182285 invoked by uid 109); 10 Oct 2025 05:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ON0spWzmRyXKyPbuv/LM7KLAyciGt5rbhRx7LMeKAlg=; b=SYRzOVxccuCP7ELrZhsXVRdooSf/tR/UlK3cU9Q0hugGveQdDA2b2b+YffrIcAWD+1Fu8msoZhHlYdoZDx6su+vB2VbCk+nX7tXQG5hxbqxXe9F3jY28Qrd8WaRu1LKOU8QrQPYTbYJKt6dBnzFaTnhKyB9CvWnZgRcTVaYUmNYv7uWDjzMRJzzC9O/llvXcHoKmoU0dO10N2rCRm8xHm7TcMfizOuFDP3Hbh0Namf8hkTVd+z+2mZq6WdhUDrt2L9f+1LK31Kr6E/ZLsvItK22R5g177yVznSz8kIvWOhTsuFelKp8xlUU4EWb34Z9t16gpIKFaLuSMbnZtdpPdXw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:54:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283322 invoked by uid 111); 10 Oct 2025 05:54:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:54:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:54:31 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 13/49] repack: move 'delta_base_offset' to 'struct
 pack_objects_args'
Message-ID: <20251010055431.GE1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <06347b6ab23d5ab1d9a7945da67473b5b9e02ad1.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06347b6ab23d5ab1d9a7945da67473b5b9e02ad1.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:00PM -0400, Taylor Blau wrote:

> The static variable 'delta_base_offset' determines whether or not we
> pass the "--delta-base-offset" command-line argument when spawning
> pack-objects as a child process. Its introduction dates back to when
> repack was rewritten in C, all the way back in a1bbc6c017 (repack:
> rewrite the shell script in C, 2013-09-15).
> 
> 'struct pack_objects_args' was introduced much later on in 4571324b99
> (builtin/repack.c: allow configuring cruft pack generation, 2022-05-20),
> but did not move the 'delta_base_offset' variable.
> 
> Since the 'delta_base_offset' is a property of an individual
> pack-objects command, re-introduce that variable as a member of 'struct
> pack_objects_args', which will enable further code movement in the
> subsequent commits.

Hmm, OK. It is true that it is a property of a pack-objects invocation,
but would we ever want it to be different between the two? I'd think
not, and from what I can see:

> +		cruft_po_args.delta_base_offset = po_args.delta_base_offset;

we'd always use the same value in both cases. It kind of makes me wonder
if it should be in the repack_ctx variable instead, then, with both
pack-objects invocations pulling from a common source. But I could also
believe that makes life harder later on, when you want to pass just the
pack_objects_args to prepare_pack_objects().

So I dunno. Mainly I am worried about somehow forgetting to set the flag
in the right spot, but in practice there really is only place where it
needs to get pulled over from po_args to cruft_po_args.

-Peff

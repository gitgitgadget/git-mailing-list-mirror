Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF31D6193
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760076893; cv=none; b=t81m1/JyP9UslGTvR511qcoG1Q0sqS6PvkIw3ay28nuVh8PFKunRI3JQeKl4ixgUitTAXu0g6RFW7j1S9pHTVelnbg8KwoGFzgtwFD2OXtfiPQFno5s5ZPLJ5ImYxoxpEXApAdTRP0OkiYJRmpInfPS0xTKBzSdYgUEIoEIGsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760076893; c=relaxed/simple;
	bh=Da9SjQVEXAbPAr4LIZ9MRYyzcgbw9AnYht4w6PB8x2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EljZ1YVS3zIA6/SPfPb8cmRBMgcKEbZ8tCyxroFqG6wgQtkQkjch1gZspAOtUJj0HRsaqhD4qdF3F9jIVKz7Dnj7Wed47lswjWq70aVjOnX2fhBmZkcAH2Gye+W90zjoFoTWdNfv95uhtmAxPhsKCQqUf/wcyexCYSmQ5p1cPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DMvTINZe; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DMvTINZe"
Received: (qmail 182377 invoked by uid 109); 10 Oct 2025 06:14:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Da9SjQVEXAbPAr4LIZ9MRYyzcgbw9AnYht4w6PB8x2I=; b=DMvTINZe2SqfnV8t8a1dVlQyI8O7Ai2/h7I/jbJKovt1yqJxYXgERGCZEES4+UunrghgqpU0SIEGd/VtLFu3bQCQfzUXfV59OFI0lFpygLLNqQIwqtHxXPHazgimOpg3HbRqaCQgTeWMNMtzWeuu+Sko0HWgOXnJI6arWZswUYl9SwKIvtjrQCMm+1uEWSlqjOQC8fAZdLKjpfS0V0B6BbPL7lEfqfs5yqLT43I14FFTYIZ15ARMu5LJR3Ilg4Uz9vHwVFJ/da6/RJD5KSlhaZxBPBExg+IDjX9AI4yXaNTuACep7nByYs0usYKkWBXOKoQtDwRfGOt19fWdw9eo7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 06:14:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283551 invoked by uid 111); 10 Oct 2025 06:14:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 02:14:50 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 02:14:49 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 21/49] builtin/repack.c: factor our
 "generated_pack_install"
Message-ID: <20251010061449.GH1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <96d27261e75fd2ae46d9633b3d4eff243dbcc187.1759097191.git.me@ttaylorr.com>
 <aNsUiho56-S4MQZg@pks.im>
 <aOV3cuZhab7xOdez@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOV3cuZhab7xOdez@nand.local>

On Tue, Oct 07, 2025 at 04:26:26PM -0400, Taylor Blau wrote:

> > > +	for_each_string_list_item(item, &names)
> > > +		generated_pack_install((struct generated_pack *)item->util,
> >
> > This cast should be unnecessary, right? `item->util` is a void pointer,
> > so C should do the cast implicitly.
> 
> It's unnecessary, but I dislike implicit casts from 'void*' to any other
> type. This makes it clearer how we're supposed to interpret the value in
> item->util, but I'm happy to change it to use the implicit cast if you
> feel strongly about it.

I tend to avoid casts when possible, because they can mask unexpected
conversions. E.g., if item->util's type changed, your cast means we
would never notice it.

But that cuts both ways. If the prototype for generated_pack_install()
changes, it is only your cast that would tell the compiler that this
caller needs to be updated. Ultimately it is the spot that _sets_
item->util that needs to change, but hopefully flagging this spot would
point us in the right direction.

And that does seem more likely than item->util changing away from void.
(To be clear, I don't think either is that likely, I'm just musing on
whether casts like this are helpful in general).

-Peff

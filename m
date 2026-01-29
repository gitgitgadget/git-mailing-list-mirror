Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE038170D
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684923; cv=none; b=CkLwf2TcnezcDghdpSgMEz1jRHOvE4UoPfFijsUANjD5VCWr4tq/zwAM4JP5MeLeQdzWwoF06pn2qUS38n2wb/XgYw9Ba6Zqkljb4vwT2Nx7RKatahERSomUdRYe0JWBNaVj8fm+5vC532CPj6EJp2FJ4+d0LbsUdVMqXMmjUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684923; c=relaxed/simple;
	bh=EFwqeuOQE87dq1chVVmUiH43cX6Sp3mRjRvwXJfJglI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7ixlvJHEp4hj+G7/KymxlAykMcmgIGcesixb27/aFKlswMFmYAqdHQkh/uLIKg4zJ3F6YTuZvACZvghFbRi7thsUBCyII+uhM4lrXv4Rb9UZVCjQiHNGeMKVLqwOYbEB8HkFEXP3FqtO2OwRFGT1nAjaFSb/OqeVoTsjmdR5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=exj0N+pJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="exj0N+pJ"
Received: (qmail 209974 invoked by uid 109); 29 Jan 2026 11:08:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EFwqeuOQE87dq1chVVmUiH43cX6Sp3mRjRvwXJfJglI=; b=exj0N+pJcQ2RgGYrEJz6kD/6A16XvbkfU2PrPtvpjLGsrunYpBJ4IkLKuvFzSwNg6V3ZP9pMzWkPm6PGgl99jQQq0wr0U2qnhs4MXGQCJ/B6d5OagCthU4VoL3BYOX1Khj153HhMOlCrGCmHsb4xaqOFb9FbII6ZQmbFbrsK+DWQtKekOyGaxH5ZdpQyRDlcXQ1eteVJOaYVzgXDVez6VPaOkSxko4SE0pSy1mINaWk/53ugMUJE1weMp4dJn1z5MwABRBZALEuBFvDB3uJOpS9UmSVJnyAm3hsBVQs4WCJy50hcCL/hXVjKU4D9mkg9TyUplNFkd2gPeoAJtHtz+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jan 2026 11:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 400454 invoked by uid 111); 29 Jan 2026 11:08:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jan 2026 06:08:45 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Jan 2026 06:08:39 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Message-ID: <20260129110839.GA1285720@coredump.intra.peff.net>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>
 <aXLNM+AOpdQtmisC@nand.local>
 <aXNCtCZwP57Tfu60@pks.im>
 <aXO/YLzRlDXD5IPY@nand.local>
 <aXcrftLpfcG4S5AX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXcrftLpfcG4S5AX@pks.im>

On Mon, Jan 26, 2026 at 09:53:18AM +0100, Patrick Steinhardt wrote:

> > Yes, the end result is the same, both your patch and what I wrote here
> > implement the same GC-specific definition of an object's "mtime". I am
> > not following the argument about pluggability, though. The concern I
> > have above is that we are pushing domain-specific logic into the object
> > storage backend, not the other way around.
> 
> To expand on the pluggability bit: every time you add a new backend
> you'll have to extend the above logic to understand how it represents
> the mtime. That by itself might be doable, but let's for example
> consider a backend that is a black box to us (like a shared library that
> may plug in arbitrary storage logic). In that case you would not even be
> able to derive the information unless you have a generic layer that lets
> you convey it to the caller.
> 
> So overall I agree with you that there are nuances here, and that the
> mtimep pointer _can_ be used incorrectly. But I still think that the
> concept is generic enough across backends, and the refactored logic
> still works as extended. I'll try to expand the docs and commit message
> a bit to cover this discussion.

There's a related concept that I saw while reading some of the earlier
patches. When you converted fsck, I wondered how you would handle the
call to read_loose_object(), which takes an actual path. And it needs to
do so, because we want to make sure we are opening and reading that
particular copy of the object, and not one from elsewhere.

The answer is that you punted on it for this series, and we still get
the path via for_each_loose_file_in_source(). ;) That is OK, but I think
it will eventually run into the same issue: we will need some kind of
cursor or context for the iterator to be able to get extended
information about a particular copy of an object.

I think there are probably two approaches here:

  1. The abstract odb API tries to share as little as possible. It gives
     the caller back an opaque context struct, and that struct can be
     handed back to the odb to get object contents or other information
     (perhaps even an mtime!). Under the hood for the current odb
     implementation this is probably just a pointer to a string with the
     filesystem path for loose objects, and the usual packed_git/offset
     pair for packed objects.

  2. The odb API provides a set of information that a particular backend
     _might_ implement, and callers can poke at that information and
     decide how to handle it when it's not available. And so that might
     include a filesystem path for loose objects, which some backends
     may choose to leave NULL.

Option (1) presents a cleaner API for the odb, but it's also more
restrictive. Anything that a caller _might_ want to do has to be pushed
down into the API, and it has to start learning about things like
mtimes. And how to decide what "mtime" means for non-filesystem
backends.

Option (2) pushes more work onto the callers. They need to not only look
up the mtimes themselves (like they do now), but they have to decide how
to handle the case when no path is available. Which in the worst case
means a special case for each type of backend, though I think in
practice they'd probably fall into rough groups.

I think one thing that appeals to me about option 2, though, is that it
keeps a lot of the specialized "business logic" together in those
callers. Most code doesn't are about concepts like mtime or specific
copies of objects. But when it does, like in repack or fsck, there are
often subtle assumptions and interpretations. I'd rather see all of that
lumped together in the fsck code than have it split half-and-half
between them and the odb code (which is really going to be some backends
idea of how its concepts can be shoe-horned into the abstract API).

-Peff

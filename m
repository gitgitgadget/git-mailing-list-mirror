Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48C344046
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768371; cv=none; b=ii4b6jw5Oxw8UnK0kFlcR3RSJ4DNOkrmzBl6cX8HSk1MyJtqzmxS+F/h5BNSnTn8Xl73dR0zv2mHyfJIVWqfjDllKH/EuwSO1UdGuwBlxYji52clZ/69dqZTg4ELzRu8Q2TtTdaNvRDbo0Remx5iVVQi2hoTYfnZ/0MmgkajGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768371; c=relaxed/simple;
	bh=edZrhaaUIZYwbQnhWVI6+Zv8HK8bhDBbBwaFAe7mQCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHAx3uYldKsJBbiaeG11DKPVx+Rq2OMIycHJYNR5zO6GhwMJxydzgoq7u70XDlfSXoRGgX2azef/WFSw24I6hYUUFnog6kY+AmdYj6xvpWjzfrFszXUZYAHMHAzTzalXx39xK6XGTiMsPuyiTzracWPmab3nqnukUs/McBedmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QkoaVInR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QkoaVInR"
Received: (qmail 295061 invoked by uid 106); 9 Apr 2026 20:59:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=edZrhaaUIZYwbQnhWVI6+Zv8HK8bhDBbBwaFAe7mQCw=; b=QkoaVInRb8CtqrrNbneNCbqNvuvB4SD33MdZlHV59AN4abgMyhtspIgeGXnJkMeAWMHKhARncobfkw50ZXawv0MHgVomcVDLcvKtElOlpF9FDnFQ1sBCqZ4YGGtZurcHGYhJ2Xv/ZA9SZbZfXtLjdCUMot/4JszlgXHOLkLAtDBr60ZJHjNPK5uQJ9mFdYF0n8gtOxflm8dxoo6TbQ+VzPCxiZUDDbFtlr5uKWqF5NyuSnlMK2W8VfHaF4/5fNW6t3QZr3i+edzBfPVCbpUcx33VtNjeVtLFqxDNzKNOQR/w27ObiVWiZzGU0OYZONG3cvygmINb8JoX4TfZ64Ywkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Apr 2026 20:59:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 487804 invoked by uid 111); 9 Apr 2026 20:59:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2026 16:59:29 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Apr 2026 16:59:28 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
Message-ID: <20260409205928.GD3076846@coredump.intra.peff.net>
References: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
 <xmqqika0ultp.fsf@gitster.g>
 <20260409202329.GA3076846@coredump.intra.peff.net>
 <xmqq5x5zsw8r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x5zsw8r.fsf@gitster.g>

On Thu, Apr 09, 2026 at 01:40:36PM -0700, Junio C Hamano wrote:

> >> As the width of ssize_t in bits can be a lot smaller than size_t,
> >> the above "unsigned_add_overflows() triggers way too late for the
> >> check to matter, no?
> >
> > I think it is correct as-is.
> >
> > The real check against ssize_t is later, when we compare total_length to
> > MAX_IO_SIZE (which is clamped to SSIZE_MAX). So this is just making sure
> > we do not overflow size_t when counting up the total (and if we do, we
> > _know_ we are going to overflow ssize_t, which must be smaller).
> 
> But then what happens after it breaks out of the loop?  We cannot be
> at i==0, so let's say we have a reasonably small iov[0] and iov[1]
> that is so large and makes size_t wraparound.  We break out here,
> and then send the iov[0] with writev().  But have we checked if
> iov[0] is under MAX_IO_SIZE in that case before calling writev()?

I think so. Either:

  - We completed the first iteration of the loop successfully (and i >=
    1), in which case we added iov[0].iov_len to total_length, and then
    compared total_length against MAX_IO_SIZE, but did not break out of
    the loop. So we know iov[0] is within the limits.

  - We bailed at i==0 either because of addition overflow, or because of
    the MAX_IO_SIZE check. Either way, we will bail to xwrite() because
    i is 0.

-Peff

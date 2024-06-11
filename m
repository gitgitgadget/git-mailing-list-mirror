Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A92CCB7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097171; cv=none; b=ndYXRKtbXAFm1YvyOHVYjryRSXqIJ1xw5FI/5CTt2ebUux8kF02ILdSMDySqdnB3NjNVHPpqOuuiQfns5qpPM8hFEktR7B5aVSIvbZ8QOd9lRDQtJDFjWZtIWl1HcjvdbSNG6ZBaIWE0vUT8WD6BXbFTTLx1rG8a8mzxkjoPOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097171; c=relaxed/simple;
	bh=9Q4++Fd0Qp+UU5xjuDKjXWmYSTN9nh73Cb+x7K+3/Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUzWc1aFd/uLTuXcHH92Ngm5vOlI0KIlF4t1SmNoGAe8EU2y8S1RLhcO+rLvEM8HrqyHqDFhHTf2DlCKOg9oRbbG0wM+zBf7k7MPBD5NvhlmZJgw4Ek9kyiQJn+wyJdk/6aCcBppFAeNFN/HTOAI0Xo+X3dqRxt8D9XLDhScwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18799 invoked by uid 109); 11 Jun 2024 09:12:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 09:12:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25103 invoked by uid 111); 11 Jun 2024 09:12:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 05:12:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 05:12:48 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
Message-ID: <20240611091248.GA3264564@coredump.intra.peff.net>
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
 <20240608081855.GA2390433@coredump.intra.peff.net>
 <ZmXKzJ9CpbYTmTwC@nand.local>
 <xmqqmsnuaqus.fsf@gitster.g>
 <ZmYJ+d3+j1E08Ms/@nand.local>
 <ZmYPjuGnh+UvT5dt@nand.local>
 <20240611080220.GG3248245@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611080220.GG3248245@coredump.intra.peff.net>

On Tue, Jun 11, 2024 at 04:02:20AM -0400, Jeff King wrote:

> > So in short, I think the fix I posted above should be tracked down to
> > 'maint' at least for the 2.45.x series. It will avoid the MSan failures
> > and more importantly the issue I described above. I would also like to
> > find a way to further test this case so that we aren't bit by such a bug
> > in the future.
> 
> I don't think we can test the case where the bug would produce a bogus
> pack, since that implies guessing the uninitialized data. I guess we
> could come up with a case where try_partial_reuse() should say "this is
> OK to reuse", but the bogus pack_int_id prevents it. Which implies
> looking at the resulting pack and checking that some delta is there that
> we expect?

Ah, never mind. I see you worked up a test in the v2 patches you sent.

-Peff

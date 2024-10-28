Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AD18A943
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093599; cv=none; b=QPsaAlKkQ4wZoWuIdNJ3iXlUNrtp5TCs184QaMNzCtbs8llz5Vq/LJ+nKA11kV/SNVEOLRtzP0pQGvSvzW+M5WIt4+cIzCT2n6/b/NVw6wa00wqE8TPYvgMuoz0zp2P0q1L+jQBxq4Ry9Ij8nxE7evYUb5Azt6B1VCDliGh323c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093599; c=relaxed/simple;
	bh=AfAtzhGlhUzUKV53lk0IoDnLHA0R9pmu/5Y/2PoYuTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNCOjAagUuXQtuhOQC6+sO+KN/dzVZY9gIr2uOG3kgHoArHCJuLc4k/YpHtYThLtdF34HEzA3OqjKg5XYSBouwrJhPocOm56j7hurxYOd7InOxjpDyFTtTZp0WGntjxIgA5F89UXwvnV9ojMxEuOk7SiEVIG+JLyovRlAR0QXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FsBPX725; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FsBPX725"
Received: (qmail 3483 invoked by uid 109); 28 Oct 2024 05:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AfAtzhGlhUzUKV53lk0IoDnLHA0R9pmu/5Y/2PoYuTc=; b=FsBPX7256z5ptRt2KU/3+K45y6JeuwLVPe6A8cpUhuZzleWE4QZSXsLHJd22clNfdLnT5TxjNYgv93mmTfaezvTYV0jVKCmZ0ei4MPUAvDQEvLB58CAZKTplqNuLGOR86yLdk2Nu37deF//TctMf8Jy6bfv3D2MWue764XX6XdXvmcX2GdUqmduGFBCQu3HRZQZ339cXj3SqDq0PDl9B3CpPye+swmVXH4iu3YT/Tk65RmKDEqEpTgFmB413vgOlVuvHMasnGHR4oH7QoBcr8P6Wvob1+8PltZjvdkwis477sykz6KBNWiCtvbq/NLjUa1mWaFN/52WSxDCWdlHs/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Oct 2024 05:33:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16560 invoked by uid 111); 28 Oct 2024 05:33:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Oct 2024 01:33:15 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 28 Oct 2024 01:33:15 -0400
From: Jeff King <peff@peff.net>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Message-ID: <20241028053315.GA2827304@coredump.intra.peff.net>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
 <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
 <20241023215618.GA821188@coredump.intra.peff.net>
 <D549EIKDKGDS.2AETZLT4RTB44@ferdinandy.com>
 <20241025062438.GA2107756@coredump.intra.peff.net>
 <D56XI8GBH2GF.3MP02MGQGP5M@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D56XI8GBH2GF.3MP02MGQGP5M@ferdinandy.com>

On Sun, Oct 27, 2024 at 11:07:07PM +0100, Bence Ferdinandy wrote:

> >> I'd probably call the flag something like "--current", "--current-only" rather
> >> than "--is-head" though. "--is-head" sounds as if it would filter --list but
> >> not necessarily end up with a single entry.
> >
> > Yeah, I think --current would be fine.
> 
> I was looking through git branch and there is a --show-current option. I was
> wondering, would it not be better to teach --show-current to also obey
> --format? It would avoid having a "--current" that only works with "--list"
> besides having a "--show-current".

Yeah, that's perfect. I had almost suggested "--list-head" originally,
but I didn't want to introduce yet another major-mode to git-branch. But
if we already have it, that's not a problem. :)

And the patch should be quite short, I'd think.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE48374CC
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281478; cv=none; b=JpoyxWCr53Wiu+/w14sqjrtcFTh+uIlavXYjhoAiEyC+wKH+op2zlYHK8HUB3CANzSrXIOUZibgzlTbHqQILL5lFTBxCT9uf3HoO772ynSqB/HLkdvc5zRiOu2fSANNua+EuA2ibZlmP3M2e1GObR5i3quxQd9NPtOf6tJIWTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281478; c=relaxed/simple;
	bh=2nMKrVW7ewy9WEWAdPtrm+/uy1S6AH6xFi5VT4R71G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS/YEiTEwbzOgeeU/JjO1oKR81q3QoVWdS/gvjaSk3/CqU8pb3I3Knv98z7QG5GcHEie9VQvJTVkbkp+FCkUIKfE/Azig+6435qhH0Q+OqYF8KZCnhfimT60Ty3ihw8N9K0avsXZ8EUBfh+tCqBquRJJHuQf0bTXGlMnSagQ2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23074 invoked by uid 109); 29 Jul 2024 19:31:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jul 2024 19:31:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3817 invoked by uid 111); 29 Jul 2024 19:31:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2024 15:31:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Jul 2024 15:31:13 -0400
From: Jeff King <peff@peff.net>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] http: do not ignore proxy path
Message-ID: <20240729193113.GA23714@coredump.intra.peff.net>
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
 <20240726211156.GA714986@coredump.intra.peff.net>
 <4f962eaa-d12b-d250-dd93-a1673af850c6@alum.mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f962eaa-d12b-d250-dd93-a1673af850c6@alum.mit.edu>

On Fri, Jul 26, 2024 at 06:43:29PM -0400, Ryan Hendrickson wrote:

> > I wonder if we could go back to passing the string straight to curl (as
> > we did prior to 2016), and keeping the proxy_auth struct purely as a
> > mechanism for gathering credentials.
> 
> Hmm, that would be nice, but I think curl doesn't deal well with the extra
> case that Git supports of specifying a username but no password. It causes
> one of the existing tests to fail if I pass the string straight through.

OK, thanks for trying. It would have been nice, but I'm not surprised
that there's an unusual interaction.

> On top of that, all of those starts_with tests for checking the protocol are
> written quite loosely, so in practice Git "supports" the protocols
> "socks://" and "socksonmyfeet://" by mapping them both to SOCKS4, and curl
> would not like it if it received those strings directly.
>
> So given that Git wants to handle the protocol and the credentials, it makes
> sense that only the host and the path are passed to curl. I just have to
> make sure that they are correctly re-encoded.

Makes sense.

-Peff

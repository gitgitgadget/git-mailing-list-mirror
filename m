Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB41139588
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854553; cv=none; b=Te9UHUVLD48d44Kc8AtOrp9BUGJaxD++uy1UqMJxdXFlixqymD7cE8krC1pcWEd8Jhie3DTjNDKygK/VNZOCRXGmazonr/siKdm3qpuvY+MZveYwXWz543QbnaQgtDHe4v5Xn0N5tZ1ONDGUVofH9BtY2AUa8Y2TtwoIcL0dvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854553; c=relaxed/simple;
	bh=slIv72ASlmj6pHSopwUW3ADO7vkJKlM57CHqr1+QdF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR3y36kfX4zaOkDKkznWdtJBEJxTXlSlLcyS8R3YJ53XRpBe/faXiydvq1l8aS24yoLIg/ZHOYlnHAUVCNKdIVmzrRDyWMSWSeWC5tcmYxcemBrZgV0RH26AwyOxQKShtzlyB66ptENm7r/imagryohKya31/LeqRud9tjKyWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1932 invoked by uid 109); 24 Jul 2024 20:55:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jul 2024 20:55:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14357 invoked by uid 111); 24 Jul 2024 20:55:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jul 2024 16:55:44 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Jul 2024 16:55:41 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Randall S. Becker" <the.n.e.key@gmail.com>, git@vger.kernel.org,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
Message-ID: <20240724205541.GA557365@coredump.intra.peff.net>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
 <xmqqed8me36c.fsf@gitster.g>
 <20240624235557.GA2727@coredump.intra.peff.net>
 <402c12c2-7ada-4d9e-c3da-1a78827e7496@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <402c12c2-7ada-4d9e-c3da-1a78827e7496@gmx.de>

On Wed, Jul 24, 2024 at 12:48:20PM +0200, Johannes Schindelin wrote:

> > But we could also have "git version --build-options" call "remote-https
> > --build-options" automatically, and just let it dump to the shared
> > stdout stream.
> 
> Teaching `git version` to show the cURL version may not be the best idea,
> especially when it comes to the version used at runtime and using the
> command-line option `--build-options` (with the option being specifically
> about the build, not the runtime, version that was used).
> 
> Wouldn't it be better to go with Emily's approach to surface this
> information via `git bugreport` instead of `git version`, potentially
> enhanced to show both build-time and runtime version of libcurl?

I don't have a strong preference either way. I naturally turned towards
"git version" because that's what this thread was about, and also
because it predates git-bugreport.

It feels like there may be some duplication / overlap between what those
two things inspect, and we should perhaps unify them. One thing I
notice about bugreport is that it doesn't have a way to just dump
information without trying to start a bugreport. I'd be very unlikely to
use it myself for reporting a bug, but I may want to dump information
about git while debugging.

So whether that is in the form of "git bugreport --dump", or if all of
the collection is moved to "git version --build-info" and then bugreport
uses that to fill out its template, I don't care.

-Peff

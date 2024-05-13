Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A537153
	for <git@vger.kernel.org>; Mon, 13 May 2024 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626258; cv=none; b=Z0sJ+CwsWOj0j4V2qEIyZWLDY5TLdEi/xBRhQsyMMYiG+3d3t0WUGA/JF/xv9Tz94VhS5/qnpqXe9MSQGtFMLp8Jtpsyf7lkicloeMQr5ekOJk3Y4L4tOStbtt/XQfYQaUFIu7hN/Rl9BGC16UBXEGBCBzRLqAl663Fj9QZ0jyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626258; c=relaxed/simple;
	bh=uNqpDxtkZiSWdrR8ogp7mcgCPiooPiRsY1c3i51GXJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdgFYHtqj6ngehS2gYyJaAiLtWobXndLpc3BXPXRj7mkUROo4GJ71DvXDcebBpak0Ay1UsSwElKAS9pggwGUsv+TRUg0o33NdI3HXPPSq1WI0xWxjZE5V21y+7+0FzkTN0hYrn+zyAJYROgoIE1qlCqU7/UubWpzYGun/NRLe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31208 invoked by uid 109); 13 May 2024 18:50:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 May 2024 18:50:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13750 invoked by uid 111); 13 May 2024 18:50:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 May 2024 14:50:57 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 13 May 2024 14:50:55 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/23] pack-bitmap: make
 `bitmap_writer_push_bitmapped_commit()` public
Message-ID: <20240513185055.GB2675586@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <dfd4b73d12edc1833e5090c956cda6f28046c9e4.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfd4b73d12edc1833e5090c956cda6f28046c9e4.1714422410.git.me@ttaylorr.com>

On Mon, Apr 29, 2024 at 04:43:22PM -0400, Taylor Blau wrote:

> The pseudo-merge selection code will be added in a subsequent commit,
> and will need a way to push the allocated commit structures into the
> bitmap writer from a separate compilation unit.
> 
> Make the `bitmap_writer_push_bitmapped_commit()` function part of the
> pack-bitmap.h header in order to make this possible.

I was a little surprised that this function and the one in the previous
commit needed to be public, since this whole topic is restricted to
writing, which is mostly contained to pack-bitmap-write.c. But you've
pulled the pseudo-merge bits out to pseudo-merge.[ch], and they need
access, which makes sense.

One could argue that it could all get stuffed into pack-bitmap-write.c,
but that is already getting to be a pretty large and complex file. So
this is probably the best route.

-Peff

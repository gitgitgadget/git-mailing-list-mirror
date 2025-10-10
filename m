Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A1635
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760075288; cv=none; b=HYCnLvwiXAWDxa8dXzzUGtHMykbLKnsX3nC9q4b1d+TC0hM043i6v9C0EE4I2vWrr+iFViJpsRvUri13MCHFrBBLFf0n0QGoTDjZBX4NN/pt2vEr8KPDJljBZ7bhBjzjZ/jf0qkcMDyqA1EYQ7xJH8cvec7RTsQPzgwmasYTBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760075288; c=relaxed/simple;
	bh=cnhy4Qt2Afl1mo05fha3EjwnpGtq7PE1O/4Z8u63e2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7M/uZ/UjCjpb4Xw6sk7KMQI16AtDw6FLrpdQ0a5QAVA/aBI784zcHJu/aj6X49YhgQIUxZx+NVqmc0gMq/KeGusijD8vPPFiPtleQZ3IeVDEFU1/7aIYO1p4Mcqnsbc8VYKZjEcy1ISpiRQED77w56Mvg0U1fAI/2oyM9oD/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U99Flz1l; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U99Flz1l"
Received: (qmail 182244 invoked by uid 109); 10 Oct 2025 05:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cnhy4Qt2Afl1mo05fha3EjwnpGtq7PE1O/4Z8u63e2U=; b=U99Flz1lMT2e8efVUj/zfCw6usfL+0gVlOJmiJzoKgQiBqwSt3ijSK369IVnrNgm+hwTwJRPyTpl0aZOTA9WHS2sslGsQW54uujDLaFYwyAjLVoJHXUGrwzShSthGvdpMyRG3F+U0gXE41GkBmyZOxTkzmogg6fjBlza3mpFnoWuLQ2QagTi0q25q8q4iIqKnJMDvmkm7RgM8kEbBxmJVUmoDV21JgPsCyiKqaVoXTg/m4G37iPf4mbatodaPzUK1YbEyTwP29QXf2PLCDX3m4Sk719xxX+2Pg3iN6lPSnSpyFvPxNp0tNTei2zyDmXvn3wmJA2CyQ9F1PZtvlTBew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:48:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283240 invoked by uid 111); 10 Oct 2025 05:48:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:48:04 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:48:04 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 11/49] repack: introduce new compilation unit
Message-ID: <20251010054804.GD1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <fe3328eb3d8202f8fa8cbef11cca215ace8b2285.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe3328eb3d8202f8fa8cbef11cca215ace8b2285.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:53PM -0400, Taylor Blau wrote:

> Let's start by migrating 'struct pack_objects_args' (and the related
> corresponding pack_objects_args_release() function) into repack.h, and
> teach both the Makefile and Meson how to build the new compilation unit.

This name is a little generic for something that now has external scope,
since it is specific to repack's view of what it might want to pass to
pack_objects (and not something that builtin/pack-objects.c cares about
itself).

I don't have a great alternative name, though. I guess it could be
repack_pack_objects_args or something, though that is getting to be a
mouthful.

I dunno. Maybe it is OK as-is. If I stretch I can imagine a world where
pack_objects_args is for the lib-ified version of cmd_pack_objects() to
use (like we have send_pack_args, etc). But TBH I find it unlikely that
we'd go that way anytime soon (and if we did, we'd maybe even be able to
refactor repack to more directly use the struct offered by
pack-objects).

-Peff

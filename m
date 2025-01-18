Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322918FC9F
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737206112; cv=none; b=Z25JEfG04v7QZtYkIyDwOW8LRTjdnG7j+rw2Y54kQPtS2W/+v8gmLcDoxWaacakc6GUHbAY6SaBv56no6tsAqCk7mN5jXj3NcYEcW9QLHmIZaN3oC/DmC//zJ+UrBnSFT6i+ZTf0P7/PP7n3e/LYVLaT79xz+9dKHfNwyTzqycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737206112; c=relaxed/simple;
	bh=FGfsg+SrcFB5CyayoRJLQnrXrVBmv+88CqbmANA6VZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhVIssfRZzl36rJ5VDsIi5E1i6+S9ZbdPLrDfubv6yGp4lZI9IGSeid3TD5M7wOh4KFfbP3Ci0SeIsUwRGBouK0B7M8fWBWi9H/lg/nTmry/J2T1XfFLAZbKaB0MjL5iSk3CppdZFt3YRkV7jl2IZd4N4wRDMi9iftdcvJMU9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d7xN8IG6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d7xN8IG6"
Received: (qmail 31493 invoked by uid 109); 18 Jan 2025 13:15:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FGfsg+SrcFB5CyayoRJLQnrXrVBmv+88CqbmANA6VZg=; b=d7xN8IG6BxHmI3YclhbxU4uZDWKpiH8w5qEVg7PGI8FY3pJ5jPXGQom+ZLkeJJ9SCzgQm259dIZR3SUGW7cL8FAHswhKHeODNiBNawKFwbB7HnW8tp5312+hbzmd8ljK4sCA2GG0kDr8t9Ii/mplfA3snEMSJIvZpaxDu4qU0F+w17lQ/I13K7bc4CUx2TgqgwjH4ytM+H1ZCc9HLESaf+1w78PtWZodY9bjUr9RX47xpcmQenP2JkbTY5FXjaJaQq3htHX4q9lfeuLoDL1bAYdgtvoDyz0mOsddA1Qd6SmC14oiUxj8x+Z8bgEJubffH8pyS9C1YThZrj7U3sVP1A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 13:15:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20675 invoked by uid 111); 18 Jan 2025 13:15:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 08:15:08 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 08:15:07 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
Message-ID: <20250118131507.GA387197@coredump.intra.peff.net>
References: <xmqqwmetgdgm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmetgdgm.fsf@gitster.g>

On Fri, Jan 17, 2025 at 04:42:01PM -0800, Junio C Hamano wrote:

> * jk/pack-header-parse-alignment-fix (2025-01-17) 3 commits
>  - index-pack, unpack-objects: use skip_prefix to avoid magic number
>  - parse_pack_header_option(): avoid unaligned memory writes
>  - packfile: factor out --pack_header argument parsing
> 
>  It was possible for "git unpack-objects" and "git index-pack" to
>  make an unaligned access, which has been corrected.
> 
>  Will merge to 'next'.
>  source: <20250117125207.GB2356599@coredump.intra.peff.net>

I was planning to re-roll this with your sparse fix included, and adding
another patch to do get_be32() on the reading side. So maybe hold off
for a moment.

(I'd also be interested in any comments on the "maybe we should just
align these buffers" approach; I'm undecided on it).

-Peff

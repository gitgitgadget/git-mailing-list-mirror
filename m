Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963A1E4BE
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736433; cv=none; b=fo8HCSHQ+FdLX5AoC53yI3He7xTIErDTVGH5xmTgaxhgeTcSoCRPp4vjki0CIFSmRyExYqgRI3ZY9kuQtfZnaUDzjFWdAEByejBwa+Ss8Vvs1P7C6DIUp7ZSmwnSMv4260GDVGIa6LgKoM9wJH9CW7B+lHQ4ewTW4BCsZi/C8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736433; c=relaxed/simple;
	bh=Omcp1WbbZp0/veJZQKFL86ZYvdfCZAeYRF9FEWE9QI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNybQKjJTuBfDk7Dk1kxOYniy6cGboLZ3amZeo+K/WaFKgunOrIDBg4q/4D0xxkKqNGxF/k6QMaSb3lzLIIKXvsqVVlksXFGUU4+1eVTKOjlfZsNBP3S1O8bsn2k+i7u8jmZI79Bjv/sv0atR/GJFdeBjoOVLJe/cqoA2HzyKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ArKGuw1Q; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ArKGuw1Q"
Received: (qmail 29379 invoked by uid 109); 8 May 2025 20:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Omcp1WbbZp0/veJZQKFL86ZYvdfCZAeYRF9FEWE9QI4=; b=ArKGuw1Q30lZ4pdJSzwMJMOBQ3CZqLl2EP1boFG+E0iqP8SlN28mBncFBH3PJ+XJ745WCN+cwNzWhZts99J3n68RIdcsJu4OwErR1TeCU/9BlAJSJfDI5yL+kv3QM4IRTLfqttnGGHk2VHqK9miEdAwrFf2cQQMfAudVosDEY/qfld+dR8aK15w+lYHD5y3PNX3bWh0f3DWemNDw1ivmO3Cnf2Ha8gSkxO/ySvr3WG0wZ58fLOz1n82biP6jsU9fjaSUNSYsYmhFZDBHNKJXTGvGzbDRrf4QsdYfdikaBBPMpm2GO/cgHkwFzCQKZZkdBVds4j/xT417iOBv2eG5yg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 20:33:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20442 invoked by uid 111); 8 May 2025 20:33:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 16:33:52 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 16:33:50 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/4] align the behavior when opening "packed-refs"
Message-ID: <20250508203350.GG18229@coredump.intra.peff.net>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
 <aBtzn4nwLsI9p5Cp@ArchLinux>
 <xmqqv7qc9grt.fsf@gitster.g>
 <20250508200802.GC18229@coredump.intra.peff.net>
 <xmqqzffm4zx5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzffm4zx5.fsf@gitster.g>

On Thu, May 08, 2025 at 01:20:54PM -0700, Junio C Hamano wrote:

> > I left a few comments that I think bear addressing (or at least some
> > discussion).
> 
> I found both of your points very good ones, especially the "why are
> we making an in-core copy anyway later?"
> 
> Which may probably mean that munmap_temporary_snapshot() is not the
> helper function we want in the code path, so one of the preliminary
> refactoring patches can be removed.

Yep.

> Even on mmap-incapable platforms, we have enough emulation in
> git_mmap() and git_munmap(), and this code path that wants to read a
> packed-refs file just mmap(), do its thing, and then munmap(),
> without worrying anything about "ah, temporary, so we need to make
> an in-core copy for ourselves".

Hmm, yeah. I had thought that somebody could explicitly set
mmap_strategy themselves via config, in which case we'd want to avoid
calling git_mmap() on systems where it actually does mmap. But it
doesn't look like we have any mechanism for setting the config. So
MMAP_NONE happens only when NO_MMAP is set.

  I briefly wondered if the existing code could be simplified to get rid
  of MMAP_NONE, since it could also rely on git_mmap() to make an
  in-memory copy. But it gets weird with MMAP_PREVENTS_DELETE and
  NO_MMAP combined, since then we make a pointless extra copy (one to
  fake-mmap, and one into the new buffer). OTOH, I'd expect those to be
  mutually exclusive.

  I kind of wonder with MMAP_TEMPORARY why we bother mapping at all and
  not just reading into a buffer. Maybe it's more efficient?

  Probably not worth revisiting all of this old code, though. And
  anyway, because of the SMALL_FILE_SIZE check, we couldn't even
  simplify away the read_in_full() code.

-Peff

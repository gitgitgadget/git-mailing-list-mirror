Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CBE38C
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368970; cv=none; b=YU6+PVSQw9JFlaYB5e/ywfjVaECxswYrFwmiXFME881Cr4EvUUX7mMfJQ6MVKXKo9H0Dw1mbEWGY1YQT6NnrBRn+vSenJS5DXUuEfDPSBhyqFTyCS3abhFFMrPubhpgB1C12OOtCTEtzYZPwvKNyUqcvgAUuwWmBBiXkEf9XDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368970; c=relaxed/simple;
	bh=ZN2781MHklxOkAUksKjYeei9Jlrigs5Po/B4dRARgsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz6uTrkPpF0CfrCYxucDey/fiuDrPtUwUjltYQGTeRNHggmpFsurxUGfcYxO/Qm0TKwx0IROFmJrgigQXXmaAbLA4BQAYCO0YUEfDG70CIuJiVBZLomZOYW3xR8GXjLkS32GEuj9K34aNwJEy/UIu0AYqroTQhj07fc2JyIaPDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=beFysYO0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="beFysYO0"
Received: (qmail 20792 invoked by uid 109); 5 Dec 2024 03:22:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZN2781MHklxOkAUksKjYeei9Jlrigs5Po/B4dRARgsQ=; b=beFysYO0Yd2Frpw3YcK5UOgV5bBRjlppW312lEN+Hqp2JmbIelUQLI2leCo9omiNr14L6AKHv1mV1BH5sJeI0qNvmKF0DJMifMbzuc3b/rbGpEz7a35OnD/uTs9EJf5Wnnij730s913F9qPPVmuuA0/OyEEDlGhvxzvtyABpi9oYZW6JRJJOJ8DT0p33pQIwXwj2qDiaW32bzcg9nXrdrVsSYmqxaZgiXu9ditD0V3ARrkLysGPARWbvT1d6MHO6EmLfmiJJtepbg9SXsUQwPKl6Bo/PeNdPsehsd4LH/dDrP3PXXAvwdCrvJy2pHYortJKJXA+pgkPvARpGQGwfsw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 03:22:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32572 invoked by uid 111); 5 Dec 2024 03:22:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Dec 2024 22:22:47 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Dec 2024 22:22:46 -0500
From: Jeff King <peff@peff.net>
To: Dmitriy Panteleyev <dpantel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
Message-ID: <20241205032246.GA2573761@coredump.intra.peff.net>
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
 <20241130163801.GA110697@coredump.intra.peff.net>
 <CAJ-DG_CNPGgfafyTcKWYeNXHD4gsspWakzQoRhfggMqZjenkyg@mail.gmail.com>
 <20241201213636.GB145938@coredump.intra.peff.net>
 <CAJ-DG_A3RY0ngY-pc6riho=OyzX2VjeaR2LRGb5=ru3CNruECA@mail.gmail.com>
 <20241202203451.GA776185@coredump.intra.peff.net>
 <CAJ-DG_BLtwg51UoBN4m64ejYUcS99zu54oPYGnC5p+55tNtzpQ@mail.gmail.com>
 <20241203211830.GA1423791@coredump.intra.peff.net>
 <CAJ-DG_AU8cFdLqfAnEE8N2KSqnQgJ47YJszyXWOvXuuKreAbCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-DG_AU8cFdLqfAnEE8N2KSqnQgJ47YJszyXWOvXuuKreAbCw@mail.gmail.com>

On Wed, Dec 04, 2024 at 07:21:16PM -0700, Dmitriy Panteleyev wrote:

> NFS server is on a linux bot on LAN. nfs-kernel-server 2.6.1. Client
> mounts shares as vers=3.

My setup was a little different, but I tried the same thing doing an
actual cross-network mount of an older box with 2.6.2, and making sure
to use vers=3. Still can't reproduce.

> After trying NO_MMAP=1 with and without SANITIZE, I get:
> "fatal: mmap failed: Permission denied"

Hmm, that's odd. If you run it under strace, which syscall fails? That
message should be reporting errno from mmap(), which in NO_MMAP mode
should be a pread() call. I'm not sure why that would get EACCES if the
open() call succeeded, but that might explain why the mmap'd version
gets SIGBUS (I don't know much about NFS, but I imagine that under the
hood the client is probably issuing reads for individual pages to
fault in the map).

Does your system have AppArmor enabled?

This issue sounds similar to yours:

  https://unix.stackexchange.com/questions/633389/man-cannot-read-manpage-from-nfs-although-the-file-is-readable

especially the bit where reading the metadata once makes it magically
work for a brief period (which is the only thing I'd expect the commit
you found via bisection to have an effect on).

-Peff

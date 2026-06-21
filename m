Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5E25B09D
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782064177; cv=none; b=DUBccEasxA639kkyBnJX8/uj33DF13K81Ro6dNm7KQZuhbrizFdRD/b4bbkkF8lWM60dDICxWH0itlal0eK+DFsKahCKn4198rX2xYCPfNNttv1KINCF5aawxf0VpNW2UjDRyOrbAQjt5zzAReTAn9GIAueO9gha18rXQvRlOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782064177; c=relaxed/simple;
	bh=R14/fgFPt6ySIo7gC3ZwFnX9ihaM8/bt93iSXgzrXe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bymdC94TeHWM0uNUQLTOldjaOsswiAww0qx0yGjKvvOOCRS2owN4i3GWVquFWjaPBqlLsznCMclQSyTMdBljpBgMRzVFuwKGKZqfSvtwXv4ByUTEZfRkEl9gkjsFU3KrSFITkJ3KISLjiqWuZ0ZpDgZAtJHNrOUuz88Duq6p1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EpdhpBiC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EpdhpBiC"
Received: (qmail 204490 invoked by uid 106); 21 Jun 2026 17:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=R14/fgFPt6ySIo7gC3ZwFnX9ihaM8/bt93iSXgzrXe0=; b=EpdhpBiC0OV2W+6cbgMDLB4+OhPN2BfLyj/pV0ovsAOldC5myup/cgMuFiJLHsCwbe/B3PZnCCazHnmAvHRYwf5Z+0I93JjyFRdQfD9FdvvMiPSad63muc2CdQqHjbWjPAUkPZpDbPANZQ41zktzGLcw/dXQSeTStQMU8v2R9KXP9ycl/fiRyHtn+CKTDvEMS4ri7biGDiT42/J+fMWYJqh9j+N36eQDtTdbQIDvKduEQgxQrlRSaD32PqZtB8alVKMPT0icjn+8SduR288qVOmoVCc27kq097uOHO7G/WQav8yez+S5y58YlN+hgkbno5u9OzZmWd6bT29PjV7pyw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 17:49:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520931 invoked by uid 111); 21 Jun 2026 17:49:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 13:49:36 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 13:49:34 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <20260621174934.GC2206349@coredump.intra.peff.net>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>

On Sat, Jun 20, 2026 at 12:00:24PM -0400, D. Ben Knoble wrote:

> Autotools-style builds permit enabling USE_NSEC for cases where that's
> desired; the equivalent knob is missing from meson-based builds.

Seems reasonable. This is not changing the defaults at all, but just
bringing meson's options to parity with the Makefile.

I'm not still not sure if turning on USE_NSEC is a good idea. There's
some discussion in Documentation/technical/racy-git.adoc:

  With `USE_NSEC`
  compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
  members are also compared. On Linux, this is not enabled by default
  because in-core timestamps can have finer granularity than
  on-disk timestamps, resulting in meaningless changes when an
  inode is evicted from the inode cache.  See commit 8ce13b0
  of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
  ([PATCH] Sync in core time granularity with filesystems,
  2005-01-04). This patch is included in kernel 2.6.11 and newer, but
  only fixes the issue for file systems with exactly 1 ns or 1 s
  resolution. Other file systems are still broken in current Linux
  kernels (e.g. CEPH, CIFS, NTFS, UDF), see
  https://lore.kernel.org/lkml/5577240D.7020309@gmail.com/

That's the most succinct description of the problem I've seen, but I
have no idea how widely it still applies. Kernel 2.6.11 is quite old
now, but I could believe that other filesystems (especially network
ones) still exhibit the issue.

So I guess if we wanted to go further it would take some digging as to
how each platform behaves, and then flipping the config.make.uname knob
for ones where it can be argued that the behavior is always reasonable.

But that's all outside the scope of your patch here.

-Peff

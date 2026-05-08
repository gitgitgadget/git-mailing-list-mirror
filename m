Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54934252B
	for <git@vger.kernel.org>; Fri,  8 May 2026 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263424; cv=none; b=FwBUZNIHt1xNAhaimx1u7uBjTEgDfWAawyxmw7Bg0SPFqa0vmpxYiowayj7gvpXaLlh5riH6CvivWR1rA1MspN2/KXYDh3OEr5oYnaMBJowTOW8WzAJWZFpP+LZHqh+FDsXK68NOzl79ia1Eqrfq9GlDelK8l8iFhnUuX/qZRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263424; c=relaxed/simple;
	bh=QmSqYEevvLl3HNSqDOoxoEhtEs7ewmg6z91u3e2a8xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHrbR6f7o+gPPY/XsIniXFXbeTC34JsQ+a0J5TubXl+9BeBQr9tCPX0j/5QFzJndtZlti81X2oA0ff1t7P51w5v3y7Kcj9UR5ZJp6LMtf6ZBFAdRpTVg/VfyPSf01WeZRd5wO7PJWOa2rimH8YfOouXtZCAKQcdub2qjTlnLTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f0PQZEeJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f0PQZEeJ"
Received: (qmail 67329 invoked by uid 106); 8 May 2026 18:03:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QmSqYEevvLl3HNSqDOoxoEhtEs7ewmg6z91u3e2a8xA=; b=f0PQZEeJTXPVRADXcNE/tBHjE2hhQLplLM4kqnvTITPoW4iKZvS9lTXNQ9i/z8mnVLnjJ31ri1R2BWe0j36Xhm8VBCmpBi0hsjmbyBF9MyaIpoZTgiN/dKTwCqf6gIehR296TOIa9IiKvFI/VyjZWNi5rdQoORLTgOHSIAo8mVg3uP2WqrmX8Y5Bj/pynVDRD2Pj3bvclOYkgYxuuRmK/i7b1xSv9eHz2Gr/aLuTwRTwc01iCSYtOh0w+n8iCXXarQQ4b260bZH+t2pN0wvdaXRy8vpeCbAGo8xWtZ4ejVi4KH4SYJojLRNKLmKo2E3GyTFDv/61YY3qrlqPIGbLLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 May 2026 18:03:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 130052 invoked by uid 111); 8 May 2026 18:03:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2026 14:03:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 8 May 2026 14:03:41 -0400
From: Jeff King <peff@peff.net>
To: jean-christophe manciot <actionmystique@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <20260508180341.GB737125@coredump.intra.peff.net>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>

On Mon, May 04, 2026 at 05:27:21PM +0200, jean-christophe manciot wrote:

> [gc]
>     auto = 0

This is enough to disable auto-gc. But these days we also (instead?) run
git-maintenance, which is controlled by maintenance.auto. So you
probably are getting a bunch of background git-maintenance runs kicked
off.

> [pack]
>     threads = 1
>     windowMemory = 1g
> 
> I expected git to use maximum one thread for packing and I'm surprised
> it even tried to perform packing as gc.auto was disabled.

This should work to tell pack-objects to use only one thread, but that
is one thread per invocation. And we were probably kicking off a ton of
processes due to the background maintenance (and worse, they were all
doing the same work redundantly and maybe even stepping on each others
toes).

+cc Stolee for wisdom on all things git-maintenance.

Should maintenance.auto fall back to gc.auto for compatibility and
avoiding unwanted surprises when people upgrade?

Also, should background maintenance be locking to avoid multiple runs?
It does not seem to do so, and if I run:

  git init
  for i in $(seq 10000); do
    echo $i >>file
    git add file
    git commit -m "commit $i"
  done

I get several concurrent pack-objects processes. After a few thousand
commits I got bored and hit ^C, and the resulting repo was corrupt!
Which is not too surprising, as multiple simultaneous repacks are known
to be unsafe, but means we should probably avoid them.

-Peff

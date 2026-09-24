Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0972116F4
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790293940; cv=none; b=PAGbWfQq4k0kpP3HENAK96caHgr63rIPlDBbnWjVEU1BXJQAb2vm3HX9L5wXUsAwKTyuMC0J3ZQJpvt7tc9VRjjZI9d/1SdVYJWFLCViQc4tzIpHbHSJb8Kw/UoFz+MzEOkamaZWyLlDPDiEdnWEdQTtCzS28pkjfPW9gFhVAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790293940; c=relaxed/simple;
	bh=kO7VxcFMwbU6gjYtiTUMH3jnKqG2NHkrOV9pwGD+Uhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ+WAWz+rsuSQ01dPrK0drHEfr7U7HPN6AHoQ3L+PEEnPuv1iTRQfXt3kChDfNYoozGhAKlMvCWRwCrJptw9LyCh8tNNQ4gl+FkjBXKr7wi+h0+H6Zm8CuNCl5q1CH8UvuuahueO1XilQ+bhSOfM+vFIckKEsgJk9IgRQ0SvDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MQ3sFT8a; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MQ3sFT8a"
Received: (qmail 49240 invoked by uid 106); 24 Sep 2026 23:52:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=kO7VxcFMwbU6gjYtiTUMH3jnKqG2NHkrOV9pwGD+Uhw=; b=MQ3sFT8a5nbbbBc/65V5qFPEUP+xXRgok7ecc0FB6dOBuvk+MZFHWkdgQPOOzCazVdfFWjLt3PoEvcRyhTUJ/66aAGftE5P8NXUjfd7B/IShcPAN9wAW+GnxNg7z2Bvhz1g+k/1lYJnM7rQRFYMEYDp/5s60ABWBWFZFTume2L97EM07CNphS2ZzORCXQ+rtR+cs3rHmo511CKNcUX5RydN9RGqMA7hiY6hTl39n+KFfLDI+zD48VY+Ud0okWpuYtT8C6VdKtOU+f6frLd38TPsFMnQOyVNQPiinjvcISrb6aaIdDnSJGyk1GT1yoMlfdfdP9mD706duD7CcSTSJqg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2026 23:52:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 198241 invoked by uid 111); 24 Sep 2026 23:52:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2026 19:52:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Sep 2026 19:52:16 -0400
From: Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] Makefile: precompile "git-compat-util.h"
Message-ID: <20260924235216.GA837070@coredump.intra.peff.net>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260915060952.569535-1-szeder.dev@gmail.com>
 <20260915060952.569535-5-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915060952.569535-5-szeder.dev@gmail.com>

On Tue, Sep 15, 2026 at 08:09:52AM +0200, SZEDER Gábor wrote:

> This patch follows the idea of 671df48df8 (meson: precompile
> "git-compat-util.h", 2026-03-19) to make it faster to build Git using
> "make".  The notable differences are the boilerplate needed to wire up
> the precompiled header with "make", and the selection of object files
> that are built using the precompiled header:

I got an interesting error message from this today:

  $ make imap-send.o
      * new build flags
      CC tools/precompiled.h.gch
      CC imap-send.o
  cc1: warning: ./tools/precompiled.h.gch: not used because ‘NO_OPENSSL’ is defined [-Winvalid-pch]

You won't see it with:

  make NO_OPENSSL=1 imap-send.o

The culprit is that I have this in my config.mak:

  imap-send.o: EXTRA_CPPFLAGS += -DNO_OPENSSL

so the build options for the precompiled header and imap-send.c are not
the same. So now of course you are asking why I would have such a weird
line in my config.mak.

The answer is that I want to disable openssl for old builds, because I
am often building historical versions which use openssl constructs that
are deprecated or removed. So naturally you are now asking why it does
not just say:

  NO_OPENSSL = BrokenOnOldVersions

or similar. But that breaks _some_ old versions which really do need
openssl for various things.

The good-ish news is that it's mostly cosmetic for me. I also loosen
-Werror for old builds, for obvious reasons. So it's not breaking any
build.

I don't know if my use case is too crazy to care about, but I thought
I'd mention it in case there are other less-crazy related cases we might
run into.

And yes, obviously old versions will not have the precompiled header,
either, but my logic for "loosen compilation" is mostly "we are not on a
branch nor rebasing", so a sight-seeing trip to "git checkout
origin/seen" puts me in the same mode. And eventually it _will_ be old,
too. ;)

-Peff

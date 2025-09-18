Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7425761
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162562; cv=none; b=GlfVnGWe9IMf4Ec1JhhJWxCuZhQZfukH3IMIO783RiK6Fjiabl3RQMRO0AemRPeYOWVZIsyRERy8JnLO3L+hfvaiaUwBFozMlUN7WJDLeTeUlmqkDFo1QuT4w09YDh5pENhPM5tCsv6PPbHDYOwDsVukLg5f8qw2J59lwn94D08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162562; c=relaxed/simple;
	bh=BOOuXTKOFVqVxnvOjQepXWWdcb+xsbxPe/Kr96dUKxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twI3vDNXQ1oKbc9nmf5G8Hb6Zs1LJDHoicdBMS1bEKyWOAix1LkQAI0a8mjpiK0FewBWCsDnliYOt2dHQxyejNhTIwlp8iqNKx3DXvBrza8UjUV85cEU0uDaVvs+OstoqVd0hPlZZ4sGeQncVkcYpfNodoWNIJ0Lsri4C5klPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a+QSKHm7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a+QSKHm7"
Received: (qmail 114174 invoked by uid 109); 18 Sep 2025 02:29:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BOOuXTKOFVqVxnvOjQepXWWdcb+xsbxPe/Kr96dUKxY=; b=a+QSKHm7M0ghBflCEFOwfOnWtE6tS6wSTuemx/hZj1G7o/wTy4KuZy9D972s+4cgcqjjuA8ikxuPDNzTkTbWogzb3hsq/DTmioEkT/JGR969iLr3rJPc5xrcyWghdVPSgBcF3jznuO5z0UwDNyRuiAF7+ee+ZgXmOBw6cFbJIMoinoB83ZbmoSQBFqbESLvuKKM2yWwD5LMkihJoenDNA/254zJf2Edgsh5YpCJIMiSg4RobPNdg/xq/sKsw3nfjXCMm+1EYfoGOK9R7xR7Ni2J3j3CaIoAsdvkjQXYJ1CL7JkrUCSFls3m6S8WJJ7+joDlE5yF0XQoMFBMqdFMk4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Sep 2025 02:29:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 185035 invoked by uid 111); 18 Sep 2025 02:29:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Sep 2025 22:29:12 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Sep 2025 22:29:12 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [Change] Git build issue on NonStop
Message-ID: <20250918022912.GA1135133@coredump.intra.peff.net>
References: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>

On Wed, Sep 17, 2025 at 10:16:13PM -0400, rsbecker@nexbridge.com wrote:

> Just a quick FYI. The addition of uintptr_t in clar tests has broken
> my CI build on NonStop x86. I will be fixing this locally. It may take
> a patch series unless a quick workaround is possible, which I am
> hoping.
> 
> For those on the list from my platform who are monitoring, this looks like
> -D__NSK_OPTIONAL_TYPES__ is now required for the build. I am unsure
> what else may be needed.

We use uintptr_t in lots of places in the regular code. I guess this bit
in compat/posix.h is what makes it work:

  #ifdef NO_INTPTR_T
  /*
   * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
   * on LLP86, IL33LLP64 and P64 it needs to be "long long",
   * while on IP16 and IP16L32 it is "int" (resp. "short")
   * Size needs to match (or exceed) 'sizeof(void *)'.
   * We can't take "long long" here as not everybody has it.
   */
  typedef long intptr_t;
  typedef unsigned long uintptr_t;
  #endif

But clar has its own compatibility layer. So it would need to do
something similar. I see the clar line in question also uses PRIxPTR,
which I can imagine might not be available everywhere either. We don't
use that ourselves at all.

I kind of wonder if just:

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index 80c5359425..f408af850f 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -875,8 +875,8 @@ void clar__assert_equal(
 		void *p1 = va_arg(args, void *), *p2 = va_arg(args, void *);
 		is_equal = (p1 == p2);
 		if (!is_equal)
-			p_snprintf(buf, sizeof(buf), "0x%"PRIxPTR" != 0x%"PRIxPTR,
-				   (uintptr_t)p1, (uintptr_t)p2);
+			p_snprintf(buf, sizeof(buf), "0x%"PRIuMAX" != 0x%"PRIuMAX,
+				   (uintmax_t)p1, (uintmax_t)p2);
 	}
 	else {
 		int i1 = va_arg(args, int), i2 = va_arg(args, int);

would be sufficient.

-Peff

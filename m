Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F87460
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712453595; cv=none; b=iCbaQZCO8HBUDtypfGUFm2W1cTBCHIsu2h0AiJTFY6VxAUSB/BhGWWRUp2L5Hauv/wUypuh3oYjU/f0pMWfvJ7SrlGxfWPRJ67EM9ZLPbCpgTkGLMOywry926CV8abXRwI5dszI/2ZfkQVIewjmxfJy3Oxm7R8r2bQChEu8GaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712453595; c=relaxed/simple;
	bh=+J7a8NXWExdOPhkYuWdIhwmhFKQqATwwOeFqarsM3WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRx3FOiTYOXtaqgFhC1AwRaxDtNeiyeDO6qPJ8s5jZIVgZaSXTo9aFTrszs86YbhfC++zNKaNRzcFFT+bbuIOvRvHbqJy8Nm05Rq64ihpsYm41ioJyiOAcb+dXFL3lrgOg3rOU674BHf573rN7wXy3Qkh1wMcAKnp+PXRfpLSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8531 invoked by uid 109); 7 Apr 2024 01:33:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:33:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11607 invoked by uid 111); 7 Apr 2024 01:33:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:33:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:33:12 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t9604: Fix test for musl libc and new Debian
Message-ID: <20240407013312.GD1085004@coredump.intra.peff.net>
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>

On Sat, Apr 06, 2024 at 10:29:10AM +0700, Đoàn Trần Công Danh wrote:

> CST6CDT and the like are POSIX timezone, with no rule for transition.
> And POSIX doesn't enforce how to interpret the rule if it's omited.
> Some libc resorted back to IANA (formerly Olson) db rules for those
> timezones.  Other libc (e.g. musl) interpret that as no transition at
> all [1].
> 
> In addition, distributions (notoriously Debian-derived, which uses IANA
> db for CST6CDT and the like) started to split "legacy" timezones
> like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
> by default [2].
> 
> In those cases, t9604 will run into failure.
> 
> Let's switch to POSIX timezone with rules to change timezone.

This made me wonder if we are losing EST5, etc. We use that in t0006,
for example. But I guess not, since I do not have tzdata-legacy
installed (I am on Debian unstable) and haven't run into issues (I
didn't notice the cvsimport one because I lack other prereqs to run
those tests).

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059092F29
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719806282; cv=none; b=NeYsPAsUBsF9rXxJmRAhJ7jjbuZ6z6lWAx8+s/QBWHavVlLQGtr2PMWI4Y6kM68l6ssZ+IyIchNUiwhsj/kiXh+11OTCyO8DFgL2I5Z2gsyXxPDB3If9T2DJMmnfK54xJXq72UTMLH2vpKCC4zcQDkLlZEI6tWSzYLnh38RAIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719806282; c=relaxed/simple;
	bh=LvhvOkcalhfJa5R1cX+TtFDRsusXgg7ZO5I+YK9D+Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVavv+kKAdeo9cvQjnO6ZGhGiXcmPRdPEOMiqGXE9XyGeTxZZi6V0Nr6HxX5d5aSDegwRb2BOwy4C9/7TGJdTqxaBd7b71iOrBqjYOJfM+cuVy/xrR1Tn1cli6wB6gunZvdSn6tNlK8h7bdReuFUbiEMElbDnzYogJRFNZwPK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17100 invoked by uid 109); 1 Jul 2024 03:58:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 03:58:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8584 invoked by uid 111); 1 Jul 2024 03:57:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Jun 2024 23:57:57 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Jun 2024 23:57:59 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t0613: mark as leak-free
Message-ID: <20240701035759.GF610406@coredump.intra.peff.net>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>

On Sun, Jun 30, 2024 at 08:46:38AM +0200, Rubén Justo wrote:

> We can mark t0613 as leak-free:
> [...]
> I'm not sure why this simple change has fallen through the cracks.
> Therefore, it's possible that I'm missing something.
> 
> I'd appreciate if someone could double-check.

I'd noticed it, too, while doing recent leak fixes. But since Patrick
has been working on leaks and is the go-to person for reftables, I
assumed he had already seen it and there was something clever going on. ;)

I also get a passing result from t0612 (and I do have JGit available, so
it actually runs the tests).

I also get funny results from t4255, but I think we can ignore them.
It's known breakages vanishing, which I guess is just some sub-program
returning failure due to a leak and changing the test results.

So anyway, this patch looks good to me, but probably we could squash
t0612 into it, as well.

-Peff

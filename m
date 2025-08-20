Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CF24DD0E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725607; cv=none; b=e115jCDEKQoETJ9PlIXVidbyQwaHhp1bM/vPldlbG7ubUdC3fN6c0t49zj0FNs0vHWBPS5K8TtYi1Zo17jYzpVdR88RvC1OGkiZgoFwCbEXlEbSPJ6Rjmgvfh66tiNMEKOtIT789VnZNOGoSJh7xGD1Z8oG1MECyIo2MRzjlcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725607; c=relaxed/simple;
	bh=Zh/cP5JbcO1Wg3ytmi9hqKEOOCkn07tCGRtcuQW996A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3IVyq8BGNuz1HMXPZKztT1/d+elO9aGXJPDI6AE5bQh2R8dGvp+aUK5URGn5o/FV0sUI7MHIkvQlUdlhvrokNnGI12OiesLuOXBgblsqvSfMbXLyNSyUK2MbPMKroWm6BodRvOwovotS2LmZwfZYFIrn/hEC4VgVnT2eQI4jKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IeVf+7xt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IeVf+7xt"
Received: (qmail 39407 invoked by uid 109); 20 Aug 2025 21:33:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Zh/cP5JbcO1Wg3ytmi9hqKEOOCkn07tCGRtcuQW996A=; b=IeVf+7xtTOsW8+B2o3+Cvxzt5hfFg+VbEcn+vzn6N9CpckFvN8QvKyWZbs04cC+OYifv569jH0QXCBHcEEvLphzVo62XBB/YvftGoQCSxFs0dCppltJdv2e8/ZSK9lh9Yc1OMtY/yevp4Yjzf7eYlj7xSqnM8XC6PcpW3F5yiMpT3yfduFe/IdLPnRl28zOcsfw5wOEENWBOx4/Ha3lrmFcbZ6Xb+G5WBfBSs+aTHPQ5Qw9JQA6loklYmA9DcIAfyJ2D4zbw/3QxfZh3xvTaMLBkr8KHRhaS2MEYY+w87t4g4ZITabwOHiIP+sgRhu0lAM9tyLhnhRxkgevuOnct4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Aug 2025 21:33:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 64951 invoked by uid 111); 20 Aug 2025 21:33:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Aug 2025 17:33:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Aug 2025 17:33:23 -0400
From: Jeff King <peff@peff.net>
To: Joe Drew <joe.drew@indexexchange.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Message-ID: <20250820213323.GA1667633@coredump.intra.peff.net>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>

On Wed, Aug 20, 2025 at 08:54:37PM +0000, Joe Drew wrote:

> The fetch fails, returning status 255, with the below error message:
> 
>         remote: Enumerating objects: 18733, done.
>         remote: Counting objects: 100% (562/562), done.
>         remote: Compressing objects: 100% (448/448), done.
>         remote: Total 18733 (delta 399), reused 144 (delta 112), pack-reused 18171
>         Receiving objects: 100% (18733/18733), 25.32 MiB | 7.93 MiB/s, done.
>         Resolving deltas: 100% (14608/14608), done.
>         From <VALID-URL>
> 
>         [.... quite a number of branches and tags .....]
> 
>         error: cannot lock ref 'refs/heads/ptv-2164': Unable to create '/Users/joe.drew/tmp/./refs/heads/ptv-2164.lock': File exists.

> 
>         Another git process seems to be running in this repository, e.g.
>         an editor opened by 'git commit'. Please make sure all processes
>         are terminated then try again. If it still fails, a git process
>         may have crashed in this repository earlier:
>         remove the file manually to continue.
> 
> This file doesn't exist; in fact, no such files exist:
> 
>         $ ls refs/heads
>         $
> 
> However, the branch _does_ exist on the remote.

This is a wild guess, but: are there any case collisions with that
branch name (e.g., PTV-2164 or something) in the upstream repo?

If so, and assuming you're on a case-insensitive filesystem, then the
lock files would collide. You wouldn't see anything after the fact
because git-fetch itself would create the colliding lockfile, and then
clean it up after hitting the fatal error.

If that is the case, you can try using the reftables backend in v2.51.0.
It doesn't use the filesystem for its ref storage or locking. Something
like:

  git init --bare --ref-format=reftable

> This error _does not_ happen in the Apple-supplied version of git:
> `git version 2.39.5 (Apple Git-154)`, but does in 2.51.0, which I
> installed with homebrew. (If this is a packaging error, I'll happily
> report to homebrew.)

That is definitely weird, and not something I'd expect if it's just a
case collision. Is it possible for you to build Git from source? If so,
and the problem happens with your build of 2.51.0 but not v2.39.5, it
would be very enlightening to see the results of "git bisect". We can
provide more guidance if you need with that process.

-Peff

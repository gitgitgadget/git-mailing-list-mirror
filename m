Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B628E17
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163753; cv=none; b=abO1wrqZ2+x8b5y+B/FRcYIzglxd5UZw8Uzh2p2bhAQJk0e6VOOi1XZEl83RgokCKD4qUkrTsgGf3yTqw8Y4EOmPMfBhKtseHtp3kHIixCdkFGRokzNQM4AhlRWi6VrjyyujrpEuKaqJN8gnKHpmAtvozXJuEaEIsQEf3m5FXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163753; c=relaxed/simple;
	bh=8FVjpGYvbDkHiQsyDRDu5wKT8KLTRgJMdS5Cgbxl4/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHnkQBtH8BQjQGtRL6dILKw7SWMRS0JysD3j8gUbEPWGoVlkkyPVPx8i0H1EiazsaIUDBF5KSPsA0Gl5ESr/+VraUehUsfHrGoxegLYXosKvM75bidn6TxqdF+6YJM4CYiHksNbBojJoPQGGCCwFbs3KyDQpvt1mJVuRTYYTNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZJtguNkK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZJtguNkK"
Received: (qmail 23750 invoked by uid 109); 5 Jun 2025 22:49:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8FVjpGYvbDkHiQsyDRDu5wKT8KLTRgJMdS5Cgbxl4/c=; b=ZJtguNkKunQH7Y0Jq0HvNTT+cs0lYDVBzeUEZiouLtjP4G0IEw6ap5BEnbJCQJw5gPbNk5lK4yUn4B/w0hC/JRZHx6Mjx3lTkI2O0KFrNtFs9B/raiPp9LLARYEJtfAec0sO5kwKogLdY1mHExDnBvp8yDAXio+38e8gnSWDzcHGOAHj7AbkxJH06ZDc9YgwwDea+0oZwFd01m2O69noK5HCBPfSfJZ+rKTezhjIOTX3rrxNKYHyFJ5bfLZynumWuHsf2PYpvFhWzvYZQw5qtuX/hQtXcGnmaC99FdF/mX3xGqHB/Pxef++PVcrdgsU5exhUHngSsZrp6U6RZTQjsQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 22:49:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32358 invoked by uid 111); 5 Jun 2025 22:49:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 18:49:13 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 18:49:10 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] curl: fix integer constant typechecks with
 curl_easy_setopt()
Message-ID: <20250605224910.GB3005733@coredump.intra.peff.net>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
 <20250604205513.GA1510819@coredump.intra.peff.net>
 <9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de>
 <xmqqh60u9nuo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh60u9nuo.fsf@gitster.g>

On Thu, Jun 05, 2025 at 09:04:15AM -0700, Junio C Hamano wrote:

> --- >8 ---
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date: Thu, 5 Jun 2025 12:57:35 +0200
> Subject: [PATCH] curl: pass `long` values where expected
> 
> A set of patches posted by Jeff King earlier covered some fallouts
> coming from new typecheck warnings cURL 8.14.0.  Here are to fix
> some more instances of the same new compile errors observed in the
> `osx-gcc` job of Git's CI builds.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, this patch looks good, and I think applying on top is a bit less
work. I don't mind integrating them appropriately and re-rolling if we
prefer a slightly cleaner history, though. (I don't think there's much
value in recording which hit macOS and which did not).

-Peff

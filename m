Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9F2040B4
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973097; cv=none; b=d8mNeqxgyi5d1BmbRbof+0rlUMj4QJjofDcCs49tp1EjBnJjdKA0Gnzxe1wJiaVmthjIcUCbpcX8a8DyaOdqcea00WsvFIR0eI3BgiKwxYqdAl1QOoj+4n2AXZRBJTKndetngps2CTNqjFkPe0CbItGfcvTr1BDf/6+y7bfgHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973097; c=relaxed/simple;
	bh=j4KZHdU65cHZhjauXzgggop8BEec9wDiEdmcmun8My0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgvNz9g7RKtulnfyGSafm3GS2L1gWSfgcoX6O6yGlYB1WSxeMBQ0Ur7mBQU/N/5S+WROGL4PkJx3MyVxc2KLBCAqr8bv+XdS+OcvbTkL/5cQ9P6yd4yca9oQtdKZa/sLhb218yyAkJzf6zut9QGEmNmDVgdRzVWi4nvTid/2rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zu5Tm2EY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zu5Tm2EY"
Received: (qmail 20335 invoked by uid 109); 14 Mar 2025 17:24:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=j4KZHdU65cHZhjauXzgggop8BEec9wDiEdmcmun8My0=; b=Zu5Tm2EYaS3wqG4W5jhC+2kpzCBQDjHmvA2m5deIWvMRHWsoji9FIBxeKTOXzPe+T10+fGail7guLrJZaiYtVkxoUotHlupeJmetwiln2Q5FAYu052793lWS9yhIYdD/DLMCSZ4lk89+rRVidvVotqSlx/fCmASES+2SCLhBBWW0YIpodziGPCaS7iGz2DeUhW+RyzxHRTT7dNKMFEL309t7fearpA6wBO0cXMXtmuoTtzfN+MIhiE0H+Bg+ozgX3kWSg/pulua5LWRP5yai3sWTvDhSeGPcJSvTsMEAQM805DrJxa8eZBZrJ3zGgw3RiNpwCjPmZPeEKv1SNHSxjQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 17:24:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6525 invoked by uid 111); 14 Mar 2025 17:24:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 13:24:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 13:24:53 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Olaf Hering <olaf@aepfle.de>, git@vger.kernel.org
Subject: Re: BUG: diffcore-rename.c:1674: tracking failed somehow; failed to
 find associated dst for broken pair
Message-ID: <20250314172453.GA16215@coredump.intra.peff.net>
References: <20240920112228.3d1130f5.olaf@aepfle.de>
 <20240920130729.GA7349@peff.net>
 <CABPp-BFb1d7dbWdPwA9q_e6pLT6OHPr2SQC5ZwqXwkS74dXqdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFb1d7dbWdPwA9q_e6pLT6OHPr2SQC5ZwqXwkS74dXqdQ@mail.gmail.com>

On Thu, Mar 13, 2025 at 11:08:02PM -0700, Elijah Newren wrote:

> > Definitely a bug in Git, since we're hitting a BUG(). Looks like it
> > reproduces with just "-B --follow" on the path in question. Bisecting
> > leads to 9db2ac5616 (diffcore-rename: accelerate rename_dst setup,
> > 2020-12-11). +cc Elijah.
> >
> > -Peff
> 
> Sorry for the lengthy delay; fix over here:
> https://lore.kernel.org/git/pull.1876.git.1741395615315.gitgitgadget@gmail.com/

Thanks, I left some comments there.

-Peff

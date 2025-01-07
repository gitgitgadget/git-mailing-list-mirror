Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670EE573
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213158; cv=none; b=EumwyUHtZHaVcGbb0+hscydLrIu3YWtip76ARomytEpxs8bmkCvrTT2lB4wPBnrDxM1r3GydORYf3WlWDQ4ylAtH6fkb9dV7eMd1MvGrfr+dmBDfI5BVqMdm0MFtOYLaiOU6LgyTy8EfMBU5xoddcKF+0zItbq1Pgh0iSrwW3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213158; c=relaxed/simple;
	bh=Myi2E0MGi6a3buOh9IaJpVIUQVhYCpr3j/alf+UCmC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sprdkGgIzORhSOclVF8F+pq27q3OjqhYVzQS2ugKezohM2+UvYT1FPTC8poLmXg/8yG8m0S1vF49nlMTAXUmzUSSdrT7gtxpA1EOyjxUoItkCO+ZZUFDpC0sIZ4L5YQCZ4jQsZZYE6sB5Iz5+CR/YuhHQ3Ugb9l3YI6Alkr/lCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dr4xkQdO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dr4xkQdO"
Received: (qmail 26712 invoked by uid 109); 7 Jan 2025 01:25:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Myi2E0MGi6a3buOh9IaJpVIUQVhYCpr3j/alf+UCmC8=; b=Dr4xkQdOGqTvH/w2/CdLrujPzeTq9Lq9Qf5M+O/MTLzWYDoSAmzG5P5gEO2a5GgrWJRz68DLQolpeS6WFbCDHjnExsrbA0F89rznyORPm3COTgvBkkenLWHXJgT1+dmjEo4ZtMxzzmTyXGjbU3PcAtOltCwqGyIybeS8jR4MF218iIhAEyspzN+JReZtz/ft3SSTkQ0MmZznGJ0st3bE0poxIbz7U+j6aWXosXfRCiGp0RlmT9i9s7D9dnyr64/Rp88RfK2D8ap3tCPvy9Laz/IL0EyBbpmYfw3B1l+S4bUWbBW2xSfRTM3r+HwmtFOoJb08PF7QxV6+pzb0hUsUQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 01:25:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18447 invoked by uid 111); 7 Jan 2025 01:25:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2025 20:25:47 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Jan 2025 20:25:47 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
Message-ID: <20250107012547.GA2363@coredump.intra.peff.net>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
 <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
 <20250103194058.GE3208749@coredump.intra.peff.net>
 <20250103195942.GA3212696@coredump.intra.peff.net>
 <Z3u6c1UVQyZuHLdk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3u6c1UVQyZuHLdk@pks.im>

On Mon, Jan 06, 2025 at 12:11:47PM +0100, Patrick Steinhardt wrote:

> On Fri, Jan 03, 2025 at 02:59:42PM -0500, Jeff King wrote:
> > On Fri, Jan 03, 2025 at 02:40:58PM -0500, Jeff King wrote:
> > 
> > > I suspect there's a way to write this as a loop that would be more
> > > structured, but it would be a bigger refactor. Bonus points if it also
> > > get rid of the try_rename goto, too. ;)
> > > 
> > > I'm OK punting on that, though.
> > 
> > For fun, here's a version without any goto's in it, that should behave
> > the same. But it would be very easy to miss a case. So I don't know if
> > it is worth the regression risk, and I don't blame you if you delete
> > this message without looking carefully. ;)
> > 
> > Diff is kind of hard to read, so you may want to apply (on top of your
> > patches) and just look at the post-image.
> 
> Thanks. For now though I think I prefer to go with the simpler diff that
> uses goto, as it feels less risky close to v2.48. We can still refactor
> this in the next release cycle.

Sounds good. I looked over your v2 and it seems fine to me.

-Peff

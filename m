Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663628E17
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163907; cv=none; b=cCbWbC3J6ruxchcC3YOaQa+hgd/xRkX3Mh7nD2vR0eyW5TTdZfU8ujLl5AVnjYm9SrdLv5zWK+aIkq5AuGk3TRGka5yfY9hGhIAPOFoHc/AWtfSmredjujoYIs+UlRu2Ap+LtRIfMPVpUvmAT58SctAs+ueR1C/XbNtU4qAVSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163907; c=relaxed/simple;
	bh=wEidTMlexHA4tGYZqJIX13uENbhKHQ3wgM9BwteiuOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0v2k+O3t5iIRsFEfoZAQf5zTH2jMA47lhhhpOCxPx24UaFIyBIx+Kxp2fawGs48PxkXIn7wzCh7V3y+cFNORd+Ke4hFvL+KCz75Ip3Sf1WW29IjcH6gPqfXtrdsGdOKTvxIyWynFIZlN498kpArkdSuDUg534tCQto0n6zW2fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SmKVlLGC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SmKVlLGC"
Received: (qmail 23894 invoked by uid 109); 5 Jun 2025 22:51:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wEidTMlexHA4tGYZqJIX13uENbhKHQ3wgM9BwteiuOE=; b=SmKVlLGCTogio4tBpPAdXXLars0QTxCW5r8wFD+Wr5uU2xMyep5AtNj6NcEPOztOr6QcoitSCIpq87zuqiKUtLwyNUteeTaTnHN0P22urOTPIMvDiPEScTxgLkDtgpbPIRfW0MVZbS3nebh8bw8F27x9Cx0U+z+2HfN8f22jSMYCJbLfwPHQYRUWyI6lgo2QMROqpTxTeVwDVdC+IPz+bSCVEf7v+HKF98D4afUpc63GhetCIUqSijsaCn9oXQRfvvmWPPsr84muy7OCipdUanIZupLh8c64U4AqwKhU4Kd2q1PBFIzboHgnciRR2plB88FEa5l5ekb1nGl5iX6TtQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 22:51:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32431 invoked by uid 111); 5 Jun 2025 22:51:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 18:51:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 18:51:44 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] curl: fix integer constant typechecks with
 curl_easy_setopt()
Message-ID: <20250605225144.GD3005733@coredump.intra.peff.net>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
 <20250604205513.GA1510819@coredump.intra.peff.net>
 <9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de>
 <xmqqh60u9nuo.fsf@gitster.g>
 <20250605224910.GB3005733@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250605224910.GB3005733@coredump.intra.peff.net>

On Thu, Jun 05, 2025 at 06:49:10PM -0400, Jeff King wrote:

> On Thu, Jun 05, 2025 at 09:04:15AM -0700, Junio C Hamano wrote:
> 
> > --- >8 ---
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Date: Thu, 5 Jun 2025 12:57:35 +0200
> > Subject: [PATCH] curl: pass `long` values where expected
> > 
> > A set of patches posted by Jeff King earlier covered some fallouts
> > coming from new typecheck warnings cURL 8.14.0.  Here are to fix
> > some more instances of the same new compile errors observed in the
> > `osx-gcc` job of Git's CI builds.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Thanks, this patch looks good, and I think applying on top is a bit less
> work. I don't mind integrating them appropriately and re-rolling if we
> prefer a slightly cleaner history, though. (I don't think there's much
> value in recording which hit macOS and which did not).

Ah, nevermind, my patches are already in next, so building on top is
definitely best.

-Peff

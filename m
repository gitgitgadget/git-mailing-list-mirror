Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACB33F8A1
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348105; cv=none; b=o57VYpGEzhtFKcKfruhLHGEUUjFjmfYqnxWLCC1R93ERdkirumRvkqNepJWjtEylSjxod8ig4qDVDl6IspyVf639pp1Mid/I3O0B25yhcdsBAezo4YXUCd1/9+7vm2R0MCM6y+s+w3l1mr5x2/+tDMKqB/LtruRjX4sw1c7s3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348105; c=relaxed/simple;
	bh=0tQhpLiTuujVxszZ5FCYROC8hAkCMvi4SZ0DEjEYRFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro7Z0G+tKVnJBNL2vWeL+aeHBQ5gYk7z8Sb+gYTd8Nv2WHPVvbjyeViDQ74Vt8obbKwk9waAuZ9Flu8EMGdbcTBRRxLkuNM6vEg08n+SvrZ2nx/Aj3Zi8o2IsycNBmC5pj+QKa2WTjhQRBKvCure166yenEA41cgZOblTTqxox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eQoUdIfT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eQoUdIfT"
Received: (qmail 90189 invoked by uid 106); 12 Mar 2026 20:41:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0tQhpLiTuujVxszZ5FCYROC8hAkCMvi4SZ0DEjEYRFM=; b=eQoUdIfTZMpL+G58zC6xnbZaYVV/rarBrvB+9zYY73qxOjttcqYPIyRYCIQhhdgVcLl23JuR7tIsZm76WKfizkzZiYLTVVAtiSMChUPJin3k/V1Mhw84ILkrpkGLq1ZHJ1UpD4gKwGxbMwv7ymX17c/MBdorM0CU9yS/Sm/lT+412HaJL5xmxYBujaNNYxoWkOtq1JiGAWJ+S6k/MjtHpsyT72SOYUfRQLdm1lmgc8121RoU2+nueU89q3X38OTt9699qg1L9Nm0CWpS5lgme+cNn+YfmyCnHuW2SSjH+bztDSjOXZacq2kI/y4eTRvj850ohnTF0uBWi2SSwJ2MuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Mar 2026 20:41:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 511010 invoked by uid 111); 12 Mar 2026 20:41:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 16:41:45 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 16:41:42 -0400
From: Jeff King <peff@peff.net>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
Message-ID: <20260312204142.GA2553488@coredump.intra.peff.net>
References: <20260311184206.GA1911377@coredump.intra.peff.net>
 <20260312195813.4006430-1-cshung@gmail.com>
 <20260312204023.GB2552877@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312204023.GB2552877@coredump.intra.peff.net>

On Thu, Mar 12, 2026 at 04:40:24PM -0400, Jeff King wrote:

> > Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
> 
> I don't know if we have established a pattern in the project for
> AI-assisted work (and whether it is worth marking at all, and if so, if
> co-author is the right way to do so). But if we are going to, usually
> the trailers would all be together, with no blank line in between.

Trailers aside, we definitely don't want it in the mail's cc headers, as
that address bounces (unsurprisingly).

-Peff

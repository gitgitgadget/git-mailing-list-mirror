Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F38821
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750483015; cv=none; b=Ah3NG1+xZJLl5XIHG1Rp1yBHS5TdfpXDSw2rL6sce5SWieSEfb3+udoIg/O6FtLTs7lm/dj5wqZ+rWi/EHU8IGCXJpCyFjy4gpLJ0Z8SJpfNyDqf50+IW9nEXivfGdnvJOF7CO2MeDuaX8xcsNI1+L2SvoYBe0K1cH6ouRuQ8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750483015; c=relaxed/simple;
	bh=jiNVTLTPppjVmqnTKZSVCfimEZyaWWckI0+QUc4nO8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNxp2WxjtPBfvpSR5OKhrCqI+4IH92f63R3E49KdOGCKCllOiL6yWssTiBYVdkVhMjZlWyxoKYne6Vc+vxmt+V/kJWquu/UpAZPea/QA39unkU+3JXGdEKNRdNMhPpxi/L+9kJF6ok5g8CPRQz9da5KEROohbSXiV1UAGE6HNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c6/iHvMb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c6/iHvMb"
Received: (qmail 31739 invoked by uid 109); 21 Jun 2025 05:16:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jiNVTLTPppjVmqnTKZSVCfimEZyaWWckI0+QUc4nO8U=; b=c6/iHvMbKbexL6WQc6RNMLTuMl2RVJZkJoJQLEZUjutiguj3DhTmPjH5XjJHkJh6eKd53pyN05q3SHcZNoEOdV7PSYyFjBOydJLRDd5PA95aDRD2SI8+X57amJGWMs0RiagZJ2baUIGWYy8tWwsPko6zUXGk2cLMA1OfDtWuKmommxMm0biCW4bjFcbiAfjB8n3zrkTYOdvCaB+zaSm3I477vYbrksNmkzqxdmXp1xtNtPwVlbRG341QNFim5ZodB/SrYAPkUwZeUtnVb0aU7GKCLcC1TG2PsCwTRZYv+TarHyO7bj2YzzAFB+WHdAf0TRNlBDMgVgMGPwFm3IxosA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Jun 2025 05:16:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12521 invoked by uid 111); 21 Jun 2025 05:16:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Jun 2025 01:16:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Jun 2025 01:16:51 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] coccicheck: fail "make" when it fails
Message-ID: <20250621051651.GB3002138@coredump.intra.peff.net>
References: <xmqqwm97bv7c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwm97bv7c.fsf@gitster.g>

On Thu, Jun 19, 2025 at 08:35:35AM -0700, Junio C Hamano wrote:

> With "make coccicheck", we generate contrib/coccinelle/*.cocci.patch
> files that contain changes suggested by semantic patches, but "make"
> succeeds.  Admittedly, not many developers may run "make coccicheck"
> in the first place, but it makes it harder to notice when they do
> run it after they introduced an iffy piece of code.

I admit that I do not run coccicheck very often. But I have definitely
been surprised by it not triggering a make failure when there are
changes to be made. So I'd be in favor of this patch.

-Peff

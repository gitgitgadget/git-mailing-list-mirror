Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88837C902
	for <git@vger.kernel.org>; Fri, 29 May 2026 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081497; cv=none; b=gHlv4N2o+fnjh1CqOKy4U0rSPXXCm2Ie7JbYSC1i05m0rEOudSKFwsaUwZXIocvtHoUEEeDHxv0ByLCyM3ox8IuAIS0bpWkIJBe3LyVVEUqKyF51zPIuTn3zPEON/JYhg8smaNYbKYlOOedSyXz27eIKtdV84mGRVqYzPJj9eNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081497; c=relaxed/simple;
	bh=ygaYxdkuDbwaTnhk4tVZozQt/t7Bqs0KOzpnWKgiX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFB2Py+xElY07uNIO1AQRFHqSZLYXVkYRbtBn4pcZ+zyvB+ja40Tu3NbyOG4D7cV9jgigbFlkG+ByJrmU8u6hEWy3Xv01FnPDXahMlIKWcfUPFFG7iK27odvsLrrIxcGsdkKFiLQG2RJmY1pO5au5lo+0l31e3R96NWweNUkDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FoZN1csa; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FoZN1csa"
Received: (qmail 9323 invoked by uid 106); 29 May 2026 19:04:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ygaYxdkuDbwaTnhk4tVZozQt/t7Bqs0KOzpnWKgiX3E=; b=FoZN1csad+XyDnnHAOlBpLyCpSu7T8ZaDqnSlhobDzvECfKfxMHmXbXD/zCAbN1L057W9LRQE4cXNE3l8VIqZfTtwn69Nd/BOpTixSoRgoCY21ryuBQhLcM2f0sW5/aJ49G4ksWr4kMNedkEBKxXJHeFoMMZe7bCAHzhSR07SebgMiaLxp3elXBmrwo0vREBUxMySwIBjAsXCyi7je6rLy3amHCs1IsuHPnJyq2rztSbWE2oN/MLnaSdotqhD7w1TjfOEbBf4V51C0XmFTQBtsLmZiue49V2etuUA+lWvLq1pKB0su1f0RRFXo4MSgY4rF33hc3sTVPCfgQdcLCtww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 19:04:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17479 invoked by uid 111); 29 May 2026 19:04:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 15:04:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 15:04:53 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] commit-reach: stop sorting in paint_down_to_common()
Message-ID: <20260529190453.GA1711766@coredump.intra.peff.net>
References: <450163b0-82c8-4b57-baab-a269efe430aa@web.de>
 <20260529084325.GF1106035@coredump.intra.peff.net>
 <107314f5-0057-4ed3-9bee-9dca4f424bd1@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <107314f5-0057-4ed3-9bee-9dca4f424bd1@web.de>

On Fri, May 29, 2026 at 05:32:58PM +0200, René Scharfe wrote:

> > Seems like an easy win. If some of the callers do not even look at the
> > result, could we avoid building it at all in those cases (e.g., by
> > passing in a NULL result pointer)?
> 
> Yes, at the cost of adding NULL checks to paint_down_to_common().  Which
> is probably worth it.

Yeah. I thought it was only one line (where we append to "tail"), but
there are a couple spots where "result" is referenced directly.

Another fun fact: it looks like paint_down_to_common() makes sure to
clean up the output list before returning an error. But the callers do
so, too, which is redundant. That would go away if they just passed in
NULL. :)

-Peff

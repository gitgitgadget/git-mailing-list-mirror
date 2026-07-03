Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B23451B0
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062051; cv=none; b=MY8GlF7p3fy66UsSq2NdqADVMXyfBZgSPDG6WoqrQYzPiFGCh2oW3obtBTnoSUUlSRa4gF3HNIaCbFo/RF6PDndsM5mIJTZcmXqU9V6br6hTlwFU83vFqXDIPI256okxKlfSAmUUIexwwf2UsqpYXufZwtIkFEAahUpRXOD+ZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062051; c=relaxed/simple;
	bh=vzNocTzwieaih9eSNV3WY4kX1gaelchxYMJ8ItkSZXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIovkLRTWD7mEvvqAkg9KHNSqG1dTD/7KekpBiCB7Y9kAvflIQieruAd2eGW081g61zAhX8vMLOUR9xCWAnX4gbEPa+nf/+iQ101Q4Glfli0uw+kDopk2rdYg5FYkfkikT++bZrNU0COa7iAigkfOR+X7vUqR7chJ8wsCnhcp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=goK588cg; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="goK588cg"
Received: (qmail 91238 invoked by uid 106); 3 Jul 2026 07:00:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vzNocTzwieaih9eSNV3WY4kX1gaelchxYMJ8ItkSZXs=; b=goK588cgR1/lFRcbmyfghlBdhTeB44cGYUzfbGb/A/4DS4avzuujnxDQAs8TKAbrNaySRk575jtFMFBZUaOnWwbIXZD8KHzqA1udtZAurguAOYGFkBAuuS16ylcLlfUMDv8od3WHOjHXga4ljx9TfhEKBLAgiI6rYlrNhuan57Itx/1ZNx4QL47v//f2nugpRQjAUgTOnWf6M+Pm7DmOxuQ39x7azzoAF3633yxQ45vy5sXBeA1wuqEV5Xn05ONL5wdOJvGcLGAISwsERncOhrKPO1MsgwH+lT7NxDp+TOV1n172tbACejP4Vyw79UjlCgBDF3iyKqiEvg990bdYww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jul 2026 07:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 194008 invoked by uid 111); 3 Jul 2026 07:00:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jul 2026 03:00:48 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jul 2026 03:00:48 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/9] t7900: clean up large EXPENSIVE repository
Message-ID: <20260703070048.GB2082500@coredump.intra.peff.net>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-6-76b4d7bab3d0@pks.im>
 <20260702213044.GD2051171@coredump.intra.peff.net>
 <akdLryzNx1Vi2BnL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akdLryzNx1Vi2BnL@pks.im>

On Fri, Jul 03, 2026 at 07:42:07AM +0200, Patrick Steinhardt wrote:

> > Hmm, I hoped this would drop the time to run t7900 with --long, but it
> > takes about 1m40s both before and after your patch (vs ~6s without
> > --long). Just looking at the script, I'd guess that it's because the
> > subsequent repacks are mostly incremental or geometric, so they don't
> > need to write the big pack.
> > 
> > Oh well. It still seems like an obvious improvement, though, both in
> > terms of peak disk usage and avoiding unwanted surprises when more tests
> > are added later.
> 
> Yeah, the commit message is a bit hand-wavy there indeed. I think the
> bigger argument here is that having a test that is marked as EXPENSIVE
> and that may influence subsequent tests is just a bad idea.

Yes, very much agreed.

-Peff

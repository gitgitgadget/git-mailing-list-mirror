Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA441EB1AA
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651550; cv=none; b=av7fEjK0jAoxlDJyPO6umuCb+Q5KflaXPneTjdhUHcWwkoc3scj3GXS609WxacTtxPYZ7vo1mqgnjpDHGIVd0gyukwhjnZ4AAzg9VUxfXSmJokDrSBsMOU0zIy4qaT1qqOgO05tehtkmWYJdi5OgLE8qv0+s+aFBWPlrHOOik8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651550; c=relaxed/simple;
	bh=ydHCFMIoSeZfBkCM8YcSXZZpAeyoRneezSiYzdv3Ue0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2GImMaXQonmMWUu15yU6y/SOrTiN599QR0t0EtkmGEkkfIaXgMMUWEhwjmoiijgx/x7VfzTnN4JpK4hp/rmatKJcaQoenfhuiXeHNn3XSaIZalOam3Gafxg51m+pLKRKaj0nqPlcHoeii24Tath9p3XdYRZw+Blp9kTlGGvFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AD3pM8OC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AD3pM8OC"
Received: (qmail 11643 invoked by uid 106); 17 Sep 2026 13:25:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ydHCFMIoSeZfBkCM8YcSXZZpAeyoRneezSiYzdv3Ue0=; b=AD3pM8OCDCxgQE39kVLvv4PHnw/E6y4KWcO2lm1urT6HNYvGGobrM4NTLwsmyCzfHKjXnymOH5d3ZOOzDjDW4Hfe5F6+G+Cx8fo3ic3U/w6OZ1d1Bo57UxkbdQRkM5IUrZ041EKyUsyd4ihHzFVeZfj7OUMrSBWwhBVMef6lIsGJPnvS55wYt3v/ivExFzRyzZ4Z9jRg9Iq4aGu3IbpaBmtQYurLcD6Wm+hvnVHvGck2Wzv3mAu4NHB3V09uGazVlpM4Tuy2wlTXchmL+j6Qat4xJfoA7P71d/GRMSm6IAH6pb53tR3N1tJ8huoVf+Xxfxo+901fTVyKbfHCX10txg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2026 13:25:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 101556 invoked by uid 1000); 17 Sep 2026 13:25:40 -0000
Date: Thu, 17 Sep 2026 09:25:40 -0400
From: Jeff King <peff@peff.net>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: gitster@pobox.com, ben.knoble@gmail.com, git@vger.kernel.org,
  gitster@pobox.net
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Message-ID: <20260917132540.GA101514@peff.net>
References: <xmqq33vb4hma.fsf@gitster.g>
 <20260917140350.44760-1-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917140350.44760-1-ub4nal@mail.ru>

On Thu, Sep 17, 2026 at 05:03:50PM +0300, Vsevolod Myalitsin wrote:

> Junio C Hamano writes:
> > So to conclude the topic, we would only need this?
> 
> Yes, I think this is indeed where we were heading.

Likewise, and the patch looks good to me from a quick read.

> However, during the discussion I really liked the idea of passing a
> pointer to the "advice_setting" to "vadvise()" instead of passing its
> individual fields. It seems like a cleaner interface, even though it
> is not directly related to this fix.
> 
> Would it make sense to submit that change as a separate patch?

I think so. I probably would not have looked into it as a cleanup on its
own, but since we already spent time thinking about it, let's not waste
those brain cycles.

-Peff

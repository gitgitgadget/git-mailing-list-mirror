Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60101EEE6
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132404; cv=none; b=kfZkA6MXjXDgLM1c09vBF7oJHadpRO1HBuC4X7EkY+kHHI9G7LdZ8AUd+RanQybFHL02Cuw+riiWeStxQs12hrnBXjdbMQCzA+SxZ2Pf7FDTgLMqHJ4LVsKe/RQz0mh2GOJOOydEe0JE3Giy9TA3DS7pWiXE5y1hALmVBEFvsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132404; c=relaxed/simple;
	bh=8Ba2ut2+IA3nm2gwjlbWDaO1sqPXnTDrBDSdrB3BvHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7gK2zwIKQjT5ktg3cClLPnHLGp6UqHSFkOEri0Hb1nix/Fi4lGHavXAGSbqxFGNiaNALFsbqU62GQJGUUjEjgBo+VfEBBliW+ulHvwwEFrHOZ1cI78Pzmqj488UMpZDIMn6IPR2t/CBmjfJ1n0jtMsTtGoDo1apnHFSOlJhHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Nxq8rBIB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Nxq8rBIB"
Received: (qmail 22895 invoked by uid 109); 17 Oct 2024 02:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8Ba2ut2+IA3nm2gwjlbWDaO1sqPXnTDrBDSdrB3BvHI=; b=Nxq8rBIBGK4L5Dx9aVaDbatVlw2U6xFVV9+/CIpFQytSVbAVglXf83bJHEGUGsMkZQiXWmWbppw+RZnHCcyApvjOtqen1fGhS4zm8VWcKmteOdktRgPilfo9qvDMtums4IR5v1dK+yndYWlH+I9whbTuMoVTd+Uh3p/HHC06hessYFnoL6K1qzdvFEWga9CzVHYk6WsJIUSiLQkr3dYtd6SpNBQ66KakV/uCKZSA1skQII1wGEw02UkyZIN+oSdDtiJmNGFrh0pZbFzQtlyp5gfJ3+4JOemWpr01r177wW3C6eHKWCkwFIs4CJfb47hUJGeZf1DENMZtY2m5KU6dPw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Oct 2024 02:33:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27239 invoked by uid 111); 17 Oct 2024 02:33:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Oct 2024 22:33:19 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Oct 2024 22:33:19 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <20241017023319.GA1858436@coredump.intra.peff.net>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
 <20241016150922.GA1848210@coredump.intra.peff.net>
 <ZxAiAUdtddwk5RS7@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxAiAUdtddwk5RS7@nand.local>

On Wed, Oct 16, 2024 at 04:28:49PM -0400, Taylor Blau wrote:

> > This all seemed eerily familiar. Try this thread:
> >
> >   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
> >
> > It looks like the conclusion was that we should adjust errno handling on
> > the client side, but nobody ever followed up with an actual patch.
> 
> Thanks for digging. It would be great if you both and Ramsay could unify
> on an agreeable path forward here.

I think the patch Ramsay posted elsewhere is the right way forward.
Hopefully he can fill out a commit message with the summary and then we
can proceed.

(I'm happy to help with explaining the credential-cache side, but I
would just be hand-waving on the cygwin parts).

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374D1CB337
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177329; cv=none; b=gTXVng1hTXCk8t1Ae5K+jvzQnO7ctNQPkylhKAsrsyKHDufozqRtdk9BULzXoqnrh66MHAt0newKWizSHUKwKmoTwX09+L4npBbT0CH66q5WOviMmstaSrFDcMmNXOjCYTrouN4B5LjJ32o3/02tT0pis+ja2fR8rj1Ke1fFkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177329; c=relaxed/simple;
	bh=nM7tlqtyb8oO0Igsdt0/OM+mklvJ1CWUMCDjkAduQjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcV9VaZ2nu8g+NrORdOw3r0CDGHAQMDy9Hvu1jy8WBYvsG37ythiSAEt4SBhUO7lVKgYjRSDD0OCYYzY6UiSNIYiP7m4xKmNutD3hqiDinzp7FUlUwSxk9iFx5MfFgi1lxr/KEJ6WyDNAh7305pMEMZZz4Ol+upUm/fycuusgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SV5LWB8y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SV5LWB8y"
Received: (qmail 29668 invoked by uid 109); 21 Nov 2024 08:22:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=nM7tlqtyb8oO0Igsdt0/OM+mklvJ1CWUMCDjkAduQjY=; b=SV5LWB8yUQ/XEtRb8H9Zgq13jdRE0cLtzi7Q5KoaHQg1gIq3ZUg6x3vGSD3wfflqTzYXYMtkKOZwZn0qwq5FQ/kF4ITSAdoV8nNafGFAuLGMsu/fYu9HFa9OcluWTXjNxkz8eEoJ33ZpR4qjHZlU3eGcAHdC9gCyUdjpKU5KySQBcsEOblAGOP1Zh5xPupqZrb8E2WTq4W6Y3ufkD1uCGsq8ZsPw7dwisYdb12TsEvfh8T6VnqOnBFgYIUYdfwcKULrKJLcSLHlaQ1F7MImHGzrge4AX0SQZjRMEcE5y5Wu+/M6mi2KqkxY4hQeCmhwgFxS7VRuWfehNpmXHZaD9Zg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 08:22:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22169 invoked by uid 111); 21 Nov 2024 08:22:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 03:22:09 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 03:22:04 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 09/27] strvec: introduce new `strvec_splice()` function
Message-ID: <20241121082204.GB581647@coredump.intra.peff.net>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
 <877c8yti5n.fsf@iotcl.com>
 <Zz3Y35YI9ysFabUJ@pks.im>
 <xmqqcyipijma.fsf@gitster.g>
 <20241121081146.GA581647@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121081146.GA581647@coredump.intra.peff.net>

On Thu, Nov 21, 2024 at 03:11:46AM -0500, Jeff King wrote:

> Looking back in the archive, though, I think "people" was Jonathan
> Nieder and "push-back" is probably over-stating his position. This is
> the closest thread I found:
> 
>   https://lore.kernel.org/git/20141209222337.GA16345@google.com/
> 
> I dunno what any of that means for now, though. I am OK officially
> declaring the "/**" thing something we we do not care about, if nobody
> is using them. I've added Jonathan to the cc in case he has comments.

Also, déjà vu:

  https://lore.kernel.org/git/20180927182528.GB2468@sigill.intra.peff.net/

That thread has more back-and-forth on the subject, but unless you have
an abundance of spare time, I do not think it is worth reading in
detail.

-Peff

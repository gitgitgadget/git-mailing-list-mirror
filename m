Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F356611A
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707021677; cv=none; b=cOJXjXYj4XzR4H2+4RV0Zn09xCxl1pUzSk/GNRaPNG/bLftyIJono5Q3gkC+iuxG3KEsEojLnHopPsMJwIW3buLl80AkXXUBJLZITB7phzQAXaNptC+owMGBC6Ud1+kEf0+6Sz/N/HWjxLhF/11UnuhQ7YYDo0Ly5REPXPOw3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707021677; c=relaxed/simple;
	bh=kyIbpB8+3X7Jmmdwq3pUPQSHh1wwRZiNTitxKgN3EtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCViMbYnNHSK4i0IhmrUNYaSPrynuFWZcIPtbc6vlrbOnGwGNVN1U5LKO8lNQZtgul1/EDkMiUnZ/ehFwgnPWMlPTan77Kg9rB3qUkTeBmmEWCLlAX0gs93PQPe/kKOEQC9u0YOdhwHffLEbnaHnhhIELbJNfPJKShPhEjlT7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28076 invoked by uid 109); 4 Feb 2024 04:41:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Feb 2024 04:41:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18482 invoked by uid 111); 4 Feb 2024 04:41:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Feb 2024 23:41:06 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 3 Feb 2024 23:41:04 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/3] some unit-test Makefile polishing
Message-ID: <20240204044104.GA295803@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240130053714.GA165967@coredump.intra.peff.net>
 <xmqqh6irwtkd.fsf@gitster.g>
 <b7b92f1a-9231-2f53-299e-ad58fc699284@gmx.de>
 <xmqqjznmtjr9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjznmtjr9.fsf@gitster.g>

On Fri, Feb 02, 2024 at 05:32:42PM -0800, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The line 753 of that file (as can be seen at
> > https://github.com/git/git/blob/38aa6559b0c513d755d6d5ccf32414ed63754726/config.mak.uname#L753)
> 
> Ouch.  When it is laid out like this it is very obvious why this is
> broken, and what its workaround should be.
> 
> Thanks.  Let's queue this on top.
> 
> ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
> Subject: [PATCH] t/Makefile: say the default target upfront
> 
> Similar to how 2731d048 (Makefile: say the default target upfront.,
> 2005-12-01) added the default target to the very beginning of the
> main Makefile to prevent a random rule that happens to be defined
> first in an included makefile fragments from becoming the default
> target, protect this Makefile the same way.
> 
> This started to matter as we started to include config.mak.uname
> and that included makefile fragment does more than defining Make
> macros, unfortunately.
> 
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks both of you for identifying and fixing this. I should have been
able to catch this, as it triggers with a simple "make" in the t/
directory (rather than "make prove" or "make unit-test", which is of
course what I checked).

Sorry I'm slow to chime in; I've been offline all week (and probably
will be for another few days) due to a family emergency. But hopefully
with this fix the topic is OK now.

-Peff

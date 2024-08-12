Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8B183CC8
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474090; cv=none; b=eTFrIX5dQTzwwwwap6OttA/GGAh2ORRuKOc85nHFm3iQreBFoyDXv0agUOB7HhLO+nvQgqe6LQThtVOXb63UyDw3gvPioWjicl/NnnlkclL2Xs2MM/ZEScSxndYBzl2Avy4geioWSNhDkcEni397zlYQMLSc1JwaKylyjF/pGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474090; c=relaxed/simple;
	bh=OCvw1Cj32jFbCsmgt/pKiavTaY4guYEKxzxDrydA7iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD/NwkCoHQj9KHfIHUJsJoF0a86Ep0h3hph4Ks6wLHy5RMl0ueuFLe4FDpKwrVPAEQusbApyAga4x3KX1cQkNwiRq2zaMS/49zc19jlNPrRcEhJnjuO5kktsivHL2XiGdqjT0w1u4fQd+qvZ+5L2co7pJmNXct/Avq8U3myYUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29468 invoked by uid 109); 12 Aug 2024 14:48:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Aug 2024 14:48:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30064 invoked by uid 111); 12 Aug 2024 14:48:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2024 10:48:07 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 Aug 2024 10:48:06 -0400
From: Jeff King <peff@peff.net>
To: Kim Scarborough <kim@scarborough.kim>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Git and gettext
Message-ID: <20240812144806.GB3800004@coredump.intra.peff.net>
References: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
 <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
 <7d507ea2-08e1-4597-bff8-8a2b40a01747@scarborough.kim>
 <Zq5qNwmTpL1H5LH0@tapette.crustytoothpaste.net>
 <1d6e0fef-9b9a-4239-aced-d20cd5c3434c@scarborough.kim>
 <20240805005311.GA66003@coredump.intra.peff.net>
 <97f1ca52-85b1-443d-a52c-67fce2e25f98@scarborough.kim>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97f1ca52-85b1-443d-a52c-67fce2e25f98@scarborough.kim>

On Tue, Aug 06, 2024 at 04:52:39AM -0500, Kim Scarborough wrote:

> On 8/4/24 7:53 PM, Jeff King wrote:
> > If we don't have msgfmt, I think git-gui invokes a custom script via
> > tclsh. If you also don't have that, it will fail. Running with "make
> > V=1" makes this more obvious, since it shows the fallback command name
> > instead of "MSGFMT".
> > 
> > If you don't need git-gui at all, the simplest thing is to just run
> > "make NO_GETTEXT=1 NO_TCLTK=1". That's what I do, and I have neither
> > msgfmt nor gettext on my system.
> 
> That did it. Thanks!
> 
> Would it be possible to modify the configure script so that it checks for
> this stuff?

Probably. It looks like the configure script knows about both gettext
and tcl paths, but running "autoconf && ./configure" on my machine
doesn't disable either.

Looks like the NO_GETTEXT test is checking to compile against libintl.
Which I do have (it comes with glibc), but I don't have the other tools.

For tcl, you can say "--without-tcltk" manually. But if you don't, it
just assumes "wish" is present without checking.

So I'd imagine that both tests could be made more robust. I don't use
autoconf myself (in the Git project, it is an optional layer that sits
on top of the Makefile knobs), so I'll leave that to somebody more
motivated (and hopefully more familiar with the usual autoconf solutions
to these kinds of things).

-Peff

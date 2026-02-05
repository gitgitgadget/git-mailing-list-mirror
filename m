Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E2241139
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284270; cv=none; b=rNnYdnmpDUZAcncnOulvyoIJi9c3oDzyemMnvrvf1ewHAN1DTLLRLpNJB+5LNP46JG4s8jmRAaDed+cx98ECSKwMdwmTbJJXI/O0v5VeNo/vIzrk0+jyw1dUkgDrskZDXT7Zd8FC3K3Xn7fk7LrqNn2q6wgldOdnGkAMogf5GAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284270; c=relaxed/simple;
	bh=ap30mfgs7shTVM9OYZLqVmHdGhSRr6B9QH0tEs1pz64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzK8vmkZodeykXMGLP7/P/jB1z5TZT2xonSV/FgICC97Ofd0CczKviAgMweojPTcrbTNiGcLp5HzrA0U5ccPZCTfxU+zki3OCzZAQXU547mFWZfyooowK43YrqlM0Tmi0Kyi0GD+k88nQ+zrIgjAfIm95pqSGK5xiVJx4H2vBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E4vJUwp9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E4vJUwp9"
Received: (qmail 290509 invoked by uid 109); 5 Feb 2026 09:37:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ap30mfgs7shTVM9OYZLqVmHdGhSRr6B9QH0tEs1pz64=; b=E4vJUwp9ppbdmuEun/taleDBQkqanJWr64+6nagBNlpObRM2AEPTverFyHm1DUIozfBRt4Pyfbg0ohHi8aFQIg/e+n9ALooa5OUjmSeaUxhlxiZFBFi95ZkNKAo07+xb6Rv7xWS92UC94tiQnN0xqelabBO+bfIkiIeRcXiTZ1nH9fvp3LPMFwHopIIpNO9BRnFnbaT9MPhDKM0weiOH9JBQ9PfnTrovb+DFCwQX/9s07tk+Bg0tnugq+cWPHr5Ah4ELHYwZghuq1gVlkZMq11NYuxLjvmHmAAOha+dSdruNMJRf9Bh56yBGoRY+UENjHYjU/aIuzRDNGhLR/nxbIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Feb 2026 09:37:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 574576 invoked by uid 111); 5 Feb 2026 09:37:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Feb 2026 04:37:53 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Feb 2026 04:37:48 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
Message-ID: <20260205093748.GA2177239@coredump.intra.peff.net>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>

On Wed, Feb 04, 2026 at 09:38:11AM +0100, Patrick Steinhardt wrote:

> Wire up both gitk and git-gui in Meson as subprojects. These two
> programs should be the last missing pieces for feature compatibility
> with our Makefile for distributors.
> 
> Note that Meson expects subprojects to live in the "subprojects/"
> directory. Create symlinks to fulfill this requirement.

The GitHub Actions win+Meson job fails for 'jch' with:

  Project name: gitk
  Project version: undefined
  Program sh found: YES (C:\Program Files\Git\bin\sh.EXE)
  Program wish found: YES (C:\Program Files\Git\mingw64\bin\wish.EXE)
  Program chmod found: YES (C:\Program Files\Git\usr\bin\chmod.EXE)
  Program mv found: YES (C:\Program Files\Git\usr\bin\mv.EXE)
  Program sed found: YES (C:\Program Files\Git\usr\bin\sed.EXE)
  Program msgfmt found: NO

  subprojects\gitk\meson.build:28:3: ERROR: Program 'msgfmt' not found or not executable

I didn't investigate, but presumably it is related to this topic.

-Peff

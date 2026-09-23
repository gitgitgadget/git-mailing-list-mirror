Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD43B7B7D
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191523; cv=none; b=mRBH40Pf6YFrJfKgJNIAp/AGKyUQQBaRkABk11OVGQGY0ZMB2QJ1E5FMRQp/4utlm3roZ4qfRj71fjuxwH89fkZMbkn/Fo2NzvdKmjXjacQSV597+5ud9y72PwY/CeOplLSy/1LJLmmpyNeF+5mBFvXLRdYZTcEDwWOUu12/qL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191523; c=relaxed/simple;
	bh=RyYiQ7oQzLfvO1k8Q7+i9FoV4e/U/GlgFX4a2sPZKbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4taQp+KlwPr8hVbr3nRq2bXKpfqru8Il3sCL136nqlcgIo/FhHQdEE8hY7QHeQeOvg2fHak2V3A/XeDoc1OUS0HR+czWhfNr7X8UYV0/24kkYZBrCPcXQwTsbh9kbjmpPmTUtKTUuQ3BYzKeOyjogflt9bm2dR9cDAcgApP52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eazr4jvi; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eazr4jvi"
Received: (qmail 35468 invoked by uid 106); 23 Sep 2026 19:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RyYiQ7oQzLfvO1k8Q7+i9FoV4e/U/GlgFX4a2sPZKbI=; b=eazr4jvisq39HQRtcs3S+IyBDGBUGwQV5WdA0GFzUWzg8vhtfovj/v3MIUThjO02aBgVIhjmj5YmTkUohM0WSRhYqK1dNoSE4W9S9Bn+0WYMhxP2E1jw66Tp9E+ZgF4t5gIc2LnZlm/26kKMuwnSYLTtypHH0Qz5KwgrxqM9r/NNIkhiXd/dAHtD5W/7S3kSXEUa0i7UK75OISAXyADtEPisS1TKvyDTmTFkPtozFaFC0sPfYgoedRhUly3yN9cSqudU4oUy83a9MhYlXNyGPmWYCp10Xs03ym8UpjI/cOG5NzOmCWGlweNhgWKPc2H3qAvInys1nWO557C4xkO/IA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Sep 2026 19:25:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 183057 invoked by uid 111); 23 Sep 2026 19:25:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Sep 2026 15:25:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Sep 2026 15:25:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication
 failures
Message-ID: <20260923192514.GA43344@coredump.intra.peff.net>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
 <20260923164700.GA28538@coredump.intra.peff.net>
 <20260923165348.GA29229@coredump.intra.peff.net>
 <20260923165922.GB29229@coredump.intra.peff.net>
 <xmqqwlsbc2ge.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwlsbc2ge.fsf@gitster.g>

On Wed, Sep 23, 2026 at 10:17:05AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +# Curl 7.88.1 can fail to retry authentication after an early HTTP/2
> > +# response. This was fixed in curl 8.3.0; see
> > +# https://github.com/curl/curl/pull/11756. The first affected version is
> > +# unknown, so conservatively assume that versions from 7.88.1 up to (but
> > +# not including) 8.3.0 are broken.
> 
> Just nitpicking the wording, but if the first affected version is
> truly unknown, assuming that versions from 7.88.1 up is *not* a
> conservative thing to do at all, is it?
> 
> If 7.88.1 is from an irrelevantly ancient past, I would say that we
> should just skip anything older than 8.3.0, but 7.88.1 is from early
> 2023 and we cannot do such a simplification.

It depends on what bad outcome we are being conservative against. If the
bad outcome is skipping the test on a version for which we could
reliably use it, then it is conservative to only select known-bad
versions. If the bad outcome is somebody running the test and seeing a
flaky fail, then yes, the more conservative thing would be extending to
skip older unknown versions (potentially up to "forever").

I think you could argue either way (and I am OK with either, or even
just matching 7.88.1).

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B8141999
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274043; cv=none; b=LP56wQub7Rl2WCNEGf5eYclmQALjWPfFLqJ6ITOEZ1StRbmN25KIytIyKAglWY41xAI2tSVlJNxfqNSRXZbnhct4DVtbwMEYijW21eVIeqZpUvEIQ4bFGNz/pn7gie8+KLwLVBqhKqA9CWsodn8fqKJY7+PT1ygUpKpSCknveiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274043; c=relaxed/simple;
	bh=ySzZk+lr8URkPkM8zjCyFZJRVTmGk4vtPVxaBMt4T20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntzJEGn81DK2TI0spYStkQtLHAYX/Q+/UjpXIjhZizny9AMpDU5Q9V7FbnLbQubVrcC3yltXegSkEavD8427TMUeeLoZYq9LtWEoaLEGiOZJkGW9MB3rp7UvYSSx2OpTuGSECmVh79j8PNdznJ9asUN0Z3FhE6Cf3cu5TVatc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26407 invoked by uid 109); 13 Jun 2024 10:20:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 10:20:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15996 invoked by uid 111); 13 Jun 2024 10:20:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 06:20:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 06:20:40 -0400
From: Jeff King <peff@peff.net>
To: matthew sporleder <msporleder@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: bundles discovery and clones
Message-ID: <20240613102040.GD817573@coredump.intra.peff.net>
References: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>
 <20240611072144.GD3248245@coredump.intra.peff.net>
 <CAHKF-AskyrhNYyzZytarKYbEUMz7MzWZhL9jNbk3VQi7s84ceg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHKF-AskyrhNYyzZytarKYbEUMz7MzWZhL9jNbk3VQi7s84ceg@mail.gmail.com>

On Tue, Jun 11, 2024 at 07:14:48AM -0400, matthew sporleder wrote:

> > I don't think the server side is well documented, but peeking at the
> > code, I think you want this on the server:
> >
> >   git config uploadpack.advertiseBundleURIs true
> >   git config bundle.version 1
> >   git config bundle.mode any
> >   git config bundle.foo.uri https://example.com/your.bundle
> >
> > And then the clients need to tell Git that they allow bundle transfers:
> >
> >   git config --global transfer.bundleURI true
> [...]
> 
> It wasn't clear to me what the <id> (bundle.foo in your case) referred
> to. Where did 'foo' come from?

It is not clear to me either. ;) I don't know if <id> is meaningful,
beyond grouping related bundle options into a single stanza. In my
example, "foo" is just a made-up word you can replace with whatever you
want. It is visible to clients at the protocol layer, though I don't
think Git actually shows it to the user.

> Anyway if people are taking suggestions for UX I'll give my $0.02:
> git clone --try-bundle, with --bundle-uri overriding, to allow the
> client to ask the server for bundles that satisfy their request.

Yeah, I looked for something similar at first but couldn't find it. You
can do:

  git -c transfer.bundleURI clone ...

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69C12E71
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720244042; cv=none; b=ry/lTNhAKi/uiA+P676bJ5kkGEVMrYHJQ74bsiK+xPj2fV1iBZickjwydOfUsGGu2gWz58AinOrk9sJunVa7qoGaLtbKvYnnAmeC2MNoGrH8bvHgZvcetU/f9DaETsGW2/BJswrZe9GWh4tytPo/KMIL2TYXwvrq7zGUyhfR8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720244042; c=relaxed/simple;
	bh=tq0/1DFiK5v9AfE994XCFOVAdLl8Bz52MoQbr6Dx34c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqr5zy4ptevJ57xLd8ggZUs6Ms8D+sLI+q8ENEDUzVOOYYDZEC3/Nr7S1q6kEqH9jUlv43uvTe7Z83aDB//PYFbpNeNX+4x3rCZkG+nle9iBtAGC5/xtP7OKuiC2I68k4am6jDygrai6C3NcabI72An9bjGVOnkm+//EfxDGHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22756 invoked by uid 109); 6 Jul 2024 05:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 05:34:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30871 invoked by uid 111); 6 Jul 2024 05:33:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 01:33:57 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 01:33:59 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240706053359.GA698567@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
 <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
 <20240706053105.GB698153@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706053105.GB698153@coredump.intra.peff.net>

On Sat, Jul 06, 2024 at 01:31:05AM -0400, Jeff King wrote:

> > > And then ScriptParser::parse_cmd() just has to recognize that any "<<"
> > > token isn't interesting, and that "-" means "read the here-doc".
> > 
> > In my implementation, the `<<` token is "interesting" because the
> > heredoc tag is attached to it, and the tag is needed to pluck the
> > heredoc body from the set of saved bodies (since my implementation
> > doesn't assume most-recently-seen body is the correct one).
> 
> Ah, OK. So it would probably not be that big of a deal to record a
> single bit for "this heredoc is interpolated". But until we have
> anything useful to do with that information, let's not worry about it
> for now.

Oh, oops. I attached this response to the wrong message (I read them all
through before starting to respond). My response here was about the fact
that "<<\EOT" does not record the "\" anywhere from the lexer.

But yes, for your implementation, we do need to recognize "<<\EOT", etc,
to pull out "EOT".

-Peff

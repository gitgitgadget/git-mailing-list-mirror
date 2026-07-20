Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F441A78B
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551909; cv=none; b=da0i9eAC9CpTaDu33PPf3DQGkMuF7dYKP+iu3iR2p1sk9uWsXnS1iOwmEyzhKMC/xzqBTTeAEOUbSrMjxHtKlA2AKCo76l+v/tI/Lr5w1QtCyK34/Pkga7m74WEO6z4e7i5euzibfQYeNW9fuE5d96ReXN60tLNbv4ViQSHL6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551909; c=relaxed/simple;
	bh=bSVt73y9wkM7sPVLhUxJeIl0MvEXGMOwpWPqGDpgNmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzHWiO9CjN5yVSWs+jwjbHYhu62xE7TNxr6hsyowcRH+/Vrit3IlIHBFXuieB3+g9tHqCTRe5RpSM4IkWz66wLARQmGgnWKjjEXe4FKNRpf3szU3E1CDoziU3F8Eyuc7IZglhb00PXPE/cnLbt+oajytMpF6BW0hH8bxAB9KUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HNF4uHXt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HNF4uHXt"
Received: (qmail 84037 invoked by uid 106); 20 Jul 2026 12:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=bSVt73y9wkM7sPVLhUxJeIl0MvEXGMOwpWPqGDpgNmg=; b=HNF4uHXtOCzAWCWpdGbhyfk8Y0pKz2thf4h4E/EPMuULuBF2IpMU0qPyu+VA7jdD/N6UvKqVoF3FAZWAP7AC0z5k2TdQ+6QtA+QgHb9omBEwxbqo+UhE+aMs8kADnyOsWMbsJKWxZa3NUrd5AyVqRNDlSrCggbZq1qUClMUfj53S1Bn8gCXo9khkJxJ8lSarnZbCALNoZHnffuXZAFwjrGYsxqdVXOGHgkESIG33VVilxQoX/G8MFHVcsvIWOVgoLMMlQXGFeTOcEkp1kdtbflt3eORu5/A4UMuDVBPKEEbdPV4GW9RGH5MujH09RlTIgrMv2KR4AcfsgzUmOvf+nA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2026 12:51:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21392 invoked by uid 111); 20 Jul 2026 12:51:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2026 08:51:46 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 20 Jul 2026 08:51:45 -0400
From: Jeff King <peff@peff.net>
To: Hendrik Jaeger <ml_git@henk.geekmail.org>
Cc: git@vger.kernel.org
Subject: Re: git config: unintuitive behaviour with --global and --no-includes
Message-ID: <20260720125145.GA5100@coredump.intra.peff.net>
References: <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>

On Mon, Jul 20, 2026 at 11:34:02AM +0200, Hendrik Jaeger wrote:

> The manpage says:
> > Respect include.*  directives in config files when looking up
> > values. Defaults to off when a specific file is given (e.g., using
> > --file, --global, etc) and on when searching all config files.
> 
> IMHO it makes sense the way it is phrased “when a specific file is
> given” but then seems to turn into non-sense when --global is given as
> an example. Giving --global is not “giving a specific file” but
> “restricting to a specific scope”, which may `include` other files.
> The results seem inconsistent and counterintuitive to me.
> 
> Am I misunderstanding anything here?
> Is this behaviour intended?
> If it is intended, can someone please explain the rationale behind it? I don’t get it, it seems wrong to me.

The behavior you're seeing is intended. Regarding "a specific scope", I
don't think that's an unreasonable way to think about it. But it's not
how Git thinks about it, and in particular back when --include was added
and this behavior was set, "--global" was literally a synonym for
"--file=$HOME/.gitconfig".

As for the rationale, it is a mix of backwards compatibility and
least-surprise. The include functionality was tacked on to the existing
config parser, and we did not want to surprise anybody who asked for a
specific file by showing them results for another file. This is
especially important for reading untrusted input like .gitmodules, but
also for writing.

> Regarding the initial issue: I just added --includes to the call in
> lbmk and it works just fine, so there is no need to address this. I
> only mentioned it for context to how I got to looking into this
> behaviour.

IMHO lbmk is wrong to be using "--global" in the first place. Looking at
the source, it is trying to check whether the user has set up their
identity. But it is not lbmk's business whether you did it in the
--global config file, or elsewhere! So it should probably just use a
straight "git config user.name", which will do the same resolution that
Git will do internally.

The "--global" was added in their 4a280c62 (.gitcheck: re-write
entirely. force global config., 2023-08-27), but I don't see any
rationale given.

Depending on what they are trying to check, it might be even better
still for it to use "git var GIT_AUTHOR_IDENT". That will give the
actual ident Git will derive, including things like checking $EMAIL in
the environment and so on.

So if the intent is "will Git come up with some ident", then that is the
most accurate way to check it. But if the intent is "did the user
specifically configure Git (because we are worried that values derived
from GECOS and $EMAIL might not be accurate)", then checking user.*
specifically is closer to that.

Though note there is one other hitch, which is that the user can set
author.* and committer.* as specific variables, since 39ab4d0951
(config: allow giving separate author and committer idents, 2019-02-04).
I suspect not many people do that, but that would also be something that
a config-specific check would have to handle (but "git var" would do
automatically).

So I think you might consider sending a bug report to lbmk. Feel free to
point at this thread, and I'm happy to discuss further with them.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3F1D90A5
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276350; cv=none; b=OtGtEXS2FdtFaE0tEiIGJrywtOvlLX9AHjWapO8ILckt47Mkyr8bHJ7UPLoJuhKd+dmC4YN7JPqLb/Qady672rDOdLC+v2DHdTFgTcD0GkvIXUf3YJNp70ibVECQV4cH7Hy3IdByF+IN9NEan0SUI5Ji0fAudr7Z8wJkI5sYbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276350; c=relaxed/simple;
	bh=xh3OfVe7H4J1tk/U/xa6AJl8BRa4oVbdX4WzbZbjGS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7SMEjCFHOcJipaphQXdhpxx6QOjSZUm+AX+W86UyaeN/r+eIp968S3/7Q0KdAxww0oCV+TVqWw3Tj/IURVMUxTIrrcVWkn51hfaKEshYTdB0sbJG5f3b4Bor8dUZw5KZYk8KSeCOaaBPTm8we1e6YW/wDV1uKuns/cqUU5epNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UAjqtNUn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UAjqtNUn"
Received: (qmail 28310 invoked by uid 109); 18 Mar 2025 05:39:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xh3OfVe7H4J1tk/U/xa6AJl8BRa4oVbdX4WzbZbjGS8=; b=UAjqtNUnBc3+G4w5olbVZltzsJLBIf77XfqCHgqvRe2JdMLH0nLYRxAkljIVm2cNYpEqLsyicJROjeSF0ww2pOgSPG13n660TnkFWSQDQQ9e5c3RM4FynZT0mk3+RN8weB0bWPqmKMao3ifmzmfZiA1WKxP1lsw9MeN9y6gJ1J6NBxf17Qq8aTffX/+0yMwynHqinUKOB0/9VVei0/FQP9pI3gATNiFSm5ieHnQuxiG1qqf1N7ejFezx8/HurADbqkwc3OjSLHPxRIeX5NjY6EMCAslQj2CDqAzDRFXsPccY8WHp070dJP4ErqB3DwIqYmUzqPYPbkPP0ZwiSvGJvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 05:39:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6150 invoked by uid 111); 18 Mar 2025 05:39:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Mar 2025 01:39:06 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Mar 2025 01:39:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 0/2] limiting followRemoteHEAD being used
Message-ID: <20250318053905.GA2051217@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309032016.GH2334191@coredump.intra.peff.net>
 <xmqq4izxq63y.fsf@gitster.g>
 <20250317180604.GB704553@coredump.intra.peff.net>
 <xmqq1puva3cu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1puva3cu.fsf@gitster.g>

On Mon, Mar 17, 2025 at 12:01:21PM -0700, Junio C Hamano wrote:

> > So I could see going in two different directions:
> >
> >   1. Only do the HEAD update when we are using the configured refspecs.
> >
> >   2. Do the HEAD update even when we are not fetching its destination,
> >      but do not otherwise trigger ls-refs to discover it (so basically,
> >      not on object-only fetches). This kicks in for more cases, but is
> >      hard to explain.
> >
> > Both are a user-visible divergence from how the feature behaves now (and
> > so I did not want to touch that in my series), but if we are all in
> > agreement, we can fix it on top. I do think option 1 (i.e., what you are
> > suggesting in your email) is how I would have done it if starting from
> > scratch. And the current rules are weird enough and the feature is new
> > enough that I think it is OK to change.
> 
> Yup, I do think #1 is the way to go.

It turned out to be pretty easy to do; the code ends up even shorter.
These patches apply on top of jk/fetch-ref-prefix-cleanup.

There is one interesting case we haven't discussed. What should:

  git fetch origin HEAD

do with respect to refs/remotes/origin/HEAD? Right now it does nothing
(at least with the v2 protocol). We ask about HEAD, but since we didn't
fetch the matching ref, set_head() won't accept it. And after my
patches, we would not even try to call set_head() at all (since we are
not using the full refspecs).

But it's also something I could see somebody doing to try to update
refs/remotes/origin/HEAD. I've left it alone for now, since my series
does not change the behavior either way. But it might be something we
could do on top (though it gets funny, because with the code as it is
now, we'd have to ask for all of refs/heads/ to see the pointed-to
branch advertised).

Anyway, here's what I think we should do now. The first one is the
change we discussed, and the second is a related optimization I noticed.

  [1/2]: fetch: only respect followRemoteHEAD with configured refspecs
  [2/2]: fetch: don't ask for remote HEAD if followRemoteHEAD is "never"

 Documentation/config/remote.adoc |  3 ++-
 builtin/fetch.c                  | 29 +++++++----------------------
 t/t5505-remote.sh                |  2 +-
 t/t5510-fetch.sh                 | 19 ++++++++++++++++++-
 4 files changed, 28 insertions(+), 25 deletions(-)


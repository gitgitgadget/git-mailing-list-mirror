Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FD359A99
	for <git@vger.kernel.org>; Fri,  1 May 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617495; cv=none; b=ak6mKBi5s5exHbl0q4j48kxQS+5mX3uN3Mgev/cMwJ91H60gh5Fexz0GGIHmft7pN+Wl1k1ka0UTVZ36ChQcEUPD/kuPUeDQ4mrIE/VOeT8JbExIQtAiwWnPxRxP7eZOmK8gkQmtDlcSWoeO9215nW6KT1WLZDSekPYdOPxzTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617495; c=relaxed/simple;
	bh=XLtB9cI9EST95bWQZH8rg03M51Hxf1Yobwo33BltBZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQGOYwLUg6OkahbzaAk9mJaB9KtSklSZywb5nZLiA1unf7fXJwjo8HSE1yUhHlgiCzYxDmfIJ5lKqrRrWk0MwAesk96PAaI+XKqmgGOl3X2xrR68cVQ4wxDBG8nnsZ6zJ9griaUtyOTzYdN0fVIviyThOFy9k7gcvz0p9KSvSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YzDSeTbC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YzDSeTbC"
Received: (qmail 2194 invoked by uid 106); 1 May 2026 06:38:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XLtB9cI9EST95bWQZH8rg03M51Hxf1Yobwo33BltBZs=; b=YzDSeTbCMcSwhIsHh4Na0xEwseGH6FeFTr1cLqKC73lB4npNt88O2Q9LGkHJ9Sg7AhvnheLi+TTHKwSAj5E/y+pLvDCeXwBp89APSxtz8BSG5xDDs93Lrqt3izg3zCkuIBCnjSC+QWu5WySVOfuvudPPLTChUf5+dBT6Ea/YD+1RtsbiZtQvvUsvl2wHp91ljwuRoDzPq1nD7DihGux31V2BlhJGOrDXCGJ5GQcoUA+d/onex3Cp8kRG+OekLQ2GWKbDFewFIBVSFItqghooiL48sYewi/zgq/CGcFapdDVuhnFSSP1CaaHo2ULyTD1TZ5+KcXaLGeYP4zziOjA9eQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 May 2026 06:38:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3802 invoked by uid 111); 1 May 2026 06:38:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2026 02:38:05 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 May 2026 02:38:05 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/6] t5608: add regression test for >4GB object clone
Message-ID: <20260501063805.GA2038915@coredump.intra.peff.net>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <a3019888d8465e0f77926a91a20db170fef6989d.1777393580.git.gitgitgadget@gmail.com>
 <e1e8837f-7374-4079-ba87-ab95dd156e33@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1e8837f-7374-4079-ba87-ab95dd156e33@gmail.com>

On Wed, Apr 29, 2026 at 09:34:21AM -0400, Derrick Stolee wrote:

> As mentioned in the previous patch, constructing this large packfile
> takes ~4 minutes in CI pipelines. That's quite a lot to handle for
> every CI run.

And for local runs, too. ;) The test suite takes less than 90 seconds to
run on my laptop, but t5608 by itself 160 seconds. Even if running it in
parallel didn't slow down the rest of the suite (which is not true,
because it's obviously hogging a whole processor the whole time), that's
still almost doubling the run-time.

I'd also worry about assuming that the trash directory can hold 4+GB
(maybe 8GB+ since we clone it?), especially since many of us use ram
disks.

That said...

> > +test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
> 
> Your prereq here prevents it from running on 32-bit builds, which is
> good. However, I wonder if it would be worth also specifying these
> tests as expensive. It's less likely that these layers will be touched
> often, so it should be enough to run these on major occasions, such as
> testing a release candidate.

I think it is already skipped in most cases, because t5608 requires the
GIT_TEST_CLONE_2GB environment variable be set. Arguably it should just
be using EXPENSIVE, too, as I do not think there is much value in having
individual flags for all of the expensive tests. I think that test just
predates the modern prereq system entirely.

> I suppose this also is a question for Junio and our process for
> validating releases. Do we have a certain cadence where we run the
> expensive tests? What has been our threshold for hiding a test case
> behind the expensive label?

AFAIK the labeling of expensive things is mostly ad-hoc, and nobody is
systematically running them. Likewise for the t/perf tests, which are
super expensive but do (very occasionally) turn up interesting
regressions.

-Peff

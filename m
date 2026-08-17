Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381EB24E4AF
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952185; cv=none; b=HoPoRzrgKHXKhUtS5TQ2x37vhrvRRRUDliWxknNlfjpXgtSSaF+I3oLI6IKXMbqdn3LocnWU8v0CL/tSHwnb133kuTe4PuObpSVSSwF75xs5ASC0P+6aOJibr/7oE00o1ZFsFmXh0wSmeBvKR617YWiPm0LHBhHZvfQkVvbeIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952185; c=relaxed/simple;
	bh=jRFasiEC8/p1T1+xsv/kenyqDSrmO/vBzkfxu8WpJm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOFwdJxGF0l006zBZG6f5CGV5kPmzPeHqJ06ladFx+9a8b6KYVaG+8QlmVEk32eb+Jn9ikl+8RsLnXq2ZFc8dog8e9PaIqNhDvw8+OvAWIb4Apg2Sme2bLvmvDBllvimIp39rOf/fmj91K7UQWsgj9ncXLpF6Wik/iihsPzJURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HX+SbqCC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HX+SbqCC"
Received: (qmail 73184 invoked by uid 106); 17 Aug 2026 07:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jRFasiEC8/p1T1+xsv/kenyqDSrmO/vBzkfxu8WpJm8=; b=HX+SbqCCmNK8ezgkqNvgpEpLMBuDi8yo9MTlTq7yjk1tk3Aq5rUVNIWJqMT2XkRwtE6S/r9DlVy0JHCsUawCiV7gVpjuMrtkWdACmSY/gdG/vjRCBaI5oe3kWtmrEi4sHQN/TGse1G89nwtNf/m7aU3waWXMEleFiGoGdHXtBL67tDZMJRcnKye/tuO5UFuV1BK8J/PGhohxbF3YNgRF17xaoLwfS3UahFijZU0QV4y5LVtHEcLB+CyfrymwbOlwYkeahTSZpJcXG5nuq3s8FYdJgQFBMGwDmZyPZVDqtDLc3pW2swdf2zeECrsNZOacrAOVvg5UCz90eVigydRYkQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2026 07:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15108 invoked by uid 111); 17 Aug 2026 07:36:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2026 03:36:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Aug 2026 03:36:21 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <20260817073621.GC690018@coredump.intra.peff.net>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814171724.GB2563235@coredump.intra.peff.net>
 <aoKeeQMps50rjhWi@pks.im>
 <aoK1ZYfqh5PnNin6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoK1ZYfqh5PnNin6@pks.im>

On Mon, Aug 17, 2026 at 09:16:53AM +0200, Patrick Steinhardt wrote:

> > So if we want to go down this path I'm inclined to just unconditionally
> > use case sensitive matching and not introduce any secondary machinery.
> 
> Thinking about this a bit more: I'd suggest that we leave this out of
> this patch and instead document this as a NEEDSWORK area for now. I
> _think_ that this proposed refactoring should be generally fine, and I
> quite like the simplification that results from it. But the risk for
> regression is quite a bit higher compared to the origanal patch that
> I've proposed.

OK. The inline lookup of core.ignoreCase feels quite gross to me, but
it's _probably_ OK.

There are all kinds of weird timing issues lurking with config lookup,
though. In particular you cache the result in o->source_paths_icase. But
would we ever load odb source paths before the repo is fully loaded into
memory (or in the case of clone, even fully formed on disk)? In that
case we'd cache the wrong value forever.

I think we have repo_ignore_case() now, since e6a79c9eb8 (config: use
repo_ignore_case() to access core.ignorecase, 2026-06-19). That's in
'master', so it might be worth building on that instead. And then if
there's any cache invalidation to do, it would eventually happen there.

-Peff

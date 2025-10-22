Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77C30E0DD
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124276; cv=none; b=aXm6v/PLV6tDy2gSq0xJj6G2U7AFdTaAnggffxmYWETnC6qxsdVRI1Y/NWyK8S3+Cag4UifxT8hZ2myApgC840jRWUGyZdIXpOAPVmTJgpun2uvXJBfwA82vdsEpfquwDCWPZ31NAkKnPsPGU4ZwhavP19GzhiWnhGOj6iKpQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124276; c=relaxed/simple;
	bh=K6XpDEHLZrQmrPUb79G4uei2Qf/2bcJHW0yafh0HnuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsr9o0psegu+7U6KxDQ9NdNasA7FLmO2DvYye7S8qH1ypFrssqrvSFpvDrGjem7IOqTdaOHZZOsuJp4XE/AgPNuo4NYgjcOtlcM7quUUAQHG2jsM5CaUNkSspEcm9w7Pxcl09bWTcvnl7yzHLFOQbe7XNLD4LIDWBLbsQxt3dzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e2uXhar8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e2uXhar8"
Received: (qmail 303064 invoked by uid 109); 22 Oct 2025 09:11:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=K6XpDEHLZrQmrPUb79G4uei2Qf/2bcJHW0yafh0HnuQ=; b=e2uXhar8eUsgvrj17xc0sK8ex3gwQrueM7ZBYgVlwZPvB8pkl3EoMusVGwMlr1dIUlrRX2AtqcPlBMKdD+c2u8OQoMsXlIePPQO1sU/CoqXp6EqTVfpZVGqY2kG2hAhLtFJxThRxeLPjht4Eveg5iWOcqDxbFgTc7619YmUb6nZvz8Eo5QFQV28HnzSwFwqo88VpHtQS29n0piXFoZW5VhxviNf5MjemrJL8/iLmDuteO6ggzysS7BhGFtZK1Y6hUvUCGb3M9c5lgd+YD+IqwynI9lDiiqvJLUJhUurQryfYNsXain9LWiSSDiTy4LiglNV6Eo8cpGF1wc/6k6CyXw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Oct 2025 09:11:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 472227 invoked by uid 111); 22 Oct 2025 09:11:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Oct 2025 05:11:13 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Oct 2025 05:11:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251022091112.GB853931@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
 <20251021073640.GB259661@coredump.intra.peff.net>
 <xmqqy0p4wcac.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0p4wcac.fsf@gitster.g>

On Tue, Oct 21, 2025 at 07:38:03AM -0700, Junio C Hamano wrote:

> > So really, the regression fix should probably cover both of them (which
> > it would if we move the /dev/null redirection into the flush_quietly()
> > variant).
> 
> Do you mean something like this on top of your patch for 'maint',
> and the latest from Lidong to the 'master' front, then?

Yep, exactly (though with the "o->file" restoration that Lidong
pointed out).

> Having calls to this helper in two loops in one function looks a bit
> awkward but the conditions to enter these two loops are mutually
> exclusive, so it is not like we can remember the result of the calls
> we make in the first loop and reuse in the second loop, so this
> probably is the best we can do.

Yeah. I suspect there is some formulation along the lines of: if we have
diff_from_contents set but are not looking at a content-level diff, then
up-front in diff_flush() we should quietly flush each to find out what
is changed and what is not. But the loop for NAME_STATUS, etc, needs to
know _which_ pairs still had changes (whereas --quiet only cares about
whether there were any changes at all). So we'd have to store that
somewhere.

And of course the chance of regressing some unconsidered corner case is
high. Definitely not something we should entertain while doing another
regression fix. ;)

-Peff

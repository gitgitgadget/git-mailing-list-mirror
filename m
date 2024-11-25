Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92101531E9
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534271; cv=none; b=A6l+cnViCPPa/7KWhsv9oFxvbUzbESBieBd2aOIqA9V004VlY4oGpAF9m54yeVfeX6P/ikuxaGa/RE1d+UYuWD/EaYgDx4G4j+mf6iP79dVrEnD/xijFz26Qa2XG1HAYB+hl+lEWOXqOOHg3SEz3nrpQ05yrMDuDj3nVrEVVb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534271; c=relaxed/simple;
	bh=jpCx6DVUi8iUtjEYqH1764+MljTWoGlGw8+2HH7ks+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvGxAgOePDMGz1sV150Aon5sC1hxQzRsFVI/jEakzcZxdRpuFAbwIH1H+8MvhSLe+lZfvSQFAxx28J4z7Jd8kN8CScmctDubPjaodLY5EVW0GoWfCOS4s1gU9/XkGTu1Zoo53lX2s/50JjTWXE4O12QqPTvEp5lkp8eqnVMQNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gKAdrfm+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gKAdrfm+"
Received: (qmail 10898 invoked by uid 109); 25 Nov 2024 11:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jpCx6DVUi8iUtjEYqH1764+MljTWoGlGw8+2HH7ks+w=; b=gKAdrfm+b+HDTjhThuBabCPXbbxL2y09gx92qAMR0zS4Wnz1Xs7bWDn9EGDshq3JS3BRFKosO/1GagK79z8yrlkCxXbF32RVx6fjtYSCSWnGy24lIvRbBihEXmAWcjV4h8LIri0nOa6MzeWBeOoPFGak3Oz828JjitOArqPbCBadd1TstplxpYVVKZ28jyUgZKM0zlLK1ZmJ1pgdYwU3aoibpDoyzoavLDmHO70GaWGd3ZrX1CMqSpHCJPzdmb5jE9kghyldpoIOSQPpgqxccWypvON2eKM7xPjRthrZu6wJocFaHySrlb2LnVhFsS9OA8GgzG8JIhIT9atNzyuXVQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Nov 2024 11:31:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9074 invoked by uid 111); 25 Nov 2024 11:31:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2024 06:31:09 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Nov 2024 06:31:05 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Philip Yung <y5c4l3@proton.me>,
	Y5 via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Message-ID: <20241125113105.GA1070162@coredump.intra.peff.net>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
 <20241019211938.GA589728@coredump.intra.peff.net>
 <UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
 <20241021190045.GB1219228@coredump.intra.peff.net>
 <ZxatqdBiB+NoMP+j@nand.local>
 <xmqq34jpl5sl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34jpl5sl.fsf@gitster.g>

On Mon, Nov 18, 2024 at 09:55:06AM +0900, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> You'd need to identify all of the possible diff code paths in order to
> >> add tests for them, which is the same thing you had to do to fix the
> >> code paths. I was mostly just commenting that we're not likely to be
> >> able to rely on existing tests to help us here.
> >>
> >> It might be worth adding a test that shows off your improved diff
> >> behavior, though I would be OK if it was a representative command and
> >> not exhaustive. I think adding to t7006 should be fine.
> >
> > Agreed.
> 
> It seems that this topic is waiting for a reroll?

I think we could go either way. I outlined a few further possible steps,
but there is no need to hold up this first step. The only question is
whether or not to add a single test to show off and protect the
improvement.

-Peff

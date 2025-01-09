Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FC19F489
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407039; cv=none; b=m6QiVe9Bkd9HlQtvs4rUpKbzlQTlh+EK0dZ79pCb3VXQw73va8xx+IHloFtDIp84A2SoIevds4fZ4R9X573jpOoiRyulsGD9tkP9jN2ALHld0QWit+SgyXHMnDD8TPtBcGqS6ufGOlFIs6DiXCgZ9o+lpPD1hEOv202w2Nn+G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407039; c=relaxed/simple;
	bh=zBP5tTdICXPWjiEmLgM7LagSA4nx3DOFMDOpSNNJjA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN0EOASxGY86SCyZOLG0h5xlgsHJmoc+Ibe+ZBOBm98aQ2wWVWP0z70OHuzxLQrgkZK/wU81Vjr+H+fma4SBMwrSZlsXZzF/31wRN8+0FlXUQj62XS9ZAxCaGybtI6e9/8MgL8rUjDjHNfWiC7NC2VBzoyrbpe9VtVJwfsUonlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A/koMvzk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A/koMvzk"
Received: (qmail 25022 invoked by uid 109); 9 Jan 2025 07:17:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zBP5tTdICXPWjiEmLgM7LagSA4nx3DOFMDOpSNNJjA8=; b=A/koMvzkBTE3Eyziu9n4X7XqOKpX528vd5EC4WQLeefqGiV2N/vlX01kVCq2XNOY3URxPYiBTPOUTwKDTcEWiIkSh0fOcirdxM3PxB0sxaUOL4esbCB6n0K0EonMzz/3Su9G1bL02Bl4BOaHOHgAZQyJHhlgKiAzHaKX9sUj5T6SozwRE9V3tW7JCSUMHss0bieXusnOFaCbSGLzuyhBBQvTdcVxpFZSVggAHfTWTbk0eh63vb/kmnpj/zAiOZbo2X/G8tDRnrmNSEf3FoBgmaV3GnWuUs3y5HMBsi0PzJWXmIdqCs/yhTE2Q8UM/1Tm+fvRgIMTZbwlRjUy3tQtog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 07:17:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19301 invoked by uid 111); 9 Jan 2025 07:17:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 02:17:07 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 02:17:07 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <20250109071707.GA2735258@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
 <20250103181739.GA2527684@coredump.intra.peff.net>
 <Z3u6lj_bpM7N93Fd@pks.im>
 <20250107023904.GB2363@coredump.intra.peff.net>
 <Z3zqKSx8NVK-QQNL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3zqKSx8NVK-QQNL@pks.im>

On Tue, Jan 07, 2025 at 09:47:43AM +0100, Patrick Steinhardt wrote:

> On Mon, Jan 06, 2025 at 09:39:04PM -0500, Jeff King wrote:
> > So I don't really see a way to do this robustly.
> 
> I think I found a way, which goes back to the inital idea of just
> generating heaps of submodules. My current version generates a submodule
> "A" with a couple of recursive submodules followed by 2.5k additional
> submodules, which overall generates ~150kB of data. This can be done
> somewhat efficiently via git-hash-object-object(1) and git-mktree(1),
> and things work with a sleep before and after the call to grep(1).

Ah, of course. I was so lost in trying to find hacks that I forgot we
could just actually convince it to send a lot of data. ;)

Your solution looks nice. It's O(1) processes, since all of the heavy
lifting is done by the long gitmodules file and tree.

I was going to suggest that you could reduce the number of submodules by
giving them large paths (or large checked-out branch names) to get more
bytes of output per submodule. But there is not really much point. What
you have should run quite quickly.

> I'm a bit torn though. The required setup is quite complex, and I wonder
> whether it is really worth it just to test this edge case. On the other
> hand it is there to cover a recent fix in 082caf527e (submodule status:
> propagate SIGPIPE, 2024-09-20), so losing the test coverage isn't all
> that great, either. And keeping the race is not an option to me, either.
> 
> So I'm inclined to go with the below version. WDYT?

Yeah, I was tempted after my last email to suggest just ditching the
test, too. :) But I think what you've written here is a good approach.
I'll look carefully over what you sent in the v3 series.

-Peff

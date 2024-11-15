Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47618FDB1
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663147; cv=none; b=B1czj7APGDD5EbbY2vDCXWwLwj2w7P22R3DYMTK/DangbwhaYVMerLxSdNb8kTJbWZ5lU4HpaabSI6X3WASKcTBFhrsrLRuDi4gSR+bBMGPhBCDgodzTptcUeC6uD0AZUMkweVyRDrQgLasEX9x+Tvhx8OnK37D9l+6FgKo1Hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663147; c=relaxed/simple;
	bh=46RUC+SEzIQ8X8jQFfHD6YhMQvof4KyY0m/WoRjzFwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMjZiMa0qnBI1Na5H7fP+5kWRtWPZf114Jn9AN4FmVWB2KJkp8HIFJSktA+Nai+I5BRRLPzMU4nGjjXFhshtEbUoSgbScpylEZPq8+RWyHeRstytFnGpKdgkM8uAtTbb5BMj5GtuUGgjQs2zvdsKjhVX15TxyAuc+IaFeF2eIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fkr8LTBW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fkr8LTBW"
Received: (qmail 14542 invoked by uid 109); 15 Nov 2024 09:32:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=46RUC+SEzIQ8X8jQFfHD6YhMQvof4KyY0m/WoRjzFwA=; b=Fkr8LTBWNi+4xRfblEklVinfFC7U1oV2WYdSy3ZjnExylJh/jGvQV7vjvCj8DexXNLKeKzcxuUFCWXC38bL4XOwITwL5qA4HDHt0I4OuuVwHVR4MgGGGw+/FNWzWrcrOmoBhYINphj7bhnliho8Sly868ddmPWF1MwX2wFRypROls2qiMbZycJgjtoRikNhVsvYK657CEtyS3mmAVXWcoVrYjqeTMUC7q71uxu8CdRuiYR2hLIuulBsp0ufl1wuRngRHIJRSSMO29Ak1fjeNMQvK1sNLM393ftMD3YrfK1BqtQhDszkrnSRH0kb11ghb6s6AZLSfwwqVYN0E7gJDug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Nov 2024 09:32:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6646 invoked by uid 111); 15 Nov 2024 09:32:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2024 04:32:19 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Nov 2024 04:32:14 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: A bughunter <A_bughunter@proton.me>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [bug] user may be cornered into delete files #9901
Message-ID: <20241115093214.GA1749331@coredump.intra.peff.net>
References: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me>
 <ZzaJzm4kyYbcDSgm@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzaJzm4kyYbcDSgm@tapette.crustytoothpaste.net>

On Thu, Nov 14, 2024 at 11:37:50PM +0000, brian m. carlson wrote:

> The only thing which might potentially be a problem on the Git side is
> that I don't know if we try to hold the connection open without sending
> a sideband during pack generation, in which case if the client side
> doesn't send anything at all, then the connection might be closed by the
> server.  I'll point out that GitHub sends SSH keepalives, so typically
> the connection should not be reset unless the connection actually
> drops.

Yes, we'll hold the connection open for git-over-ssh. We can't generate
the pack until we've seen what the other side advertises, and it's
probably too heavy-weight to start a second ssh connection. Even with
ssh keepalives, I would not be surprised if the process terminating the
Git-level protocol conversation on the server side had some internal
timeouts.

There are Git-level keepalives during the similar compression operation
of a clone/fetch, as well as the delta resolution for the server side of
a push. But there's nothing during the client-side compression.

I know we've discussed this on the list before, but I couldn't find
anything substantive, and certainly not patches. I think it would
_probably_ work for the client to send 0-length pktlines (actual "0004",
not "0000" flushes) every few seconds while it's waiting. But it would
be the first time we've done so from the client side, and the first time
we've done it outside of sideband framing. So it's possible a server
might not like it (in which case we'd probably need a new protocol
extension).

> Overall, I would not say this is a bug in Git.  Pushing over HTTPS may
> help you get your pushes working in a more robust way, but in general,
> I'd recommend storing the data in your repository differently.

I agree with everything you said, but I wanted to add one more
workaround: running "git gc" locally will pack all of those objects into
a single pack. And then the subsequent push should be fast, because
we'll already have done the delta search.

-Peff

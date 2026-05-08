Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CC2F8EA7
	for <git@vger.kernel.org>; Fri,  8 May 2026 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262763; cv=none; b=f3ACYcYH64Phgcqv7mYNjHWpInceCAP6lDaEGXD5IixSJyabuNwk4N2Si5/MCcU5wp8CE0W/5YV+SLicPSunp6pbJREw86PdlMrlg54Yw/xQZdUdrUk3ttzqWvHM/8uLVGt22eNdIRNG9xxP7CRHMnoPAfSrnGY/xTwBWYWkDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262763; c=relaxed/simple;
	bh=Molzi4qZ/sZ3v8m/lM9ISEZC6OpR687owQvjUqC/68Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJAlmMIdahneirZICmIwFZVQ4KMtdGUKDghWv9IiI1eaOIgyo9FJ1c6gy5AqPk1zHNRddtwC2BdMmscB39PZfKjIZmj6iQq4kmQWSacWkbjcgq6l9uDGGFuM3R4UGvGeZqhAyedSsvAFgxWBS/CZOFj7okTJhHEIj97v7Vz968k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AAL+1iWS; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AAL+1iWS"
Received: (qmail 67254 invoked by uid 106); 8 May 2026 17:52:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Molzi4qZ/sZ3v8m/lM9ISEZC6OpR687owQvjUqC/68Y=; b=AAL+1iWSnIGq/iBcwRe/Lf+vZo57Kl8nNEabYvIjhpJ/S3QbXRTTCB8sQqud3gPZsy9ZJC9irpqIc70YU4bguzp2YT6YJXh4Zvp507Z0y0x4JjdyMj7RifeVWLL1gy+6K1+DbHYnsh03k/CB4+bFatn12KXYqCJqIIOLX7xtFO2cKIFZ/+wl6zG1/S4W1/nHAoojZzYZok2YzqFktnYIaqZfSs9redJEeOeQyHUk1gWB66r7Ajbao0atPEleW8HqC6ZGdXaS2rI5oGcRj+PJThAAVJnUP5yO5ICyVS5Atnri/TD3mthKEnl+OBO0EGtLmK1Cxa4a1xi+DDBUwW1C2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 May 2026 17:52:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 129875 invoked by uid 111); 8 May 2026 17:52:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2026 13:52:40 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 8 May 2026 13:52:40 -0400
From: Jeff King <peff@peff.net>
To: Greg Hurrell <greg@hurrell.net>
Cc: Greg Hurrell <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Gregory Luke Hurrell Stewart <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH] git-jump: pick a mode automatically when invoked without
 arguments
Message-ID: <20260508175240.GA737125@coredump.intra.peff.net>
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
 <20260508141314.GB709299@coredump.intra.peff.net>
 <c5e0a1fa-f228-41dd-b547-07b0ad6c0964@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5e0a1fa-f228-41dd-b547-07b0ad6c0964@app.fastmail.com>

On Fri, May 08, 2026 at 04:30:36PM +0200, Greg Hurrell wrote:

> On Fri, May 8, 2026, at 4:13 PM, Jeff King wrote:
> > On Fri, May 08, 2026 at 09:07:34AM +0000, Greg Hurrell via GitGitGadget wrote:
> > 
> > I'd be a little worried that it is more confusing to somebody
> > approaching the command for the first time and just runs "git jump" to
> > not see usage or other guidance. But that might be overly paranoid.
> 
> Hopefully, they at least read the README before installing it from contrib/
> (although Homebrew recently starting installing it for folks automatically,
> so may not remain true for much longer on macOS...)

Yeah, I'd hope so. And even if it might be more discoverable, I'm not
sure that is more important than being convenient for experienced users.

I guess a config option would be possible, but probably not worth it for
something as trivial as git-jump.

> It's mostly the finger effort of typing it because I generally know exactly
> which mode I want; eg.

OK, that makes sense.

> This is muscle memory for me at this point, because I've had a `git jump`
> alias for this in my dotfiles[^1] for a couple of years. Homebrew
> installing `git-jump` by default a few months ago[^2] broke this, because
> aliases can't shadow builtin commands.

Ah, yeah, that is frustrating. We try to avoid aliases overrides to
prevent confusion, but for an add-on tool like git-jump I think it is
overly cautious. It might be reasonable to limit that protection only to
commands in Git's exec-path, but I haven't thought hard about it. And I
think it should be considered separately from this patch anyway.

So yeah, your patch looks good to me. Thanks.

-Peff

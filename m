Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887C3B14D8
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555000; cv=none; b=j/Ardu4TzWf3+OjnQsdX9EM8e7cYwcrZwc8b2zcZaVhwG+yIgQdUAi1EoWLc2IqC/cv3lEpmGxW66mETXMN91MGkN8LEVX+scZeJgkX/7U1b1BBGzz1kiBt2Mq0ZPlO2sKCqWrAvZAJYO6z1RluzFkGwriE90IImM6veYF3qEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555000; c=relaxed/simple;
	bh=DVg4Ty3zSUH6eG6FJRrinaaNlmOc4Trc3Jb9ESV7YpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMG6deGI9EzuzPJfc8lHSyOkBI3mcZLkx/vuTqDDVmrH52N7+h7Jn6x3iw4EPWV+btYh9yJq6A/oUrdqEHL0zfnEobAWZCo7mhISDsH1S+YowUL8b5+1BgBwSsXsh8uHLfnzxu+XnUsSxL/5YA1NS0ZsRs3z3XAkntKm1wpJyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Bc+b8J/1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Bc+b8J/1"
Received: (qmail 105880 invoked by uid 106); 24 Aug 2026 07:03:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DVg4Ty3zSUH6eG6FJRrinaaNlmOc4Trc3Jb9ESV7YpU=; b=Bc+b8J/1HyrZF0KJUtXbBMaenafdWxdOSCHWItWo2OpX2m/ZpX0Nf8urfosnE6QLvhlQ1xbB6K4Je3JPmMiZiTEYnDxwuXdW9IgmzYpf8Av3Y0/lvv7vVchergYvyBkH1fdKuRKAWRvt6W+3OyEVEA0IBl4FcVYG2Upc2wUtD9J47GZwKbVuSEAyw7klsElV4GPmd5pscqbWI1To4mlPV+V/H5EEWbBhpilg7cPp4qyC5jZJAb/c1IQgt6Ac3FPY79PgP1iQ0RnUVAhu1/0l0b4y9K5GyAKo/PKKWoJHQL+R5gP3YSIr0OCx9emvIQxbhyVcCJVLgw41R61dXZl2OQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 07:03:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 130044 invoked by uid 111); 24 Aug 2026 07:03:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 03:03:21 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 03:03:17 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260824070317.GB149254@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <20260824045529.GB142844@coredump.intra.peff.net>
 <aovZRjcIbAUqswFT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aovZRjcIbAUqswFT@pks.im>

On Mon, Aug 24, 2026 at 07:40:22AM +0200, Patrick Steinhardt wrote:

> > This is all assuming the fallback is worth pursuing. I'm still puzzled
> > why this specific case would matter when we have the same (already
> > solved) problem of reading a regular .idx whose .pack has gone away.
> 
> I've tried to clarify in a parallel message already, but the issue is
> that we skip over any packfiles that covered by a MIDX when doing the
> lookup. So any secondary packfiles that contain the object would be
> completely ignored, and that's why we don't find the object there.

Yes, thanks. Your other message cleared it up for me.

> But this mail here suggests an alternative fix: instead of re-scanning
> all packfiles like the patch proposes, wouldn't the proper fix be to not
> ignore _all_ MIDX'd packs, but only the pack that _should_ have
> contained the object?

Do you mean in the main code path, or in the fallback?

In the main code path we definitely don't want to do this. Imagine we
have a midx that covers a million packs, and says object X is in pack P.
A simultaneous writer deletes P and rewrites the midx, and the object is
now in a new pack Q (which might be covered by the new midx, but we
don't know because we're working with the stale one).

We definitely want to look in Q for the object after the midx can't find
it. But we probably don't want to immediately search in the other
million midx packs. Most objects won't have such a duplicate and the
search is fruitless.

-Peff

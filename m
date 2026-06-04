Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37763D6CAB
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557127; cv=none; b=gGDLopEPB1zkJoBAuJ8s/1tVeMJNrVjZH9Y54ZreIAq6Bc2NHgMOAQDaV2Vj3Uk14Fre+NGpkB7obp59je2bwfewSjlI9pul2lzAoXVqQTo5o80K7rEv19gnSsIMedRmSpcH4IxDJthRB/A+JQV09RRXU9kZdh+V9S0o1Y1nyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557127; c=relaxed/simple;
	bh=Q2qHN4Lkk3x1irflW6JAfcb5Ew018C2KiZhjJwwYxyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoJAgLovNegdMG8hGNMpzPV29qljgwkbKiQceYxOkI9upf7ShdkyI+oLiiXA2JpjNLe1Rp6s5Kmv+6wRF4WEM1l2gdbOH3bP0hikwoCjJLOPhbtw4xduyYoYB2L4BYNIEHLhZIu1gCpkFw5DGLuQ90Mzys9vDw6VZ2Ee1bI95og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G0BoPYBQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G0BoPYBQ"
Received: (qmail 43494 invoked by uid 106); 4 Jun 2026 07:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Q2qHN4Lkk3x1irflW6JAfcb5Ew018C2KiZhjJwwYxyI=; b=G0BoPYBQHqAhyz07c32gpeR6dMgE15KX2jH1lONkR6gheeoY4N5jwmP1edvHwN64Ulsh5yZkhxJeBdSeRaY2FN9y/3GQN+JqdkJS396Ll15E/MSjSEg1Pa+pvVbzMyj0KwMcLK1g3lYo9zlDI7z4IeNFxzrTwNRQE3SC+7bWsjpi7Yli4tH15J/Ce+1H5m+8Cs1IyUxFLLcGBj4NAoGlrTgHbCdSUB3UeQeFpsNJULXPS2QfwuQ2+In9LB/1XAHFWOS30PHwEwwRoMHrznB3dbNLA5OVXYykPTm7I0tqTmZFFF2kl+VGNAwBsFnl0cgrzftrr3vU/+iY8glfAgqj8Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Jun 2026 07:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111085 invoked by uid 111); 4 Jun 2026 07:12:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Jun 2026 03:12:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Jun 2026 03:12:04 -0400
From: Jeff King <peff@peff.net>
To: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Arijit Banerjee <arijit91@gmail.com>,
	Arijit Banerjee <arijit@effectiveailabs.com>
Subject: Re: [PATCH v3] index-pack: retain child bases in delta cache
Message-ID: <20260604071204.GA3196596@coredump.intra.peff.net>
References: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
 <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>

On Wed, Jun 03, 2026 at 12:05:17AM +0000, Arijit Banerjee via GitGitGadget wrote:

>      * Addressed Jeff King's review question by releasing cached base data
>        after all direct children have been dispatched, while keeping the
>        existing subtree bookkeeping intact.
>      * Re-ran t/t5302-pack-index.sh, p5302-pack-index.sh, and end-to-end
>        full clone spot checks with the precise-release version.

Thanks for humoring me. I fully expected the answer to be "it is hard to
do and doesn't show much improvement, so let's not bother". ;)

It was hard to see the difference between v2 and v3 performance (which I
tried to dig out from the range-diff below), but it looks like it was
basically none. I did my own run of p5302 between the two versions using
both git.git and linux.git, and likewise didn't find anything.

I guess it would make a difference only if we were routinely expiring
useful items out of the cache due to the limit. And even though
linux.git is a "large" repo compared to git.git, cache locality here is
mostly based on how wide the delta tree for a file gets (that is, how
often we go down one chain, caching bases, while still finding it useful
to keep earlier parts of the chain to go down a parallel path).

And that probably has less to do with overall repo size rather than with
how we tend to pack things. Though I guess a repo with a lot of large
files might see more cache pressure (just because each single entry
"costs" more). We could simulate that by dropping the cache size in
p5302, but I still couldn't find any effect even with a tiny cache.

(Actually, with a tiny cache it looked like things got ~1% slower; maybe
noise, but maybe extra thread contention due to the release code?).

So I am happy with either v2 or v3.

-Peff

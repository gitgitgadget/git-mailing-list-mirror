Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4019E97B
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521972; cv=none; b=XKacjfNapLQNuBjGr3LXjmdYMsL64poHqm6PJon2yyQdA6a/k0KSzXyCYvK8KZkJS0FtmZmlgQ1Sd+KkwkOIajnK6vV63XTotPueSZKRjQpQWERG3o3D7uQvpK3We11sR10k/FCrf3+0kFsbFQyNZxQAKS9zM1NNY3KBKhTB1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521972; c=relaxed/simple;
	bh=P34F0ORcTgP4rt1Ze0EwZv6T1BCgw+7S8OAX/5+X9Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWfiD+Gm/hdFuNyWpEKvFZ5Auhq3cToN7YYqMbuW7cRH2Nqj24pJ3mtThUXsq0ApRA+W4hcJohPEcNmz9NA2nAgV5BYyXR9U+yCiQy6MPdooGAO40T+hSXEcml2F6b5qKC8MMYAYWtm5GSYoX/m0LayU3CwqdNZU7xDBEzD495U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=THVsxRcU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="THVsxRcU"
Received: (qmail 5746 invoked by uid 109); 18 Dec 2024 11:39:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=P34F0ORcTgP4rt1Ze0EwZv6T1BCgw+7S8OAX/5+X9Vo=; b=THVsxRcUn3XfhkBpaY7LMMB8T2rtQKvHrKSvX4K/L/nCYwKfJliCmLWFdmMdr8ilk9TupWadXwASf3tX0EEt0KQuzeQiBdsOKxZohyhz5y7nl17XU5VId5uZEpRP3IqClTHzr3TfAN5ZtY73O9yggYiCqqNK6T3OC5Tro5HjJVE7zG5s82r4cDKeYSRvCKzzo375OKjRuWZnjF04qzXKWB7rryaOXIUO8+u2zAPzlkdyaxXo1MpqXH+xQu7GQNxZvHlYJljLB2B7BYpQ+CjEToQIikWicfH9wlz5N1bjCoM9bYyf6aQgSjUQxSfh4rG94FcE9wAZEDJuHEtKT75h/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Dec 2024 11:39:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24530 invoked by uid 111); 18 Dec 2024 11:39:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2024 06:39:28 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Dec 2024 06:39:27 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241218113927.GB594795@coredump.intra.peff.net>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20241213081211.GA1443203@coredump.intra.peff.net>
 <xmqqv7vnevjc.fsf@gitster.g>
 <20241213103850.GA1456983@coredump.intra.peff.net>
 <xmqqcyhtaecy.fsf@gitster.g>
 <xmqq5xnladwi.fsf@gitster.g>
 <20241216111112.GA2201417@coredump.intra.peff.net>
 <xmqq5xnj7fre.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xnj7fre.fsf@gitster.g>

On Mon, Dec 16, 2024 at 08:29:41AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I recall that the performance of attr.tree is not great for _some_
> > commands (like pack-objects). So it's perhaps reasonable to use for
> > single commands like "git diff" but not to set in your on-disk config.
> > It's possible we'd want to warn people about that before advertising it
> > more widely? I dunno.
> 
> Or we disable the unusably-inefficient feature before doing so.
> Would attr.tree be much less efficient than GIT_ATTR_SOURCE?

Whether it's unusably inefficient depends on what you throw at it. IIRC,
the performance difference for pack-objects on git.git was fairly
negligible. The problem in linux.git is that besides being big, it has a
deep(er) directory structure. So collecting all of the attributes for a
file like drivers/gpu/drm/foo/bar.h needs to open all of those
intermediate trees.

So I'd be inclined to leave it in place, in case somebody is actually
happily using it.

GIT_ATTR_SOURCE suffers all of the same problems; it's just that you'd
presumably only use it with a few select commands (as far as I know,
pack-objects is the worst case because it's looking up one attribute on
every single blob in all of history).

-Peff

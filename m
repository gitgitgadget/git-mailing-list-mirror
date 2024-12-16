Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23858204568
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347483; cv=none; b=VnGOLUZnT744EPX1ot2+gd0bXj5VEwSzWhAtTUhZJyx8oZMvIl1r2OHKTPQOV4ObioDITDnbfNGYKJUajWuX6CRs4PKl7e9MBIjCm31meEJuY7ts09oZukJRzCz8bJzCvjDpAcbMXyLy7b2tWIrG37fZPrKsbjnz1grFyxCigHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347483; c=relaxed/simple;
	bh=ObUUf3Y+JbXYKQz0yzBj8gCWwaROS6gBzI3UflMteBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0WBg5GrpBHeuf81FAjGHX0H+8JZBKJoAb3uQeyC3kpEEzqHOVvPv9+sc+/0wGbJgZP3yVKi8MftSl3nEsgIadS6f6W7DmZBVcVSEvOQLxg5/NdH6JJGIDnh8rLJCjPyrDHeAM+DN2CYqnnOIkGg7SH8ZgIhWeegcMv3giENj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DxC9mBjL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DxC9mBjL"
Received: (qmail 26193 invoked by uid 109); 16 Dec 2024 11:11:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ObUUf3Y+JbXYKQz0yzBj8gCWwaROS6gBzI3UflMteBk=; b=DxC9mBjLIfpJMlcsX55w1B7Cq6jmo7PAaloMe5XC043z1DaDpH6hU2mFoT90mPylh9iVlTkiaLBii0BGpY1JrsxagaT2LUb8+RnSXiqVJstkZE7nTxF9/hbcfmrvrfG0td7UXPu4vKg+Rr1Rr8XYrPZZcwO76/MVMK9/LK/K9S4+nmTxwkYBj74NAiKehq5RHI25/5ppLdGDlqQ7JhccmOxLrUQly/blZ6Qgr+OGtUO+L4LHs9+P3oTQC/3f9FO/Ldzu+3ORmLrXH1lhLLf1wZUIQQrEp+khV9wRU5nitSAeHgXcTHYC57TURkm0WTmu1u6GYTX+n299SbCXI+A7sA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Dec 2024 11:11:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26553 invoked by uid 111); 16 Dec 2024 11:11:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2024 06:11:13 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 16 Dec 2024 06:11:12 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241216111112.GA2201417@coredump.intra.peff.net>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20241213081211.GA1443203@coredump.intra.peff.net>
 <xmqqv7vnevjc.fsf@gitster.g>
 <20241213103850.GA1456983@coredump.intra.peff.net>
 <xmqqcyhtaecy.fsf@gitster.g>
 <xmqq5xnladwi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xnladwi.fsf@gitster.g>

On Sat, Dec 14, 2024 at 06:17:01PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Yeah, you're right.  I forgot about attr.tree (does not seem to be
> > documented, by the way)
> 
> We do have an entry in Documentation/config/attr.txt that describes
> the three; I simply assumed it is not documented as I didn't see it
> mentioned in Documentation/git.txt where --attr-source &
> GIT_ATTR_SOURCE are described.
> 
> We may want to add something like this, perhaps?
> 
> ----- >8 -----
> Subject: doc: give attr.tree a bit more visibility

Yeah, that looks good to me.

I recall that the performance of attr.tree is not great for _some_
commands (like pack-objects). So it's perhaps reasonable to use for
single commands like "git diff" but not to set in your on-disk config.
It's possible we'd want to warn people about that before advertising it
more widely? I dunno.

-Peff

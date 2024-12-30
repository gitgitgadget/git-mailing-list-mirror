Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93172AE8D
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735533166; cv=none; b=pxi3MN9ebvgkr/QvzeGAV6DWrIhJyGEfAk5BwcBbxv1y82uwXHvuIQ0X3IbTaPuvE53eOpMfrAwAc+FkTa7V0vZK/sqUZl8nEkFCd7+jVgCux8mYgbXbawPp7tB2e/d30CDk09qv1BDR01xUmF/Wl//V7fy3O5qVhuEeiQEZ7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735533166; c=relaxed/simple;
	bh=ExP1as26nNIXPoxxoM2EOeGtR8oHe6waCi7i5D8sMXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssztsEZ4tBIwrHbqhuwXD0vPivqGdqKU4MrsiLZoIAhA++NzeKIiu+q6bNpiz3uv72OM6sGnp/NsPSl4LNI4BQ7dFbfr1yk7afFqCtGn4GYURWJvW9DIjWOQcAuZfPoEQ9QO3CL2ZHnVVjF08gudP/95lADzlInogez2ZVVfdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SloQjZm8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SloQjZm8"
Received: (qmail 14791 invoked by uid 109); 30 Dec 2024 04:32:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ExP1as26nNIXPoxxoM2EOeGtR8oHe6waCi7i5D8sMXY=; b=SloQjZm8zs1ReFBjxEeRlZKrT9uerYVEUjv0pOQuOHBsxPBv4RzDq2ZTwL1oqHBoDUCEfj3Blmsau+5OabWaCqMMNXg+Xx7PGaoMT9qwkjx0v2nBxnnRAK37/Mmb0kwbRb1iyrlKeqzBkmKM+Kh05XPJ00d4Nnr8HRqnCytlQg1EkPfIhDW9m3o5z0Ad57uByxJBnMWfqj7BvvRSyCCvCP37dh7+WX7GAThRF8eiJoJ9BgnYPnAAYvV1mweEGd+O4fLgysH6Yy5co/RfqOWniMEeTknGuNQCnVZTtAotgP+Iee62Cd3/x7zN+YFGuG8zKCs8CqcK2dO3va22TDBfWg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:32:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14365 invoked by uid 111); 30 Dec 2024 04:32:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:32:43 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:32:42 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: racy leak sanitizer builds, was Re: [PATCH 0/9] commit-reach:
 -Wsign-compare follow-ups
Message-ID: <20241230043242.GA112402@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
 <xmqqbjww65i1.fsf@gitster.g>
 <Z2-2dbYVuuLxpNmK@pks.im>
 <20241228190541.GA815586@coredump.intra.peff.net>
 <20241228192307.GC815586@coredump.intra.peff.net>
 <965bd864-3ac0-454f-b7bb-f8e0214e9969@web.de>
 <20241229165715.GA3158370@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241229165715.GA3158370@coredump.intra.peff.net>

On Sun, Dec 29, 2024 at 11:57:15AM -0500, Jeff King wrote:

> One of the reasons I hadn't sent anything is that I was waffling between
> two approaches:
> 
>   - implement barriers everywhere and just use them. More work, but we'd
>     have the tool if we wanted to use it later, and all builds behave
>     the same.
> 
>   - make a "maybe_barrier" interface that might be a noop, and let most
>     platforms compile without them. They are not needed for correct
>     operation in most cases, but only to work around a sanitizer problem.
>     And it is not even a problem that comes up frequently; it is a race
>     that we occasionally see in CI. So enabling it only for our
>     linux-leaks CI job would be enough to dull the pain.
> 
>     And there is no risk of any portability or run-time issues, because
>     the code is a noop for most builds.

I sent the "maybe" interface in this series if you want to take a look:

  https://lore.kernel.org/git/20241230042325.GA112439@coredump.intra.peff.net/

I'm not married to that approach, but it seemed like the easiest place
to start. And I especially wanted to see how much hand-waving was
required to justify it in the third patch. It's a fair bit. ;)

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A471EEDE
	for <git@vger.kernel.org>; Sun, 29 Dec 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735491449; cv=none; b=qqhsEPEkgA29oN6Sl2085DIMskpkmRQ9mpKmgoLY3m+RfQXFj1MFZp5/Qetpb7B3ORDsUqW3avGifvmdP+2Y6zsAReC4iJVAJn7XhERDUEOX5JxfMBoNM+k4qP24EWU+8wcya3qUi/Zz4BY4GfLv83t8H+csRvAwN6jnSTIiU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735491449; c=relaxed/simple;
	bh=onl73lZ2s6U5ZDh9jHwHw+OObHV4tJ8QaaX9UDk8KrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+/7Vcd3Bxs15fpuDje3MP77r7afURjOr+fH5MSAkaoyNUemtb5C/uyZuBA3hHvmb+ePtfrPdJqLBZUj2gpwD+u4yNzLkrIJaSGglnAMADTI8iozFlq52qPWkNGiZYcZF94dsKK3pUV7yOFg7l6o0e7Ic/3voEKD7bYEsXD3BAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GEAP6kwI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GEAP6kwI"
Received: (qmail 7348 invoked by uid 109); 29 Dec 2024 16:57:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=onl73lZ2s6U5ZDh9jHwHw+OObHV4tJ8QaaX9UDk8KrQ=; b=GEAP6kwIHkn2LCFovyVvhXRku02lQDF99/1enM/mSMFOugwJUe1bd03VRgFis0bG6fHGyECjROE57CESV9UDGndlfqvZnFARk9Oa2F1I9FUGfgpOQ4tsjzGUshcLUw4tUDdFXYFg+AxzZGumhPzycEuXKBOtse4Gr43so0pi96neGgKAtL2mApxsWf+/fjye3Gr41gCeWjNm6wxWI3xpHFCjZIG0D25/KQRyR/H+k2STJY6/leJjlPD5PRDqtuBm/VcUH91t61nlAEZbrOlzYomH90bo29ON1LQYdeyZ31NnZrnWBZdm/elEfH3LqjlctAJzd6oDTuQjeAulWPWAJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 29 Dec 2024 16:57:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8339 invoked by uid 111); 29 Dec 2024 16:57:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 11:57:15 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 11:57:15 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: racy leak sanitizer builds, was Re: [PATCH 0/9] commit-reach:
 -Wsign-compare follow-ups
Message-ID: <20241229165715.GA3158370@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <xmqqbjwwucvy.fsf@gitster.g>
 <xmqq7c7kubx8.fsf@gitster.g>
 <xmqqbjww65i1.fsf@gitster.g>
 <Z2-2dbYVuuLxpNmK@pks.im>
 <20241228190541.GA815586@coredump.intra.peff.net>
 <20241228192307.GC815586@coredump.intra.peff.net>
 <965bd864-3ac0-454f-b7bb-f8e0214e9969@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <965bd864-3ac0-454f-b7bb-f8e0214e9969@web.de>

On Sun, Dec 29, 2024 at 01:02:13PM +0100, René Scharfe wrote:

> Synchronization Barriers were added with Windows 8 and Windows Server
> 2012, Git for Windows requires higher versions, so this native
> mechanism should be usable.  Relevant links:
> [...]
> However, macOS doesn't have pthread barriers.  Here's an implementation
> that had to be fixed to satisfy Coverity, so it might be good now?

Yep, that matches what I'd found so far.

One of the reasons I hadn't sent anything is that I was waffling between
two approaches:

  - implement barriers everywhere and just use them. More work, but we'd
    have the tool if we wanted to use it later, and all builds behave
    the same.

  - make a "maybe_barrier" interface that might be a noop, and let most
    platforms compile without them. They are not needed for correct
    operation in most cases, but only to work around a sanitizer problem.
    And it is not even a problem that comes up frequently; it is a race
    that we occasionally see in CI. So enabling it only for our
    linux-leaks CI job would be enough to dull the pain.

    And there is no risk of any portability or run-time issues, because
    the code is a noop for most builds.

> https://github.com/libusb/hidapi/blob/master/mac/hid.c
> 
> Perhaps that implementation could be used for Windows as well?  All
> functions it uses are provided by compat/win32/pthread.h; not sure if
> they are sufficiently fleshed out, though.

Yeah, I found a similar one. I think it's an undergrad OS assignment to
implement barriers using semaphores, but probably building on a mutex
and cond is less horrible. ;)

-Peff

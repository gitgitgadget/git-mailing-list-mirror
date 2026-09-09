Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8257ED97
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969291; cv=none; b=LGDvfqgm4PCHu6Ru6Iw9P5N64oZvT7LNWeYtH4GqXkNN9bDB/Ev5rD3Ue6ukiX/7kLZ+lz75173ISpwy/F5SiXlw8Cs8s2FTT/QkGAltUqnEvNwOHFYjhXNCoYTZUB9voGax7ZtHjP+REtmq/ioik/o6SdjZMpS4P+mPOgGaR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969291; c=relaxed/simple;
	bh=8O1i8Oz0f0jHseiYHvIZ4su6aw5omltSsCIQT7xslwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjc/Hry/E8sNoJ9oG3i9WFwCSEv1vNaaxSEaHEHF4V4aRZs7i9YIocUZp5u4Dh4AXCsxFu0ZQh1EgsJDkCT4uLRxfaDC646fx5F6b13xYaFtv+XOt63LRSvmyqQgtATwNmhcd8vFsgLri4uazsvb31ujrShymw34gukai11ffbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ICWaCYgv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ICWaCYgv"
Received: (qmail 28391 invoked by uid 106); 9 Sep 2026 15:54:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8O1i8Oz0f0jHseiYHvIZ4su6aw5omltSsCIQT7xslwQ=; b=ICWaCYgvwVs/nW0jH98E8rGd1tmDhHZPoUCCe3ZP8k5hCTz3Ve9TFAPYeomCVd6aTO7ng252AIchQXuWivDZ5mx5LFz00E6ODBry8R3pvyNAik0jgnNx6dj6olpwS2u3kU6vIniFoKIBsPQAEImahne5HYoKLq1CMkdGhSGhottFU8CC6HHqqeCIfAImEcE8FyStBPAq9wdxvYRF5N6cXKleZYCl4hCz71/2XGALYWx/dh2BGyrHDzoJrBBuxmu/xiWTutYNmn+n8uNt9lkcO1L5ie7wU3O4H8sjmZ7HIhzza6tTB8ngavw0MhtY4K0H200xdcJe8T+ub50Ckdgggg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2026 15:54:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 144296 invoked by uid 111); 9 Sep 2026 15:54:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2026 11:54:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 9 Sep 2026 11:54:40 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, ben.knoble@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
Message-ID: <20260909155440.GA94069@coredump.intra.peff.net>
References: <xmqqik4fyaav.fsf@gitster.g>
 <20260908213840.37833-1-ub4nal@mail.ru>
 <xmqqik4fwoz5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik4fwoz5.fsf@gitster.g>

On Tue, Sep 08, 2026 at 11:57:18AM -0700, Junio C Hamano wrote:

> Vsevolod Myalitsin <ub4nal@mail.ru> writes:
> 
> > Yes, I agree that passing the "advice_setting" itself is cleaner and
> > more future-proof. I will change "vadvise()" to take a pointer to the
> > corresponding "advice_setting" instead.
> 
> One minor glitch is that there is an ad-hoc vadvise() call in
> advise() that is not tied to any particular entry in the
> advise_setting[] table.  I think we'd need to give a name to the
> advice_setting struct type, instanciate an ad-hoc instance on stack,
> and pass it down the callchain, perhaps like so:

Isn't this a natural fit for NULL? That ad-hoc call wants to pass the
notion that there is no matching advice config (or at least not that it
knows about). And then vadvise() can check:

  if (conf && !conf->level)
	...show instructions...

which seems natural to me.

As a side note, I think this is revealing some existing shortcomings in
the callers.  Most of the calls to advise() are doing something like:

  if (advice_is_enabled(ADVICE_FOO))
	advise("ask your doctor about foo");

Those won't get the "turn this off with advice.foo instructions". Only:

  advise_if_enabled(ADVICE_FOO, "ask your doctor about foo");

will. So there are many missed opportunities for offering the turn-off
instructions. Nobody seems to have complained, which makes me wonder if
the turn-off instructions would be annoyingly chatty if we printed them
all the time. Most of those calls predate the addition if the turn-off
instructions and advise_if_enabled(), which was added in 2020. I wonder
how people would feel if we converted them all and started printing the
turn-off instructions everywhere.

Anyway, UI philosophizing aside, another obvious pattern for advise()
is:

  if (advice_is_enabled(ADVICE_FOO)) {
	/* do lots of work */
	advise("try %s", results_of_work);
  }

which _wouldn't_ want to convert to advise_if_enabled(). If that wants
the turn-off message, we'd want to be able to pass the advice enum to
advise(), like:

  advise(ADVICE_FOO, "try %s", results_of_work);

at which point we might need a way to pass the NULL advice marker
somehow (for those cases which really aren't tied to a config value,
though arguably that is an anti-pattern in itself).

I guess the caller could just do:

  advise_if_enabled(ADVICE_FOO, ...);

inside the block. We know that it's enabled, but it's not like the check
is expensive.

-Peff

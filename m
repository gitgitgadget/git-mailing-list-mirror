Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91E34E743
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937474; cv=none; b=U7SXKKijsaQbi7HNpPSAT9nyihi1zja+uUbHGYrE1eL6/zDOt8Bx4fxsh7fcBa2bbxL8KxAV62Ki2HClkWAF2Kof9NkK5zNmlolI2N/nk9Mn7MPrcHpLuM6jNKL3BMdwOaJHIZH8yTxDTx0/XjwH41bCyjyJ812xosPxYlEaDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937474; c=relaxed/simple;
	bh=mt6Ni9JumFuUaFuEZ+NOpTXpIIKM0DMx4aAGP3+NrMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FewRrM+D5bBpZ46oHreTwf3wsgxHcMh62/vVjxvuYp/lVeKoH8lAhhcMN3PipbJEldZCXO3v7jyVlYmITV45p0IV4BROO+F8ZeQZir8cILHhAj1fy4nqko6mexLmvu79VO4rAg56Pmw41J2W34cNJe1qwUpCbbKtZAmzZF9L9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GDyr4s9c; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GDyr4s9c"
Received: (qmail 116865 invoked by uid 109); 20 Jan 2026 19:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mt6Ni9JumFuUaFuEZ+NOpTXpIIKM0DMx4aAGP3+NrMA=; b=GDyr4s9cAIDdYrIGMYyfYoZLWQqvTyP3jaTOdjGJDLnxhPJe6M9YKFs5uZZACwGc6uAUtLomE7TD/t1i3ENGr7YcS//WguoQGRlSkbj0Gi9p0ogdAqGgUV0mIDyzuck8XeFhz+FD3ppnThJVnvgSIwVudh7O5yRBlVNUSUKXHyXdPBnF8Xe54EUxeWgVn5RpYBDx+jWlqQ4NANxkHzKP9PVW9SAM2YQJ9Uk0DrgEdPxmjD73WUyG4jSm41rAHdUy2YdTuR/TuKjo6IQJX1WxuKNWY6B7vsmpFwLEHJH41N3ThpemOHO5+57HsCDw+8Jmjdf2yGp3hrtd1a1VzLu3Sw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jan 2026 19:31:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 184034 invoked by uid 111); 20 Jan 2026 19:31:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jan 2026 14:31:11 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 20 Jan 2026 14:31:09 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
Message-ID: <20260120193109.GB3295894@coredump.intra.peff.net>
References: <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net>
 <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
 <aWnekt4ESo0bKpOT@pks.im>
 <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
 <xmqq3445bn33.fsf@gitster.g>
 <aW3bSYCIPMhJT1mf@pks.im>
 <aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
 <xmqqa4y81ag8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa4y81ag8.fsf@gitster.g>

On Tue, Jan 20, 2026 at 09:05:27AM -0800, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > I'm not opposed to adding support for this as an opt-in feature for
> > those people that want it, though, and I think that's the right path for
> > including it.
> 
> Yup.  I am hoping that there are no folks who think that forcing
> this filtering on everybody is so important that it must not go in
> unless it is enabled by default.
> 
> I however wonder if we need two different levels defaults, depending
> on where the user is going, to make it less painful to configure
> things.  I would imagine the remotes one would interact with fall
> into two quite different categories.
> 
>  - The ones that you talk with every day, essential in your work,
>    would be something you would have to be able to trust and if
>    these trusted people want to give you a bit more colorful output
>    from their hooks, you shouldn't have to manually configure "I
>    accept colors from them", for example.
> 
>  - There are others that you will visit for the first time as you
>    try to discover new good things.  These you may want to be extra
>    cautious about than the familiar remotes in your everyday work.
> 
> Perhaps "git clone $URL" should filter the terminal output by
> default, but once inside the resulting repository, "git push" and
> "git pull" from the established remote that is used by default when
> you do not say whom to talk to, our default can be more lenient, or
> something?

I hesitate to suggest this, but: we have a similar distinction already
for protocol selection, where GIT_PROTOCOL_FROM_USER tells us whether
the URL came directly from the user, or if we were directed there as
part of an untrusted automated process (like a .gitmodules file).

We use that to disallow file:// from .gitmodules without breaking "git
clone file://" on the command line.

So we _could_ use that as a signal here, to suggest that servers you
feed on the command line (including remotes you've defined) are more
trusted than ones that you may have been redirected to from a possibly
malicious .gitmodules file.

But I say "hesitate" because:

  1. This is a convoluted scheme making heuristic assumptions about
     trust. It was a not-so-bad way of compromising on the file://
     thing, but it may not be worth the complications here.

  2. The trust boundaries aren't quite the same anyway. If I feed
     "https://evil.example.com" to Git manually, I can verify that
     "https" is the URL and that is OK to use the HTTP protocol. But it
     doesn't say anything about whether I trust example.com to write to
     my terminal.

So maybe a dumb direction, but just thinking out loud.

-Peff

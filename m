Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541721E885A
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168129; cv=none; b=i9KjNsCkqfPLu8RKV0ocqsolsMCACgXt2m0LapS1Vw5+TgWH1fpvMLt1P0FO+JZCytLsNLeIYzKxnhkZEy8HFgsY4x//JW0NsEYZsrytj3TKlrGAS4d+DOsuty6xkVyhEOIytL/c2WD0mrrUayWj4vtaOc7VU1iGfFVoDbKh//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168129; c=relaxed/simple;
	bh=gJgSkv1lCjbRyjeOTsAERBEQLIlq2LMi/cMKHVZrwjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tv9R8mI/s5OdMpmQ2xqyY7oKurNNI6DTnYJVzsOUSSCEQ2a/P9A2yFcytAe6VyMFPGlMZ95V93Kupm+cRhLtWFedhqHN+/4p9cCdoF3s0ygiTF3P1VDRqX51KvF8GWgzA/l0DKyjZtb51iJo2A46+B7hKsiEKtB9lVGdbrxY9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RSNPeyGm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RSNPeyGm"
Received: (qmail 107148 invoked by uid 106); 11 Jun 2026 08:55:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gJgSkv1lCjbRyjeOTsAERBEQLIlq2LMi/cMKHVZrwjk=; b=RSNPeyGmRtNSdUOYPL0XaCx++vaLeVRe6ewL2pBFeUz4wl+qmxnzNwBdBy9OoOgzJbArsTBAXFgwEKXvjxuzh+2GGdD72KqPrrVv+J0ojSJQPi2YkPh4ioVc7TReTdXbMEAMXr7Fa1WvovldbxJTe2buGN/2hOO1injX7eUAQO497CB5UNKtfQ/a8vL1siDxnfFn+13eui5SEp0a/VwVO0fOPFzHq/fgPhFgIsF1vazPgiPKVaJP0A5QJ/btR9vnpijmgCvkkrd6kFmS4MX8xHnUZsq307f62tNlJDT79Sb3VLrO1IbtklUPhkntdcT5ZlAx2T6BM6TKV02ZYOhsKw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 08:55:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 315413 invoked by uid 111); 11 Jun 2026 08:55:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 04:55:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 04:55:26 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <20260611085526.GL2191159@coredump.intra.peff.net>
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net>
 <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>

On Tue, Jun 09, 2026 at 01:15:11PM -0400, D. Ben Knoble wrote:

> > Which implies that the entries are stat dirty. And indeed, if I run:
> >
> >   git -C linux update-index --refresh
> >
> > now they both take ~20ms.
> 
> Ah, TIL about --refresh. I suppose it could be nice if "git diff"
> updated the index in this way, but that sounds like a band-aid. Maybe
> creating a fresh worktree should do the equivalent to make sure it's
> considered "fresh"?

I think "git diff" _does_ refresh the index internally (that's what
takes so long!). I thought we then wrote out the result, but maybe we
don't notice that it needs an update for some reason?

I'm pretty sure "git status" does something similar, though running it
in a slow working tree _does_ seem to make things faster. Maybe it's
more aggressive about doing the update.

I don't think that refreshing after making a worktree would help. The
problem is one of timestamps: we just wrote an index (so it _should_ be
totally up to date), but we err on the side of caution for some entries
because the file timestamps and the index timestamp are the same. So
what makes it "work" is that one second passed between writing those
files and running "update-index". If you ran it from the worktree
command automatically, it might all still happen in the same second.

And of course, it's not just worktrees. Any time we checkout we may
suffer from this problem, though initial clones and worktree creation
will write more files than most.


> At $DAYJOB, I _think_ some version of "git restore <stuff>" ended up
> also updating the index.

Yep, that would make sense. Any index write (after the second-hand
ticks) will make it go away, since it means updating the mtime of the
index.

> > I'd have thought USE_NSEC was the default these days, but looks like it
> > isn't? Try building with that and I'll bet it goes away entirely.
> 
> Thanks, I'll take a look.
> 
> I can see on my Macbook that at least Meson does automatically set
> either USE_ST_TIMESPEC or NO_NSEC automatically, but has no option to
> enabled USE_NSEC and try that. I can probably write that patch (which
> I'll do to test), and I can send it along with the "worktree add
> should refresh the index" if you think that's an appropriate thing to
> do.

I think NO_NSEC is about not looking at the nsec fields of stat structs
(since they might not exist). But we don't actually use them for stat
matching unless USE_NSEC is set.

I guess the distinction goes back to c06ff4908b (Record ns-timestamps if
possible, but do not use it without USE_NSEC, 2009-03-04), which details
some reasons you might not want USE_NSEC. Feels like it ought to be a
run-time config, though, and maybe even something that gets auto-probed
by git-init.

Definitely not an area I have looked at much, though, nor thought hard
about. So there might be gotchas. :)

-Peff

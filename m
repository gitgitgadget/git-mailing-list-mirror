Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C051C01
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171027; cv=none; b=r06VLSWNOdua/sJ3TgH+Jep3EXcxTJU6bYUENtapxoX7S9D4AMeEiM01qClIaeW9qDX30SBvB9UVP9lEugXd9OTvWGa4vkdlDuYIALZOS23O1cJWWUqOxmJY3Jbn9QTBm4X95S8wp5hT6P377dkMWpKMbhiz27lJGjrjuExaEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171027; c=relaxed/simple;
	bh=ciQwU0E9UdJ2P9bRAQbXdC+ADQ3Z/SbMaLkdUsiG75Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG+116OL7JXBTI8bW+AoqRQj2IVhftKPGlw3VrfHn+OgRLb2jQHjJ0DyCmwdRde6T1kOvUbOZ9vBpdni3IUoCMOq8+ZEqRPorHSql4POzfYFnGsw5y7LD2IL1DAbX302cYyuzd0RuJaY4osrrS+KLte4a/jd0OWwZRdN3UARjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TL5zoozp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TL5zoozp"
Received: (qmail 25183 invoked by uid 106); 5 Oct 2026 03:30:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ciQwU0E9UdJ2P9bRAQbXdC+ADQ3Z/SbMaLkdUsiG75Q=; b=TL5zoozp4O/DfBrwdmEZVU4KdVz7u62hhGJOHktoVwpoT+mvARLMGc+P1l+FFbWhCvR2hr+RtloAFqOYnhtvSAI+tDYx3UlpS/PJeSKFD7FhhuuCWAFpnCTynDDXnYJXP64IuWincKwm1vKLkabLYt5jpBcyrIqOs/iEoJAycJitzKWDVNUKhr8grEmYaj7JjtGxVw8G3+oU13PmfObXmWbDQUN5pOTjP93gB0jb3/jc2NuH+3xfbIMYbQHI9iYGc9u+WYzb0iYX4XsltRUydJZs4IqxVvUVekfLXKWaw2z706jx7ViO72Py16r1jpOO8pHQIOkRrUUOt0uXq2ojlQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2026 03:30:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 81325 invoked by uid 111); 5 Oct 2026 03:30:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Oct 2026 23:30:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 4 Oct 2026 23:30:23 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: a "limbo" object-format state for empty repositories?
Message-ID: <20261005033023.GA10271@coredump.intra.peff.net>
References: <20261002224400.GA834158@coredump.intra.peff.net>
 <asBVY1WniGUo6bQS@fruit.crustytoothpaste.net>
 <20261003012512.GA1324483@coredump.intra.peff.net>
 <asEPp6Bg3xDpA4e1@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asEPp6Bg3xDpA4e1@fruit.crustytoothpaste.net>

On Sat, Oct 03, 2026 at 02:22:32PM +0000, brian m. carlson wrote:

> > So I think the best we can do is advertise magic-limbo, and then new
> > limbo-aware clients can always do the right thing. Clients which are new
> > enough to understand object-format but don't understand limbo will use
> > the server's object-format unconditionally. So the choice there does
> > still matter. But if we don't switch to sha256-by-default until
> > magic-limbo is implemented, then anybody who has a local sha256 repo got
> > there intentionally, and presumably knows enough to configure the server
> > side to match. So the sensible protocol advertisement for a limbo repo
> > is "magic-limbo" plus "object-format=sha1".
> 
> We need to declare the other object format as well because we need to
> know that the server specifically supports SHA-256.  If we add a third
> hash algorithm, then maybe SHA-256 is unacceptable for that reason.  So
> maybe `alt-object-format=sha256`.  We do definitely need to be sure that
> multiple options are accepted, though.

Right, that makes sense. And the presence of alt-object-format would
replace the need for a separate magic-limbo at all.

> As I say below, we probably need to initialize with some hash algorithm
> at first, so we could also have `object-format=sha256` and
> `alt-object-format=sha1`.

Yeah, that makes sense.

> You hint at delaying SHA-256-by-default until this is implemented, but I
> don't think that's a good idea.

I wasn't proposing a delay. There's at least another whole release cycle
before 3.0, and this feature doesn't seem all that big. So it seemed
like something that could be implemented in that time-frame. I may or may
not work on it at some point; I just don't want to preclude anybody
(like Scott) who is interested and wanted to run with it.

> > Those parts seem outside of the scope of Git, or at least its protocol.
> > But yeah, I'd expect a forge like GitHub to let you say "do not allow
> > the creation of sha1 repos in this account/org", and the object-format
> > selector for a new repo (at the forge UI) should be a tri-state: sha1,
> > sha256, or limbo. How that translates into Git commands is TBD: whether
> > via config, or more likely, that you have to select the limbo state
> > explicitly with a command-line option to git-init.
> 
> I disagree that they're outside the scope of Git, but I do agree that we
> should add support for this either in the config or via a command-line
> option.  I think config would be better here because we also have to
> deal with the fact that someone might use commands other than push to
> write into the repository (on a forge, that might be the API) and we
> need to specify _some_ hash algorithm for that case.

Sorry, I just meant that policy decisions like "this account should not
be able to create sha1 repos" was outside of Git. We definitely need
some config flag to mark the limbo state (since it's set by "git init"
and ultimately respected by receive-pack and elsewhere). I would say
that any limbo-state feature should _not_ be on by default, but could be
a useful building block for forges that want to reduce friction. There'd
perhaps be some forge-specific work to do on top, too.

-Peff

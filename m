Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215123D291
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962589; cv=none; b=MVhJEXJWz+6CVh3iYsAtLD36bL3zPfjOgR2NUSHiV/2Lqg+6+myZsUUo6R1YBinjgYLaut4rbj8XLfi3cKYlFQlsLErU7J/7+flNqnsbYNlEvut/oCAzIw1NLtyRk3BlyOYNA2MNhhfUkNQthoGtMwRCWljFiiFstf65dnAmi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962589; c=relaxed/simple;
	bh=xafuzdLwmA1eS6p3LQNl8fz5IQR/pwNG4PEFzGATAT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb0Iap5rCDsiA8piFF2p1oQCBjDMyDLzlQHv6THxM/6p7NUY1zw8+qOXEbs1lkYwUgQjQSGFlueq82otzAil07cfAHv+9yam1qVvqWB4xpYl0cSRlWyApKYKu79OnB9oD+cu8E1sFN1HN6KiKrKiqDSbnqO50M/ySo7/n0YpQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DOmgMX8Q; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DOmgMX8Q"
Received: (qmail 83894 invoked by uid 106); 8 Jun 2026 23:49:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xafuzdLwmA1eS6p3LQNl8fz5IQR/pwNG4PEFzGATAT0=; b=DOmgMX8QKVqCGFVnUIZRmEpRe1tDtMPfvI0IuqGOvH3c9LndvcKgc1lpqr5pcbcUlZzpHRmrGZXUEXIYom3HAhiF4CP2iWbi657wZ6HdfgusOcwjEsBMSzlZbXc53gLMSwqpNVkhq48A50uT7lve5pUZJybzlxO7f4PcutPFXXJOP35aaQMZQ4s81EeWdvwlMv/5w9TK+IqzwHVeJ83qSbuslwmNzz5PW44pUCzVV46Ouzmxh/MuIc3msDu6pzsHpI98pypR54TGgPS/zyD0KthnnQ6JfofZ2xch1K2E8NnPYX+b8ipPX6aiz+TCHkg/d+4K+AgeoTCLqkZuI9RV7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 23:49:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 245551 invoked by uid 111); 8 Jun 2026 23:49:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 19:49:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 19:49:46 -0400
From: Jeff King <peff@peff.net>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org, Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: followRemoteHEAD management question
Message-ID: <20260608234946.GB358144@coredump.intra.peff.net>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>

On Fri, Jun 05, 2026 at 12:31:30PM -0400, Matt Hunter wrote:

> In the past, I've preferred to run 'git remote set-head <name> -d' when
> setting up a new repository, since I generally have an awareness of what
> the remote default branch is, and I don't like seeing them in branch
> listings or git-log annotations.  They are especially noisy to me if I
> have multiple remotes.  It's possible this config is ill-advised - I
> would love to be educated if so...

No, it's perfectly reasonable. Being able to refer to "origin" to mean
"origin/HEAD" is sometimes handy, but if you don't use it, there's no
reason to set up the symref in the first place.

> However, since b7f7d16562c3 (fetch: add configuration for set_head
> behaviour), these changes are undone by every 'git fetch'.
> 
> The topic mentioned above (merged in a1f34d595503) adds a new
> configuration key 'remote.<name>.followRemoteHEAD'.  I'm assuming that
> the intended use for followRemoteHEAD is really only in local /
> per-repository config, since trying to apply it to my personal
> .gitconfig has some odd behavior.

I think this is a gap in the new feature's implementation. It added
per-remote config, but there is no global config to fall back to (e.g.,
the way that remote.*.prune falls back to fetch.prune). There should be
a fetch.followRemoteHEAD option (or perhaps remote.followRemoteHEAD).

> The <name> in the key template does not accept a wildcard, so I must
> list out each of the common remote names I use across different
> repositories.  Since many of my repos don't actually have remotes
> established for all of these names, they pick up a kind of half-baked
> definition for each of them as git performs its config parsing.  For
> instance, a name will appear under 'git remote -v', but it won't
> have any actual properties configured.

Yes, this is a common problem with the remote-config namespace. Defining
_any_ key makes the remote "exist", even without a defined url, but that
isn't usually the intent.  But we can't distinguish that from the case
where you really do want to define a remote without a url (in which case
the url is the name of the remote).

> Is there another solution in place I've missed?  If not, would there be
> any opposition to a new key like 'remote.followRemoteHEAD' which serves
> to provide a default value for any remote that doesn't have its own
> 'remote.<name>.followRemoteHEAD' key?
> 
> I've started scouting out changes to make for such a patch.  It's not
> ready yet, but I figured I would throw this question out in case an easy
> answer can save the effort.

I think you are on the right track. I can see arguments for or against
putting it in fetch.* or remote.*, so you'll have to pick one. ;)

-Peff

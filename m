Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E4367B9E
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167186; cv=none; b=TrbLBAAEkzSQE5tV1up4vgLqkLmqY8afPyym15lh1Ao6ke5M5+eD++ig3MSUyd2lWDJ8tLRQhzv5N2Kj7ZkyR0bS4zZY25CRUq8t/djR9L81ZEQA8zuqB6LEKDeulUkUXFhN/IWAhSh/QAnvB/64mtF9bxoDMClF12mvQJ65o70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167186; c=relaxed/simple;
	bh=njhyvQdPvCSNEnvQo0TznCf8KZsc/uQFNqWSAsH98CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOIxaBzKy4imU1h8TzlJC1lnYzJc38G7KTXq0tpIGUEoDWMiBrlZURkKZqrNvwoPLUBs/CUObAhZxR+VB376jYDB1PfW04vvWxkYLZ3hJ71v/Ber/fonY3VLU6/xziCQBvPeMbYTfvdFwKtEfSPzhUilklUKGXuuxhsukvEpbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AHoC9XSV; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AHoC9XSV"
Received: (qmail 107034 invoked by uid 106); 11 Jun 2026 08:39:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=njhyvQdPvCSNEnvQo0TznCf8KZsc/uQFNqWSAsH98CM=; b=AHoC9XSVj/BgcgQJyP96uxjQXBMLBxdA+Z0aiQ9ivYoJmvd9T0vMpNBEEonbCKVxRuOXX3gMNmrZ1qAKI1ZDA2Jdz75TtZ5PaXwE0aJofCP6YtPRkOKQY7uKM8wzrjfq+bANdkeaZtbqGupA5T4uzhis8ThGr+6l+vhWSir5qyG8WfeaA0Oj+KfhEg0yLTNTFkavyG6XIWRfAPmVSRxgNEaE1AVCuEo+alzpnCllsgyVGWrx4ZCa5DhFVppsAnpV2EGWruK7jQK/dSLnhg4m+BqGXARf36mnGLYn2vf7BABibHBKnDiK234YqD2/jaztmrIRDz3RvH+HogZfUZdHMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 08:39:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 315186 invoked by uid 111); 11 Jun 2026 08:39:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 04:39:48 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 04:39:43 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/3] config: allow disabling config includes
Message-ID: <20260611083943.GJ2191159@coredump.intra.peff.net>
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
 <20260608225149.GB340696@coredump.intra.peff.net>
 <4d7834c0-d8ab-4dcd-8a7f-ed62c30cbe43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d7834c0-d8ab-4dcd-8a7f-ed62c30cbe43@gmail.com>

On Tue, Jun 09, 2026 at 08:59:22AM -0400, Derrick Stolee wrote:

> > So I dunno. From the described motivation, this feels like a band-aid
> > that fixes only one narrow instance of a greater problem.
> > 
> > The notion of enabling/disabling includes per-command is itself a
> > flexible building block. So it's possible that it has other uses in
> > general. But it's also a fairly broad hammer that covers more than your
> > use case. If you're planning to use "git --no-includes" in some script,
> > then it breaks the config of anybody who uses includes in their
> > user-level ~/.gitconfig file.
> > 
> > So you may need some more directed limiting.
> 
> Are you suggesting some kind of internal sandbox to limit Git from
> accessing repository paths from config includes and other config-set keys?
> That would be a more complete solution, but I'm not sure how we could plug
> all of those holes at once. I'll think on it, though.

I don't know that I'm really suggesting anything, but more just thinking
out loud. My concern would be that we plug one such hole, and then later
find we need more. And then we are stuck with the solution for plugging
that hole, even if it may later become redundant.

I'm not sure I entirely understand the problematic case, though. The
user points to in-repo config (which we already tell people is a bad
idea), and then that config breaks for some reason? Because the include
is relative and git is run from another directory?

If you are going to make such an include, I'd hope you'd at least do it
from .git/config, which should reliably resolve relative paths based on
the source include file, not the current working directory.

> This is exactly the kind of case I was worried about. This specific case
> only impacts write operations, but some tools do those things. And this
> email case is a common one that users do in their global config to isolate
> personal and professional identities.

Yeah, I picked it because I suspect it is a very common use of includes.
But really it is up to users to do whatever they want with includes, and
they'd probably expect them to always work.

> I'm trying to think if there's a place where we'd have some config that is
> critical to the repo functioning not in its local config (like the repo
> format version or extensions). Perhaps borrowing from your work/personal
> example, a user could use a different credential helper for work than they
> use for personal repositories.

It depends what you mean by critical, I suppose. If I happen to prefer
shoving all of my diff.*.textconv commands into ~/.gitconfig-diff, then
including it with include.path=.gitconfig-diff in ~/.gitconfig, I'd
expect it to just work everywhere. But disabling includes would violate
that assumption. Probably not _critical_, but it could be annoying and
surprising.

> Or: are we venturing into territory where we don't even want to create a
> new foot-gun? If there were another way to solve the situation that I'm
> facing without these risks, then I'd be open to it. Any ideas?

Yeah, the more I think on it, the more it seems like a foot-gun. Like I
said, I'm not sure I entirely understand the use-case. If you could
flesh out an example, that might help.

-Peff

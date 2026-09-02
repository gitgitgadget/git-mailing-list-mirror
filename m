Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEDD371D14
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334010; cv=none; b=FuB+snjicOiWW65gypiSiIIK5Fg7UqHMzBx2AQvAJI2bNZFplFUpGOGiNpdsIgpOrvarGKkdPPdKJPQzfVLrxPs/I7zKNF+OsCWk7Uzoj+1pZKsV+ppgQmCmXQs3r+xdPbfD+ugl3V8BDIOsyUyG1GMueTU5RDNxA8ZFnlhdYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334010; c=relaxed/simple;
	bh=UTNZmCstcOptrnrLMVw2U7OStrhsVzlMEsC6GmsoQDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyd3y9OWHV5Uu5Te7SWn4AZfEtUP6fLocAA1p0BJQCoHJmVToES+jRLs0Fu/+BEpmaB7gHibc+zHWuUsAFyjCkVxI+xWeSmiFMYrTqKYlOBV0h9D7ETEeZHIutfTWjKUr0I42DNYw7+iJvbWHAZ+ODVgAyQMAfElpxYajjQW94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R7btU1qx; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R7btU1qx"
Received: (qmail 10196 invoked by uid 106); 2 Sep 2026 07:26:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UTNZmCstcOptrnrLMVw2U7OStrhsVzlMEsC6GmsoQDY=; b=R7btU1qxgeEZza5oB2CfNmYYJrcNvTi1siJyLTaIS4pIhBnlejBzbimi+hABPslVwQBJbdBEKQP8sAKksvuCxguiuBAY9bMsVYsgFLNRIW/7t4r6TLIVyOc2nqmZP45PpQ+tpDL1P/qbEkKHO+36t5GvAXbzfqUNEIaQnhAuZBDuisxLVoS+ti28QWkyi7iHXrQ4jJYx5ppi87chjhqMfizS9axDhWPn3/EKci5BxHbjjWk94xGGu2g8XtULXMOVHk64YxV/OPxL4ooaf7OLU5Zen7iQqhGmF9hwVHmajWy20U34BPxJe67ywDLCJsV89DzsWki+8w7rJdF0hDjf7g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 07:26:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47608 invoked by uid 111); 2 Sep 2026 07:26:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 03:26:47 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 03:26:46 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <20260902072646.GB70165@coredump.intra.peff.net>
References: <cover.1787231825.git.ben.knoble@gmail.com>
 <cover.1788206466.git.ben.knoble@gmail.com>
 <0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
 <20260901045403.GA1075462@coredump.intra.peff.net>
 <CALnO6CAZYvnv3fMWkU0pqY+XN3ncBqVav49ZEvzV0LMtmkYO0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CAZYvnv3fMWkU0pqY+XN3ncBqVav49ZEvzV0LMtmkYO0Q@mail.gmail.com>

On Tue, Sep 01, 2026 at 08:36:22AM -0400, D. Ben Knoble wrote:

> > This hunk made me wonder if we even need to do any build-time magic here
> > at all. If your platform doesn't support nanosecond stat entries, then
> > you're probably not going to ask for core.usenanosec in the first place.
> > But if you do, I think the code still works; we fake the entries as "0",
> > so they'd always yield a racy tie, just as if core.usenanosec was
> > disabled.
> 
> At first I thought you meant we fake the cfg->use_nanosec as 0; it
> took me a moment to realize you mean that we fake the index entries as
> 0ns. (That is what you mean, right?)

Yeah, sorry to be unclear. I meant that we still have this code:

  #ifdef NO_NSEC
  #define ST_CTIME_NSEC(st) 0
  #define ST_MTIME_NSEC(st) 0

So we are free to pretend that stat nsecs exist and compare them.

> In that case, yes, I suppose it would work. Might be confusing in a
> debugger to see use_nanosec set and checked, though?

Maybe. Looking at the list of NO_NSEC flags in config.mak.uname, I
suspect it's a pretty small population in the first place.

> Hm, yeah. I haven't thought too hard either about the interactions
> where you toggle core.usenanosec on and off, but giving it an initial
> think they seem fine. Unlike this hypothetical case, when it's off we
> don't look at the ns fields, so I don't think we end up with any false
> negatives.
> 
> And in this hypothetical, by restricting the option parsing we avoid
> reading the ns values on unsupported platforms, I think?

I'd have to double check, but I thought that even without USE_NSEC (and
thus even with your new core.usenanosec off) we still read and store the
nanosecond values in the index, as long as the platform supports it (and
if not, then we use those "0" fallback values).

So they are always there in the index. I guess the same odd sequence
applies even today. If you:

  1. Build with NO_NSEC and get "fake" 0 values in your index.

  2. Re-build without NO_NSEC, and also enable USE_NSEC. Now we get
     _real_ values when we stat(), and compare them to the fake values
     in the index.

Now the index values appear up to 1-second older than they actually are.
Which could maybe yield a racy miss of an update? Probably not for
stat-freshness (where we want an exact match), but maybe for some index
vs entry racy-git comparison. I didn't think that hard about it, because
at some point this sequence is just kind of insane.

> The build-time conditional _does_ mean that if your distro (e.g.)
> provides a NO_NSEC build, you can't access the core.usenanosec feature
> without compiling yourself, even if your platform supports it. But I
> haven't thought too hard either about what it looks like to get rid of
> NO_NSEC entirely, and I'm not totally sure if that's a good idea.

You couldn't access it even if core.usenanosec is supported in the
build, because your fake nsec values would all be "0" and it's
effectively a noop. ;)

My suggestion wasn't really about supporting more cases, but just about
making the code simpler by having one less #ifdef. But like I said
earlier, we can't get rid of the NO_NSEC knob entirely, so it's probably
not worth worrying about the one #ifdef either way.

-Peff

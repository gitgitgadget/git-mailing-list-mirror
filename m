Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355361DA617
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161442; cv=none; b=Rj2pWYYPJSCOhPx+fV/1SwhN6RMRFGK12+3Aq6e4btdhabll393rltIPnGjnPW28R2T6osGHF+287dC5169698+aoESoYM1lsN5td8+IudCKULMd9Yk8uW8tZfNlAwvuERfyMNvHDSC6vyP8LtZH7EYORkps1pCS3qsmsqYEn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161442; c=relaxed/simple;
	bh=Ij9OL8qRSGlQQuUAR+hNKmnYev9T1tQxJ1gCAibnkok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwTLflB6nUYpNXrBcNw5Y0zLAz0wigBzNLT62AnZVGqXdw/v9tRG3TiSyfEjkqVIxfOvz8D2jH6BZr3D/N+k90Ba2Eh7wHpeqMNJcaRwLqKbFMMJrm5LkRBzzErUhvywcw4PU4SfeOqmX4sbE15tY228hUnKu0u2ZOKHKHsjHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LYSQAjIi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LYSQAjIi"
Received: (qmail 18532 invoked by uid 109); 5 Mar 2025 07:57:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ij9OL8qRSGlQQuUAR+hNKmnYev9T1tQxJ1gCAibnkok=; b=LYSQAjIiBbBrpOYJsjLuucsP6wbSLBCcGu5lwz9vV77tUkIXxhVVa7CGmaXx3Wlq/FYv1/UhvvH253+NsYrO2hVsAfdX++uonSh16XyjNhW5jaGN6z40kr/9zms5Atb0yKy+q4jrkHtMIfufolJGkJr1BEHd403B2ua1UN0dmU3Us40ikCCiPKJZiMox+bxdFO8bMC/S4qLav2Z6Be67qY5Kvx8y/SjB2lDuZqxvESFMJf1XD9K1uOAHYKL6f30XIPCob2eHqAHP+BVmpNxgNktvOacEluBDaP00qMZRHdRUUay7IrPAWahrDff2pCOnO62YwUTQF3kHvvNJr1sfRQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Mar 2025 07:57:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8701 invoked by uid 111); 5 Mar 2025 07:57:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Mar 2025 02:57:10 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Mar 2025 02:57:10 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"\\ Junio C Hamano" <gitster@pobox.com>,
	"\\ Elijah Newren" <newren@gmail.com>
Subject: Re: GIT-BUILD-OPTIONS can override manual invocations
Message-ID: <20250305075710.GA1917508@coredump.intra.peff.net>
References: <Z8IX2bMJe+V80idE@nand.local>
 <20250304082901.GA1297837@coredump.intra.peff.net>
 <Z8d5++1dNdo/32uz@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8d5++1dNdo/32uz@nand.local>

On Tue, Mar 04, 2025 at 05:08:59PM -0500, Taylor Blau wrote:

> > Hmm. I am not sure what this is supposed to do, as I would not expect
> > that "make -C t/perf" to build anything at all. It will use the working
> > tree version built in the first step. So I'd expect your initial "make"
> > to do all the work (and either fail or not depending on whether NO_EXPAT
> > is set in your config.mak).
> 
> Oops, I should have used the t/interop example instead of t/perf from
> above. I agree that t/perf doesn't build anything. The buggy invocation
> that Elijah and I noticed was:
> 
>     make &&
>     make -C t/interop GIT_INTEROP_MAKE_OPTS='...'

Ah, that makes much more sense.

And while it's the same issue as my:

> >   make &&
> >   (cd t/perf && GIT_PERF_MAKE_OPTS=NO_EXPAT=1 ./run HEAD^ HEAD)

I can see how it's even more confusing, since you are feeding it as a
make variable, and not through the environment (though of course it is
through the environment that you'd eventually expect it to make it).

> > I do think it would be nice if environment variables took precedence
> > over the sourced GIT-BUILD-OPTIONS for "./run", but I suspect doing so
> > is a little tricky.
> 
> Yeah, I agree, and I think that would be tantamount to also fixing the
> pre-4638e8806e behavior, which would be nice. I think a good middle
> ground would be to continue to allow environment variables to override
> options that are unset in GIT-BUILD-OPTIONS, which definitely is a
> regression in 4638e8806e.

IMHO the root of the problem is writing GIT_PERF_MAKE_OPTS and
GIT_INTEROP_MAKE_OPTS into GIT-BUILD-OPTIONS at all. It is not used in
the actual build of Git run by the initial "make" invocation, and if it
were to change we would not actually need to rebuild anything. And yet:

  make GIT_PERF_MAKE_OPTS=foo

will not fail (since we don't look at the nonsense value), and:

  make GIT_PERF_MAKE_OPTS=bar

will rebuild at least scripts because it doesn't know that the changed
value is uninteresting.

If we instead just read the value when running "make -C t/interop", we'd
always get the fresh value (whether from the command-line, the
environment, or reading config.mak).

But there are two catches:

  - right now if you do:

      make GIT_INTEROP_MAKE_OPTS=whatever
      make -C t/interop

    it will use the value from the original "make". I think that is the
    root of the confusion, but possibly people depend on that? I don't
    know. I would (and in fact do) put it into my config.mak, where it
    would be seen by both invocations.

  - we'd want to see the values from both make and the shell, and their
    syntaxes are slightly different. In particular, right now I'd do:

      echo GIT_PERF_MAKE_OPTS=whatever >>config.mak
      make  ;# this writes it into GIT-BUILD-OPTIONS
      cd t/perf
      ./run HEAD^ HEAD ;# this sources GIT-BUILD-OPTIONS

    How does that work without GIT-BUILD-OPTIONS? I'd need ./run to
    source the config.mak file, but it's in make format, not shell. So
    I'd have to do something like this in the run script:

      opts=$(make -epn | perl -lne 'print $1 if /^GIT_PERF_MAKE_OPTS = (.*)/')

    (or there are variants that can be implemented with a special
    target). It's an extra step, but maybe not too bad.

So I dunno. It may not be worth changing the status quo.

> > > So I think a more robust fix might look like only filling out those
> > > lines in the GIT-BUILD-OPTIONS template when they are non-empty, similar
> > > to the pre-4638e8806e behavior. Something like:
> >
> > Yeah, that would fix the regression. But I kind of feel like your
> > initial command is already skirting the edges of what the original code
> > was meant to handle.
> 
> Hmm. I'm not sure I am following what you're saying here. How so?

I think you were lucky that giving a different GIT_PERF_MAKE_OPTS
variable to your second make invocation ever worked at all. It was not
not the intended mechanism (at least that is my understanding; like I
said, most of this was not documented and the implications of various
approaches were probably not through through all that much).

So yes, 4638e8806e is a regression for your particular invocation, but
given the adjacent issues (if you had those variables set in your
config.mak), is it worth trying to support your case? Or put another
way, is there any reason you can't just do:

  make GIT_INTEROP_MAKE_OPTS=whatever && make -C t/interop

? If this change impacted a lot of users, I'd be more worried about
retaining corner cases. But the perf and interop suites are developer
tools, and I'd guess that only a tiny fraction of Git devs even use
them.

Not that I am particularly opposed to your "don't write empty values to
the GIT-BUILD-OPTIONS" solution. My main complaint is just that it's new
extra code, though if we can at least write it _once_ instead of having
to remember to do it for each variable, that's not too bad.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D41FAC4B
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076945; cv=none; b=GHavllZLVrg/IkzjRLungCEawlOnyKwWrtv3Yqw0wha2b6kT9UDbn0idnuZ3+pk8KZ7Y6b9jzJXLVYNDk9B56vyaBqYPGNj9gmrTlfZxpza9dF8Rrv0F92DBmi5W99BffdIxGTxCEZdyfcM2pP7IgltisltnB+rYxB1h8XGy2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076945; c=relaxed/simple;
	bh=fDHN1PhAgJSWBsQfxMOK9P/VxcXaNJ1nKobIF3I1Ba4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STyo1yod1kP7Vgg5lv4wPNfxzeyFMIFHrF/cKqX/3XXVGkOqpzZmau83EeXoaoiIFAVjvGc57Zh2zTatTKxsaxp6rxkYWteICqjBbSEvU4bRF0Bs590QIZcHhnve5S4ok2FCLizIwKXKi3srgORs+vqg9u2qB4uArujGpJinDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ApHWt05D; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ApHWt05D"
Received: (qmail 10300 invoked by uid 109); 4 Mar 2025 08:29:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fDHN1PhAgJSWBsQfxMOK9P/VxcXaNJ1nKobIF3I1Ba4=; b=ApHWt05DcmXp61cHFdAv4zN7n6P2jD3H5tTZ0SV+PGZSzQhVwNir5BXfatwpt+bQIYYNhw6KFN43KlGFGJQ4XQQsMXSKmcH4j1sAPJaw/F69o0gEPYh+VPu40vP7AYo28SlBvPmu3fN5eaBBT/Zy6R/w4xwWCRgdlVkHx0eAx0HWt0t2F86RNb1xGl2ya9WIg2FM0Qbf3SyKIs/RRrFaob/uhjbMEb3oUY6PobVP1QA5viMaL676s1qlFf2I+CCvL+g9xCM8pVhaSv2MVBC1bYAgF9nexK90K0tMDGyPlR6T1LFBIQfB2UkhLvOeGpbRhV3IpB78fzgxdMjtQqYY8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 08:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23422 invoked by uid 111); 4 Mar 2025 08:29:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 03:29:02 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 03:29:01 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"\\ Junio C Hamano" <gitster@pobox.com>,
	"\\ Elijah Newren" <newren@gmail.com>
Subject: Re: GIT-BUILD-OPTIONS can override manual invocations
Message-ID: <20250304082901.GA1297837@coredump.intra.peff.net>
References: <Z8IX2bMJe+V80idE@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8IX2bMJe+V80idE@nand.local>

On Fri, Feb 28, 2025 at 03:08:57PM -0500, Taylor Blau wrote:

> In 4638e8806e (Makefile: use common template for GIT-BUILD-OPTIONS,
> 2024-12-06), the project's Makefile changed how it writes the
> GIT-BUILD-OPTIONS script. Prior to 4638e8806e, the Makefile would write
> the file itself, but post-4638e8806e it fills out a template
> ("GIT-BUILD-OPTIONS.in") with the appropriate values.
> 
> This has an interesting side effect when running e.g. the t/perf or
> t/interop suites. If I do:
> 
>     make && make -C t/perf GIT_PERF_MAKE_OPTS='NO_EXPAT=1'
> 
> , then we will still try and build with the libexpat headers!

Hmm. I am not sure what this is supposed to do, as I would not expect
that "make -C t/perf" to build anything at all. It will use the working
tree version built in the first step. So I'd expect your initial "make"
to do all the work (and either fail or not depending on whether NO_EXPAT
is set in your config.mak).

I usually trigger a build of another version using arguments to "./run".
Is there a way to make that happen via make in t/perf?

> This is AFAICT fallout from a change in 4638e8806e where instead of
> *not* writing e.g. GIT_PERF_MAKE_OPTS into the GIT-BUILD-OPTIONS file,
> we now write it with an empty value. So when we run 'make -C t/perf'
> with a non-empty GIT_PERF_MAKE_OPTS, t/perf/run will source
> GIT-BUILD-OPTIONS, and override the value of GIT_PERF_MAKE_OPTS we
> specified.

But yeah, I can see how this would fail with:

  make &&
  (cd t/perf && GIT_PERF_MAKE_OPTS=NO_EXPAT=1 ./run HEAD^ HEAD)

if the GIT-BUILD-OPTIONS value takes precedence over the environment.
OTOH, wasn't that also true before 4638e8806e if you did set
GIT_PERF_MAKE_OPTS? So:

  make GIT_PERF_MAKE_OPTS=NO_TCLTK=1 &&
  (cd t/perf && GIT_PERF_MAKE_OPTS="NO_TCLTK=1 NO_EXPAT=1" ./run HEAD^ HEAD)

would fail (or more likely, the initial one is set in your config.mak).

I think you're "supposed" to do this:

  make GIT_PERF_MAKE_OPTS=NO_EXPAT=1 &&
  (cd t/perf && ./run HEAD^ HEAD)

Rather than rely on the environment. But of course none of that is
documented at all, and is just convention and the whims of the few
people who bothered to run t/perf at all in the first place.

I do think it would be nice if environment variables took precedence
over the sourced GIT-BUILD-OPTIONS for "./run", but I suspect doing so
is a little tricky.

> So I think a more robust fix might look like only filling out those
> lines in the GIT-BUILD-OPTIONS template when they are non-empty, similar
> to the pre-4638e8806e behavior. Something like:

Yeah, that would fix the regression. But I kind of feel like your
initial command is already skirting the edges of what the original code
was meant to handle.

-Peff

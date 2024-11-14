Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CB225A8
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547653; cv=none; b=ICUSqGQYr+ATn4+ZQxcl6f5iURFza0+QeBrYgsekYPnSPxnL/xw62NeS8wlIKY40tlrrB4xS11azmpVSPFr8Q9jIuTBAPBenMaJ4KP528F+tHWhiV+E9KZtpfyMdX9XfAJ8mbDZFr+VunDaQ3Rs++qi61sosQ3kE9MVlgODE4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547653; c=relaxed/simple;
	bh=wZ6bHxN/Rz3DcV4/eqLxGMyPMp4l/70W7CDtIamh6xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzSdyR/gYooHIthT7OSaYZwprjTl9dzo2TczSVghmweuUpxO4OoZEaPIea82dC3DkgpLkDVKfKP/RFBkpQvHLAWF6T/DeE2o8h1G2/tL8D0/AlPn6b2GfWp8y8F6euO/+uQFOvxIARjMGONwjDApSvQKG63OSSdLms02SRLjCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f9mWq7Ci; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f9mWq7Ci"
Received: (qmail 26476 invoked by uid 109); 14 Nov 2024 01:27:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wZ6bHxN/Rz3DcV4/eqLxGMyPMp4l/70W7CDtIamh6xU=; b=f9mWq7CiLCaZA0eeGdlt0steIq9m/1g1SCC//8FpbLz4CujwnP+ZcvRA5yX/mD64LjwA+M+MqQl3mUGkUcobwfzL+2oYmaOVdjIUtVmyRQkPy3xDQfa9DlUumpCYhVNiu8b2vD9lekB0jHKtMtt0UqgRwikw8jb4OZyLmT30cOKoq2yIFZCxujDO0870iCqY939psLwoZtGNhf3iwKvslG2MePRj+Bl/M6GLFGkXyqNzoSK7LDMyQVmdYtJInbibebpTIIJNCDhlQyvQs2EqGvPPivJx0qwLrldO98wjjeOLU3sf6sGoxmxSK8DuKLwnV5CNAN/8NQNnLAd1bymqXw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Nov 2024 01:27:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20174 invoked by uid 111); 14 Nov 2024 01:27:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2024 20:27:33 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Nov 2024 20:27:29 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: check malloc debug LD_PRELOAD before using
Message-ID: <20241114012729.GA1148710@coredump.intra.peff.net>
References: <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home>
 <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
 <Zy-IYwjb_RO5NW-s@teonanacatl.net>
 <20241109190012.GA588841@coredump.intra.peff.net>
 <xmqq7c9aihvx.fsf@gitster.g>
 <20241111070134.GA675125@coredump.intra.peff.net>
 <87zfm3iggu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfm3iggu.fsf@iotcl.com>

On Wed, Nov 13, 2024 at 11:19:13AM +0100, Toon Claes wrote:

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index a278181a05..4fe757fe9a 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -593,9 +593,12 @@ then
> >  	}
> >  else
> >  	_USE_GLIBC_TUNABLES=
> > +	_USE_GLIBC_PRELOAD=
> >  	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> >  	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> > -	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> > +	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null &&
> > +	   stderr=$(LD_PRELOAD=$_USE_GLIBC_PRELOAD git version 2>&1 >/dev/null) &&
> 
> Can we assume some version of git is in the $PATH here? I see $PATH and
> $GIT_EXEC_PATH are only determined at line 1440 and further.

Hmm, good question. This is after the "you do not seem to have built
git" check, so I thought we were OK. But of course that one is using:

  "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"

So the check is probably running some system "git" and not the built
one. That mostly works out anyway since the real variable there is the
LD_PRELOAD, not the specific version of git. And that's why testing it
worked for me. But on a system without an existing git in the $PATH at
all, it would disable the preload, even though it would work fine.

So some possible fixes are:

  - use a more complete path, as the earlier check does

  - delay the malloc-debug checking until after we've set up the $PATH

  - use a different program. We care about the preload working, so:

      LD_PRELOAD=$_USE_GLIBC_PRELOAD ls

    would mostly work the same. Though I suppose if you want to get
    really crazy, it's possible that "ls" might not be linked in the
    same way as our built git (e.g., it could be statically linked
    against a different libc).

So I guess just moving it is probably the least-bad option.

> > +	   test -z "$stderr"
> >  	then
> >  		_USE_GLIBC_TUNABLES=YesPlease
> 
> Shall we include a warning in a else clause to inform the user the tests
> were started with malloc check, but libc_malloc_debug.so.0 was not found
> and they should either install it or run with TEST_NO_MALLOC_CHECK?

I'm not sure. It is optional, and many systems will happily run without
it. Just identifying glibc ones that happen not to have the debug
library installed seems weird when, say, Windows or FreeBSD similarly
run without it. And we'd be forcing the user to set TEST_NO_MALLOC_CHECK
unless they want to be spammed with the warning from every single test
script that is run.

At that point we should almost just revert my patch and let it fail when
the preload doesn't work (the only advantage is that we could produce a
more useful message).

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D231448F2
	for <git@vger.kernel.org>; Sat, 19 Apr 2025 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745034852; cv=none; b=MGIwAV5SDPYKWgSE5HsVbReoosvkIzRubGrKmaruIQdBRVxmoenjKdYxrjRmuU5ku7w1F0d+YawWQaT7nvKuN9mPL9+HMra9Nw35ABjwLWhXy6Dh21uU2rZVKBzZcEFbXfErNiWbTFV76Uds+8z5ZgaVA6m49+bvuf32OqARg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745034852; c=relaxed/simple;
	bh=7V4+PDLBUZk+CB3z7KSZCgcUoTOkt/zpURS6SKURD2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhD33PG978snW/rjs8p55ajgB6s3pMMy0yRJntl3wQRDzdoZRmLVz+Xm3/F7rdnod9X5wq+LinxeC4ryPgCU0A8zhBi9dXNnTHBJ+IA5d6vjL8OFK5XMI4l7EGeaS3OBk/Led+IL6V57XZPf6BJeYvRbhWqD2nL3t1rsuRTGh4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ciBEijLJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ciBEijLJ"
Received: (qmail 21562 invoked by uid 109); 19 Apr 2025 03:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7V4+PDLBUZk+CB3z7KSZCgcUoTOkt/zpURS6SKURD2U=; b=ciBEijLJI5LkJ1vVs1mX2pXW/VRkzYpfYi6bpN2OfseiSGFYtG9kJO90md8gtwUFvVkm5ZcJb/pqUejQiVsVTM1neIrdPFC2gyFLAMSoVpxcvs1am8vZRxT9aNryT1oO0Rhd5cbOkNfq62EFbv3q5U2TW0bTVoOhvjdHn755KaZEzsRvb4PKcpL1YF9Ltirl8U/G6aRzHLx8Bzb8nACByljzomUCMrOwyFn1FlN95WwO1kHuIF5Zd+zvi5A9MkNKNhXGvdReKJMZuLwJqg4xElkWISD+6FZVBprGrdpmlVAXi3uILRH/GPD96zBaw6IqsGrK8PU8bG5R/FgFCUD0wQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Apr 2025 03:54:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12025 invoked by uid 111); 19 Apr 2025 03:54:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Apr 2025 23:54:12 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Apr 2025 23:54:07 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] perf: do allow `GIT_PERF_*` to be overridden again
Message-ID: <20250419035407.GA93039@coredump.intra.peff.net>
References: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>

On Fri, Apr 04, 2025 at 10:56:07AM +0000, Johannes Schindelin via GitGitGadget wrote:

> However, in 4638e8806e3a (Makefile: use common template for
> GIT-BUILD-OPTIONS, 2024-12-06), a subtle change of behavior was
> introduced: Whereas before, a couple of build-time options (the
> `GIT_PERF_*` ones included) were written to `GIT-BUILD-OPTIONS` only
> when their values were non-empty. With this commit, they are also
> written when they are empty.

It doesn't look like Junio picked this up, so I wanted to chime in that
this regression bit me today, too (specifically for GIT_PERF_LARGE_REPO,
but also another variable which I'll detail in a moment).

This is also the same issue that hit the interop suite discussed in:

  https://lore.kernel.org/git/Z8IX2bMJe+V80idE@nand.local/

(there I was a bit dismissive of it, because I think GIT_*_MAKE_OPTS
would usually be set at build time, but for these other variables,
they're almost always going to come from the environment).

> Let's work around the original issue, i.e. let `GIT_PERF_*` environment
> variables override what is recorded in `GIT-BUILD-OPTIONS`.

I like this direction. It not only fixes the regression, but makes
things generally behave more as I'd expect them to.

I think it doesn't quite fix everything, though. I noticed that
GIT_PERF_REPEAT_COUNT no longer correctly defaults to "3" when using the
"run" script. And there are two problems here:

  1. The "run" script itself sources GIT-BUILD-OPTIONS, so it would need
     similar treatment.

  2. But even if we did, that, in my case I am not setting
     PERF_REPEAT_COUNT at all. So there is no local env variable that
     we'd use to take precedence. The problem is in the way the "run"
     script assigns defaults. If it sees an environment variable set
     (whether actually from the environment or from GIT-BUILD-OPTIONS)
     it accepts it as-is, rather than installing its fallback. So it
     will never use its default of "3", and instead retain the blank
     string (which, by a stroke of luck, does still cause it to run each
     trial at least once).

So I think we either need to rewrite the "run" script's fallback code,
or teach the GIT-BUILD-OPTIONS writer to avoid mentioning unset
variables (which is the real source of the problem in 4638e8806e3a).

So...

> Note that this is just the tip of the iceberg, there are a couple of
> `GIT_TEST_*` options that may want a similar fix in `test-lib.sh`. Due
> to time constraints on my side, this here patch focuses exclusively on
> the `GIT_PERF_*` settings.

...yes, this is definitely the tip of the iceberg. I don't mind doing
this patch as an incremental step forward (and because it is an
improvement in behavior even if 4638e8806e3a were reverted). But the
issue is far from solved overall.

> +# GIT-BUILD-OPTIONS, sourced by test-lib.sh, overwrites the `GIT_PERF_*`
> +# values that are set by the user (if any). Let's stash them away as
> +# `eval`-able assignments.
> +git_perf_settings="$(env |
> +	sed -n "/^GIT_PERF_/{
> +		# escape all single-quotes in the value
> +		s/'/'\\\\''/g
> +		# turn this into an eval-able assignment
> +		s/^\\([^=]*=\\)\\(.*\\)/\\1'\\2'/p
> +	}")"

The implementation here looks correct to me, including the quoting. The
number of backslashes is a bit vomit-inducing, but I think unavoidable
(we could put the sed command into single-quotes, but then you'd have to
escape out of it to show the single-quotes you do need to mention).

-Peff

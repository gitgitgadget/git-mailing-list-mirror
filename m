Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008D26A090
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556017; cv=none; b=oTW1kHtywBF/fYSyWk4Rgu2hncTPThyQkWyzfejHb/qe0e4WsPo1T3KxHxdeXj7F/mF3f24AQmIq2V/rlpmBXCUMinRrmxxBBXOQCJmO4BBeIE74msSIbg+HbIPpbAGYCqOOVmiPJmxZabkI4yFaPEBiaBHpsi39WhN1cCgDqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556017; c=relaxed/simple;
	bh=wNfbJjgz5nHgL6f4id5Ow0m7lCimRGdP0AaJiQgiLEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu/YaXJe4va+Q1VvkP/x4GUkVSLSoEjgzn6mz76J1Sz0QR0ydGemf0CuhGPHqoyg9/a3EpJZalDfNQ9awZm/HrFmlJFm5xZqm4yJ3ZYQuQhAaynHkLwaDKYKVUTLehgrUeOcExzCenY2674eAU2pn2vW+B9wb+QdPzIpefLlH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IMqid26m; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IMqid26m"
Received: (qmail 5747 invoked by uid 109); 26 Feb 2025 07:46:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wNfbJjgz5nHgL6f4id5Ow0m7lCimRGdP0AaJiQgiLEA=; b=IMqid26msTpP/sqKNt284xSeMSgf8U9DO6I+XtNjbnXlSDVHRRcPLXYMITISy6p37ggt2fTUKlwTQSMQnXeFHXVmw3id/FXrOw/NpDJNqGOkRh+dsowdKPjU6kh5PTjHcB6LacdedJIcU+Ok/ZhaLfS6+DVmwYbfuAYWnJ8+GvUHjV2KlfUCjBm+TwPW/34qPC4v7ymuV1TSAitiq/1Zh7l9jws/WCypr2J3PCWFla9Ce3EuqepnVGdQmoEku7pHsQ54DVRWK367DJfl3MoXcxQCUXKjTlsHGQYb3QC3ZQlhvUQ1g8/EEBtMAV2suWW3b/C1m+UJpTMHM80p7X4NVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Feb 2025 07:46:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21085 invoked by uid 111); 26 Feb 2025 07:46:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2025 02:46:53 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Feb 2025 02:46:53 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <20250226074653.GA27455@coredump.intra.peff.net>
References: <xmqqo6ypiz9w.fsf@gitster.g>
 <Z76qYgV7B2eUJHiP@pks.im>
 <Z77EJRJwPDGUglLk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z77EJRJwPDGUglLk@pks.im>

On Wed, Feb 26, 2025 at 08:35:01AM +0100, Patrick Steinhardt wrote:

> > Hm, interesting. I didn't notice those issues in our CI. Thanks for
> > diving into it, I'll figure out what has happened here.
> 
> Okay, the issue was in 163a3e97ac1 (meson: simplify use of the
> common-main library, 2025-01-30). In that commit we stopped using the
> common-main dependency for a couple of binaries, including
> git-remote-https and others. What I didn't realize though is that this
> also made us not use the linker arguments anymore, but those are
> required on Windows when linking an executable.

Ah, thanks, I was just closing in on that commit, too, by reverting
backwards from the tip of the series

There's one other oddity I found that you might be interested in. After
each revert doing "meson test ..." mostly worked. But when I reverted
bf4a16b84a (meson: drop separate version library, 2025-01-30), the build
then fails with:

  $ GIT_TRACE_PACKET=1 meson test -C build t0210-* --interactive --test-args=-vi
  ...
  [305/571] Linking static target libgit.a
  FAILED: libgit.a
  "gcc-ar" "csrDT" libgit.a @libgit.a.rsp
  C:/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/12.2.0/../../../../x86_64-w64-mingw32/bin/ar.exe: libgit.a: No such file or directory

I'd imagine that if I did a complete "rm -rf build && meson setup build"
it would work. But it's pretty lousy to have to do that preemptively
during a bisection.

I didn't dig into the actual source of the problem in that commit, so I
don't know if there's a way to write it that is happy working with both
the before and after states.

-Peff

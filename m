Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A461F7917
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118332; cv=none; b=jNTpt0mjWEXJmf3kGOdwk0YGAIWT+3Q0b+cU4I9fGyeLo0P5xO/GNa4+ZVBlSD9yFEDzklza2ryE8ku2xgsdihOxsdoDxQ510lB7jakYd2v7aaaxVC+EX3LiHwzlgDuAbuwxRdJxF2IC7Z2WelOC7AbsyReUAzi3T5PQEZNbZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118332; c=relaxed/simple;
	bh=HfAQydvR0inIR4HC9MBXmcm93RVEOQivMuUbsCDXkU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNRsJnMO0aBbkT4WK7tKqDR+QcPmEQJ8acK5IrKkH5sZRqcAimLHJpv7NGrPixYPApdwJVJ8WgFuB2vzSHoE515WEueRrEBTGdYVVXwXPo65W4dVEtfJYNcxxM3UDXCUp1I1zEJoCnYnkur8xpW2uztD+cKxCLU6XjkFMnjX6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dzFXqXlY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dzFXqXlY"
Received: (qmail 21898 invoked by uid 109); 17 Jan 2025 12:52:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HfAQydvR0inIR4HC9MBXmcm93RVEOQivMuUbsCDXkU4=; b=dzFXqXlYr9zdkt9raHFWYcSUlJiF4pO9a3gouJ+vVBUZPz2zx9okB+XwTa9lUnfhSIKQRigtupDLQ0VZ09F1i3vYKx5bHL8/nIhIM+y19jvfkJUap37Em9E55jlWJLJG37iMqeFIvShpigbKxtmO3jMVWUyJWllr0SYfnUgoCK/k2KlKGKp4yKUTnpG1xckYyNS8xdaoFJZ2SrRlw+HB8Aai58HOkMVL/wvJ4EQ4TVGNLb2C8p5Yn6/vpXpq6ALWXjpyZTg4AFd+iJfKqx5HLd/uTTprgnYEADZkJFg7iUkBwIzbJ4KgR1KKtLRvVc30NR6QuI+m5rwQP2anaFwHxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 12:52:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8032 invoked by uid 111); 17 Jan 2025 12:52:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 07:52:07 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 07:52:07 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <20250117125207.GB2356599@coredump.intra.peff.net>
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com>
 <20250117121121.GA2356599@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117121121.GA2356599@coredump.intra.peff.net>

On Fri, Jan 17, 2025 at 07:11:21AM -0500, Jeff King wrote:

> Which certainly seems sketchy, though it is kind of interesting that it
> has never been a problem before (and the code has been this way for
> decades). At any rate, the fix is probably this (and we'd want the same
> in index-pack, too, I'd think):

Assuming that helps, here's a series which does that fix plus some
associated cleanups.

I'm curious if it's enough. After we write to this unaligned buffer,
naturally the next thing we'll do is read from it, and the reading
routines will do the same cast (see unpack_all() in unpack-objects).
But maybe your platform allows unaligned reads but not writes? Probably
I am being too optimistic. :)

  [1/3]: packfile: factor out --pack_header argument parsing
  [2/3]: parse_pack_header_option(): avoid unaligned memory writes
  [3/3]: index-pack, unpack-objects: use skip_prefix to avoid magic number

 builtin/index-pack.c     | 18 +++++-------------
 builtin/unpack-objects.c | 18 +++++-------------
 packfile.c               | 22 ++++++++++++++++++++++
 packfile.h               |  6 ++++++
 4 files changed, 38 insertions(+), 26 deletions(-)

-Peff

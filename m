Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4A40DFA0
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 04:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775621839; cv=none; b=GI15lu/5nJr6WksvsiX+rosmsFQ0rLO7fB/3wFGsvSAZGNqGrltwbuei/ENxuohsYwP0X8Fh5aCdO009BIl4AMi0KR9IKwJlbEmJZICqqLYhtjgg1nU4TfF1npNzDs9yJ1KHfGKNYfzZrJXb8Qz31hTn/Nw6ZagkZZR2CNTP7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775621839; c=relaxed/simple;
	bh=rCyyJemzYm6k3edVRlyxhhfj0KFYf6qU2w0uB0Gwwf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUOsKnAUdjvKBDW95ZCizGIX5Ko6JTGq0Pn/yQHUyj4du/HToCEtaTHzp7R8B7notcRskMu4dqYcwmhZHTYmlCeqUydwqLuaJI3jHrDbZqdPxMhwFSHA3HjXSOduy7BjW3EdJ6LZVV7OVV25hm75xqJsftmReP6+9PLmSAInqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fXwQJQYA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fXwQJQYA"
Received: (qmail 279233 invoked by uid 106); 8 Apr 2026 04:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rCyyJemzYm6k3edVRlyxhhfj0KFYf6qU2w0uB0Gwwf0=; b=fXwQJQYA1h5isbHNi9/4Gx/Ovrcms9CiefW3lVJyBgqSNVUn6E/lgCq1EdWzCP2/JZJCUdC7jPyN2ecNvWtpqrrdW5no+q8SD+p9XBqRwhjRYEV4M4oY9ERAOdCTmDU9Ux7U9tuFN7C20VwoGeccW3+0ZF3/GqtHa55UB4iin+r1NhTDuygbfgKr74jffc62SGT2QQ4oKHnPP7zg1VxFhycB7lNCavdkQaNmDdiricPKc384jVxOqVYuzI3l/im7FDOLSqGMh5B+koNGuLOkHTKq2mg3vCDJf4yzOHb4FKfBPuvLpRa8ZYajFtGxWolq3oOaWIe4SjvCGeI+dBBT7g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 04:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 456867 invoked by uid 111); 8 Apr 2026 04:17:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 00:17:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 00:17:16 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260408041716.GA1324339@coredump.intra.peff.net>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>

On Tue, Apr 07, 2026 at 07:29:50PM -0400, rsbecker@nexbridge.com wrote:

> I can getting numerous issues in t5310, t5326, t2527 relating to the
> following use of --git-dir:
> 
> In t5310:
> fatal: not a git repository: 'clone.git'
> not ok 55 - fetch (full bitmap)
> #
> #                       git --git-dir=clone.git fetch origin second:second
> &&
> #                       git rev-parse HEAD >expect &&
> #                       git --git-dir=clone.git rev-parse HEAD >actual &&
> #                       test_cmp expect actual
> #

This test hasn't changed recently. The clone.git directory should have
been created by an earlier test. Can you try running with "-i" and make
sure that this is the first failing test, and we didn't fail earlier?

Especially because...

> In t5326 and t5327:
> fatal: writev error: Invalid function argument
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output
> not ok 24 - clone from bitmapped repository
> #
> #                       rm -fr clone.git &&
> #                       git clone --no-local --bare . clone.git &&
> #                       git rev-parse HEAD >expect &&
> #                       git --git-dir=clone.git rev-parse HEAD >actual &&
> #                       test_cmp expect actual
> #

...it looks less like --git-dir is a problem here, and more like the
introduction of writev() is. It is now used in sideband_send(), so it
seems plausible that a similar failure might have broken the git-clone
operation that the other test was using to create clone.git.

As for why writev() is failing, I don't know. If it were totally broken
on your system I'd expect almost everything to be failing. But maybe try
building with "make NO_WRITEV=Nope" and see if that makes the problems
go away? The compat implementation just does a series of write() calls,
which is what send_sideband() was doing before.

-Peff

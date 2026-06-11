Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CC388E6B
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160832; cv=none; b=aJD+M8WcpEn+XJG6NV75OB2lokTgZ0Y4ofK3IBuzuTYI6Ykc3RHThhjq8LCPi/v0ZN8bgWXn6oWnQCnUJfLMOXDLcGYRxWALRvF0LSSFHAWU0YftmGb9ITkmqruiFbPALCCgJ24TuywJmZEjVWjFVTTMcXllLlnpMWNGzUbD5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160832; c=relaxed/simple;
	bh=t8NklF39/QhFfREvDFK9CF+vXK+3FbvEunOuIelPrpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJOvNlCfeIRqUfRmU+LQXw3UBGlyUgf1PjQTxKEty7ljA6P/kqeGQKrG9nJMji/WL/mAqHxqVExX8bcVGuqKeP1alYI2pmK2HE7aqDD7lx9nJH3OgWq6Gp1zF07Woj3fA57Ae9IFvpO8094ObaEVMOjzkhFdNg2WgjB4x7aec0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HXP/r4g6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HXP/r4g6"
Received: (qmail 106317 invoked by uid 106); 11 Jun 2026 06:53:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=t8NklF39/QhFfREvDFK9CF+vXK+3FbvEunOuIelPrpU=; b=HXP/r4g65M5kWZqabw9/hd7wItH5kvoj13faxO433PdZ031mGIMOB+52SeWkcyjAe9oHXJnHrafCGPLtR1FuafyqWooFQ5lWlj8yzb9JfokITQOi6uNOphdVAwVzbERyWG9mWlPIIy9S4esOHW5dqbyfpUyJVn1/Vrg3QYk3fM1ScccsnLi8nS2jCL4Akji7M1P1Q1MuuvzpbafABFt8blrpbaJPKc6Kpr7Vu8u9iQpUA3IzZhH85JruaBImgxPvGZOMHT9DDnGv8Ud/2scehpR1aZ1r7sSMr0EwAgYPVPG+ZSKe2hEADj+fC8SBsQXV5asdpRI8LMvS/VgkkenGfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:53:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 314137 invoked by uid 111); 11 Jun 2026 06:53:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:53:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:53:46 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/9] refs: stop using `chdir_notify_reparent()`
Message-ID: <20260611065346.GD2191159@coredump.intra.peff.net>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>

On Wed, Jun 10, 2026 at 04:57:06PM +0200, Patrick Steinhardt wrote:

> this patch series is a follow-up of the discussion at [1]. It converts
> the reference backends to always use absolute paths internally, which
> then allows us to drop the calls to `chdir_notify_reparent()`.

We added chdir-notify to suport set_work_tree(). Commit 8500e0de3f
(set_work_tree: use chdir_notify, 2018-03-30) mentions an optimization
from 044bbbcb63 (Make git_dir a path relative to work_tree in
setup_work_tree(), 2008-06-19). That commit demonstrates some measurable
speedup from using relative versus absolute paths.

If we move to a world of all absolute paths where chdir-notify is not
necessary, will we lose that optimization?

I'm not sure how much it matters in practice these days, or if those
timings could be repeated. And they weren't all _that_ big to start
with. I guess it may depend on how deep your repo is within your
filesystem, too.

-Peff

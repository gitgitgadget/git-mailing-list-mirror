Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2A33F8A1
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988840; cv=none; b=trHb25DiRP4NBw6iOtvmyy0qSL7LT4pKa8V4DIu8Ca7ODZaSnmcVlp0wRy5b91LRj53Z3xG57/pQVXh+G4JGFic1J/RyZKVvdDF/1XsxfRIia/jAmauZKN8PJ6euOpjNJvEaqasJt7hiu3wKc8RSr3Yfvrp4S72YcP7g7uMYj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988840; c=relaxed/simple;
	bh=nq/jVLrWqO3s9z1FYJuvKARTb8rrs4D7XKvif+3iV1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGrr5+z+oUR88RUSwdXDr9/t+TQAffp7IHxK7bvisZrhAh1aI51b2x/kMM6k8vqtiiofVON7TJYCaGfWcT2JgPc4+juKucTm5Ikso0TXAdNBFihPmAN4nj5n22seLiM1zlECUGYDQ/ynYRm/ftjNXz6Eof4ACidIYq8xJPYvUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=brN7ctxI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="brN7ctxI"
Received: (qmail 73778 invoked by uid 106); 17 Aug 2026 17:47:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nq/jVLrWqO3s9z1FYJuvKARTb8rrs4D7XKvif+3iV1M=; b=brN7ctxIzic1prqQ5cRc+yWMOhK+oeUI8VbAdSPXMP/A3TzU5CnV2WGD3lzZtYtvTBRvvC96WU1z+JpFF3yj808QzC4GkoOSs9Asmdi3R2e+/5KKPU42r/lt8t18uCWJtK6ASbQDxVc1gVDojmOjBD5Zg10ISPgtCVfhjEVH+wO72lwQkCK7J7GfZ2m3FVaswUKHhB61DvSyLvGajhLU4qQ7qoE8YWMSgwfq9occVdSjFocEMFJUsboTULNyqcbXZx/ei3UXNlO1VB/MOHNAm7HfNqw4BvGDdOqYFdqV55//5MDOd7k0+/qJb1miT4xflWifAU/N1Te1BQj8M6BfFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2026 17:47:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21357 invoked by uid 111); 17 Aug 2026 17:47:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2026 13:47:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Aug 2026 13:47:16 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <20260817174716.GA732563@coredump.intra.peff.net>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814171724.GB2563235@coredump.intra.peff.net>
 <aoKeeQMps50rjhWi@pks.im>
 <aoK1ZYfqh5PnNin6@pks.im>
 <20260817073621.GC690018@coredump.intra.peff.net>
 <aoLXioIecFZdGe_O@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoLXioIecFZdGe_O@pks.im>

On Mon, Aug 17, 2026 at 11:42:34AM +0200, Patrick Steinhardt wrote:

> > I think we have repo_ignore_case() now, since e6a79c9eb8 (config: use
> > repo_ignore_case() to access core.ignorecase, 2026-06-19). That's in
> > 'master', so it might be worth building on that instead. And then if
> > there's any cache invalidation to do, it would eventually happen there.
> 
> We can't use that one though, as it uses `repo_config_values()`, and
> that function only works with `the_repository`. So that'd break with
> submodule repositories.

Oh, wow. I looked at the function and saw that it took a repository
arguments. But then repo_config_values() does a BUG() when you pass in
anything but the_repository. That's...surprising. And gross.

But yeah, I agree it's not yet ready for your use here.

-Peff

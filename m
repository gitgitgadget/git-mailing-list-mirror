Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377723EAAD
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770869235; cv=none; b=SeUm4xh6zLplOdBnP8TfyQlpfSjZBy+h+pWRdAVRFYMOG+CWNa2Du1DrSyeijXsLIr0Rg4KbDNaT2a7i71LRzjgBekRTeYjA4xroUB0AERUjLwq6gaU7AZTTGENkvArZyoyIhGXCsJ3WDGxv+DryjJ/EDKux816HKITnUp+iuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770869235; c=relaxed/simple;
	bh=HKoLz7tf228ZOtwGtWfwIL+Fzp4USBpJnQzmKdAkSN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1yHXGhn1hvWHifLR8vw6dBr1vyBtw/rvvA0t+zsPvBCqn9CR1R2uReZ16QS0nE/IWplFwm5AaZp1GTp6dAzpNwHHSkrybxBL/RpH+HJovDJIzf5xJFzTY6/1av4gB8Ap3WwaI5vp9H623wH9Zw5EPl4qWyWcSOHu0/2GccdUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eVWh8cRh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eVWh8cRh"
Received: (qmail 20035 invoked by uid 109); 12 Feb 2026 04:07:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HKoLz7tf228ZOtwGtWfwIL+Fzp4USBpJnQzmKdAkSN0=; b=eVWh8cRhSBinRuZgmEk8M2rygfaA8yyZczWwjtXM9VCDC2rju6Zo4TZvaE4ds6rMu+derfRFwbKUls/MJjmB7idRhLLi+qlF68cz80POA22OxY0+31kvAGiRTh6/v8FYcbslbSQb3kx0hNRvv7QhQEM0uXpFNzlkVni9FwZ5Zz4N/Rdsw/qE8lH5rM8sFE7oUm1DOtj+DUJ5f0vLKXZONA8K8x7cAXPE2Q7RrW6OcS+RrBEi1chiojgo4SzkzkSe+6hwtr2ePr7Vl3rgGMM3djjszvI8623wv3be88d58zdaOgv6qaQp4LdN9MJISIycx+UioHfkKIs8XDu0cQC0tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Feb 2026 04:07:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 40090 invoked by uid 111); 12 Feb 2026 04:07:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Feb 2026 23:07:12 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Feb 2026 23:07:08 -0500
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: cat-file: dies with --batch if reflog entry is out of bounds
Message-ID: <20260212040708.GA1894049@coredump.intra.peff.net>
References: <2b07489b-1689-4ecd-9cda-012540fe56e2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b07489b-1689-4ecd-9cda-012540fe56e2@app.fastmail.com>

On Thu, Feb 12, 2026 at 12:13:36AM +0100, Kristoffer Haugsbakk wrote:

>     $ git cat-file --batch
>     HEAD@{7}
>     <commit>
>     branch@{20}
>     fatal: log for 'branch' only has 5 entries
>     [died]
> 
> This is a known limitation.

I expect there are others. E.g.:

  $ git checkout --detach
  $ echo @{upstream} | git cat-file --batch
  fatal: HEAD does not point to a branch

So I'd guess that there is probably a lot more work to be done on top of
393bbb21 to make GET_OID_GENTLY work consistently. But doing that will
incrementally take us in a good direction (for cat-file and for other
callers).

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AC3A16AE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979126; cv=none; b=nG4Db/PkD9qmYd12M3jtttoxX7p66Qx1DRfER+F7tBUdePcWqyn9/gpiUjLLjba7MHSJI63lztYQNh8ODyt7xKZgcwVAhHrdrLDXIwbVNfSc8EOAV1PcAG+23xTsuoVdoREuykKkQE1qq0Z6RJw18ZCXw7Hn2MfSd2VX6DiMebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979126; c=relaxed/simple;
	bh=ue7liDkvJnIabiI3vAQGuR7wmzjmvw8FVyg59m8o/Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl7TltchPtNuQJ9lDmZ3XSOz7PodpU3lpiSuxgN9woAT7rI8/CKafoNd5bVmfXFLLZqDM+oy3XtX80K5ak9jucFTV1cUUbbBpn4izg0KuswzKpCQhdsFZks6PgfxIS61yryvb3fYWcQwuOECyG8bdKbQA4B3neEmpMu4w+VckzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DLXxsyGU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DLXxsyGU"
Received: (qmail 16572 invoked by uid 106); 2 Oct 2026 22:11:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ue7liDkvJnIabiI3vAQGuR7wmzjmvw8FVyg59m8o/Yw=; b=DLXxsyGUEUzRlEViNUPDz6OF21V7cePWqPbI29fQbC7As/1xuajQ5Upy2Eqh8KJvfyZDfWsKEHoHN4652Z9GyN2f4o91JKi2xHgGf1Pqeq/2N2cbHxlEPR/dRQnukiFs2O4IiWGOZEQyrazAskGpylamOMiX7/7ANLO+EiSI8kjGHtAtLMf2Zz8o4/cPsSZ2qxZotBbfikrtBvT35jkGnjPuTbcG+NQEcnQPQXhIlpmL/+GofH9ksdZTvxnXpK0Q5ZG+0YedsrbQjgHHWR8czxwj5zCF6TLDcyZ/bJ0ERu8rMF/SkTEVvvTals3fJ4ApYW1DaQx1U6b3zVwxmIzBig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 22:11:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48512 invoked by uid 111); 2 Oct 2026 22:11:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 18:11:57 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 18:11:54 -0400
From: Jeff King <peff@peff.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-bisect(1) next after finding the commit
Message-ID: <20261002221154.GA833115@coredump.intra.peff.net>
References: <asAbOSQ4BkuCTPY5@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asAbOSQ4BkuCTPY5@debian>

On Fri, Oct 02, 2026 at 11:49:01PM +0200, Alejandro Colomar wrote:

> Is there a plumbing command for retrieving the bisected commit after
> a git-bisect(1) session has successfully found it (and of course before
> resetting the session)?
> 
> I expected `git bisect next` would bring me to it, and then I'd rev-list
> HEAD -1, but it doesn't bring me to it.

I'm not 100% sure, but I think "git show bisect/bad" should work.

As the bisection progresses, we advance a single refs/bisect/bad from
the bottom of the range (the top is multiple refs/bisect/good-* refs).
So at the end, it should point to the blamed commit.

-Peff

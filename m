Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB051DF739
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963123; cv=none; b=QtA4RJAYhaYvpXrl4uEsdPaBJViUVeVDv0+j7jNw+UcpAWV0WmQDcTVvwjxiZ1C9o3MseVI97pFrcBEscuK9DK9i+i8/hracePnovtX4aRh18WiT7ebUQw7cwIxS3JnZOFK81BrWRDaaX/bkWJvFqbXNha4oN8EN8pGGSjP89NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963123; c=relaxed/simple;
	bh=idSD+totlZM6nzplOwB8qIPbutTtGslrw1mXsBoGIdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3jdCwiOi3uKdQlPkF0dUuszgFsrCNEfnWqtShYKillHLt/gWGaA4pfo6luBLT8vxjhx6xF3szIQV6nQ62JXiOLngdGjxoko/hYD4wB52vfoMMqsvKeJAYO2A3ffmiNDSCF469H8PZrgvVQpBsshIoQR9t8fj3GXiyaL4ArQqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d61sETMF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d61sETMF"
Received: (qmail 10593 invoked by uid 109); 26 Jun 2025 18:38:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=idSD+totlZM6nzplOwB8qIPbutTtGslrw1mXsBoGIdg=; b=d61sETMFvFsNeIAxkK76HRKRGJWDMk0JBS+nKqSJx9m3ye7BriWeNUzFUkH4fNcNS7tLBQUJwEbjZEBsmLYCgIR7gd3HVNkxCG+mYQt0OqNIrL03Iiw7aF3m6e7kSR7wxYBQOu2ljeToKvCjBEBjulzqu5a21Xscpb+mOc8zodsenk7UqEJQLLrFOCWT4PoIUcfCaZSloV8vCqxlZzETwPhgE72mD5S77Wi/JMJIorrktybY3z9y2hr6YI/e6XkDS6oknHIYCvbn62X0QR7Y+rfbr/bCju5Rvn9yUWmGdQxrykEKTJ0s/e5OlLy/wHA75WPbKUAZlWXikYYCVcSZJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jun 2025 18:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9072 invoked by uid 111); 26 Jun 2025 18:38:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jun 2025 14:38:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Jun 2025 14:38:33 -0400
From: Jeff King <peff@peff.net>
To: Brendan McDonnell <bmcdonnell.emb@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: How to show "bisect" refs in "git log"?
Message-ID: <20250626183833.GA17172@coredump.intra.peff.net>
References: <CA+MGQRBjx2XfhFo6Bs+X_WzRq9kB-ucZtTuw_kAfuZCVKGVvsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+MGQRBjx2XfhFo6Bs+X_WzRq9kB-ucZtTuw_kAfuZCVKGVvsw@mail.gmail.com>

On Thu, Jun 26, 2025 at 01:58:11PM -0400, Brendan McDonnell wrote:

> I use this command
>   git log --all --graph --decorate --pretty=oneline --abbrev-commit
> frequently to visualize a repo's commit history.
> 
> It used to include "bisect" references in the output, until ~a couple
> years ago IIRC. Is there a way I can modify this command so that it
> includes them again, without excluding any references that it already
> includes? (Appending "--decorate-refs=refs/*" includes the bisect
> refs, but excludes some others that are there without it.)
> 
> Is this behavior change a bug, or intentional?
>  - If intentional, why? And is it documented anywhere?
>  - If it's a bug, should I report it somewhere (else)?

This is due to 92156291ca (log: add default decoration filter,
2022-08-05). That commit doesn't mention bisect refs, but there's some
discussion in this sub-thread:

  https://lore.kernel.org/git/kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com/

There are some possible directions there for adding them to the default
set in a cleaner way. In the meantime, doing:

  git config log.initialDecorationSet all

will restore the old behavior.

-Peff

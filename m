Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149482F39C2
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669837; cv=none; b=s6nZPBud9uz6VCoaDV+6t2N1m/jYIvXmfwJCfgkw/i70OJHF9wZijBaV5GC+kSX/khi9R42rru98yg6KRAbe9jighlsfzEHZujximFqN9gJX+2WkGvBs3O7MdKcaBhYeesynlSf0oCBZN+SBUmdgn8tReTdUcb5RA/OBdMqgxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669837; c=relaxed/simple;
	bh=scrxe4tnapoo2xrsw4G/9EWZz8GCI0yjWFlGZXJ9MeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb0TinSS8iaRzWXlX8X8b+ZH3FDSqxzwCwqTSvOrsC+PfY4a52vtQoBKiSGZf9xcMAM8SFX/JEOO5CWEfhnQO2tsful5rpBOc4uxHFKZqqohtsLX1EcQe/m/9Hlg2jugEKhlZiqN+msvmoLEUPPP70Oj5tqvmyrdifBIR+aClds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eguqEiP8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eguqEiP8"
Received: (qmail 283994 invoked by uid 106); 8 Apr 2026 17:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=scrxe4tnapoo2xrsw4G/9EWZz8GCI0yjWFlGZXJ9MeI=; b=eguqEiP8CQNmDp7iExGbdapyLJUO63SAmyMXhauGIgLDkb5VsJ20bDECClP7fUIIhCa2hBY0g9awFkl/eooRbSmcoesQC/uUWHT4JEdPUYSkhAM57MscIiAvVc9wU73AlGHmZklIkY4jOIB/RqcbOoE65NG+fDwt3JCVsEUSrqohhaCRjDnwSbHPMlj8kr/rlFOKLRsF4xGBpZD1eXq2stW7pUOWt4cqbbY7pYKJKKka0YODoM9nKMSygJVcKWacLgm8j2kzu60VINTG39DTx5aSWX4XU49XLlLw59BKbhAQ1t055eer5KyUCu30QMx3/H4WStl5Qri+Sl+CeV2j8g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 17:37:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 466451 invoked by uid 111); 8 Apr 2026 17:37:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 13:37:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 13:37:14 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260408173714.GA2850002@coredump.intra.peff.net>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
 <20260408041716.GA1324339@coredump.intra.peff.net>
 <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>

On Wed, Apr 08, 2026 at 10:54:00AM -0400, rsbecker@nexbridge.com wrote:

> First fail is as follows in subtest 25:
> 
> expecting success of 5310.25 'clone from bitmapped repository':
>                 rm -fr clone.git &&
>                 git clone --no-local --bare . clone.git &&
>                 git rev-parse HEAD >expect &&
>                 git --git-dir=clone.git rev-parse HEAD >actual &&
>                 test_cmp expect actual
> 
> Cloning into bare repository 'clone.git'...
> remote: Enumerating objects: 629, done.
> fatal: writev error: Invalid function argument
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output
> not ok 25 - clone from bitmapped repository

OK, good. Well, not good, but at least absolves --git-dir, and we know
the problem is just writev() everywhere.

> I think the invalid function argument maybe an ioctl or socketioctl
> not supported for the file type.

Yeah, this is weird. We are just calling writev() here, and not trying
to do anything exotic. I could believe that writev() isn't supported on
certain descriptor types or something, but this should just be a pipe.
But why does it consistently fail here, but not in every clone? Weird.

It might be interesting to use strace or a debugger (or just printf from
writev_or_die()) to see if there's something interesting about the
arguments here. But finding the root cause may not actually be that
helpful (or at least not worth the effort).

Does building with NO_WRITEV make the problem go away?

-Peff

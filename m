Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050A1BFDF7
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632018; cv=none; b=uJd76alxRtHrGDU7MSi9/62cqdda52YWln3mg/OItgF2beyFhk7Tl/7ElCW+FzXqvssNRyfnwJwjyCqJk5irKCivTbM1Cm72urEsxZv+9MaXl0BQy99KD3Yc0KV4O9K+oRg4g4NRwIQLPUqAmZuXWroqBVUDJKIZfhwUpduMzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632018; c=relaxed/simple;
	bh=Ku1tVbkHmi2DgS1qNMdbwXyC07sUeqVlZOYd0RXgQpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTASAAwJ0ya5g01OUdTqTz+M5C+AlSs1JU7TfoiNtIS8Tir3huHRZsnCPRdYiwMFc+MHn03gJ3uU41cT0tcb3bETvLdLKeZlVeg1223w3+rUREG8CRAEZQbue2x1zo+dcxx2yFoMHL0AG+NIBZs5lU4NRdg6597MZNnI0Jwm0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e4+FqqfF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e4+FqqfF"
Received: (qmail 5083 invoked by uid 109); 11 Oct 2024 07:33:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ku1tVbkHmi2DgS1qNMdbwXyC07sUeqVlZOYd0RXgQpY=; b=e4+FqqfFHp4cT4agz6nr3yknLQDtm5gxGS2N2uQkm9rdNm5mhDCwv418qP1N+Jq0tnWpUcsC08+K+zj+AAzzFVfiUZTBTm3r4TdkIjGpm5WJ9ROx9UeJm94YhEzrqd4rrKX0kBlGaFEuUkmlj5qp8pNQYhCTLpPYiazxRKvhOWT0KbyLzk1w6Bg3kozTLowZ92RQkgFgox2f1KPZ9S7FKaRlQW/Y3L1j119hX68g1qffXxorqYuIKrf//oPEuzeHjgXqSxjBBqxSGuKXpP9GCDmWXMhhr+zn8gzcYALwHPQAUOuxqxxPWP9OV8GehR5bVmWjSgfy8STh6PTrnUMrew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 07:33:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17321 invoked by uid 111); 11 Oct 2024 07:33:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 03:33:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 03:33:26 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/13] git-curl-compat: remove check for curl 7.56.0
Message-ID: <20241011073326.GB18010@coredump.intra.peff.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241010235621.738239-10-sandals@crustytoothpaste.net>
 <ZwjKTJye2OmQClSW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwjKTJye2OmQClSW@pks.im>

On Fri, Oct 11, 2024 at 08:48:51AM +0200, Patrick Steinhardt wrote:

> I wonder whether we want to have something like the below patch to give
> people a better error message in case they have a version that is too
> old now.
> [...]
> +#if LIBCURL_VERSION_NUM < 0x073d00
> +# error "Your version of curl is too old. You need to have at least curl 7.61.0"
> +#endif

IIRC we ran into some interesting situations in the past where some
distros had older versions that had backported some features. So Git
would continue to compile, even though it was not technically the
version we said was needed. And a patch like the one above would break
those systems, even they'd otherwise be OK.

Now possibly that is a little bit insane and not something we should
worry about. I don't have good examples of what kinds of things got
backported, but searching the archive for LIBCURL_VERSION_NUM and
"backport" yielded this:

  https://lore.kernel.org/git/4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com/

and I seem to recall most of the discussion of this was around that
author and RHEL/EPEL.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD61925A0
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218830; cv=none; b=mK+FEKD+OjXNgvdpC4UOBcWo1iEQ3AORq176jlu0G5zYYDSnqoyi9b9kVQEPCe623sq6CgigKSw1T2mIKaYpIVrByLG4233ycjoL06m6KRjp0xcYVZTEoVsIveWBFWJWHNE7cjluTvehSEbjD0dre/3Rbda9ysRGiLeBzbpl+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218830; c=relaxed/simple;
	bh=+hsdnZMHoaYDR6oqIyJ2ldA3RNspdroc845p4U/VArc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUuvwsTuE10CdZ4YlgUOwBAq2eSlKDbDPlKvUMiqsj2b94K+9RIcXYsgiGrrOe1oBO24nf8ssvaYsxGrUybnLp8F2CsJHdzB9CqNLUK/y0pQHHXlgQXpOR68IDdZ7z6kqLnMMf12Pp255iqSdZCNV5HzIZODi59GHgm3fDOqlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NPvS4dx0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NPvS4dx0"
Received: (qmail 27008 invoked by uid 109); 7 Jan 2025 03:00:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+hsdnZMHoaYDR6oqIyJ2ldA3RNspdroc845p4U/VArc=; b=NPvS4dx0nQRhA2Ok56tQpm7dHQmlkLtzBQxMcTfqzWr0vjaOSiY7R5xrFL91WHihVHshOQsEpCvvKwroMkTcXBGxMb6lhhPoRp2iaLw3oU94qSvNtDYBz6vZk829Wmt93ZRKsZVhBrbo1T6tZxxgvx7amIufKVfDYWM/yTz7Ihs4L3/qNjeKJiW1zK783sgMylmziOJnieMwU0rrLDDz10yAoMvcoHN20cYQ0NsmgGnwWA1S/lNr4Y38PxbKFqbicA0UpI99NqXgLEox0Gsm4smQlBweB/m+Vyl7TotiB6BGq47my+neaj6BtBAwqSyUs3zQvE9bbSpR/UWqmebQRA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 03:00:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19382 invoked by uid 111); 7 Jan 2025 03:00:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2025 22:00:26 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Jan 2025 22:00:25 -0500
From: Jeff King <peff@peff.net>
To: Carlos Maiolino <cem@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: [Bug report] signingKey beying bypassed
Message-ID: <20250107030025.GA21698@coredump.intra.peff.net>
References: <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>
 <20241216113543.GD2201417@coredump.intra.peff.net>
 <cw6ggzhw4o5c5v5juh7sx2ubfaidnzugxx3ydgfvdlywqhndzf@6rfdfajvscif>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cw6ggzhw4o5c5v5juh7sx2ubfaidnzugxx3ydgfvdlywqhndzf@6rfdfajvscif>

On Mon, Jan 06, 2025 at 03:55:32PM +0100, Carlos Maiolino wrote:

> >      If git is passing the correct "-u" option to gpg, then the bug (or
> >      misconfiguration) may be in gpg.
> 
> I particularly think git is the 'problem' here. After I tried GIT_TRACE, I decided
> to run it without specifying the key on the CLI as I'd normally do, and it did
> work normally, and I think I what happens is git defaults for another key, if
> the specified key is not available.

Git doesn't know anything about available keys, though. We just call
"gpg" with the signing key configured in your .gitconfig and it tells us
whether it worked or not.

Are you saying that:

  GIT_TRACE=1 git tag -sm foo foo

shows git invoking gpg with the wrong key, but:

  GIT_TRACE=1 git -c user.signingkey=$RIGHT_KEY -sm foo foo

uses the right key? That implies something funny with the config
reading. Or are there cases where GIT_TRACE shows us passing the right
key to gpg, but the signature is made with the wrong key? Then that is
not something git can control, and is a problem with gpg.

Can you show us the exact commands you're running and their output?

> As I mentioned earlier, the key configured on my .gitconfig, is inside a
> smartcard.
> I just tested creating a tag, without the smartcard connected, and git
> ignored the signing key I passed, using another key.
> 
> I am not sure how right I am, so please correct me if I'm not, but I would
> expect git tag to fail, or at least give me a big warning if for any reason it
> could not sign the tag with the specified key.

I'd expect it to produce a warning, too, but we can only do so if gpg
tells us it failed. From Git's perspective, we are just passing along
the key string from user.signingkey to gpg. We don't know what it means,
and don't have any mechanism for using a different key.

-Peff

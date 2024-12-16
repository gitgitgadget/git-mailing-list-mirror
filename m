Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A3200B8C
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348946; cv=none; b=K4Y4o4EbBvJLDZfqPqxQKmY2FWlQRfN7OZPqgtLrNsem5xzR/2/aFQy12fvsZXeFDXc3cigVmTiPNsHNji/62EcUgSeMRebcBVu12jlNZFtSdo/5SiJrmBnY/BZFuA6AvB+94JwJq4SdvhIvPEaWP9CRpO0GT9U/44cEFQJEoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348946; c=relaxed/simple;
	bh=1RhfUTaSXZ1Y5VyGcNjSwAnLQEh1ZUz8YOfB80XBlEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqr9z653Cwk8O2bpqBwrgo2K0uLO3GZmFgVEKdiFajb471Dn+Wlv4Y/4Thi7Pv5lnFhXRl5UkxwerAR56PuQJtqPuNfKxf/YiRSB8H+kIV8aQ3bYnL8dDOSPLsBqoGUa9dT5Rn1VPBAEu37kucfWf0SpSbncKY4ckit5q0SBp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XvYipQMx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XvYipQMx"
Received: (qmail 26447 invoked by uid 109); 16 Dec 2024 11:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1RhfUTaSXZ1Y5VyGcNjSwAnLQEh1ZUz8YOfB80XBlEY=; b=XvYipQMxs2rqVU8hf8KYB59nUdMi6M7lcCmW0brWUUQdEX35tz9RUcgzG2AQ+e8rj9bQ3/qWB+Qq8JAwK6jX1Ad/TCsStpgnsX9DBVTbpBgvp1sjpvSRwalPIay5WoCKV3wBWj3Rdzd3lqoQG5HtOion9/IPcmoj8RkuvHppUeolhm2Qxf6J2QCSGSHYIUFfpg3oYhPnjqWuMkzpNTYj2w2woWBu80yA82G2rmN4WxVNqdjxJ3HJIisT172vhWqpP1ayFvLo4m6tTlKd+C8vUFUF5BSmAUrjR1qzwfWHjtTTYRZJZZCGu+1KcuNmt62qG5lQofHn10gOQnTEjA3n1Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Dec 2024 11:35:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26856 invoked by uid 111); 16 Dec 2024 11:35:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2024 06:35:43 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 16 Dec 2024 06:35:43 -0500
From: Jeff King <peff@peff.net>
To: Carlos Maiolino <cem@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: [Bug report] signingKey beying bypassed
Message-ID: <20241216113543.GD2201417@coredump.intra.peff.net>
References: <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <hx6q4liyd7udyezlqy2fzanxlicu24imtdqielig622sdqz2wc@lxa4ybnzyjs5>

On Fri, Dec 13, 2024 at 09:23:29PM +0100, Carlos Maiolino wrote:

> the git-tag manpage states:
> 
> "
> CONFIGURATION
> 	By default, git tag in sign-with-default mode (-s) will use your committer
> 	identity (of the form Your Name <your@email.address>) to find a key. If you
> 	want to use a different default key, you can specify it in the repository
> 	configuration as follows:
> 
>            [user]
>                signingKey = <gpg-key-id>
> "
> 
> 
> I do have my $HOME/.gitconfig configured to always sign tags with a specific key
> per above documentation, and I just take it for granted.
> Today I had two smartcards connected, and when signing a tag, git-tag used the
> wrong key to sign the tag, instead of the specified in the .gitconfig.
> 
> I believe this might be a bug or some expected behavior that doesn't match the
> manpage. Or perhaps I misinterpreted the manpage?

No, I'd expect it to sign with the key that you configured. Two things
I'd check:

  1. Try "git config --list --show-origin" to make sure you do not
     accidentally have incorrect config somewhere overriding what you
     expect.

  2. Try signing with "GIT_TRACE=1" set in the environment, which will
     show the gpg command we run. E.g.:

       $ GIT_TRACE=1 git -c user.signingkey=foobar tag -s -m foo bar
       [...]trace: built-in: git tag -s -m foo bar
       [...]trace: run_command: gpg --status-fd=2 -bsau foobar
       [...]trace: start_command: /usr/bin/gpg --status-fd=2 -bsau foobar

     If git is passing the correct "-u" option to gpg, then the bug (or
     misconfiguration) may be in gpg.

-Peff

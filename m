Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E02253B0
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302412; cv=none; b=WPC1eAnr8wF4/qC+vv4CtEW23TGfN+q49KPzRrXDBABrSioWYA/SKwZqyMvkcbYnJZCrZeLEesyoTGUQr4tIZby4kRZQpkO/1g4wtCuF3Aq8Vv5/cOCTMPOqhltlczIfvqdBiBXo+xATtYU6cPKobAmWgGlgEQycjuHE+gQaQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302412; c=relaxed/simple;
	bh=2xDXllPfr4tRHvQnU8TK8F9kfVMgze2Xf27YsYLCh3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBWiedGpcD5YDNhpinA+K1ituFDVnY9JFvGRbGhRxViV8hO3S1KvavwR8+SKELaPm9KL2zSRBd6KJM9GEhADAyUhxIeNyLsPDKwQ5aYZkqWT2cWYzh0s645vk6IkE2jQK2Np+selMQQ1rUZAlIZ5NP3vqAMArZSumH0h5Etv1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ez8z/S1X; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ez8z/S1X"
Received: (qmail 131687 invoked by uid 109); 19 Sep 2025 17:20:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2xDXllPfr4tRHvQnU8TK8F9kfVMgze2Xf27YsYLCh3s=; b=Ez8z/S1XJ83RFYcdSGs4IQ0GyizFiQ7urAyrQQUZbS+IwC1oXS6FAm3Gd4Pte9ZZW0d6NcAkcAS8Ku+wxek6SKzcZltMvRqqUz89ysUjsM+IBVGe45VWglGNxhwL8C8X39U3GnnKhCcfCcYbPZ00VIEznInpvG0mDi/YiNBzmmymYuwbLr3rzvaMqKeq2AQD8Gpavt5ouq3iPxUX0F/jD/cbRKjVa6ZC1UYbJfnrgtpxqhVeJIyOyOHOR2AXm42jFrEqREr287tbE5L2stS/HUp7fRUBEltJ+lEXbsCLq22JmZ3GLiBydcpMSoxJfB1xl5MT8A0oanAXllezJ/OyVg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 17:20:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 208058 invoked by uid 111); 19 Sep 2025 17:20:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 13:20:08 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 13:20:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [BUG] git stash show -p with invalid option aborts with
 double-free in show_stash() (strvec_clear)
Message-ID: <20250919172007.GA59895@coredump.intra.peff.net>
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
 <1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
 <xmqq4isy77qr.fsf@gitster.g>
 <xmqqldma5qha.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldma5qha.fsf@gitster.g>

On Fri, Sep 19, 2025 at 09:58:25AM -0700, Junio C Hamano wrote:

> For completeness, here is how the other approach may look like, but
> I have made my share of off-by-one mistakes all over the place over
> the ears, so somebody else needs to lend an eyeball and check it for
> sanity.

I _thought_ there was an off-by-one at first, but I think what you have
is correct:

> +	/*
> +	 * NULL out the leftover args we did not understand, which has
> +	 * shallow copies in earlier slots in the array.
> +	 */
> +	while (left < argc--)
> +		argv[argc] = NULL;
>  	return left;

We definitely want argv[left] to be NULL, which I thought at first did
not happen because of the "<". But because it is post-increment that
happens in the loop condition, it works.

I probably would have written:

  while (left <= argc)
	argv[argc--] = NULL;

which I think is the same (but I didn't test it, so it probably does
have an off-by-one!).

But really, I do not know that we need to NULL the whole thing. We have
given the caller the reduced argc. The only argv invariant we are
violating is that argv[argc] should be NULL (or in this case,
argv[left]). Anything after argv+left should be considered
uninitialized. So just:

  argv[left] = NULL;

would be enough, I'd think.

> diff --git c/t/t3903-stash.sh w/t/t3903-stash.sh
> index 0bb4648e36..dd70deb3b3 100755
> --- c/t/t3903-stash.sh
> +++ w/t/t3903-stash.sh
> @@ -69,6 +69,11 @@ test_expect_success 'stash some dirty working directory' '
>  	setup_stash
>  '
>  
> +test_expect_success 'controlled error return on unrecognized option' '
> +	test_expect_code 129 git stash show -p --no-such 2>usage &&
> +	grep -e "^usage: git stash show" usage
> +'

This passes now, but fails with SANITIZE=leak. Along with a bunch of
other tests, as we are now overwriting entries in strvecs with NULL, so
it has no opportunity to free them. We need to respect the
setup_revision_opt to free.

I'm working up a few alternative patches.

-Peff

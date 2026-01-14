Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95A274B40
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413789; cv=none; b=UnLWSYXbf4Q5D59U/lM0jxfjghGZpNltu8Ix+rjIW34Hu+ehoPHAmEDT9y6//LvYT/BbD2PgXat3Ir0J+tFC2h6yI5j/bPvHeEpivU6NmsWwvC8yXZ2GasW4toJw2a4zKU/lvTZC+9wvIS8tdOzHL5C0caun3dKKNjl5ICXnIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413789; c=relaxed/simple;
	bh=EIdJV5VEXvnqG72XduwgVfPmIUz67hyFcCR384sL/eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXmQIb2QJUU35XEs2gcDvlod5mdPTY82jc432fHWQibf5TfFnOWH1PkN+zrRlRh0vtiItnM1Fngn95M06TcZIOikUUhX314/2XZVMSNJhjEIa7+yAg8pyDPtm1ESFv4DycHb7ArFE4I9LT5fhXt9abm8TqunZGCDqbg1Q9wOw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q79kSE8O; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q79kSE8O"
Received: (qmail 40884 invoked by uid 109); 14 Jan 2026 18:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EIdJV5VEXvnqG72XduwgVfPmIUz67hyFcCR384sL/eM=; b=Q79kSE8Or1qExcSjfAwG5KVZW3aduIhcc2CAs+tFLqkzK1arxEH8aFSRow0vuAF7DIQONb8+nhZ+QrsQ8Gg4qwpBV1OOeQarhzGaw2c4FX0cNXd581x0zFeCg68KznE/663hZ+eOgEqlSTR16A3bsfpokqbm1PiC6MZV6d9wW3Y0UjR/jQMtInsip1tBL6WlnKXJJEgYTs7LpJV7/19GnDdH+vvcjfN1z/S7zYN9xCDr2l+mWwMboIFVv7KNyGDFq9cbVs713tOqiaVmhsgV42kCw1iCUbHg6Lt7ZW0HergtB0Kmnk/K2+suhwB658/asRUP+s0Cd8RXKEokiJqqug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 18:03:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67577 invoked by uid 111); 14 Jan 2026 18:03:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 13:03:07 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 13:03:06 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 6/6] receive-pack: utilize rejected ref error details
Message-ID: <20260114180306.GI885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-6-f5f8b173c501@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-6-f5f8b173c501@gmail.com>

On Wed, Jan 14, 2026 at 04:40:47PM +0100, Karthik Nayak wrote:

> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19),
> git-receive-pack(1) switched to using batched reference updates. This also
> introduced a regression wherein instead of providing detailed error
> messages for failed referenced updates, the users were provided generic
> error messages based on the error type.
> 
> Similar to the previous commit, switch to using detailed error messages
> if present for failed reference updates to fix this regression.
> 
> One downside of this is that the messages can be very verbose, for e.g.
> in the files backend, when trying to write a non-commit object to a
> branch, you would see:
> 
>    ! [remote rejected] 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d ->
>    branch (cannot update ref 'refs/heads/branch': trying to write
>    non-commit object 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d to branch
>    'refs/heads/branch')
> 
> Here the refname is repeated multiple times due to how error messages
> are propagated and filled over the code stack. This potentially can be
> cleaned up in a future commit.

If we are going to have a "potentially cleaned up in the future" state,
I think I would prefer to see just:

  if (details)
	rp_error("%s", details);

here. And then it comes over the stderr sideband, but the actual
status-table gets the same non-verbose message. That's what happened
in v2.50.0 and earlier. Later if we want to try to cram more details
into the machine-readable message we can.

-Peff

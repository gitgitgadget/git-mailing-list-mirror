Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50306193
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430467; cv=none; b=mn2GXLg7WDlGsrUsZmAUtP2CGYHeRL9ve1T4hjEQJ8tUyexS+WH+9QBOuUexOD5N3WsjbDk5MNBySKbTAZqomgYtZKruHghqKK4Uxp3spRB6lt7tkhcpOLpJo8eRp8ZNrJHR5tfGZtk2Bg5G8YNlf0uOYQAVXkB6Xo0G+xJz66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430467; c=relaxed/simple;
	bh=HLxhUYfcOPmZWPnOp+pR9xnoaHS/k6uRX8qdLwRHKcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krerNvIyEIY3zimjFwTzWKewH9ibSS3GfwkIHhiK+y3tFWlCNkN3skai491UvqFhoyNoS0SL0Fy5PZg1xAUmsKWthu2LIxAb9yCUuK+v7bclb/Fncx6BPqwneoF34qsizyga7c3ZfC6DFmLO6DcK1TeN7v3FgqDFK8h9d7Vwjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PXtaneeM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PXtaneeM"
Received: (qmail 32126 invoked by uid 109); 5 Dec 2024 20:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HLxhUYfcOPmZWPnOp+pR9xnoaHS/k6uRX8qdLwRHKcg=; b=PXtaneeMQNkBdowUzNIFEkiKpcvfXXOBvHMqdLRaeCsNrgudAhUeypmgnl+PaezC84B3FizSnHncoh5iIbRY341edGE1/X1XJUINi+PM8cY8e7WGXVnZL1W9jnKE1xtxVu9Z769eQF3vfNaoPyi1G75KAZEZ8RjogpSj5c+TBDFFC5LqLrBJQ1dAV+UqrvQ/P8IZADaAsammVsh89kDIvQOOfK1ufLLHEXDMQwwhi2V14LqdHv8jIKb7f2bEU67IsIZN7ZvVu53p0ZEq7Iqlv+rlMxaV4Mc5KXTMoQahScgypm+0ZbTHNjj911Ikf6KnFoAWCZvAemPGnZtEXEMGAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 20:27:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9676 invoked by uid 111); 5 Dec 2024 20:27:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 15:27:44 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 15:27:44 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
Message-ID: <20241205202744.GA3170018@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-5-gitster@pobox.com>
 <Z02voaSNYRciv38z@ArchLinux>
 <xmqqy10xft94.fsf@gitster.g>
 <20241205202647.GE2629822@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205202647.GE2629822@coredump.intra.peff.net>

On Thu, Dec 05, 2024 at 03:26:47PM -0500, Jeff King wrote:

> > > I am wondering whether we should also update "check_refname_format"
> > > function to report "refs/heads/HEAD" and "refs/tags/HEAD" is bad ref
> > > name.
> > 
> > Check the list archive for the past few days; it was considered and
> > rejected.
> 
> Agreed, but maybe that is an indication we should discuss that
> alternative in the commit message. (I had looked for similar
> justification in the existing "branch" restriction, but couldn't find
> it, to the point that I wondered if I had hallucinated our reasoning
> back then).

Ah, nevermind. I just read your v2 and I think it covers this nicely.

-Peff

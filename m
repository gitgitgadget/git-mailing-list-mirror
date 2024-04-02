Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17115ADB1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090517; cv=none; b=Nbvj6TwSm1CXk++b6HboQhu5uR1dAu7vm+FjuWuQ5cU5Kgs7eP+Lg+3kddOsQnuFxCgDzQTx8JHI2pAmeCuuX2eHAyRfrUq5hzHb+paVzNXRBat2+rl0PhREHfoxnd9bRJJ4f1x8KfYZ2WJl4lvalm4wM6k6b4+eXVonMfBdPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090517; c=relaxed/simple;
	bh=DKkbj0HalZNNUiHGlucNVuas+Y8Tb+be/CwxSQLqhL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuiR3sXXWleBiqSgsrK/BNavbnXUfdJfu5Yt+qLjvBsNPDM2Y7Q4YBLq0Pg0gzGLjGwYQ/6JvbrFDzzdvQsoqz/2LFC/1yfnsD7Y0zCEFhR1K+cpdGLCJb7WOoSb39DpWNRbhOPg0AQvMi7YTmLAOoCVYn/E70IOyihJSqV6dmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7439 invoked by uid 109); 2 Apr 2024 20:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Apr 2024 20:41:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1524 invoked by uid 111); 2 Apr 2024 20:41:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 16:41:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 16:41:53 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
Message-ID: <20240402204153.GE875182@coredump.intra.peff.net>
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>

On Tue, Apr 02, 2024 at 08:30:31PM +0200, René Scharfe wrote:

> Test names like "basic" are mentioned seven times in the code (ignoring
> case): Twice when defining the input and result macros, thrice when
> defining the test function, and twice again when calling it.  Reduce
> that to a single time by using compound literals to pass the input and
> result arrays via TEST_INPUT to test_prio_queue().
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> C99 added compound literals.  Are we ready to use them?
> 
> Test definitions become more compact, but look busier due to the added
> punctuation.  We could hide some of it with a sugary macro like this:
> #define INT_ARRAY(...) ((int []){ __VA_ARGS__ })

FWIW, I think the result is way more readable than the original, even
without the INT_ARRAY (which I'm not sure adds much). I don't have a
strong opinion on compound literals in general, but if we did allow
them, we could clean up the horrible non-reentrant DATE_MODE().

-Peff

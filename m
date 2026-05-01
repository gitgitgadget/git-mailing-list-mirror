Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BF28C009
	for <git@vger.kernel.org>; Fri,  1 May 2026 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777618198; cv=none; b=eReCRUIYiFbz7/FYCpobYcYrDKToQcjANIWn/IOpFwxF25XRHac08zncGt8bNAwmdbAtegvGvvcpv4yuHqgrfd3QQq4/dEF0fXL8nC6P17RzYbQQKKbG0+bnM/pfpM4ANb3+kfOgyUiJia/BYhw7pQTV1Ufu5VfQG2wClfpqpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777618198; c=relaxed/simple;
	bh=mV8je61HIZb04heLI/KxZVtkhI3ZQJXAOVma6Bfh62A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlV5Uwr7Aig0TjU8KFqeRNuWPZ/8y24rJpaM9H+2NsHWw2zmosL6THWmgW5C9seQMlX9TUwVkDzfsXUbYa+IB61MSV7Euokur+AhtBQnpmIbEJHiWfzXzGzwD/y0TXl3FP4zhmVvCsFBEZMQDorbT04ISw80N54Ch1gFuZjCubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H1x7tnMc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H1x7tnMc"
Received: (qmail 2338 invoked by uid 106); 1 May 2026 06:49:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=mV8je61HIZb04heLI/KxZVtkhI3ZQJXAOVma6Bfh62A=; b=H1x7tnMcd8EO7Nlhcr4GjDEmucQcTl3Ri3YbmiYYI+0Y1+YDc+XSyvrz919ksBSLnJo2tWlExE3BNRppjOk/3LowgaV6LbBChrLmCvnFxRG9755NMZ4K55JRfSzjEW7fs0m+XsPht0O6CFada9FUIi8At5a5RULIa+08XlwxT4AVtUJvx5iQQWqzUSOcdNtlfohMBtFDkLZfVLUx7JbfFyHE6oQIagxina4yR8Cqh7Uu/fQcMRL+XrjFa9doGWIzQ4hVrJ3oj82k4AjtbXEoJ9igbCRpc2zaCQXAEYvB/8hMLspPyGgKGbez5f73p5j/oPgbd8aPBJrFt+4h3oFdNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 May 2026 06:49:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3959 invoked by uid 111); 1 May 2026 06:49:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2026 02:49:56 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 May 2026 02:49:55 -0400
From: Jeff King <peff@peff.net>
To: Yuri <yuri@rawbw.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: git commit silently fails
Message-ID: <20260501064955.GA2706240@coredump.intra.peff.net>
References: <a650d44b-1ab1-4a20-9b17-c82cea604acb@rawbw.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a650d44b-1ab1-4a20-9b17-c82cea604acb@rawbw.com>

On Tue, Apr 28, 2026 at 01:39:35PM -0700, Yuri wrote:

> But today git failed:
> [yuri@yv /usr/ports/devel/catch2]$ /usr/local/bin/git commit --verbose . -m
> "devel/catch2: update 3.13.0 → 3.14.0"
> [yuri@yv /usr/ports/devel/catch2]$ echo $?
> 1
> [yuri@yv /usr/ports/devel/catch2]$ /usr/local/bin/git --version
> git version 2.54.0
> 
> 
> No error messages, no verbose messages, just failure ...
> What might be wrong?

I can't reproduce the problem here, so a wild guess: do you have a pager
configured for the commit command (with pager.commit, for example)? That
could be eating all of the output (including stderr) if the pager
command fails to run.

-Peff

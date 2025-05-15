Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B9298CC6
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340816; cv=none; b=CUYZORLYmcrQjxoJkxy/egYZTRzTT4009wu1NPywgfbNpoTewsKxRd7WdEewvKYwNz01ZirbVjKHpa9nGZevCvJcWKiHkI9zaGsY8fQLhCHytzaRS8G6PslzXRvUhbqGIdER+Gf05Ubeys4Iwgq20NVTdOhaO5rbpaMNYc0F8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340816; c=relaxed/simple;
	bh=Z9Q7fTE+EFTE5Ez4UXydZGUSwnzsssxgqK5w3SzHKPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0V08cr8Z9IT4FtCk6JI4s8V9RQJ4YXFPE1s1GpvFw5sV3yA7t+yVNxD8XQItm8fxmUVJbL+zxEsr3PeL2rPpOVSjmpV+6URkpdmGv7FfrfayY5duDG5e47kqH/kfplwKiMZvoIYiH2oBH86BjDOrQ4USKpJXmqwGzGByExAwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aXfO29Ap; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aXfO29Ap"
Received: (qmail 938 invoked by uid 109); 15 May 2025 20:26:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Z9Q7fTE+EFTE5Ez4UXydZGUSwnzsssxgqK5w3SzHKPQ=; b=aXfO29Ap6d7gF7JDVjoDKGfzjLaf8tXjEsxoE+KXR2CRX9BIzDkUcyfKhyD4xp88/YV4I3+vzDkcX8vVedPiQ7O+FXe/tXVGJy5Sy0JbbmDvoxqk0DnN6tLmBB9k9iGU/ExsJWCUnI7G8aCyBgg6AUcRm7bO8R87Z/BfMRB0I2gYLaWWrm8SiAvqxRJoJDU4qiXakm4WR6bwoSWR914ehSj+tROUF+lRM+tWJnlWjXl6U7RyblQL08E/mgh52iZsmGqHYiP7ABEuKEQACPVdiltZ0pla79ubzwc4vDxc7Oevu7FYq8FYZQoQQJCFZ2L4yIutZ8WcmLDaEyUdftB3Ww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:26:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30902 invoked by uid 111); 15 May 2025 20:26:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:26:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:26:52 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] CodeQL-inspired fixes
Message-ID: <20250515202652.GM3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:38PM +0000, Johannes Schindelin via GitGitGadget wrote:

> CodeQL [https://codeql.github.com/] pointed out a couple of issues, which
> are addressed in this patch series.
> 
> Johannes Schindelin (11):
>   commit: simplify code
>   fetch: carefully clear local variable's address after use
>   commit-graph: avoid malloc'ing a local variable
>   upload-pack: rename `enum` to reflect the operation
>   has_dir_name(): make code more obvious
>   fetch: avoid unnecessary work when there is no current branch
>   Avoid redundant conditions
>   trace2: avoid "futile conditional"
>   commit-graph: avoid using stale stack addresses
>   bundle-uri: avoid using undefined output of `sscanf()`
>   sequencer: stop pretending that an assignment is a condition

I read through all of these and didn't find anything incorrect. I did
leave a few comments that might or might not be worth following up on.
Thanks for fixing these.

-Peff

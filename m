Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142D1FF600
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717635; cv=none; b=EoR2WJFuUBiFi6NjNpYU30uLeVy6g2s/i74qbmMFQx1kvTSxlO4yetQSfKIXlOfOyAiK9G3j2D0MrURmdBfwRr9ZHTh5Iz1lmQSJzbJBAfV/Il0FdSIFc/gVtXq0ENyUWVzU3WGX9nI+PI6sBOnQd8aH5Zp3jKjXfo7ldIkbomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717635; c=relaxed/simple;
	bh=VDOqhLrdgraR875Tr6QUjAEZgEyNilpEBjUFV9ul7o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqrojcqNjuKPH+lTIZ4GLX41z3oMlNJ/oyW3RG2U9mPtRHHZpRedcZqIHwbRNOeTzPtTzzEBkY7zt85+OstuF5C8lL+UELdlmHT6gvxkiJAatkIzUPgv0m/03ZfN2qMZdOOFizTK8+vH+MC1tUKWNcYx06Yvcyt9AjmjM3t9PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JnljIQ4k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JnljIQ4k"
Received: (qmail 5112 invoked by uid 109); 27 Nov 2024 14:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=VDOqhLrdgraR875Tr6QUjAEZgEyNilpEBjUFV9ul7o0=; b=JnljIQ4k2m4eaFdEP8g94NSnsiICfeGA/WzHXwl2hul9VIpet5ks2tMcDuVaKCSzNfCmQtF5UnFubhSWVwtHjzNK38ys9QxepaTi4FSnucBBrE411ugkZYkIgXyoCiOahtIM/iQ1ZRaoazbCpLlsDdqC/oMj1E0mcqr7VdPI0kz8hZHQvP7Yt5dQpTT4LJX5D/KItsGoGHUwmTYFdzwa1nUAU5otpq26JwXQyK//DcemyYceSgxNroiTXI4m4/m/qoEvIS7PG3HG2Pk01jD4x+I0yaUb7to/RdW1kv1opWeIq7NLRwhLK4rPeJTCaSEKebFkBCl0ZrLuyxOezWK1vg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Nov 2024 14:27:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 785 invoked by uid 111); 27 Nov 2024 14:27:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2024 09:27:11 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Nov 2024 09:27:11 -0500
From: Jeff King <peff@peff.net>
To: git@jowil.de
Cc: git@vger.kernel.org
Subject: Re: git tag -a HEAD leads to ambiguous branch name
Message-ID: <20241127142711.GB1712@coredump.intra.peff.net>
References: <47cdf937-6192-4c83-a0e5-700e98f36c1e@jowil.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47cdf937-6192-4c83-a0e5-700e98f36c1e@jowil.de>

On Wed, Nov 27, 2024 at 01:14:23AM +0100, git@jowil.de wrote:

> today I encountered a warning using  git version 2.39.0.windows.2:
> /warning: refname 'HEAD' is ambiguous./
> It turned out, having written
> /git tag -a HEAD -m "Some message."/
> was the culprit.
> As
> /git branch HEAD/
> yields the following error
> /fatal: 'HEAD' is not a valid branch name/
> I wanted to aks, whether a similar check should  be applied to tag names.

Yes, I think that's reasonable. We won't ever completely forbid "HEAD"
as a branch or tag name for historical reasons. But when porcelain like
git-branch or git-tag sees it, it is almost certainly a typo or
forgotten argument.

-Peff

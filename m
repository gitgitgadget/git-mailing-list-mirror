Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930941DE8AA
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333891; cv=none; b=K1UuAGwwvpH0a/dJvAW/8kou+JU/I4g+NKK1q6GfSIy/1KMkI3qTSik/1Rki98ewgRXdbx7pt0d5AZ1m1zlOIQbEECVfWB7COrUZTqsd6W4o581ctqoSM2ygHb/IrCxchyYVC5BgxP5BDAEjTfKzvm89uZMnMhc+FmPciQt2WQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333891; c=relaxed/simple;
	bh=yM1H+Gtli2U2lk/FWnF3HRkga/si1hggMRfcYQ+Nczo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP3GlNYipGA8xrx1EN/+fNIphBI+DynCOd4IqmIlagaH1WxwMBKmQ12jbTFUWbQHAI5Yk3IPxw9QZ4ZnnrYONWYIrm6ak1SK93ayIwJsg3QdOh2QCeRe+Md+6WGpfsLufhHV1wObmz5dZ6TwYke93MynD/Ovp069za174AId4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MNvaWF7p; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MNvaWF7p"
Received: (qmail 5014 invoked by uid 109); 7 Oct 2024 20:44:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=yM1H+Gtli2U2lk/FWnF3HRkga/si1hggMRfcYQ+Nczo=; b=MNvaWF7pPOS0LKS1/PsZGAC6Chehorxhoh0QPBYq+XZSzv3fsFZfXaBsZyZ5mIalHcKhxkTjrYmGkzBymdb8M/NOWhEUdqoHFPsH1KH8Cf5ZdRn4rCBz/30JRv7h3Mfn6JXSv0Ea1CMQDP5e85Zjb4a8yVMf5yF25mwCLajUXgGNc50x5f1XQEMyf0HNkLwQKoo2QiY4JpLg2WJTwUHWQ4X9+i8dZrOhKnwP2Vc18s+eZH4PPi9R9PeVybodyEp+5tOsbCva4mt1OQp2beNiojZS0qN4uw7x0xdPJiBPW97bsevmlz5wXb69sr/i6b0P1hbwna/mLI8WxgyqXkO7jA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Oct 2024 20:44:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9399 invoked by uid 111); 7 Oct 2024 20:44:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Oct 2024 16:44:48 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Oct 2024 16:44:47 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] object-name: don't allow @ as a branch name
Message-ID: <20241007204447.GB603285@coredump.intra.peff.net>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>

On Mon, Oct 07, 2024 at 10:15:18PM +0200, Kristoffer Haugsbakk wrote:

> `HEAD` is an invalid branch name.[1]  But the `@` synonym is allowed.
> This is just as inconvenient since commands like `git checkout @` will,
> quite sensibly, do `git checkout HEAD` instead of checking out that
> branch; in turn there is no practical reason to use this as a branch
> name since you cannot even check out the branch itself (only check out
> the commit which `refs/heads/@` points to).
> 
> † 1: a625b092cc5 (branch: correctly reject refs/heads/{-dash,HEAD},
>     2017-11-14)

There's a bit of subtlety here which makes the term "invalid" somewhat
vague. The refname "refs/heads/HEAD" is allowed by plumbing, as we try
to maintain backwards compatibility there. So the current prohibition is
just within the porcelain tools: we won't allow "git branch HEAD"
because it's an easy mistake to make, even though you could still create
it with "git update-ref".

And naturally we'd want the same rules for "refs/heads/@". I think it
might be worth adding "...in plumbing" to the end of the subject, and/or
calling out this distinction in the text.

It might also be worth mentioning some of the reasoning about the test
you put in your cover letter, since that content is not otherwise in the
Git history. I'm thinking something as simple as:

  Note that we are reversing the result of the test in t3204. But as the
  comment there notes, it was added only to check that "@" was not
  expanded. Asserting that the branch "@" can be created was only
  testing what happened to occur, and not an endorsement of the
  behavior.

> diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
> index 594e3e43e12..7dcd1308f8c 100755
> --- a/t/t3204-branch-name-interpretation.sh
> +++ b/t/t3204-branch-name-interpretation.sh
> @@ -119,13 +119,8 @@ test_expect_success 'disallow deleting remote branch via @{-1}' '
>  	expect_branch refs/heads/origin/previous two
>  '
>  
> -# The thing we are testing here is that "@" is the real branch refs/heads/@,
> -# and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
> -# sane thing, but it _is_ technically allowed for now. If we disallow it, these
> -# can be switched to test_must_fail.
> -test_expect_success 'create branch named "@"' '
> -	git branch -f @ one &&
> -	expect_branch refs/heads/@ one
> +test_expect_success 'disallow branch named "@"' '
> +	test_must_fail git branch -f @ one
>  '
>  
>  test_expect_success 'delete branch named "@"' '

I was a little surprised that the "delete branch named @" test
immediately below did not need similar treatment. But I guess all of the
"check refname" code in git-branch is split between those two cases,
because we want to allow cleanup of broken names created through other
means.

So I think the patch is doing the right thing. But it might be worth
mentioning this distinction in the commit message.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E62028000F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107411; cv=none; b=gBq8MfxaWRR7Nzy1kCCeT+tDCOXJCQ7OCzU3CYw/TspqH6f6cNLpHD72FmySBg4HXcPmU6miY5hdwssuk+d6nGaf7FVD5UlfHbrAJq740cRlmk5Xh2o5+hYiny13FyU4qYQW8W6opH06FA5qKulqpqlTEbfDNMVOa/RifS5FDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107411; c=relaxed/simple;
	bh=HajYKXkIIaZvGT8TCIsFmam3b6YO25Fn29T9Z5pkyOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGf6RpezxprER0aqzRqJ4HN4YzR/AiaudfJiY4SQWLB9r5RL9yOxmyR7GYgVKVCGr3hLxkEWgk+CUixysM/BuhgiUG05SggJIl48oA+jqr97/YC/Mmp157fmTSpKbu7/yZlMlmAKyG/1Z2pJwB5u8JfTCLQL4zR7MnHsGfHrw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dKh/W+Un; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dKh/W+Un"
Received: (qmail 220994 invoked by uid 109); 5 Sep 2025 21:23:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HajYKXkIIaZvGT8TCIsFmam3b6YO25Fn29T9Z5pkyOM=; b=dKh/W+UnnOFhbOe49nrjKwV9xIyqtaXAF2ImuUo9fxXeAs6FexP8hEJUn2tZccP+lTEG5wyjgR/e+IbyIdabTLDp0hOHTr6S81mmVz0W1uIrPsZkaeEevVsAckdJOHfWTUL6Mv/bcG2L6qdTsduhjDUsVNA1AV4spj+MU/oUIjSCCETn2JCvGihJ+ICoollXxsDl+dbSMdzbW78PwWLnGOrlJgLf3q0FXtX5+63WyxF5MO7fX1rHGssfVK3gwcv6KpAlPALmO4C9BzwCK6LaemZhssQ1pTGYn732DTYoNuyhVoxFkBiXnMXztmL0B8K0GvELWgJAcJBTvlaCBaRoLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Sep 2025 21:23:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 380465 invoked by uid 111); 5 Sep 2025 21:23:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Sep 2025 17:23:22 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Sep 2025 17:23:21 -0400
From: Jeff King <peff@peff.net>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Config options -c in rebase --continue not passed to
 prepare-commit-msg hook
Message-ID: <20250905212321.GA612697@coredump.intra.peff.net>
References: <CANM0SV0+t7x_VTtZNCO8rKo1vvxhJjwEdmjLDN70njxCo7DofQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANM0SV0+t7x_VTtZNCO8rKo1vvxhJjwEdmjLDN70njxCo7DofQ@mail.gmail.com>

On Thu, Sep 04, 2025 at 02:46:13PM +0200, Devste Devste wrote:

> For some reason neither environment variables nor -c is passed to the
> prepare-commit-msg hook when rebasing.
> Other parameters (e.g. -C /path/to/repo) are passed correctly/it's
> running the command in the correct repo

If the environment is being cleared, then that would explain "-c" as
well, since it passes through the environment. However, I can't
reproduce the problem here.

This is my full recipe:

-- >8 --
git init
git checkout main
echo base >file && git add file && git commit -m base
echo main >>file && git commit -am main
git checkout -b side HEAD^
echo side >>file && git commit -am side


cat >.git/hooks/prepare-commit-msg <<\EOF
#!/bin/sh
echo "in prepare-commit-msg hook"
echo "FOO: $FOO"
echo "config: $(git config --get hooks.foobar)"
exit 1
EOF
chmod +x .git/hooks/prepare-commit-msg

git rebase main
echo resolved >file
git add file
FOO=bar git -c hooks.foobar=hello rebase --continue
-- >8 --

The final command produces:

  in prepare-commit-msg hook
  FOO: bar
  config: hello
  error: could not commit staged changes.

which is what I'd expect. Do you get the same thing? If not, then I
wonder what could be different between our environments. If so, then I
wonder what is different from your earlier testing. :)

-Peff

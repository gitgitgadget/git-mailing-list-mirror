Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E992209B
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537255; cv=none; b=EpvKRaGI6SAfUuILLFCPthWBUotMdtxBkNZTY2clVNFSPzjxsTyJxg8PS67YipVHsAikt79xcaW7JTdFJJJKGuGIllU6lE8peqewQYzjqbJbK/f3aobxAW+lCL7WaltMBop/ehSfFmqodw2tddDWKmNhY0Vp0Awt5Jr8EGquzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537255; c=relaxed/simple;
	bh=3wsl9i2PNvTjW9ebZ7muSa+TZqvvtyLSZHyJigv8lxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duW9pxUfjdTHEo5HBn7vWn5a6V48RE3XjoXuhZ0e6ug5c/WkcBvVj+nGs6YvKKghB9NvztYN9bw6HTCsLiO4HYrkHyHmxCAWig97Qjd7XyGiuGXe1ttu9wCPSJKjdtQgL5zhDaI3mn0QFtlBiGtJMJym0YVhpfKW7IY/a9gHg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HulRpOVo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HulRpOVo"
Received: (qmail 19214 invoked by uid 109); 21 Oct 2024 19:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3wsl9i2PNvTjW9ebZ7muSa+TZqvvtyLSZHyJigv8lxc=; b=HulRpOVoXGVqOg0QbKKDcph6DlCq/10TpGge8qn6fAqmduAXB9y0n697wELPQ9zH6w2D5tW8NRokwhgWr3MsUstioGvJ6YZuc8q6D3CcC6MWFzLZrVljYkVjmfulsPFbCcPTXMyTu5JEpIh3Nh7aR4CG1gprQwAHOuvN5Cw716Xs2X0ZUPXL5nlKpoN7ClrzfJLNJ5zIGHTOLRffs4h4iXzQaD45ZVTKTNnPOUHq8FEsctLMEbYDQv7B0PmV5C/gxu7a2Inm6uhRFiGjoUTuerHqeG869l58MrHAJWt7i9Lp0gHNLcx3FL2/fBk27clr2J0z4Xj2TyPG7EAz7LAi3Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Oct 2024 19:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31688 invoked by uid 111); 21 Oct 2024 19:00:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2024 15:00:45 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 21 Oct 2024 15:00:45 -0400
From: Jeff King <peff@peff.net>
To: Philip Yung <y5c4l3@proton.me>
Cc: Y5 via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Message-ID: <20241021190045.GB1219228@coredump.intra.peff.net>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
 <20241019211938.GA589728@coredump.intra.peff.net>
 <UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>

On Mon, Oct 21, 2024 at 12:11:33AM +0000, Philip Yung wrote:

> > errors will likewise go to the pager. E.g., try "git log --foo".
> 
> Hope that I didn't take it the wrong way, but I don't think `git log --foo`
> starts a pager, where the routine `setup_pager()` is put after argv parsing.
> (checked by `strace`)

Hmm, this actually depends on config. If you have pager.log defined,
we'll start it early in git.c, but otherwise not until the setup_pager()
call.

I was mildly surprised that pager.diff would not have the same effect,
even with your patch. But that's because we only handle pager config if
RUN_SETUP is true, which it is not for diff (because we might be doing
an out-of-repo --index diff). And the reason for that is mostly
historical, as reading config early interferes with repo setup (though
I'm even sure that's still the case, as check_pager_config() these days
uses the "early" config mechanism which is supposed to address that).

What a horrid mess of inconsistency and hacks. ;)

Likewise, any builtin that sets USE_PAGER in git.c will turn on the
pager early. So "git shortlog --foo" will go through the pager, as will
range-diff. I was somewhat surprised those are the only two these days.
Looks like 1fda91b511 (Fix 'git log' early pager startup error case,
2010-08-24) dropped many. And I think your patch is the spiritual
successor to that.

So I think in an ideal world we'd:

  - convert those two commands to do the pager setup themselves and
    retire the USE_PAGER flag entirely

  - move configured pager handling down into more commands. So git-log
    should set DELAY_PAGER_CONFIG and then call setup_auto_pager()
    rather than setup_pager(). Ideally DELAY_PAGER_CONFIG would be the
    default, but we can't do that until every builtin makes its own call
    to setup_auto_pager() at the right moment.

  - push calls to setup_pager() (or setup_auto_pager()) as far down
    within commands as possible (right before we start generating
    output). Your patch does that for git-diff, but there may be other
    cases.

  - consistently handle pager config whether USE_SETUP is set or not.
    That means git-diff should set DELAY_PAGER_CONFIG, since it handles
    the pager itself.

And that would make things more consistent overall, and avoid pushing
early errors into the pager (though of course it would still be possible
to get some errors in the pager if they happen after we start it).

I don't blame you if you don't want to start down that rabbit hole. :) I
think it would probably be OK to peck away at it incrementally, and your
patch does that.

> > would be missing a spot that needed a new setup_diff_pager() call, and I
> > suspect we don't have good test coverage here.
> 
> This is actually my concern as well when I was naively testing the coverage
> using GDB, which turned out to be quite tedious. Would you consider it's fine to
> add a pager consistency test for builtins, probably in another patch with regard
> to `t7006-pager.sh` OR a new test `t7007`?

TBH, I am not all that worried about adding tests just for your patch.
You'd need to identify all of the possible diff code paths in order to
add tests for them, which is the same thing you had to do to fix the
code paths. I was mostly just commenting that we're not likely to be
able to rely on existing tests to help us here.

It might be worth adding a test that shows off your improved diff
behavior, though I would be OK if it was a representative command and
not exhaustive. I think adding to t7006 should be fine.

If we fixed some of the bits I mentioned above, some of that should
likewise be covered by tests.

-Peff

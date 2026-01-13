Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9F341678
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324235; cv=none; b=tXaTx/MyDSS9yKhbpGKCj3sYToZ4nmidu+VpGOVE4v0gR0kzilSjOGmYFY/5T8KjxjHDuey0YzG3A1SlrFedJyzVeaM4JpgeTBV3bDBJpG7d4ZJ4WjQfoAVjNy7xHCYhUZ9gKsntihCOVDKqRkGoM/Z6tnFlMWzN2VPiO3Su5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324235; c=relaxed/simple;
	bh=f1VNFiEC6oXyjJ2zcaYGP3/ltW3/x805On04Rvxjchg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITA33SGXK+B8AROgjNvKMPsT6BQMTRDIPqMfscC1CfWfBHeM5seFZGspkh+dASJ4XngVT98Tc8J89dOWwD6MU+x9Q5iFBva0ceYA9KUDVNcbLZsut7WcqaR1/SUBe9oDPUH/OQTEq1DGPnPUT7EgP/w0O98nqSutfYTEQ99IUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZA0nU4Bs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZA0nU4Bs"
Received: (qmail 30241 invoked by uid 109); 13 Jan 2026 17:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f1VNFiEC6oXyjJ2zcaYGP3/ltW3/x805On04Rvxjchg=; b=ZA0nU4BsB/zUdeKrCaZczGcgRx4RU+gnh97tbHQNrToeM+Urd3ehKte/e7rpdwaWF8kNvjqaZxnBwubVb/ASQA1v9JNtAUj0BKT6AIS00n5xMvmnkh3Dn6717C31mkiPCgrlDrwlWGGVIZrja/YMmyPCRKYWOi9xb2kwlBeOn5us4HgHGqRrEcp37j1a6VRFVZjzHm8o6sQVOCPpTPStDXlf5ttNTd7KgKWMqio2uX84k2F2gZ2Erblny4xochziEIlmswmDrF6uuOuBVqegVKGX9XusT2GQIOk8hlegJuJi8qQrtVWX/I+PetPtwXAarie8wthMbwAaJ5kfwPKFyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jan 2026 17:10:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 51960 invoked by uid 111); 13 Jan 2026 17:10:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jan 2026 12:10:32 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Jan 2026 12:10:30 -0500
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Alan Mackenzie <acm@muc.de>, git@vger.kernel.org
Subject: Re: Difficulties using git rebase.  Help, please!
Message-ID: <20260113171030.GB265671@coredump.intra.peff.net>
References: <aWPFxQloyfx8x0ED@MAC.fritz.box>
 <fefb3d25-3723-4e10-893a-620fbdc0cc45@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fefb3d25-3723-4e10-893a-620fbdc0cc45@app.fastmail.com>

On Mon, Jan 12, 2026 at 05:08:52PM +0100, Kristoffer Haugsbakk wrote:

> On Sun, Jan 11, 2026, at 16:46, Alan Mackenzie wrote:
> >[snip]
> >     $ git rebase --onto master origin/linux-6.13.y HEAD
> >
> > ..  This didn't work well.  In particular, I got a conflict in a file that
> > I had never changed.  Why?
> >
> > Well, I corrected the conflicts in that file, git add'ed it, git rebase
> > --continue'd, then got another conflict in a file I'd never touched.
> > Same again.  After the third such conflict, I gave up with git rebase
> > --abort.
> >
> > Criticism: there doesn't appear to be a --dry-run option in git rebase,
> > with which one can see how many files will be conflicted.  Instead they
> > are notified one at a time, drip, drip, drip, .... to the user.  In my
> > case there might have been four conflicted files, there might have been a
> > thousand.  Either I'm missing something, or git rebase is missing
> > something, hopefully the former.
> 
> Just a dry-run? I would use `git merge-tree HEAD
> origin/linux-6.13.y`. Then you get to see what files are conflicted
> without stepping through anything.

Minor pedantry, but: those are not quite the same thing[1]. You may have
conflicts in the rebase that would not be seen by merging the endpoints
(in the simplest case, imagine a series which makes a change and then
reverts it).

I do think it's a good approximation, though. But that also points to
why OP's request for a --dry-run can't be fulfilled: we can't know what
conflicts we'll see in patch 2 until we know what the tree state is
after applying patch 1. If there are conflicts in patch 1, we don't know
what that state is until the user resolves them.

-Peff

[1] If you want to dive into the world of rebase vs merge conflicts,
    check out Michael Haggerty's imerge tool:

      https://github.com/mhagger/git-imerge

    and some of the associated blog posts and presentations. It can make
    big ugly rebases/merges easier to deal with.

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCF3A1A59
	for <git@vger.kernel.org>; Fri, 22 May 2026 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428596; cv=none; b=Ep3CM++n0jHhQr0gqUGSzIMhnogA8YJlwg7rfLsyhI9DW/10uffSOyCfpPx1+HdxZb1/pPF6kxSrBTI69EpyW8qgwT2RPQHMAqBcGWXCELSVHqHurLwNFFGXhnsNzHU9UBMr7SkUAf2nAhCwlTBl/GVBLkBDhoKppOyATkgzUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428596; c=relaxed/simple;
	bh=EB7KzGHsqLfIRWPDxzyrWbur2Zfp2trM9xJVAj/5mEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W17eK5ET+qy2H5XcqKEMc3n46Dp/Zs+03/IjirXXIL+H9KbXOf7gddMxqPnn5aCIT21w+e74LUQjIobY4ZWXzUX4z64PkhJTCF70phYY7SDFs07QvAQT7k5xiKccy4YxO+PUTGurkOiTBjNttW3FTKKsARI6XZV7MNQTK5DdwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D8C+SJs+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D8C+SJs+"
Received: (qmail 47203 invoked by uid 106); 22 May 2026 05:43:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EB7KzGHsqLfIRWPDxzyrWbur2Zfp2trM9xJVAj/5mEY=; b=D8C+SJs+UnO/VXGy3bTALE7CbmLNJLiBmWD6g1H04R+KhbEOr8dYQiNwnZvvg58Dj1B5cnQjVGwXFeHKn1pLqcpCmbpxj8acQ2WHYSmF5iHGz4rPM/fmCITI4F/5d20fD0xyuNJbYfEDViCCQVLQgc9GVzfzwc0BJdLnqtWnYdBPUzyj5l2Z4jNGa1xybANOVZKuymg651N2LC6OcqZ57hDzGY56G1Lw7rFVKvzvRwfpkEut3Qo4I5IlHLGLZWegU7fiFEXdYUxULclTjzUrBvsLs7wagkDAPh5InYnyaRSqouMPsGqcCHoe30c1M9gWSvdM+btFd893fquzCv+nag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2026 05:43:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99296 invoked by uid 111); 22 May 2026 05:43:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2026 01:43:17 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 May 2026 01:43:12 -0400
From: Jeff King <peff@peff.net>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] log: let --follow follow renames in merge commits
Message-ID: <20260522054312.GD861761@coredump.intra.peff.net>
References: <agLU58gbG1y7KLz-@collabora.com>
 <agwAkHzjrJQPVtCS@collabora.com>
 <xmqqo6ib7vlp.fsf@gitster.g>
 <ag2265RJal-tJLoW@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ag2265RJal-tJLoW@collabora.com>

On Wed, May 20, 2026 at 03:28:11PM +0200, Miklos Vajna wrote:

> Hi Elijah, Jeff,
> 
> On Tue, May 19, 2026 at 03:37:54PM +0900, Junio C Hamano <gitster@pobox.com> wrote:
> > > :-) Should I just wait more or should I resend this?
> > 
> > Rather, ask other reviewers
> 
> I did a small improvement to how 'git log --follow' works, as in if the
> rename happens inside the merge commit itself, then the rename was
> detected "vs the first parent", but it wasn't detected "vs other
> parents", which is painful with a "subtree" merge commit.
> 
> I'm not sure if it adds value, but I can append a one-paragraph summary
> of Junio's comment in this thread to the end the commit message, to be
> more explicit that the inherent limitation of the current log follow
> design (single path, once a rename is detected, we only care about the
> new path) is not changed with the patch, this is just a fix patch so
> 'git log' works better, similar to how 'git blame' already does.
> 
> May I ask you to review the patch?

I saw Junio's comment. I was about to write something very similar
before I saw that he had already done so. ;)

I think we can probably all agree that both before and after your patch,
--follow is never going to do the _right_ thing, which is to follow
paths independently down both sides of history.

I am OK conceptually with making the current broken behavior slightly
more useful if it is easy to do. But I am not sure if we are making
things more useful here or not. If we see a merge where the file "bar"
was previous "foo" on one side and "bar" on the other, our broken follow
is going to either pick "foo" or "bar" to continue with as we traverse.
But which one is right? Whichever name we choose, we are potentially
omitting results from the other side.

Right now we pick the first-parent name always. But it does not seem
more correct to me to pick one from another parent. You'd be missing
further commits using the original name along the first-parent track.

There might be a more useful rule like: if the path is untouched versus
the merge result in all parents but one (i.e., TREESAME), then choose
the parent where it was changed, including any --follow processing. But
we already do something like that for history simplification. Which
makes me wonder if you could get the results you want through some use
of history-simplification flags.

Or maybe we already do that TREESAME check. Simplification kicks in when
the traversal is limited by path, and --follow mode by definition has
such a path. But I'm not sure if the --follow code would see the
simplified parent list or not.

So I dunno. Probably some experimenting could yield more analysis there,
but with the patch as-is I'm not convinced that it is not going to make
some cases worse.

-Peff

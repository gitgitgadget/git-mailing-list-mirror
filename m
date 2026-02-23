Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA41CEAC2
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853436; cv=none; b=sKAIoaLEvWyIeivy296IFAI8rmTRUiufj2amd+vEfQ5jxLBzEKSIN4yWj5nTgoECbGeeOcFUVZIXvceX74AOsTQDvTFFDqf58mGE4zx4k22u3F9r4ZwsTs7aPThiTWVpu9mrYqBMN09uVOr6lJEurQnJx5PNbUduPay/e2zLtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853436; c=relaxed/simple;
	bh=8kuXsb/91VhdcQBs1+fyQLdIyQKGVBByBHhJVzO9okQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+/609d2JZzQyec6mNl0Fv8cuASQdU4xmW7oFCt3QS7Ky11MJlTYnd02/6LZPycS9/llYuzQeuBd1GiFfnzEKdl1W42a9q4iBlLlViUPDUI5mH1t3vnah1CzQySMQuwoZc1RcTr5+pVXPM7jsIPX7rBODJ7sV2VF0EWEgukkzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Yb0pdSgs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Yb0pdSgs"
Received: (qmail 54475 invoked by uid 109); 23 Feb 2026 13:30:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=8kuXsb/91VhdcQBs1+fyQLdIyQKGVBByBHhJVzO9okQ=; b=Yb0pdSgslODRAagdmkFuFzyABjyPxxFeMPUnBU+158YOZR1HTwOd9rZYGHN/uyo3YH3TZ/IX3lwMJUKicmf0RjzBG4aV54E4jw4WPiMdIIllRU7g8osEMn1P6Sg9V0BHRfLE7+kA61hUFnuPZ/kTiLFxuOE+Yc1qWTf2GDi3WKHOpK1j9Z1CFg0Ass8IFAxYLnMpoZwxhNt12ssAVfRwnS8BL0gY41EoG3M3wd0bXReTJJLe1jh3Ol1cXxJYwdhAo9bVLiTzEID7bHiz2hBhIAMqxJhMMBwZi5JEJvGKWvuqiL5i1k1NXRr8L1qZrnBsw3QaIE7eQ6Fb8fpkD81ZmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 13:30:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 105396 invoked by uid 111); 23 Feb 2026 13:30:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 08:30:34 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 08:30:34 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, gitgitgadget@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
Message-ID: <20260223133034.GD215671@coredump.intra.peff.net>
References: <067978dd0946732e00e4805d62ea51348fbf336e.1769112471.git.gitgitgadget@gmail.com>
 <20260221080201.7847-1-haraldnordgren@gmail.com>
 <xmqqwm06rp6p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwm06rp6p.fsf@gitster.g>

On Sat, Feb 21, 2026 at 09:17:50AM -0800, Junio C Hamano wrote:

> Harald Nordgren <haraldnordgren@gmail.com> writes:
> 
> > Hi Junio and Jeff!
> >
> > I see that this topic has now been marked as "Stale". Isn't it time to
> > merge this now?
> >
> > We went to several rounds of reviews and edits to reach something that I
> > think everyone agrees with 🤗
> 
> The entry has been asking "What's the status of this topic?" in the
> past handful of issues of "What's cooking" report and we heard
> nothing from anybody (until you responded ;-)), so I moved it
> together with others to the [Stalled] section.
> 
> The topic has been paged out of my consciousness for quite a while,
> so it may take some time for me to answer this question myself, but
> list participants, do you imagine yourselves using this feature in
> your daily life?

I do not personally have any interest in using the feature (I only
joined the thread to complain that it could not be turned off ;) ).

So in that sense I don't care how far it takes things along the path of
what was discussed in the v27 review. My main concern is that we not
paint ourselves into a corner and be stuck forever with an interface
that is inconsistent with the rest of Git.

So what about this. We add a config option that takes a list of items to
compare against. But it _only_ supports @{upstream} and @{push} for now,
and interprets them as branch@{upstream} and branch@{push} (but probably
done manually, not via dwim_ref). That limitation gets documented.

Then later, if we choose to allow resolving arbitrary refs via
dwim_ref(), we can add that support on top:

  - rather than manually resolving @{upstream}, quietly rewrite it to
    branch@{upstream}. This is OK since branchless @{upstream} makes no
    sense in this context.

  - otherwise, pass what the user gives us to repo_dwim_ref()

  - optionally allow substitution via %s or similar. Technically I think
    "%" is allowed in a ref. I think that's probably OK in practice,
    though if we want to be really careful, then "[branch]" or something
    that's forbidden in the ref format would be a possible substitution.

But if we stop short of all of that today, we don't have to worry about
all of those weird corner cases I dug up in the earlier thread. And if
nobody ever _really_ cares about sticking arbitrary refs into their
compare-list, then we just never go there.

-Peff

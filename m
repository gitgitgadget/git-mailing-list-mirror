Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B64A23
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376989; cv=none; b=ZuG3S2XSEppnPcy0Svzy5GXBDrIf2Aw45JgUb8QvuJ/jxaoNhihn2X9LT7A7rQy17zhtJ8RXXtUkcF+fWo7ncjOaZLvOwYd4fMwj9TGekmLJBOIqOAm6A+9f6oXRacq9SPBrLlI+xwx5WwYT+YONCiNSGLnP3xQ2j61WJBSvmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376989; c=relaxed/simple;
	bh=pHu+3lw5ruYlyMfmazENTnWnbhjt3H/dXa7RSSbaWR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apuJnKM01JTkMDERsYpz9hgVWb8nUVyHkIiSpqD2Et1VcchlX0XL5vvFrDjlVb0sGuwxAzEvjcuYMH1jlCIYzTVy4t0hXDlyedJ/RgwgY9ER6qfopeZHVilPgyW794TDd4y92MvHcHsKAs/IF6ZmlA26iFlyM964iWCr25PyQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J/HAdZut; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J/HAdZut"
Received: (qmail 10012 invoked by uid 109); 1 Feb 2025 02:29:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pHu+3lw5ruYlyMfmazENTnWnbhjt3H/dXa7RSSbaWR4=; b=J/HAdZutLk2b3tWlVdI1vjeyZsfcGUSS7QnmG5IvkuGAkVp5+IBwl4E1r30LnhaPMFhpins/CAg7DBFzHFcj9MvfXVLrDha+X/YcVOGt39xUD8Or6KVmgZSxU4GYV5h8qCpHMrLKjmi9eKjBJ9EXomgiug2Ss9MMUP8ZtaCkGPoJ926enVzTkhsAxDCVVc2vf6eo2tnEA/PdiorpDtA70EUyLsE7bR4oy0zzKqymq6VfLXeDZ0CLzGklZfqRmeztUcB0Br8ezBB6l7NuJeZP7daC7izIYp1LuRvWK1FbPcbN7JmmuhDGO61rAyIYCj0U6wBNIP1OqL8GNkakGkHNtA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Feb 2025 02:29:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8257 invoked by uid 111); 1 Feb 2025 02:29:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 21:29:49 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 21:29:46 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <20250201022946.GA4088801@coredump.intra.peff.net>
References: <xmqqbjvyv510.fsf@gitster.g>
 <20250123003613.GA3900660@coredump.intra.peff.net>
 <xmqq5xm6uwip.fsf@gitster.g>
 <20250131233452.GB3544301@coredump.intra.peff.net>
 <xmqq1pwi5yt9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pwi5yt9.fsf@gitster.g>

On Fri, Jan 31, 2025 at 03:49:22PM -0800, Junio C Hamano wrote:

> To help the idea of catching before things hit next, it probably
> would make the most sense to test the tip of the 'jch' branch, which
> is somewhere between the 'master' and the 'seen' branches and
> contains a bit more topics than the 'next' branch does. The branch
> is usually what I use for my work every day, so even though it may
> have acquired new leaks and UBs that would not cause troubles in
> practice, it should functionally be a lot more stable and usable
> than the tip of 'seen'.

I've switched to basing my branch on 'jch', which did turn up a few new
hits (lots of uninteresting ones, but a few that may be important; I've
responded in the relevant threads).

What I'm most worried about is that it does have leaks or UB. My daily
workflow is usually to build my personal branch (previously 'next' now
'jch', plus my own topics) and stop everything to investigate and fix if
CI fails. If I start getting CI failures for other peoples' topics, then
I'll have even less time to do my own backlogged ones. ;)

Right now you are shouldering a lot of that during your integration
runs. And if it were even putting some of your load on me, that might be
a good tradeoff. But I have a feeling it is just putting the same on
both of us as we see the same CI failures and poke at them
independently. I dunno. I'll try it for a while and see how it goes.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B739266597
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309360; cv=none; b=WHA5pWZyR/JPrdMdf19SMhE9VotvOyXDVkARGBDgQFIiJ9Ob2+57VgK9DGm5LvHGSY4nOTPWHBuxhHz1C7dqpr2bMXyR4mBdiTAsfjauvzcTnQmMAP1SJ5IJoctUrMgz8iK/eg0le1eLXm1eZZ0FG7HpSJ8JF5yw5h83B4kAAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309360; c=relaxed/simple;
	bh=ufzjnmXHorLW9WpR9rsyX31WaO+KO0lzYAa6lwrOG5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKt9O0CCTjCz2TjuYtz470m2C4QbgHM3nJALXzWgFq+1NZWJrzARqFQtIYsw6mCaHPqoyIHqp8WHnGCliIhGCOaH41linvHHshMIlsLWE4M+EZ9W/AjhEQAy4I0ajc0+pEKj+7gZrdDPEuUMjV+2IiyH2+TRbU/f6vBsqilOG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SMAGauJN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SMAGauJN"
Received: (qmail 20630 invoked by uid 109); 11 Feb 2025 21:29:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ufzjnmXHorLW9WpR9rsyX31WaO+KO0lzYAa6lwrOG5c=; b=SMAGauJNInqEbuNxZf7VtREk8d6yDCI3cHD1vOtqToZp2trKU3uVRnlB7gqQcwb+LL7soPTBDdrFPX3bivz8Iu2ninmYH2sJMbnLD/He6TfVyDFRRXh81SUWqbgLV9vFlWAY7jQ3sGPaKw5cA/e0y2BO+3jtB+wZkPvBo9p8kDjwJu1dbUqNzTXYP1EgJfJLU5r9fnWt9TxiyrIGBbuyqviuD8O/rZq9vT+0S/Lv1gNQIS0d1D2fC3OAhDSWBBft+3USblYaPFfIUZVSS0TFiExRRkl+5qFFWpZGflrqDoeAzpJVPy4kX3YqQ83kgeIVMTv9pbNC+Vb5ZvAC3kP7Vg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Feb 2025 21:29:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12806 invoked by uid 111); 11 Feb 2025 21:29:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2025 16:29:12 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Feb 2025 16:29:09 -0500
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Emily M Klassen <forivall@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] revision: fix missing null for freed memory
Message-ID: <20250211212909.GA3113114@coredump.intra.peff.net>
References: <20250208061702.88469-1-forivall@gmail.com>
 <Z6sCeYmljrqWRFnS@pks.im>
 <CALnO6CDHZerHKaWwGc-9CmwEMiFVY+Ds5-GNWYKUi1yO7=U_Rg@mail.gmail.com>
 <CALnO6CDdJ4abqxZKMaevPO+aCzSqriM98JuVOX068gQrxWZt5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CDdJ4abqxZKMaevPO+aCzSqriM98JuVOX068gQrxWZt5Q@mail.gmail.com>

On Tue, Feb 11, 2025 at 03:22:28PM -0500, D. Ben Knoble wrote:

> 2.{30,35}.0 fails to recognize --no-graph, so I checked "git log --grep no-graph
> origin/master" with "git describe --contains" and decided that 2.36.0 was first
> release recognizing --no-graph, but it didn't build for me (possibly an issue on
> my end). I got 2.37.0 built, and it was "good," so that's where I started.
> 
> Here's my "bisect run" script.
> 
>     #! /bin/sh -x
>     make || exit 125
>     # segfault has exit >128
>     ./bin-wrappers/git --no-pager log -2 --graph --no-graph --patch
> --cc || exit 1

I don't think this is quite enough. The problem is a use-after-free, so
the behavior is undefined. Depending on whether that heap block is
reused, it might work just fine, or output garbage data, or segfault.

I'd have _thought_ it would usually just segfault, but it almost always
just output garbage for me. Building with:

  make SANITIZE=address,undefined

is a good way to get reliable results for this kind of memory error.
Doing that shows that v2.37.0 is actually bad. And bisecting shows that
it has been broken since 087c745833 (log: add a --no-graph option,
2022-02-11), which is not too surprising.

> The --cc is important, since this repro logs from where the bisect is! Without
> it, if the head commits are both merges (likely), the repro will accidentally
> mark the commit as good when looking further for a commit with a patch will
> fail. Omitting -2 might work, too, but that makes "git log" take longer.

I've also run into non-determinism when bisecting like this, because my
test command depends on the value of HEAD. The best solution here is to
just feed a stable tip to git-log. I bisected on:

  git log --graph --no-graph --patch origin >/dev/null

(I didn't need "-2" because good commits failed with "unrecognized
argument" and bad ones were killed by ASan immediately ;) ).

-Peff

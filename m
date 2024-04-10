Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46838168DC
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772368; cv=none; b=V0m/ZW9T63RQjGCmVoB7uy2zsz6WdTN+UT22kGax6Y3pVvzTl3jSq9KohGMKJDKKnIs7MUf+A5QRtkb+MGpgLXGsk7oSk1E/TKPLo2Zsk0mJ2sFllztiw13SPLXfHU2uhmJo8NqQxlrzo5uN4BozT/57iAmY8BQWuqGOaTh15Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772368; c=relaxed/simple;
	bh=mJ8CWkOdoc1opMPef2fs9GEK9z9a/yaF87shyoM7z2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLF0kCwd4vLc0qYf2UZn4KG5soME3tqSsF4prps21ZyxcPzpXgZiZA6Lkyx6JHoWWMzL/liXxTKb/eEJwJEur19YdIyk9+XcegeqSzJrhoadweKHg5FWPK/GUCZaoye6fnTXbkHtkdvAKCqA1gKZQRCJVDI2j6aJ7nwtcQPYpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15630 invoked by uid 109); 10 Apr 2024 18:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Apr 2024 18:06:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18365 invoked by uid 111); 10 Apr 2024 18:06:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Apr 2024 14:06:06 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Apr 2024 14:06:04 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/24] pack-bitmap: drop unused `max_bitmaps` parameter
Message-ID: <20240410180604.GC2260545@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <c6a08dae037351f0a5ba8f1044837c894c471b4f.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6a08dae037351f0a5ba8f1044837c894c471b4f.1710972293.git.me@ttaylorr.com>

On Wed, Mar 20, 2024 at 06:05:11PM -0400, Taylor Blau wrote:

> The `max_bitmaps` parameter in `bitmap_writer_select_commits()` was
> introduced back in 7cc8f97108 (pack-objects: implement bitmap writing,
> 2013-12-21), making it original to the bitmap implementation in Git
> itself.
> 
> When that patch was merged via 0f9e62e084 (Merge branch
> 'jk/pack-bitmap', 2014-02-27), its sole caller in builtin/pack-objects.c
> passed a value of "-1" for `max_bitmaps`, indicating no limit.
> 
> Since then, the only other caller (in midx.c, added via c528e17966
> (pack-bitmap: write multi-pack bitmaps, 2021-08-31)) also uses a value
> of "-1" for `max_bitmaps`.
> 
> Since no callers have needed a finite limit for the `max_bitmaps`
> parameter in the nearly decade that has passed since 0f9e62e084, let's
> remove the parameter and any dead pieces of code connected to it.

Great, I'm happy to see dead code being cleaned up. And thanks (as
always) for digging into the history to explain how we got here.

-Peff

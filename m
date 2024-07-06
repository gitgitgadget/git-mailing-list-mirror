Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C019BBA
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247225; cv=none; b=GI7TyjDaYb+pu9rBwFWUZiq/qUnDKNmXnEbeYuadXrfGg41yL/xepfN/yJFSyc9wm3yWMnGz65W49ll50j/t4aejbQNBng9im9quDvLqKeXuve0TBYs7UsCLKC6pQiPBC6Ulz3KNSr1K3mZYcQpkANq4mib8jXYnZv+0RPjmj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247225; c=relaxed/simple;
	bh=fxN1dqLyqv0TQ2lkjG4uqFolzUykz8JDCbUu5+exmlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr5SdEOF3+dYHWDOJNy9bBTsENuaTcE53HeaALt3690qlz3xdOvV/EbGWb4ajJ4Iahu3XINYU5ggX3jtsQJ6Y47MokPiZZFVsebaq2r7i1rmg+BRKpazcMgkN1IjHMof2F9DBZhaN/4s7/0Sfr/SkXXaKW2t0oETYh6uZoIO4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23711 invoked by uid 109); 6 Jul 2024 06:27:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:27:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31364 invoked by uid 111); 6 Jul 2024 06:27:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:27:00 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:27:01 -0400
From: Jeff King <peff@peff.net>
To: wonda-tea-coffee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, wonda-tea-coffee <lagrange.resolvent@gmail.com>
Subject: Re: [PATCH] doc: fix the max number of git show-branches shown
Message-ID: <20240706062701.GC700645@coredump.intra.peff.net>
References: <pull.1757.git.1720046185710.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1757.git.1720046185710.gitgitgadget@gmail.com>

On Wed, Jul 03, 2024 at 10:36:25PM +0000, wonda-tea-coffee via GitGitGadget wrote:

> From: wonda-tea-coffee <lagrange.resolvent@gmail.com>
> 
> Contrary to the number listed in the current document,
> only 26 are actually shown.

The commit message would be a good place to explain how we know "26" is
the right number. ;)

It looks like this is computed at build-time based on FLAG_BITS:

  #define REV_SHIFT        2
  #define MAX_REVS        (FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */

That's defined in object.h. Looking at "git log -GFLAG_BITS object.h",
it seems it was 27, then 29, and now 28. So I'm not sure how it was ever
29, but 26 makes sense now.

It is unfortunate that it _could_ change again without us realizing the
documentation is now stale. But I don't think it's something we'd touch
very often, so this is probably OK in practice (and as the TODO above
those lines says, ultimately this should use a commit-slab to handle an
arbitrary number of refs).

> Signed-off-by: wonda-tea-coffee <lagrange.resolvent@gmail.com>

We generally want a real name here, since this is certifying that you
agree to the DCO. See:

  https://git-scm.com/docs/SubmittingPatches#sign-off

-Peff

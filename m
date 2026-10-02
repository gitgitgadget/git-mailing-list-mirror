Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E71F3B85
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979573; cv=none; b=j0EC+66expEW8QS+/10d0L15qZ8JYRNKOLrC2ez/BTWUfUZ7Cqzuzz4Y+TQm6aRZF7qNKmsFHHI9q1pJNjr40lv4zbA9nAlf+adx6wJnks0fndhut5oj4I8onl6wCL9vX+Z2Uu2lOJ2WleT6fNnbyOzCnjdsECD7a2O6yAijkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979573; c=relaxed/simple;
	bh=O48t3mFit9Glssv3BdGfJvE1ws8aW2dQvAjDr9BVdYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2uTCENaHpFME2zr3wwPhlZHcrZbIwdSZlssX3TcmykP5lf526yqLwU3rBldNHz07jmrMcPNfTXIuXLWzG5vmt/R2FGqQWfvdQf1YbGBme4bilDRPbQ2drUF8A6dLeHDtVRhY4DGeUUAxVZ4VfVZxTBNaG9V8b3Uc/60niYD+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fa43zmn8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fa43zmn8"
Received: (qmail 16622 invoked by uid 106); 2 Oct 2026 22:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=O48t3mFit9Glssv3BdGfJvE1ws8aW2dQvAjDr9BVdYs=; b=fa43zmn8XIi6aL9Yc5K9dmykgNuAv2Yx5IXnbCXrZDJrGSbPJ8Eyj5IJ8R2pDMSj0QOz9LBVsJD5QHSqR0ppUNu5T6oYl0F4i2ZIronuq1hBVb1JCfYeWq0nUGSKCYy/ml9CuXTv/mb/66qVNaM6hUIpprfoipfFHfO76f1cjV0sRxOCvxD1uqd8fbx4XWjjNOhrthmIkzwryF5i7IKxRV+QyTV/1OTy9K95D7TOFnyPaYDPR1vb4edWLSH8T4KJzcZPx0nLUSIJkKDhs1ev0YmZ7ORzYGYauN0Y6TyJmpxYlGg39uzHGVo6/wSSDqiscFJi4MvjbxtOAIKAefIppA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 22:19:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48577 invoked by uid 111); 2 Oct 2026 22:19:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 18:19:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 18:19:29 -0400
From: Jeff King <peff@peff.net>
To: Pierre Bruno <pierrebruno@hotmail.ch>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Windows: ~1 GB RAM per git process, many concurrent
 (2.56.0.windows.1)
Message-ID: <20261002221929.GB833115@coredump.intra.peff.net>
References: <BL0PR05MB5603A8CE8FD78127FB810BE2D8892@BL0PR05MB5603.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL0PR05MB5603A8CE8FD78127FB810BE2D8892@BL0PR05MB5603.namprd05.prod.outlook.com>

On Fri, Oct 02, 2026 at 11:04:00AM +0000, Pierre Bruno wrote:

> On Windows, git status-type commands use about 1 GB of RAM per
> process, and dozens run at once when I use coding agents (OpenCode and
> Oh My Pi) in a repository. CPU is near 0%, disk I/O is steady, and the
> total is several GB. Since two unrelated tools cause it, I suspect git
> or my repo.

Is that counting shared, mmap'd memory? Git will mmap the on-disk
packfiles (or on Windows, CreateFileMapping/MapViewOfFile). So if your
repository has a 1GB packfile, that could explain it. And it can lead to
two unintuitive conclusions:

  1. If you have several git-status processes, they're sharing all of
     those pages. So it's still only 1GB of memory use.

  2. Git will make a large map and assume the OS will fault in only the
     pages that are needed. So you may see a large virtual memory size,
     but a lower resident size (these are the terms I'd expect from
     "top" on Linux; I don't know what terms you might see on Windows).

You may also see a large resident size if the OS has faulted in all of
those pages (e.g., due to other commands). Ironically this is a sign
that you _don't_ have a lot of memory pressure (otherwise, the unused
pages would have been dropped). Again, this is coming from the Linux
side of things; I don't know how aggressively (or not) Windows is about
faulting in or releasing pages from mapped files.

-Peff

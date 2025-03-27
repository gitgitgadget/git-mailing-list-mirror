Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9701E505
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057314; cv=none; b=PE79vLULySMpjXGo4x8S/NyvZVOOYwdEQP+gGC8Qtqi5CNQc/jVpmo4c38DIcQ4UZqvGHV6zv0VoIld1drwg58cgajZ4pyJgS6xd0vX6KRn2EUFl1dmPiqN0/IZJ+bzCam3iiQ1VQqpymDJEfT28te2e9TH3JQPfzW0OZzOCyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057314; c=relaxed/simple;
	bh=j19IxQXVNKCEP0pRatXNGThnPBiJnzZhTiXh8P9W6fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXEtU4HTXLY1+GeLDUokFVBKyN0a6vHSsUVZM/3XO/6vSy02kf+fylPripNBhiadc+1vCtRxLvY/un6DZzV2Y9XZeiCyVuNizGFDW/F9u58HVjlVIfjKcpNSMZ2F2Qq0n3QFaujhiq0zNzAJ1CHr4Up0BjfBSGTC5COuvKUplKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dp7PRx7E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dp7PRx7E"
Received: (qmail 19477 invoked by uid 109); 27 Mar 2025 06:35:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=j19IxQXVNKCEP0pRatXNGThnPBiJnzZhTiXh8P9W6fY=; b=Dp7PRx7EHrSFfF8z/x+wOC2DvyJGAqC8B8jpsjDBt33BzqvCUa0hYHIZipkFAPmu2Ffn3D26W57jsnAjX7Lvse4s0WHwRoOHgOFoXOrqbmod/9aUhfp4fJb3eWRW8vxsmEVgXyFvpnTaflNDWlXpo6Kuua7uq2n0IanNBpuEW26OzGhMi96vmh0T75dz1tvwHA4P0EJijyy7rt1oeCEtbWzGmRNLKPekw08vFU1ZRWosrLBEtrOo/dMjHVGCYahQVpV20q5PfU9yknflCr4pnyx57u5U1aqzM1SFFok9nmclcTJmVGcWhPmsCKFZ6RbVcH7qPoOwlKk5wx6a8roc+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Mar 2025 06:35:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27868 invoked by uid 111); 27 Mar 2025 06:35:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Mar 2025 02:35:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Mar 2025 02:35:10 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] detect-compiler: detect clang even if it found
 CUDA
Message-ID: <20250327063510.GC3042475@coredump.intra.peff.net>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <2f6f31240fe6ce5f8efab662af477540a0f966ca.1742945534.git.gitgitgadget@gmail.com>
 <20250326174127.GA2508080@coredump.intra.peff.net>
 <CAPig+cR+ESNg4tV1G6jbKKeRKABD053qZcG0BoFuQ7aC+1tGYw@mail.gmail.com>
 <20250327051419.GA3042475@coredump.intra.peff.net>
 <CAPig+cTmcPY9XDJcYc8s+O+a78x5vwBXV76tw7+S2wbOaMAMyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTmcPY9XDJcYc8s+O+a78x5vwBXV76tw7+S2wbOaMAMyA@mail.gmail.com>

On Thu, Mar 27, 2025 at 01:21:03AM -0400, Eric Sunshine wrote:

> > I think just "/foo/p;q" works on GNU sed, but no idea if it does
> > elsewhere. What you wrote seems the safest.
> 
> That's not quite the same, though. The patternless `q` will cause
> `sed` to terminate upon reading the first line of input, not upon the
> first line which contains " version ". This matters, for instance, if
> the first line output by `$CC -v` is not the version string (i.e. it
> might be a copyright notice).

Oh, duh, you're right. I even tested to make sure were still quitting
after matching, but of course that is because we were quitting even when
_not_ matching.

For some reason I also thought /foo/pq would work, but it doesn't. I
wonder if it used to under some implementations, or if I'm simply going
senile.

(The point still remains that what you wrote is the correct thing).

-Peff

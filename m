Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C622F767
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441369; cv=none; b=TulMZQ+q/ZBCWCORk3iHC+eC2/xpX5DgH6ogKAmINRepMXp3VvUjdMhVHGj+QLYfgReT5ROV++HLLfh2lNzi06XF0YxIc/c3tVxmm6aWqOPtzQ2liVWE7bDQFEsOfxxTwhthxtAWBfeNtkmcMQ6n2gobrhI7eey8+EGkUQMPhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441369; c=relaxed/simple;
	bh=PD59hMYRRbaN5NLxwNwhFZkvClRyGXUSxmwW+aD5taQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/6hI+VFynhMVLRKGjUNfHWBwCfxjNGbK27icPz6Y69tLzAu92pNXqAcMOVkqMKvGPxCx9kSZkJ6pb93EbE0iAdyymnbbQv6WP51Oz2xI2Hd6XncU8x22lVULAHHTPjFbtOEwMZa6upxNFZNUIhUMJU/4Xf1BzkwfJJg/RdB6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CbakxcdG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CbakxcdG"
Received: (qmail 26126 invoked by uid 109); 25 Jul 2025 11:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PD59hMYRRbaN5NLxwNwhFZkvClRyGXUSxmwW+aD5taQ=; b=CbakxcdGxkJbMtAS1SbPw0nrwL35Ku7qDDjbOcRAthgtz+1XSXLpzygPi72pKROi3fYAoeOTPpjdpFgxPz2WzPv/nHXSRpYSpLzEqBCamTYy+dGdygsqy7u5mxotCJfLexgUsrWaX4I8fD1yr6mlfYPlk+DljTk5leqS60dyO/5ZTfBGer6bhCvYibRwQtXRSd/a1I2dJ5cfV+CRGJZkuYnMPX4tVrQDoIzcNqtWo12mrDTbyWrVNhnGO9I16rZyQsj30ZMLwgrsQieqmldbrN6txjvNmQ8EhCN/SGjIVpqMRE+nBOjV39QuCYaaIH/6nuvatcSpMCILFyrVnfpg/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 11:02:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21008 invoked by uid 111); 25 Jul 2025 11:02:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 07:02:43 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 07:02:43 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <20250725110243.GA3014187@coredump.intra.peff.net>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
 <20250724104536.GA1316505@coredump.intra.peff.net>
 <aIIf7S5iPspktxdw@pks.im>
 <aIIvHxR8wXLTCgMW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIIvHxR8wXLTCgMW@pks.im>

On Thu, Jul 24, 2025 at 03:03:27PM +0200, Patrick Steinhardt wrote:

> I've quickly hacked something together now, see the work-in-progress
> patch below. The patch does not yet handle reflogs, but that isn't too
> hard to implement.
> 
> And these changes indeed speed up things by quite a lot: instead of
> hours it now takes 7 seconds :) I'll polish this patch series and will
> likely send it in tomorrow.

Cool. I agree with all of the pain points you outlined, and the general
direction. There was one other sub-optimal thing I noticed, which was...

> -	refs_for_each_ref(get_main_ref_store(the_repository),
> -			  read_remote_branches, &rename);
> [...]
> +	result = refs_for_each_rawref(get_main_ref_store(the_repository),
> +				      queue_one_rename, &rename);

Both before and after your patch, we're iterating over _all_ refs and
skipping ones that aren't in "refs/remotes/<remote>/". If we just ask to
iterate over that subset of refs, then we save the effort of iterating
over the others that we don't care about.

But:

  1. We have refs_for_each_ref_in() and refs_for_each_rawref(), but no
     refs_for_each_rawref_in(). Feels like it should be easy to add it,
     though.

  2. It's an obvious small optimization, but it doesn't help us in a
     big-O way. Iterating the refs is obviously O(n), and in the worst
     case rewriting the packed-refs file is likewise O(n). So I wouldn't
     expect to see the dramatic improvements you found by removing the
     quadratic bits. But I'd bet it's still measurable in a repo with a
     lot of refs (and maybe with reftables it actually would be bigger,
     since the goal there is to amortize the rewrites).

-Peff

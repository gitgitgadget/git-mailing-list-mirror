Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478C3D5240
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035725; cv=none; b=WV5F18rrtlHJf+jzXOhdQ1Hj4d3LdZJXFtcUK/fUbQZSP9Nu/usnCVCR2RUzyCjTFn6HOAHuD+yyR5Ol807Yj3lx3dIAsL6z+1mXCZs1Hu1NR6ULFcF0mZHc7o7WeVrvc1Y2FpBKH+k+5l24ElZ84qBn7/lshrN+sEG/+J1VjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035725; c=relaxed/simple;
	bh=tK7v/znSlef3TNmYujna4fbqV34wotf1Cz53UFewSz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxWb31iCHIy8v/N9lPU9mBZLtVWSDhtbl6b+6JWz6Sg1W7kWwMOqQUKjaaHe5Q6X9RKiBgBsDkR3TPYdgDPNhb+8QSNqI3ybpJ9LurVcjJb0uCBiLd4v4G93sslpPiEPW1LSW5Ugb0iM9k4A62v7d2BAPqSa7wzsMRWSAUdfcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fKgm2Guq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fKgm2Guq"
Received: (qmail 67603 invoked by uid 109); 25 Feb 2026 16:08:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tK7v/znSlef3TNmYujna4fbqV34wotf1Cz53UFewSz0=; b=fKgm2Guqa+fVoZWomNkCbSPJr8V5Un39rN6Hv8ivmsoDCNEyJfFVdiYookuF/LIfpDvDlp1XhtF3U+/scWQft8/kfmzHjbMI063F0g82mrSW/eWvG1EomAzSozkcxZSeXHfdBD3Swzh3VCmxsPhamJmt+/rFG74YQ4Nw93HVmRmuEBsesoy1r2GbgyagPTrCqVYwJ59uNLJgWV8TBgfTmf4w8sNT947mx3YpgcbKvFUp0nmvMUY21EBgEno0MdCxBHxtMDrGh5cErNaXm7Pf6/jJxIdxfW1fyr2sSt4Iyh6vGyOStFHu6ezoXZJli2QhlZIrpOucEZrkg/bA947nDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Feb 2026 16:08:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 203904 invoked by uid 111); 25 Feb 2026 16:08:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Feb 2026 11:08:44 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Feb 2026 11:08:42 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
Message-ID: <20260225160842.GA2160019@coredump.intra.peff.net>
References: <xmqqms0xeqaq.fsf@gitster.g>
 <20260225102228.95152-1-haraldnordgren@gmail.com>
 <xmqqzf4wbzev.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzf4wbzev.fsf@gitster.g>

On Wed, Feb 25, 2026 at 07:44:56AM -0800, Junio C Hamano wrote:

> > I worked on this feature for 2 months, and then it got marked as stale
> > instead of being merged. Will this time be different?
> 
> A topic becoming stalled is something the original author can (and
> has the primary responsibility to) avoid by keeping the discussion
> thread alive by responding to reviews, pinging the thread with
> comments similar to "now I think this one is done, all comments are
> addressed by either updating the code or replying why we would not
> want to go there (which the reviewer who made the comment hasn't
> responded yet, so the ball is in their court)", etc.  Even though I
> try to help keep the ball rolling by pinging discussion threads that
> smell about to go stalled from time to time, I cannot guarantee that
> it would not happen again.   But you can help ;-).

To be fair to Harald, he did ping a few times, but I think was just
unsure how to proceed after the issues raised in the last round.

I think what would have moved things forward more than just a ping,
though, is generating a plan for moving forward in the face of confusing
review. That can be quite hard for first-time contributors, though.

That was why I tried to lay something out in the last email. I _think_
it would not be too much work to get there from the last iteration. It
would mostly be removing code/feature that we're not ready to commit to
yet.

-Peff

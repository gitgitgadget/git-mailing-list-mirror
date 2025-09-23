Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0E2BD11
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588493; cv=none; b=T6Z4mZ0SmFO8Uji6GGV0X0icRmzxgHQcc61A1y6hVuS2zuJsDK4ygCR7c4GyyT3BBmsO1KYR1qKFaznDpGE9s32cg2rAKroU1xAmR9FeOKzdcYtxi3Hmv+R0ggBH8gRlc4qPSR+AuI/f5u8egH/LsJOCNz3kGjeI2Jea9tUCc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588493; c=relaxed/simple;
	bh=UnOSQvO0cL5xk47iVUNeZ4FDfF90IttUX9XsgJgh5zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZnwqSv8q+feI0CIOCp5s7hwdWlBRBmFXrWVzM+nVUBCIHqsrlrbnyDeN0YYu/5Pd+7ZaXYJ+S2u1gZN6UOHdQz6H5weUDv+cuM7gZVLOO0QXzqK61Bw0n+Pud2hpLtx1Ls0FaZ8MM1aEXNEGeOFFqgnrZTqp0ncR+wnZNmX8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ISfWkXxP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ISfWkXxP"
Received: (qmail 164487 invoked by uid 109); 23 Sep 2025 00:48:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UnOSQvO0cL5xk47iVUNeZ4FDfF90IttUX9XsgJgh5zw=; b=ISfWkXxPaOG+gwKKyQTIKaFOj0/Hd6M2eTUbMjKb5iUzd466q+KsGSFARSxDK81to9utA/KnxVfuDvXTUgiWldQM7NM7pNVxILcoCNKbeX7CeBs4+Wu4KSZHWWlVbY4qnwe8S42tQR+dXgWeBfiNEii9U7J6Enc2jbk3DeH2LaADczpg7h8AB6jbhDQpVtlyjbOOodx7KV7XvXSRhhPAt443EoM3xoxK0Q0b0nhUah33YfaOcaXZF3NIp/ZKmzS9xtkHPNsRXQqoYoMYTr9tEemANVMGd578H43edEhCsNxLNGBLROfNJRbXn4OItucf6+l9tzddFhfAqkvXv6r5Zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Sep 2025 00:48:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 263380 invoked by uid 111); 23 Sep 2025 00:48:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 20:48:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 20:48:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/6] stash: tell setup_revisions() to free our allocated
 strings
Message-ID: <20250923004808.GA2271307@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
 <20250919224027.GA594545@coredump.intra.peff.net>
 <xmqq1pnywkwv.fsf@gitster.g>
 <20250922190555.GA2205919@coredump.intra.peff.net>
 <xmqqikhath3d.fsf@gitster.g>
 <20250922202509.GE2205919@coredump.intra.peff.net>
 <xmqqms6mrxez.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms6mrxez.fsf@gitster.g>

On Mon, Sep 22, 2025 at 02:26:44PM -0700, Junio C Hamano wrote:

> By the way this also solves the original "git stash show -p --invalid";
> do we want to credit the bug reporter and mention that issue as well?

That's not handled by this patch, but rather by patch 2 ("manage memory
ownership..."). I put this one first because until we start setting the
free_removed_argv_elements flag, that second patch won't do anything for
git-stash (and I don't think there was a way to trigger the problems
from the other callers which did set it).

That patch discusses the original issue, but yeah, it could probably
stand to have a:

  Reported-by: Lauri Niskanen <ape@ape3000.com>

trailer tacked on.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A025B0AB
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611582; cv=none; b=ooikkhW2h6O6nXPMcd0E4TsuWAGfTCqDQFYCJJbhJaDwLLfrCz9R9RjE7ofQfCdmB2DN5UalAmqNHXEEjIJhODPLXi47wEtJ8i9HdOut9u03R0sVXVvACxWfKC30AAL8kieJR6jZhjRJO+IegC2VloacRYXCtpdM2CXOEGbiQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611582; c=relaxed/simple;
	bh=V/H435F6ABBwVJtFWIBX6ksiohTYM6fdker65fI+xU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XALzACed1sCEq4zGVgWzgKehJuiFpqWq6N9OuY7RXfcsiCVbdALJOnXMm6G/VOhpgAqkzoEkzUErsmgCWh2w3xjB8+F6Cw3YH5LvYDuuES0BLquYQj/0KIk3h/UctrxKiRv5nZIAs8qUJnhNI9HmXtZdRMmSWMtYWqkl4vS1BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bEWuNy9g; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bEWuNy9g"
Received: (qmail 28948 invoked by uid 106); 12 May 2026 18:46:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=V/H435F6ABBwVJtFWIBX6ksiohTYM6fdker65fI+xU4=; b=bEWuNy9gFyiVlmG75E41O2hMuAMc0XeSFm1uCh/7eK4g9vmoCqi2mL18hlbFFcHd6GLXpR9lxBd06kUVx+UWYYtdgFGTtXS3cDnSvJjiuPN1JThPrZoUT8BnTyV4D20ijM7r0oBExwgFVKAIBXgXjrdUcUMHy68ITuKWuMQpspjwqxLaEEVrJBjKrVopRB1JEcho/csMXpu0Udo9YYG2sKut3egCk1SHtLOFJ1MeR7yHwV8bPE5kVqwWvwvLCw9uqxxsgIudEsYB/cyUS627G4bAv5uAQlZCP3iArwrVs7IGv/dAsXikPBAUNj394rQZ2opaAP2Rqh6BNplAhqsqNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 May 2026 18:46:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 52524 invoked by uid 111); 12 May 2026 18:46:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2026 14:46:19 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 May 2026 14:46:19 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] cat-file: use strbuf_add_uint()
Message-ID: <20260512184619.GD70851@coredump.intra.peff.net>
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-3-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512115603.80780-3-l.s.r@web.de>

On Tue, May 12, 2026 at 01:56:01PM +0200, René Scharfe wrote:

> Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check='%(objectsize)'
>   Time (mean ± σ):     751.7 ms ±   1.5 ms    [User: 733.5 ms, System: 17.1 ms]
>   Range (min … max):   750.5 ms … 755.0 ms    10 runs
> 
> Benchmark 2: ./git cat-file --batch-all-objects --batch-check='%(objectsize)'
>   Time (mean ± σ):     720.4 ms ±   0.4 ms    [User: 701.9 ms, System: 16.7 ms]
>   Range (min … max):   719.7 ms … 721.2 ms    10 runs
> 
> Summary
>   ./git cat-file --batch-all-objects --batch-check='%(objectsize)' ran
>     1.04 ± 0.00 times faster than ./git_main cat-file --batch-all-objects --batch-check='%(objectsize)'

Neat. It is sad that sprintf is so slow that this makes a difference. ;)

But it seems like an easy win, and I would argue the resulting code is
more readable here.

-Peff

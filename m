Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB08392820
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973274; cv=none; b=YVqpC7+d8k9wH32EoCDdwiDzDI3Ty62kbIzhBffQVI/MZXjo6X9VcasXRiAPuAQswXWgYuWrWXXiPBEkj3g2hP6HGrxvIxWc92Q3JKvq+SBviu2JScrlmrmqGqBS3lTeG44sTMpK9H0rYpr+Jx1WlpBYCB/V82O0KLD+sTnaFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973274; c=relaxed/simple;
	bh=JqyuXRdaFyLgZwMHsGx5tJ+3pyDxGLNxCsmdgzs5UVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laBjk6M2AmRK3kBgVLh6FpczE/NwgNnIPI9lmX5mwfLIE8uVAW1mDfQzlSLzSY5zGDLt7q7DBg0gT01miP25EFl6iHK/kybq+oTYwdDlmvd4pcbuoo4TUmivS7mFKs2eqblxfTBubaz2DoaKZh6pa97WogTX/h0T7aA9E1xG9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dpvb0wTN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dpvb0wTN"
Received: (qmail 119306 invoked by uid 109); 21 Jan 2026 05:27:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JqyuXRdaFyLgZwMHsGx5tJ+3pyDxGLNxCsmdgzs5UVQ=; b=Dpvb0wTNTCSUP69nnU+Q7LnLsuPr4IoqwUwQjz4YbgbN/WoSKAZRIlu5ltY+YMzkIPx3g8dhainFjsPg7/hFCGm0/z/K6wWpCY5dH8o0CbsiYh5BUhCYg3yziN6NBgolRvTsQepeFYzBGrB14eBemSrqwcdcuFlitsG0ykdnh32r85zv3C8PVc1XQljHoRbrCeCcWXS/gxLwBWhQ0B6IYDHrkaJZKpZj/99LbHcHNk2EynSUjooXajgaONHD6buWNokJfYVnIqNfaqm6xFJw4R1s510pGTI4FXafWhMcSFIbGyYxtK4kYMfCBLgwxZYYCHx1XMnQhXvHB+8h7banAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 05:27:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 193321 invoked by uid 111); 21 Jan 2026 05:27:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 00:27:54 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 00:27:50 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/4] parse: add functions for parsing from non-string
 buffers
Message-ID: <20260121052750.GB567009@coredump.intra.peff.net>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131537.GB199335@coredump.intra.peff.net>
 <4d83375b-76e2-4420-80dd-6a04d3201532@gmail.com>
 <xmqqldhsxawm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldhsxawm.fsf@gitster.g>

On Tue, Jan 20, 2026 at 12:54:33PM -0800, Junio C Hamano wrote:

> After this message, the discussion stopped and the topic has been
> dormant since then for a month and a half.  I'd drop the topic from
> 'seen' soonish but that does not mean an improved version of this
> patch is unwelcome.

Yeah, it's been low on my todo list since then. I think it is fine to
drop it for now, and I'll eventually get around to re-rolling.

-Peff

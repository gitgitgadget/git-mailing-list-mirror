Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BC4499B8
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783756877; cv=none; b=Zf+jJDUf+DZgIFhNwuNPaQY5WrCqk9OSbaVk78akHtPUqr8hXNV4lDJ2Gtrl+foi1Kjx4DrD7raIVlXb1k99xILImNInLyJdZ5+Yd5rll6KUXBIMMfqHScAq8mbALCTJ2X9BPnpl29U43HMnIvqHFeQc+KUwyF3WRJ2w1Fm3ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783756877; c=relaxed/simple;
	bh=ySd/TPm1aySx86sNSS+5nh6wwauwd9JogCKFpO8xMxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1K5FxNax2uOCxQQgEKC7omv5Bj8DHCTn7HwNuMqEiyWtEIgAPzT5tdYlT2mikI23BrSHo2Cv1VtnNQFtD8chS2fCNJuTMUB19o6UX+GMv18fe5PgtcMlaEjNc197JhHRBQ6tMWTTmn3aEOHRE1+TEnZR1P1Q2Dp3uFRuMSZ5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aNNovB//; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aNNovB//"
Received: (qmail 55794 invoked by uid 106); 11 Jul 2026 08:01:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ySd/TPm1aySx86sNSS+5nh6wwauwd9JogCKFpO8xMxw=; b=aNNovB//adwlJbogMTIkHxRNGoLkjYmnHIBMwamlwT4darU1MKX3ZMf/nRaSLYMSJYCvysahrw1Eijr8NUUMqwKuzPYFLEkXUC3Fb9E4IZXneCPxUij+LufR0gnPpFgBYX+CW/X7f4PRiuQoiskNpnCN/wRRHbROlGELwW5hbHQRUcbOLn0shapeGmKFv5kJV7pZOZj8IMb1u20k/P8f0O+xtW+GU9SilJ20kMNF8i21iDSpbGPKn/SmGVmfGgt2oMsoGeEtNwfvM3Kn0qStfp7Vpq17FxDqRYIAKKK8jzXitP8xJVlUHzXCUXub5Aot37EyA25v59L+MHMHsnQiHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Jul 2026 08:01:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 95516 invoked by uid 111); 11 Jul 2026 08:01:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Jul 2026 04:01:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Jul 2026 04:01:14 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] pack-bitmap: allow aborting iteration of
 bitmapped objects
Message-ID: <20260711080114.GA1470749@coredump.intra.peff.net>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-3-3710a9cc165a@pks.im>
 <alFzja98avOoKjQE@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alFzja98avOoKjQE@com-79390>

On Fri, Jul 10, 2026 at 03:34:53PM -0700, Taylor Blau wrote:

> However, the remaining `show_objects_for_type()` callers from within
> `traverse_bitmap_commit_list()` do *not* bother to inspect the return
> value, despite taking in an arbitrary 'show_reachable_fn', which itself
> may return a non-zero value.
> 
> I guess this must be effectively OK in practice with respect to the
> existing code for the same reason you indicate in the commit message
> above, but we should change this function to *also* propagate non-zero
> return values to eliminate the foot-gun completely.

The matching non-bitmap traverse_commit_list() does not allow aborting
based on callback returns, either. In fact, its callbacks return void!

Whichever direction we go, those two should probably stay in sync (so
either both should allow aborting early with a non-zero return, or both
should return void).

-Peff

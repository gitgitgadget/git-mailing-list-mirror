Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926C2F3600
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986232; cv=none; b=I+SKFf3BQTfo4xpvUjXgAzCm9K1qK6osVfMdEljge26e7cXC6GV5q+905mZldeXco6in+vupRTMacmqR5LofXyFy66cxsGg1TaXH9LuJW45mwO8nixTHbQ0YanDiggZchMhQiTGwUTXvx7PNNlazHKwCCJ/aXD9cQTjA6olaZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986232; c=relaxed/simple;
	bh=lCpHNTxy1iv/rDcTEmdt8VplO/YWkXe5Cg4fkR5c6Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8oLlYddPAFF7evk2uhLeIN4+NS+kOQgJsj2PCOh24Q7T4yFYfWsx8c/Jh2Ff9dNkHXHl64b7dMwRfNN2UGWE/WKskr8t3buKvxfgpyKbVjwl2LiukEjSNGa4obaY9xpS4h2pySlr81c+l0TXjEbhjbPB7gR/mWxEutYn1WdK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GW2zUnxF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GW2zUnxF"
Received: (qmail 65471 invoked by uid 106); 20 Mar 2026 05:57:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lCpHNTxy1iv/rDcTEmdt8VplO/YWkXe5Cg4fkR5c6Z4=; b=GW2zUnxFaVN0OIyFErUPz4Lx7BrqElpLW4rdKF/94hwgnkW4QM/DbnAHtnXzHKfcY0++4bVIP5CM5x2C3eD335YqHJC+bT2STrakVotfqA4erUKFzkqWLpACegNf14my2TJF8whaSoaacXGWvRDCalVdGI0E5Qko13w0LIWnT8N5pYXE2S0pMdsQS2tzpkKDx/QpXVK2mR67jlYQomlUFx9BOkBIBX4LeKx/VRPH3G5b8wJxGnxCLe8gpl7AurkRtw3PqwOl3iUQIMQOIeS05/Ae83GaHD1bpkgNDRhCcwBrcyLKmxVQzBRIFQ/BaCEVc/CuIQpSxl1qm4GQR/0gIQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 05:57:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 95774 invoked by uid 111); 20 Mar 2026 05:57:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2026 01:57:09 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Mar 2026 01:57:09 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260320055709.GA35291@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <xmqqcy0zgtmu.fsf@gitster.g>
 <20260320041803.GA18125@coredump.intra.peff.net>
 <xmqq341vgilb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq341vgilb.fsf@gitster.g>

On Thu, Mar 19, 2026 at 10:45:04PM -0700, Junio C Hamano wrote:

> I may have phrased the idea very poorly.  In short, the core of the
> idea is that we do not have to use the original content of the
> strbuf at all.  I.e., "buf" does not have to be anything related to
> sb->buf.

This seems like a non-starter to me, though, as it means getdelim() will
always allocate a fresh buffer, even though we had a buffer it could
have used. I.e., here:

> +	buf = NULL;
> +	alloc = 0;
>  	errno = 0;
> -	r = getdelim(&sb->buf, &sb->alloc, term, fp);
> +	r = getdelim(&buf, &alloc, term, fp);

we will always get a new allocation. And so looping over
strbuf_getline() will incur one allocation per call, rather than using
the same buffer over and over.

I haven't measured to see what the exact cost is, but I know that
looping over a strbuf (with a reset in the loop, or the implied reset
from a getline call) is a common optimization trick that does have a
measurable improvement for some cases.

-Peff

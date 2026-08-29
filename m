Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067038D6AD
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788002155; cv=none; b=NfTGX37GLkVsTyOeZA4CnLnrA99kiaYI2ReUMLE+0vrkBpqXT5DxUMQdoezNArMM8OVIhhaEom8mHK8F/4zWH87EnXXEEeoUfrNhkTA3kz/s0eCstd0FHLB4nvFNujLP+tlj591/VTVCH0x6RIL0VDdzj7IJfTC5fHSqq2gBwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788002155; c=relaxed/simple;
	bh=1AiXh5sLgD9qfShCeLQzcCcln8KjZCDzSqsbIjG+Tug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVkAW9gJNUeivPgUgh921q2cu8wQorGD4scKaxinX2zQrXLYnACPYM0Kxd+6B6B7cpvbPK8077Vma2zDPg0IdG6VcF7FuwzqAbENqCc7HxXelDAtppdyn8klM6AF49v5LvjYX/uwUPb6uF+yzBlrmup5ZqXlycyXwCWBvJqVH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gqWD7TiI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gqWD7TiI"
Received: (qmail 46565 invoked by uid 106); 29 Aug 2026 11:15:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1AiXh5sLgD9qfShCeLQzcCcln8KjZCDzSqsbIjG+Tug=; b=gqWD7TiIEw9nBVlnl6c+uOr4wDgX61ZoIQ5s9GHd2QK3BlQLze18/aTg8g4Fq3ocUrIDYngzhBYPTu54v+v4Q8LoUTwqy0Ud7pKxEd3ahlltgTJKjtxp4gH9T3pOyhkaNwRcE/4Ri/9KtJusGXrGp1uy6W2EoZzl990JiGC0QI6x0KfSOlNr10nA7qKVhFOs8ZPV5QQp1mXZKfxpQUETYmuW7fhxYsnVHI0yFyIsyjQyOHHk2NlfPTc3ub7393qnfxjkriaQu9DeD86tJOB0C7mUTE3BbwmGkYCKzFpV3CkpQjrZsL4b0PLuT1xPlbrqgQsDzzLj631G/rWwPO1kJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Aug 2026 11:15:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 83595 invoked by uid 111); 29 Aug 2026 11:15:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Aug 2026 07:15:50 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Aug 2026 07:15:49 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] die_for_incompatible_opts(): unbounded number of
 options
Message-ID: <20260829111549.GB40814@coredump.intra.peff.net>
References: <20260826233152.1703497-1-gitster@pobox.com>
 <xmqqbjana2wv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjana2wv.fsf@gitster.g>

On Thu, Aug 27, 2026 at 10:28:32AM -0700, Junio C Hamano wrote:

> +void die_for_incompatible_opts(bool opt1, const char *opt1_name, ...)

I'm mildly negative on this, just because there's no compiler support
for making sure there is an EOF somewhere. Keeping patch 1 and using
LAST_ARG_MUST_BE_NULL would be preferable, IMHO.

-Peff

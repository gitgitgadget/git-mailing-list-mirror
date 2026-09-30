Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A454472F89
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808106; cv=none; b=uAS6eO/sBjfesmwxGJxYfIX+ZOsberum+VWKsSNK8I0I1af9qmeYxUFiF3iApB6k4/1E4X9ysWTn8G9igthYthlKiT+NPxMxPfXN29qYT1jXXCNEzc58GM6fiF0RQuKsa5Oz4L15yGJXsGS8cQGyjKhc2PYd8lhomX2XRdyq5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808106; c=relaxed/simple;
	bh=WuhKKIImUcH2ZAJt6/9/9uAXz6XUkyDh1Fdom9lc3vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx9gapI4yTKx87ayOf4ZpbGoXtyygxB0QGd/GQYHDaznnJBj63crpmYmbISGZyLM3VpOu4Nz2l6JIdXWDBtRNbZDmqM3ljyFeo6dU2CwAIyVTQPUuRClyyz8iN+W0jiXgs519BeyKnkUKEvdI4yreyEEAzkUUuydXMdDkSymQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VTQ7Sctj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VTQ7Sctj"
Received: (qmail 7934 invoked by uid 106); 30 Sep 2026 22:41:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WuhKKIImUcH2ZAJt6/9/9uAXz6XUkyDh1Fdom9lc3vI=; b=VTQ7SctjbKBBk/t/LSEHgflwFcAqDaLdgQXHfWHFRV2t5/9EpV8zk2ScWT+q5HDFVtq5pLKvpMMlQ8d7Mk5pXi+Krb4oyZBXiPBDSlU8BVHf64EAUH+CYfyyES7Ml2wNP9/ASomS6SI+FHOCUzbg0olbnV4psnS8n85z+/XbTYpdG2NWwMHjJIYgilTwSLai00MHM26U2meNR/7WgrmzbzMxC703MDcCyVbcqioAkIfKmHH21SD16zJ3U2RYJ6Xu5Rf+TnFD2BzVFLDteCueW2wOSrCBTRfxWhiTdH3kq71joJtHFSU4cHM4zZHoCFNhxYQxvSKp+celjJ+Zm/wn0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 22:41:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19964 invoked by uid 111); 30 Sep 2026 22:41:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 18:41:45 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 18:41:42 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/5] merge-ll: report an error when reading external
 merge results fails
Message-ID: <20260930224142.GB763270@coredump.intra.peff.net>
References: <20260929204157.GA1733321@coredump.intra.peff.net>
 <20260929204421.GB1734030@coredump.intra.peff.net>
 <xmqqv77neowx.fsf@gitster.g>
 <20260929214943.GA1735259@coredump.intra.peff.net>
 <xmqq8q4ibouf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8q4ibouf.fsf@gitster.g>

On Wed, Sep 30, 2026 at 11:01:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's a resend of that final patch (not just a squash, because the
> > commit message mentioned the chmod).
> 
> Makes sense.
> 
> These 6/5 and 7/5 are probably better squashed into 5/5 than left as
> "oops that was bad, so here is a preliminary clean-up to make the
> fix easier (6/5), and here is the fix of the fifth step (7/5)", no?

I don't think it is the fault of 5/5 at all (which carefully tried to
maintain the NULL behavior). The problem fixed by 7/5 existed before my
series.

In theory that fix _could_ come earlier in the series, but it's actually
much easier to fix after 5/5, because we have a single spot to error
check.

-Peff

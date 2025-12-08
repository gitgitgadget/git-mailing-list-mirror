Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7811E6DC5
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225991; cv=none; b=skff1+1OH4+jDeB84LuKDudK3IQACb5cZfV3WT0P0VJF5Y7mWeAaggJCoDzmAvBv5PznMmEiD7iqSdVXH6pOI6L6Kp+cn4IJoHq536gi2pFI2xmtqZDwSn7dcePvPLGt25gfiGCs6xt45uT3hfO1cxUVORNUPuRxLaAxMMdzWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225991; c=relaxed/simple;
	bh=wCtqxlqxJ6AkN0u687h9i5wJZ1ScRswBT49bd3P+XrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSSQL0d+WOUjqovUQwkcc+Tx/+fGudNmYdIHGjB9yDdFQccTGPC0DZCx1rYjCKgO6zK1U0Ifdgf5d7XyEW+SVTnr/2TZxRRjRohQlbeW1Q1yw/DJtNFIL18pcfBkNUkAjIyGykiDHAvqPFSaHdbkOzV9ySEtQ3gpzUpb6JuLPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RsSP7wMw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RsSP7wMw"
Received: (qmail 305734 invoked by uid 109); 8 Dec 2025 20:33:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=wCtqxlqxJ6AkN0u687h9i5wJZ1ScRswBT49bd3P+XrU=; b=RsSP7wMwQY/2Jcb6TwgzLZoh7rYfZq2YyyEsRvX/0smXeV9xy6KAAXhNBovMsy36tpRWkm6fwsQrfiroHpTeVYb+80tXs5vDTKZiotkgETbh0tgcN3QefB0XjPSeUNKG+lBSztgpqN+wNrg37o/cPbaRWrSkT3GHiCde/iIst1G+z0qHPStcKpzBDgpG7D0OBGFloK2v0KQ/bnHrOdHaq06GeghcdtHuRGQtiRMshZHsrOF2sSJsLqYcGaFCWK/Kucy07PGa2JXfOtYGiRN/BE+lv4SJ7BCZJ25/IBiZXGQETaYf3Z5k/2USqWzRwRofychztTA5iMLZEUjLRtICMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Dec 2025 20:33:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 390038 invoked by uid 111); 8 Dec 2025 20:33:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Dec 2025 15:33:10 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Dec 2025 15:33:07 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Chris Torek <chris.torek@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] ban mktemp(3)
Message-ID: <20251208203307.GD216526@coredump.intra.peff.net>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64e62623-b911-4ddd-a481-05191853c0a6@web.de>

On Sat, Dec 06, 2025 at 02:21:06PM +0100, René Scharfe wrote:

> mktemp(3) is insecure and POSIX.1-2008 no longer specifies it.  Stop
> using it.
> 
> Changes since v1:
> - add comment regarding return values of git_mkdstemps_mode()
> - add patch to drop trivialized gitmkdtemp()

Thanks, this all looks reasonable to me. I don't have a system without
mkdtemp() to test the meson change on, but I can confirm it builds on
Linux for me using meson. ;)

-Peff

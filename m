Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E621991B2
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233454; cv=none; b=YWzJLpGMy9nZMm2x2EWcdg4J9ppwP0ONnuDAoo5VpP4pzMedTf4YzZVYKFCXQYqcLykRD2RfmIoy3/Z2q1GaWi947SEBKkLZycD+jyYSFfJpw2Wz78romDVEDPAvNaDlWiKpBxzseq2M4tJVWuInL0DZOEpCGrpwGC/W4ya0pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233454; c=relaxed/simple;
	bh=LGqxSCBHyNjIHM0I1S5UFwL/r4qM++D+TmufmLAE/hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKCPag6oWwGPXlgRiKdyvZyG5a/pV3bSLmrIx8iKaGYxGuot3P1rQ0n7V+K5RBzkEjmZLTo/nilPCYa7DXHuRf5bivhF42+VsAh216H44uJAEEosp50eqGSKI6KiRbtE1glf4b5qBqg2XQvWOdMJ50NRSWH0UuNbGMtELHMzZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=URPH+29Y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="URPH+29Y"
Received: (qmail 28991 invoked by uid 109); 7 Jan 2025 07:04:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LGqxSCBHyNjIHM0I1S5UFwL/r4qM++D+TmufmLAE/hw=; b=URPH+29Y3VLi6C6oXhzPTH4jTGaQlHP5acAJXORA5xUEFCdcZgzxUp0GTZ2rY0qnBAb0CimwkG84W7hWrU5mKKBf88OvpVPXtaSKoUaP3OI6rs+O4vx0NW/IXzw1j3Yez5dhUK5Rl3f6iXW+5kpwnNUQ9I2J8Ns516dEVVmyLtGWEDsUZHZDDF6XNni6b+96c84EQYYPRcQWpGGMOSOYtWgzFdFuNWgLyk3XwhVvr8z0SrTeYeaCPWA0tjBqIK2jt7ohqYtld7XElb91TZtL3Q9YFXrQtsJV3O5VUeKBEn0FZNhMN1luYyNiilXXs/eQqvnWCba1f7xl4BAG7O9tSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 07:04:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21813 invoked by uid 111); 7 Jan 2025 07:04:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2025 02:04:09 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jan 2025 02:04:09 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 0/3] lsan test-lib readability
Message-ID: <20250107070409.GA584456@coredump.intra.peff.net>
References: <xmqqpll9xehr.fsf@gitster.g>
 <20250101191422.GC1391912@coredump.intra.peff.net>
 <20250101201226.GA3304465@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250101201226.GA3304465@coredump.intra.peff.net>

On Wed, Jan 01, 2025 at 03:12:26PM -0500, Jeff King wrote:

>   [1/6]: test-lib: use individual lsan dir for --stress runs
>   [2/6]: Revert "index-pack: spawn threads atomically"
>   [3/6]: test-lib: rely on logs to detect leaks
>   [4/6]: test-lib: simplify leak-log checking
>   [5/6]: test-lib: check leak logs for presence of DEDUP_TOKEN
>   [6/6]: test-lib: ignore leaks in the sanitizer's thread code

And here are a few cosmetic improvements on top based on the review from
Patrick. They should apply on top of jk/lsan-race-ignore-false-positive,
though that is also in 'master' now.

  [1/3]: test-lib: invert return value of check_test_results_san_file_empty
  [2/3]: test-lib: simplify lsan results check
  [3/3]: test-lib: add a few comments to LSan log checking

 t/test-lib-functions.sh |  2 +-
 t/test-lib.sh           | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

-Peff

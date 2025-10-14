Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF132C181
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402112; cv=none; b=PtO5wIuX7vZLC5x/1CjYjtPmGNMiFuEnqP2tQaudp6s5EVhp1wOzrAp4Kn08GnLSmk8EJVAk9qb7dTinq42erPXYQYMdTIPVJQRX1nNtKqwZOF8gJtHsNkRlRsm0lnKls1pnmPoKRVLF2bgu+T9lGXznE4lTSBVEc8fkciYzKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402112; c=relaxed/simple;
	bh=6GbFaJtkOTrjER6IkdpRMucu9lkp2+sZcEoA7P2024A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWi3IYpjo8dPeUjgAXfnCpDiJmb0xiv+CU2KC0MA+an1eAFh87jtP9Lw1cwvd/CzbOhlirdGN03FFAga3r3EijRAqbRHQxy67NTBb7hjCosUmsn+O+m4U72bk4jqtSijGKGsLJS+UaBAvj2G0TWt26yueGNzlVmZ1n2BxdX9gAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YYzNoRTu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YYzNoRTu"
Received: (qmail 212099 invoked by uid 109); 14 Oct 2025 00:35:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6GbFaJtkOTrjER6IkdpRMucu9lkp2+sZcEoA7P2024A=; b=YYzNoRTu0e4hk/Tlys5add6d7jnbwB8czXI2xBFnRlKXBd8hfWm6sKuxmTzhA7q1e3RZuGHWlJnxtE31ezfRlaTbKqkCVYCnHszcZfFXz6yLpwcWA3kPLAh3WuUE8iSfGDXXmFEzEB29QS4XaqO1v1OKmdFXetTuO3vUZWXchOxaYUI/ESA3CEcAjNvKrmGNILyyqkDc4a3Bi4Yg9Nx6S2mFS4+Teaf3gP4G8l0fcmM86EVMiDI6/VthGTtjNPJjGfcePNQuMVwmtb9U5KnGNR1hfTmltdl0EhIWJmmSgA3Yj/GNbFiNQCLjRiISnAxLrnaAdXMgboT0sgxABCHkPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Oct 2025 00:35:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 342016 invoked by uid 111); 14 Oct 2025 00:35:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Oct 2025 20:35:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Oct 2025 20:35:08 -0400
From: Jeff King <peff@peff.net>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] [Outreachy] commit.c: clarify comment describing
 commit re-parse behavior
Message-ID: <20251014003508.GD1507@coredump.intra.peff.net>
References: <20251011093611.62937-1-okhuomonajayi54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251011093611.62937-1-okhuomonajayi54@gmail.com>

On Sat, Oct 11, 2025 at 10:36:11AM +0100, Okhuomon Ajayi wrote:

> The existing comment in `parse_commit_buffer()` mentioned a "leftover
> from an earlier failed parse", which could be confusing to new readers.
> It implied an error state rather than the intended cleanup before
> re-parsing a commit.
> 
> Clarifying the comment makes it explicit that we reset the parent list
> to ensure a clean state before re-parsing, which improves readability
> and avoids misunderstanding during future maintenance.

As the original author of this comment, I think what you've written
retains the intent but is easier to understand. So looks good to me.

-Peff

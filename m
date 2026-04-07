Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4D375F76
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541957; cv=none; b=rpbrA2MR+fuVEgFBVjeLG3rxbHntRfOF37sRFmW3GU/Fo5oHafaZ16B4zxk1f9L9Z3DccDmLxC2OtXhxNO0+9eeucxErE6aiE1eiu47IMfluWX7Vs2uIRmWjE390yH4D0cmtAuagtc1kJOfk36IAUZyHx6GREtNNL+uz3XfI1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541957; c=relaxed/simple;
	bh=h1iAZ4j7N+7yHMzj9LsrppFRz7BCUi8fKj9Cyd77NJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ57xxiwusUxDZUWbRPRFk/Ed2b6Zt2AEjZyAOiHqhOXn90BxJK48omhClxDjBykvH1zb5WZil/6DIp+RKfJquuqabN+1ndeZYC4qveyLV530SaEJznTLexF+VK+awWTkTsOPXh/9A/eqzsfe0mEhlWl/JDTTocM9QK9LWFnaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Uc5yHBbi; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Uc5yHBbi"
Received: (qmail 269425 invoked by uid 106); 7 Apr 2026 06:05:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=h1iAZ4j7N+7yHMzj9LsrppFRz7BCUi8fKj9Cyd77NJk=; b=Uc5yHBbi3TzJBy4nhnhre5aag0bBaIxl8FuopH1NwhNcrl6Pj++JP2lHSPbb2HjOwRsP/xWrfGHWfM/DCsjycPAaxU+KiH36udsyfGQqtaa0JjD5yU8MEKExSZpd6CTw4kjSFXDXfamgju/5wnrb42qxDQH1Hj268MhPPJwFsdY13HGDaAdx7+QoG2DTpAKihpcqeh1K7Fw3cllhMrsOno7JKo+Knkewq9z5am0j/G7iK3KU1HlOgjOZur6EB7X0HtjSIOK8xWXtIqgHqZ4bzpWoCoGV2Lq9+HgTGCmqsTk9r83dSnwSNMOwnHuKmmYft+bDPCfYpRxERiWxbHmOSA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 06:05:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 441730 invoked by uid 111); 7 Apr 2026 06:05:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 02:05:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 02:05:54 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 08/16] midx: expose `midx_layer_contains_pack()`
Message-ID: <20260407060554.GC714878@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <6af23849f1d499e7a23d1ef4a70ac3d29748e1ce.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6af23849f1d499e7a23d1ef4a70ac3d29748e1ce.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:11PM -0400, Taylor Blau wrote:

> Rename the function `midx_contains_pack_1()` to instead be called
> `midx_layer_contains_pack()` and make it accessible. Unlike
> `midx_contains_pack()` (which recurses through the entire chain), this
> function checks only a single MIDX layer.
> 
> This will be used by a subsequent commit to determine whether a given
> pack belongs to the tip MIDX layer specifically, rather than to any
> layer in the chain.

Yup, that is a much better name.

-Peff

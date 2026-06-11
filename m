Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC5374E71
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161073; cv=none; b=bCpLPHBHFlYabGQ6qSV30UiRnEH2Jp59N0gJtsViVpW5pa15J6QNn3UqvzlvK31vueWqWOC9ZK7dumW+jpSy5FUDFju57EC3/OR7nfICp9bLdTGage21RbAwZ64zE0JKmIQFX+gWthUkFGnE5RSns8HTA5s5Kvo5jidyjkRxAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161073; c=relaxed/simple;
	bh=FObH1i2oJrVskw0XA97VH6E+TVFqe36ckcbTjxIlzcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2sZA3dldNC35CTGPTAVf0J/Fr+4AE5h2JqAPFpHAoUzgVqirv05qkaNnTMIG3EAQMDY/RdtiExwQGYbtDHDNMfhEGVaPv+9V0fzG9Jmh2F0B2JaAnzH8k+egqbXXA57JAhJCyZsw8AFp30N5jNOS4rBSZq/TLGHXZL8mHJXXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OGsc52+/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OGsc52+/"
Received: (qmail 106342 invoked by uid 106); 11 Jun 2026 06:57:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FObH1i2oJrVskw0XA97VH6E+TVFqe36ckcbTjxIlzcQ=; b=OGsc52+/GlnE3trxKdag3fCW96Mr3rwesCyS18AgGuRV1tf1jXgJrFC1WQZOHqEDV1RB6oz1eM0I4GxuSEGuCs2CPwSkMqSOVR+oXxeTW6QuC7saJDkVWR/+H2XQbzja7moUbevQEkJybtCwRUrcSm+AfQct0Njahr281YixvXUba4NX6peD8Dv2wVxG78QYqRuFgVu1efIOBp9rBoh5Azdx6Ams3zjV0f/2pctoA+Kz7+2rD1aYgek3QPcoe1n9zqxAG8Xe5wtoypLe/RyeNVo1EBgb/guqj6956HzkNGQVepp4vcgwz7N+cqrIWpfA2L41FsWyMIVlUJcNK7iGgw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:57:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 314191 invoked by uid 111); 11 Jun 2026 06:57:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:57:53 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:57:48 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Arijit Banerjee <arijit91@gmail.com>,
	Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Arijit Banerjee <arijit@effectiveailabs.com>
Subject: Re: [PATCH v3] index-pack: retain child bases in delta cache
Message-ID: <20260611065748.GF2191159@coredump.intra.peff.net>
References: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
 <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
 <20260604071204.GA3196596@coredump.intra.peff.net>
 <08B48BBE-4084-4619-94B0-503158B93BEF@gmail.com>
 <xmqqldcmxxco.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldcmxxco.fsf@gitster.g>

On Wed, Jun 10, 2026 at 07:51:19AM -0700, Junio C Hamano wrote:

> Arijit Banerjee <arijit91@gmail.com> writes:
> 
> > Apologies, my earlier replies were sent through GitHub's notification
> > emails and appeared only as PR comments, so they did not reach the mailing
> > list.
> >
> > On Thu, Jun 4, 2026, Jeff King wrote:
> >> So I am happy with either v2 or v3.
> >
> > I also did not see a meaningful performance difference between v2 and v3.
> > I am happy with either direction and defer to the maintainers on whether
> > v3's more precise release is worth the added complexity.
> 
> I have no strong preference either way.

Nor me. I'd probably go with v2 simply because it is shorter and less
code. If there is an optimization whose effect we cannot measure, it is
probably not worth even the few lines to have it. It could always be
resurrected if somebody finds a case where it matters.

-Peff

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7C1EF0A6
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314767; cv=none; b=tgFrNmYt/s2sHufEVIavUFsoopaHO/dSJwjHxqDw+eXMvnNyiz3TF/xlujV6MnUNJB0Sy1yOXKjZ3SLIjUYFBaT/PMD4YTq+Pma/ETVE+g8pCzOyn+D7i5Bj0dxI+6EVzHohFfs8uZ6Hxu73h60ezj00LkNAFOdPvwrEGwWdzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314767; c=relaxed/simple;
	bh=HDeWg/aRbIxLRanW1dJ9Z4UAziNMFF+npbjGu955yqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P782YSMRi4XngzbmEaHuvRuoO/mnmu1dhcS6uet4kf3SUhGS0nIo+aIX1enc9X5xTeZfKMsvxBlhZFTHy3gvZxyrobXkDsDiVQwurOsxEGxIdmpnOxaKdKjQcblqihYOraiauan74vs0XyJ7u/FhKhd6nlZ3wLB6+TC5eEimN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TCO1t+lC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TCO1t+lC"
Received: (qmail 11925 invoked by uid 109); 23 Jul 2025 23:52:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HDeWg/aRbIxLRanW1dJ9Z4UAziNMFF+npbjGu955yqM=; b=TCO1t+lCz1U0cc6QHMXoSHmvyEF0lKT6UL9SL1KDihBDPXbZE7IXqMPa+Mg22ARxp+atvj1aB52d4hfaYt9fjjwuvNzAcLRCZIK9dvKlgRZN7wXcSOWuZ2sSj7h+sBUE14R2AhyltAKUIp+HxYrEEXZrFBCU4+o+7wwVQD0LfWCpa7ISt0rR/UE8EuvxcDxTduXDYjfMsKze9qqQ12ZgByTllIuT0I8Uy3DjXcNEpAaOoCuA1VOUawpGw1B0cmvXng2QK7HqduV3Js2LrZnAT+7n48CwJ4LdPNpu7v06kDMjUFMQ725Pv86Fcn5ImRvzdaQSJQP6Az08hdxbDzOB3Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jul 2025 23:52:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25685 invoked by uid 111); 23 Jul 2025 23:52:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 19:52:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 19:52:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	schwab@linux-m68k.org, phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] ref-iterator-seek: correctly initialize the prefix_state
 for a new level
Message-ID: <20250723235234.GA592873@coredump.intra.peff.net>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqldoelgnd.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldoelgnd.fsf_-_@gitster.g>

On Wed, Jul 23, 2025 at 02:51:50PM -0700, Junio C Hamano wrote:

> When cache_ref_iterator_seek() "jumps" to a middle of the sorted ref
> list, it forgets to set the .prefix_state member of the new
> (i.e. deeper) level it just initialized.  This later causes
> cache_ref_iterator_advance() to look at this uninitialized member
> to base its decision on what to do next.
> 
> Kyle Lippincott [*] and Jeff King noticed this with MSAN and
> Valgrind, and Karthik Nayak as the original author located exactly
> where the missing initialization is.

This explanation makes sense to me (from my admittedly rusty view of the
ref iteration code). And certainly the patch looks right.

-Peff

Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3C38C40E
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193568; cv=none; b=dVy/929omJcsIh+L1/bVQrfJb4QFWacjX5SFKiIMw4oSV4pH9+r8YbXkl6ubjOqFeu/MKfXuBARxVgYnisrrhNK+egUFlh6BHrKACOxp4WTftfmXVFsAQ+bxtCiQQJodXyVIvveZfCqCtLyDqasudxxP7COzYvDuhxZOnAjcgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193568; c=relaxed/simple;
	bh=MYo9zMYGiRD+sPZjwQPXRMBYt5h3VgjTmqQdFbwtt0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXr3ncRxM3OrNi5KZLbE7MG5VGhpeV+Kv53YfBfHmPT8w7b6aC8Ufq3kdYTXksMK0E6chyD+hDKdpfS+No9wdZHicUCC+jR7DwzwhsQJaoRSqqVA61yJ9rB2N+Yxq8r/YTd0VwFBYO6VRzqJRxKy9SVaJjHosYE3+oU1Mwyw3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=frNV0SbP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="frNV0SbP"
Received: (qmail 42846 invoked by uid 106); 16 Jul 2026 09:19:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MYo9zMYGiRD+sPZjwQPXRMBYt5h3VgjTmqQdFbwtt0w=; b=frNV0SbPui6fAZxGnWGlK3dJlppNyoJW9qZSs5fOWYq+RM4a6gUUAGPluS6ZXnkdxeLdebc00rQO2TdMjd/g0cB1btGir9WGPCKnV+6pch3imxdx7NDNBDSZ70P9Fj9npxuq/fzjltF/dKp4RVXjS1pQuSyoxp1VeSz7KFu/7AI5FpN31410P9lMDVrFultPXx5Ll4BZY8OKQyjs0Ep6SfV1yQKXlhc8qDM4+ROum9mqA5X2vQOc7plFN4HYy+7wzCX2FTYeyG5HKcBnFycFxhobC7b3ijj1wFNYQc0OKPjQXS479f/oBkuaxfh2s0cH9QDWJxLK/IlFRofPVsrdvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2026 09:19:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 77717 invoked by uid 111); 16 Jul 2026 09:19:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2026 05:19:29 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jul 2026 05:19:24 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v4 0/3] Reuse --contains traversal results
Message-ID: <20260716091924.GB1212956@coredump.intra.peff.net>
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
 <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
 <xmqqqzlpulkp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzlpulkp.fsf@gitster.g>

On Mon, Jun 29, 2026 at 01:40:38PM -0700, Junio C Hamano wrote:

> Tamir Duberstein <tamird@gmail.com> writes:
> 
> > git tag uses a memoized traversal for --contains, while git branch
> > and git for-each-ref repeat a reachability walk for each ref. Reuse
> > the memoized traversal when generation numbers can bound the walk.
> >
> > The first patch makes the memoized traversal reject cyclic replacement
> > histories. The last makes the non-memoized path report reachability
> > errors.
> 
> This unfortunately hasn't heard any responses since June 12th.  Are
> there remaining issues with it?  Or do people fundamentally have
> objections against this change?  Or things are too busy in general
> that there are more patches than there are folks willing to review
> them?

The last one. ;)

I think the direction is good and the patches themselves look fine. The
only nit I had was that there's an unrelated (but good) comment cleanup
in patch 1. That could be split into its own patch, but I am also fine
to declare victory on v4.

-Peff

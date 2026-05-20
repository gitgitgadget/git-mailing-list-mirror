Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A6322768
	for <git@vger.kernel.org>; Wed, 20 May 2026 05:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256040; cv=none; b=pIjMSqN8YV0j/jlQwArIQ+TtQkkPbz3KceQ3WK+Uv2sOM4uHjOVv2NWv87kv1F7TW4hUU4CRzscsxc918ypsRbvUcCiWuxZ/dbDq9aPJ+w7W7R3JOR3SJdZ1T+ZNjqv+8xab/MYPklsoP3H6Vixj227UzZ2A7Z7VbDczmV7PnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256040; c=relaxed/simple;
	bh=eoyefI6y9fzDyxrgFvZKWvzn+4jwY6KtoYvzfCP8t4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npYHUgYNkX2idyZ4owPKVQi7IvfFqo1gktvSSOCNxPHrUKycepi2bHSS8PK1v+pFfika6I1+1LtoWiYK6fhUbaot4/jO8CIF3oKpClDKH3jAO4IlzXrqAtB9YpODxL90+1TprTlCY/XXdDGoNU4OHeZqVOOlP3v5KBZQ5mgRIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YXy/zAAO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YXy/zAAO"
Received: (qmail 27475 invoked by uid 106); 20 May 2026 05:47:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eoyefI6y9fzDyxrgFvZKWvzn+4jwY6KtoYvzfCP8t4M=; b=YXy/zAAOOoVFfhHqMtQ1DaGhVj4xUAOcQskvX533lWf29JMdIGfuXfvc15Hp8cLXscZ88woOg3OPR108wlMpkXTye/b9ZmBSqVAmulyDU/50kGi9yy8H9sWgHJDnn3EVJqz0uODGvh+M1J8Eo4tev1dg2+1GReGjLDbe+ZCRfMN103wIy9eOXFnsdkaX+m6hCUy+uQn8SLIMu0fBT7QZNbfqk7k0SdYTcjP5HxLkH/y2vYvpZdBg1EBoO9csIiE5KYwbXwWdU+tgJJW4A4+Y7ygJ8gzgpjtOZNlvYs3a1HIsd0BQT+L4z8PtDmWlhpobyt4VegS6pamYXm4p/+IwIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 May 2026 05:47:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 63916 invoked by uid 111); 20 May 2026 05:47:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 May 2026 01:47:20 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 May 2026 01:47:16 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org,
	Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/2] builtin/maintenance: fix locking with "--detach"
Message-ID: <20260520054716.GB3849892@coredump.intra.peff.net>
References: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
 <20260513-pks-maintenance-fix-lock-with-detach-v3-1-f27a1ac82891@pks.im>
 <xmqqy0hnipy4.fsf@gitster.g>
 <agz78jjYEAif4lZt@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agz78jjYEAif4lZt@nand.local>

On Tue, May 19, 2026 at 08:10:26PM -0400, Taylor Blau wrote:

> Thanks, Patrick, for making the change. I think that this series is in a
> good spot, though I'd like to hear from Peff who had some comments on
> the second patch from the previous round.

What's in v3 of the series looks good to me (both patches).

-Peff

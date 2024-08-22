Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D76182DF
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339761; cv=none; b=uIOO1/q2OiGtA2jm66z8MTDV2sTsGYXUow7m2mI+HgN0kuWr42iyZrhAQ9dIY1NM5vlEb/Rs5Y9hCvqvTselld3XJFubKkTtv7JOOOtqq+bCPy31tJiJIwNCiQsDXkECqX+cQb739F8J6qOLHG6V9HnJRW3qvSkrWZlQDjt1Q3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339761; c=relaxed/simple;
	bh=0s5Ko71+ZlyhvGif847af1txI2hc0VuveGCcoeh2QgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dlGWr8TyEhqxB5elWYgCSBcCW22uuONDblynouLSX1KG/wZjORnuPGt+Jb5CtaMpOaVeqPhonlFejspyi3/N4SJQGctapF9Z9dAdVn01xt6MyEtxRwlyt9Dk3C6GcLj0h9T0n6kMS0kbgAuPmPRd8BnLFVo5uClb5I3bq0EHXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RKrSy3nY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RKrSy3nY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A8E420954;
	Thu, 22 Aug 2024 11:15:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0s5Ko71+ZlyhvGif847af1txI2hc0VuveGCcoe
	h2QgQ=; b=RKrSy3nYUOijZumw1pZtARhnumHm8rZg0C3L3Ef13IbXPA5EsNd7sF
	NMtuOYatWFu5y8gyfG7CQktvnJUqYAgxags/rD806G+PdlQtEzeSWWVNMzfS/qJG
	/NJeOJIxLZrG2X+CibhRsu21099cElX0/LsW/ICyMn760BGD+W3VU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 733A320953;
	Thu, 22 Aug 2024 11:15:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B017C20952;
	Thu, 22 Aug 2024 11:15:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 00/10] reftable: fix reload with active iterators
In-Reply-To: <Zsc03CSJ3Ece5L6s@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Aug 2024 14:53:48 +0200")
References: <cover.1724080006.git.ps@pks.im>
	<20240822124100.GA1070988@coredump.intra.peff.net>
	<Zsc03CSJ3Ece5L6s@tanuki>
Date: Thu, 22 Aug 2024 08:15:55 -0700
Message-ID: <xmqqmsl4vb9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6E3A3280-6099-11EF-ACDF-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I can certainly do that. I know that there are conflicts both with the
> patch series dropping the generic tables and with the patch series that
> move the reftable unit tests into our own codebase. I did address the
> former by basing it on top of that series, but didn't yet address the
> latter.
>
> I'm okay with waiting a bit until most of the conflicting topics land. I
> guess most of them should be close to landing anyway. Alternatively, I
> can also pull all of them in as dependencies.

As long as the resolution you see in 'seen' looks acceptable, I'd
rather prefer you do nothing, than a rebase that _reduces_ the
number of conflicts (but does not completely eliminate them), when I
already have a working resolution recorded in my rerere database.

Of course, updates to polish the substance of the topic are very
much appreciated, and I'll redo the resolution in such a case if
needed.  That's one of the things the maintainers do.

Thanks.

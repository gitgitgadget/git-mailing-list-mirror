Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA115F3ED
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837735; cv=none; b=E/RLmkGCOQr+wSnQlxgxbr4WxqEjcepA3mx2x2Kd0BPH1e2vMiJT6Tb4iH1HNGEPKrKQJUm7qxfM0H6WULkbk++IPfLBEhkQxgxH47irGWnlBoJb0qxtzEhABd0+sZFiAuB0hkHUiMAiZ5RbV3eEn1vH3iP8uqvLwij479iPLxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837735; c=relaxed/simple;
	bh=Hww4KsAWz1uTK4+W00U/l6tlFFqxcDEvfiwXo6022Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R77XQZE0LR+5W58ZGHS0p975toz3exffotmqg2SSCpZ2FUHKrqApLdnqMD04uwQ7TuKoZUVstTnU2agK73MXyJC6XhYkTXQxRdorHVOtLO7C+HdIexyTiHmQEm9Z/rLrOw5p2YEhNXQpXb0b9raxJnsxH6N0h0Hv4vvCefIw9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qFy0gusZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qFy0gusZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 03AB62928A;
	Wed, 24 Jul 2024 12:15:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hww4KsAWz1uTK4+W00U/l6tlFFqxcDEvfiwXo6
	022Ec=; b=qFy0gusZa5VUDgrngWXbhuoZqQzygNUVzMKHJzf+oJ2QBXBkfs21e7
	yLQAr5u3/AQbITGzpnJkRgvuCUS+iL5+pNVs1VlWqYnk9O+xAuFwQydbVPVZS2SA
	NjOg0FxP8QGg6xzQlM/2JHnL/jjC50uFaB7LPpcUx+inRPmQuQd80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF2CD29289;
	Wed, 24 Jul 2024 12:15:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3225829288;
	Wed, 24 Jul 2024 12:15:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 6/7] t-reftable-pq: add test for index based comparison
In-Reply-To: <ZqDDS3EhXwDittDr@tanuki> (Patrick Steinhardt's message of "Wed,
	24 Jul 2024 11:03:07 +0200")
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
	<20240723143032.4261-1-chandrapratap3519@gmail.com>
	<20240723143032.4261-7-chandrapratap3519@gmail.com>
	<ZqDDS3EhXwDittDr@tanuki>
Date: Wed, 24 Jul 2024 09:15:31 -0700
Message-ID: <xmqqikwuydek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F367F0F6-49D7-11EF-938F-BAC1940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> One of those reasons that we use the modulo-loops in the other tests is
> so that the order in which entries are added is mixed. Here we add them
> in priority order already, so that makes the test less interesting. We
> might thus want to do the same here and scramble the order a bit.

Wouldn't modulo-loops mean the total number of elements must be
prime with the skip count, or something, which in turn means that it
is harder to test certain corner cases of the underlying data
structure (e.g. "what if the length is exactly a power of two?  A
power of two plus one?  A power of two minus one?"  etc.)

It certainly is much better than just inserting in the priority
order (or in the reverse priority order).

Thanks.

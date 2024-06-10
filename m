Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663C150987
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042947; cv=none; b=sLdpM6T+OED89dS6eHsqMKPupAWzDaqz3Z+zEcbXuADayTlXO8Sta4s0ca/4TCzniFq3fVvktvbf8lFk+5wdFBozSD0q3JJPXfi7m8T6jD7KPu1w5WBhdR8ivePG/OENKHWlmWQ77F879JGauY4dVHvTvv7R10VQf/FCGVI73u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042947; c=relaxed/simple;
	bh=Lx+Ed14JDFgLe8KYr47XRA7NrzlaobSe1Mmgje0mcJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uH92wlxYnB4bNXgpwRUGF4qF5QPOHfQwFUKQwWY6lvpy6Wqz/XEljTdVmQXYs5QWlAeP2xM13pQizZQsWfusygvCEKVoj6AvSDSEg3LXmS8WQC+9RuSB+1qmTD6nJEuBohOAaaofOOQwoEdPhFvVJTRv2av76kKJcstWdFaRoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aRksCFJb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aRksCFJb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A8CEA1ED11;
	Mon, 10 Jun 2024 14:09:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Lx+Ed14JDFgLe8KYr47XRA7NrzlaobSe1Mmgje
	0mcJU=; b=aRksCFJbqkdlWW1jG3+WhmDvnbZNE1Efd90rnao/YMnLRYvNhRSqhQ
	TptPzPUnmzR/gKMcLsSmdafGpE27tquS5Zj2ho/qGjNL+N7kUND0p245gQflwV05
	l//WZKySrNCyMEriitcRn3quk3Z0th6ZAvk/2uOKPpo6+eCWQpNqc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F2F41ED10;
	Mon, 10 Jun 2024 14:09:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6BDA1ED0C;
	Mon, 10 Jun 2024 14:09:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
In-Reply-To: <ZmarVcF5JjsZx0dl@tanuki> (Patrick Steinhardt's message of "Mon,
	10 Jun 2024 09:29:25 +0200")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
	<xmqq34pqlyou.fsf@gitster.g> <xmqqv82mkk15.fsf@gitster.g>
	<ZmarVcF5JjsZx0dl@tanuki>
Date: Mon, 10 Jun 2024 11:09:00 -0700
Message-ID: <xmqqy17c3c1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84125FD4-2754-11EF-BDB4-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I wonder whether we can future-proof the code a bit more by introducing
> a struct that contains everything we want to pass to the callback
> function.

That would hopefully make a change with a large blast a one-time
event.  But at the same time, it may end up making it too opaque and
hard to verify if all the API functions are using/updating/verifying
all the members of the struct as they should.  Compared to that,
unused parameters are easier to verify mechanically by compilers.

> This would also allow us to get rid of this awful `peel_iterated_oid()`
> function that relies on global state in many places, as we can put the
> peeled OID into that structure, as well.

Yes, such a benefit may justify a one-time "affect many callers"
event.  Or the underlying for_each_*() friend of functions can be
updated to use a single struct and then the current "only selected
parameters that are used ar passed" API can be made into a set of
thin wrappers around it, and then callers can be converted one step
at a time, in a multi-step series, perhaps.


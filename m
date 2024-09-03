Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56917DFF4
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379667; cv=none; b=BfWl/Plpa0TPWnJHPXEGvsXkCh8S5Net0kWwlGJQqDHGJAwa2NeCSx3KLgU4FUlhBApRb71NN5AiDCqaDkk1LcrV4GQD4NmgIPAYt5E10wUI7tkjG7s/or25lU7IiFXeknCjE8P6Gnje42VdRrYeKkGIO5LDMADAlWGX+9SuU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379667; c=relaxed/simple;
	bh=9X5kSCb/zCkxsHmpHk34icTF9vTTR7fCzzisgTSKcUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XjHtMSyattzE0Nq4v0teIKLE1Nd9F1Criuv/Adp+GHgBTlScuMBsMy8U0JHDme0d/M2jTUlZy1+XZW29rIIoFnBj38EB+kFZnN/jPlmV0XE3z/SqaJCZzKuNRxkYhKW2tWYnDkySqLjS2/DmInQcOsT+ZGzDQjIR5dw6J32uGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=laqa9Evd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="laqa9Evd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38FCF36704;
	Tue,  3 Sep 2024 12:07:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9X5kSCb/zCkxsHmpHk34icTF9vTTR7fCzzisgT
	SKcUg=; b=laqa9EvdpxDCCk2pD9ymb4fN9rHrbB4UI+KGyjgehB8jZPgqYqo0Ek
	gUxHLQD7V25mnGBhYdJPSgvbyrJjSB1fWY/KqCEzrvDCg4JVukpfYZP+7EER5jyi
	Kbs4umw0ehsi5JVGkxzJF43usjt+k4xZM7Dieogt1M2j8kv4Ml0Eo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30B4336703;
	Tue,  3 Sep 2024 12:07:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89EAD36702;
	Tue,  3 Sep 2024 12:07:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shubham Kanodia <shubhamsizzles@gmail.com>,  git@vger.kernel.org
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes
 to fetch
In-Reply-To: <ZtacHCuql0pX3V2u@tanuki> (Patrick Steinhardt's message of "Tue,
	3 Sep 2024 07:18:20 +0200")
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
	<Zs8KzG0vzCEDvkvx@tanuki> <xmqq4j7438yc.fsf@gitster.g>
	<CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>
	<ZtacHCuql0pX3V2u@tanuki>
Date: Tue, 03 Sep 2024 09:07:42 -0700
Message-ID: <xmqq5xrcn2k1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A79AE276-6A0E-11EF-98F8-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The prefetch refspec would be rewritten by git-maintenance(1) such that
> the destination part (the right-hand side of the refspec) is prefixed
> with `refs/prefetch/`, same as the fetch refspec would be changed in
> this way.
>
> An alternative would be to _not_ rewrite the prefetch refspec at all and
> thus allow the user to prefetch into arbitrary hierarchies. But I'm a
> bit worried that this might cause users to misconfigure prefetches by
> accident, causing it to overwrite their usual set of refs.

I agree that it is the right place to configure this as attributes
to remotes.  It would make it handy if we could give a catch-all
configuration, though.  For example:

 [remote "origin"]
	prefetch = true
	prefetchref = refs/heads/* refs/tags/*
 [remote "*"]
	prefetch = false

may toggle prefetch off for all remotes, except that the tags and
the local branches of the remote "origin" are prefetched.  Instead
of a multi-value configuration variable (like remote.*.fetch) where
we need to worry about clearing convention, we can use a regular
"last one wins" variable that is whitespace separated patterns, as
such a pattern can never have a whitespace in it.

As you too agree with the position to consider "prefetch" should be
invisible to the end-users, we should not allow users to specify the
full refspec at all, or if it is forced or not with "+" prefix.
Only accept a set of patterns to match, and keep it opaque where in
the local refs/* hierarchy they are stored.  It is an implementation
detail that the users should not have to know about and rely on.

Thanks.

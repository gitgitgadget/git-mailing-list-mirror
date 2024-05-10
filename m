Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987910965
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375000; cv=none; b=Iru0+e2/sBSXaAu96wx5mPTCDh6w4p/FvuoHerwvGA3fhu3vr5sibtS9IALhrZ5k7QBeoLfI7a+NwSHJ69RkytgnCpL6w/qyoPTN6mCKfFRybIRynZAPToZ+SOzRruFWHpoBMKrgBQBO+VhDCVZTePuT5mFHwW3rBrGtsLjYHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375000; c=relaxed/simple;
	bh=5uzFKY8AxHCj8ZCkLp+6oYxULtMsgZj13HgLQIwpHNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQ29b1M0yy1Xw2AgPPMZmYW1pJ40kB6xnFGM+m3mO6Uu5rLv0ZVH24xD3CKkjntIAd2ZtFjyFzs8FZO6mrrIcBSvlt+N6Sp9f0YX9wrWBmdD4qHueMSbhw2KOFJKXvP5Fipfn/oE2GlOU9GHxydXM0LeeOqTEUZ9UhJSDTXnOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CPggvkdX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CPggvkdX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DC9B036D85;
	Fri, 10 May 2024 17:03:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5uzFKY8AxHCj8ZCkLp+6oYxULtMsgZj13HgLQI
	wpHNU=; b=CPggvkdXEDSxYl9FXEeCFAod8bet6+BxILeBw3Rveg3ZpAhseZT2z1
	nluW5aEBEnhjbMM7C8M1WB9Q9Exr5i0PT3Uic42wQh7xYg89iVFbYnInNbUamZvF
	ib4rMBiqvLYCjlf1kHVJn6Mes08EIJGF7lbCwARRZYh4MzvSwurBU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D515D36D84;
	Fri, 10 May 2024 17:03:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6291C36D77;
	Fri, 10 May 2024 17:03:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 01/11] reftable: consistently refer to
 `reftable_write_options` as `opts`
In-Reply-To: <7efa56630681b6aca64c04fd19fb020ffbb76152.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:29:20 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<7efa56630681b6aca64c04fd19fb020ffbb76152.1715336798.git.ps@pks.im>
Date: Fri, 10 May 2024 14:03:09 -0700
Message-ID: <xmqq34qp4bxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B5B517F4-0F10-11EF-B3ED-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>  int reftable_new_stack(struct reftable_stack **dest, const char *dir,
> -		       struct reftable_write_options config);
> +		       struct reftable_write_options opts);

Passing struct by value is somewhat unusual.  As long as the
structure does not contain any pointer to something else, it is not
too bad as structure assignment would also work well, though.  Not a
fault of this patch, and this series is not a place to change
anything about it.

> -	if (config.hash_id == 0) {
> -		config.hash_id = GIT_SHA1_FORMAT_ID;
> -	}
> +	if (opts.hash_id == 0)
> +		opts.hash_id = GIT_SHA1_FORMAT_ID;

Nice attention to detail.


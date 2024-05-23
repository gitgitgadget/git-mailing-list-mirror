Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94C128818
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506766; cv=none; b=dOUXIPXFA0JiHV4zvYp0NMGKW80HERveJqCjVzvYWYFbDxn+Ubu6GSaH1Pnb6wCy4yORSVq9pNBNpEpE1ICFdD+y7YAabI7+zxPIVNj1nj4wO12EQpAPKSJnBiglsSeGmF6FBWY5LqE7LssbR3PkrCtkTLH1gb75NhQ7OM+dY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506766; c=relaxed/simple;
	bh=jBsyFaDMVTL8H5gC75Ro6FQpLpHnoOHiLjwGJbBvNMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=diWjMZya65/eX0Ga/PMjBcC527R9q9Yghg0Xgzw3VvcaLsI1OZdWrrCCiTHtyXbrRXKl+bQxZUEFIyuDvCv2lL6weAbs0ommGkKeAPCn2RIBc2zG+8syCDzZnqNLK93vFfo9o3wm5Z+Exmy3CGdsEzxx0CefeNZIhT1ppe4iDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JMnnqIsl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JMnnqIsl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2904434760;
	Thu, 23 May 2024 19:25:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jBsyFaDMVTL8H5gC75Ro6FQpLpHnoOHiLjwGJb
	BvNMs=; b=JMnnqIsl3f/B8j7p8GIln76zhg0+whdLwvPsbEsESVcqj4n4ug4wZC
	haaaZVKKHbUUlihQ1Y03iP6iOjqz3DFkCsOOdTtE2Snk5iFzTPC0pjgZrucS0QTQ
	ycEpPjkIx6PiOlt50ILVw/6JrMkFkd4+8EnmAdf2mMwse+pjqlR9E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 207963475F;
	Thu, 23 May 2024 19:25:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 824603475E;
	Thu, 23 May 2024 19:25:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] give range-diff at the end of single patch output
In-Reply-To: <83436db5996b129032c2869f331980d0@manjaro.org> (Dragan Simic's
	message of "Fri, 24 May 2024 01:22:23 +0200")
References: <20240523225007.2871766-1-gitster@pobox.com>
	<83436db5996b129032c2869f331980d0@manjaro.org>
Date: Thu, 23 May 2024 16:25:55 -0700
Message-ID: <xmqq34q8qfek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE4B74A2-195B-11EF-BCC2-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Hmm...  I think this should be made configurable, with the current
> behavior being the default.  Without that, we could easily disrupt
> many people's workflows, because the power of "muscle memory" is
> often really strong.

I would view this more like "Porcelain layers reserve the right to
change the behaviour to suit human-end-user needs, without having to
complicate the system with extra configuration knobs."

But if other people want to do a follow-up patch to cleanly add such
a configuration, I would not object to it.  The main desire of this
patch is *not* to make the option to have range-diff at the end of a
single patch "series" available, but to make that the default.

Thanks.

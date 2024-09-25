Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08917BB4
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284285; cv=none; b=oUiJb9Z+sHfZXViR5BaAfyMTWkHEuLdxkCNc2A0wOevfkBn/COxPh8JQ6ze5jbH+aK9RKn/aQdp1CiwD4bkN1EAO2h+eQ04PXwZzrhB3EH3lDgk+xmeMrqfDk6b+gVE2ZotUOyXd6ao/YoXehm+xBYttPGvjREbtQJDUHZyxX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284285; c=relaxed/simple;
	bh=QNtciOVJO5Xxpe15CbnLlMKJ3ntyBzh+4CG8tx3wSMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZN1I1n+37efQU6pCjrCo8Hy0MFtZLfYszyjJwAkZ2lOxWd2RCfByO8LkImuNLZtVFipRxNFDfmI3/yHM+kXtH0J404PbqMI3jZN82RtzVMN5slpG/WAikIcQbSzS7u9BGQTCyfWttIisZHpINFhT3+YHIy1yzNmS2uaJBYZR/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UrF84Obs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UrF84Obs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B17C32D358;
	Wed, 25 Sep 2024 13:11:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QNtciOVJO5Xxpe15CbnLlMKJ3ntyBzh+4CG8tx
	3wSMw=; b=UrF84Obs8F+7qIRZGD0ChkRA/h4ARdi3mKHWGcVViG2FDk/XOK9rjn
	ahST/r2fsTPDsoRgewTM/BsniOUEmEBaWC1OZYUwI2AWyLxZyLFupNJcJs4ME/Bu
	qqHkgqwY8muOnb45fqduGBFuKXR8tAB5z0T9l20iVj+d/9oj2JmWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7DF22D357;
	Wed, 25 Sep 2024 13:11:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0591A2D356;
	Wed, 25 Sep 2024 13:11:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <CABPp-BEqWhSVSEArOu_45Bt8W0d8PWThSbWrYAEWKrcMsDGsHw@mail.gmail.com>
	(Elijah Newren's message of "Wed, 25 Sep 2024 09:58:47 -0700")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1727199118.git.me@ttaylorr.com>
	<CABPp-BEqWhSVSEArOu_45Bt8W0d8PWThSbWrYAEWKrcMsDGsHw@mail.gmail.com>
Date: Wed, 25 Sep 2024 10:11:20 -0700
Message-ID: <xmqqjzezodzb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3013BE76-7B61-11EF-B839-9B0F950A682E-77302942!pb-smtp2.pobox.com

Elijah Newren <newren@gmail.com> writes:

>>     -    these callers are safe to use the fast (and potentially non-collision
>>     +    these callers are safe to use the unsafe (and potentially non-collision
>>          detecting) SHA-1 implementation.
>
> Is the "and potentially non-collision detecting" parenthetical comment
> still needed now that it's referred to as unsafe?  Even if we keep
> most of it, maybe we should drop the "and"?

I appreciate a careful reading like this.  The use of "unsafe"
becomes easier to understandable if we lost "potentially", e.g.

	are safe to use the unsafe SHA-1 implementation that does
	not attempt to detect collisions.

>>     -    , and generate the resulting "clone" much faster, in only 11.597 seconds
>>     +    , and generate the resulting "clone" much unsafeer, in only 11.597 seconds
>
> This fast->unsafe translation isn't so good; this one should be undone.

Or "much less safe", but that is not something we want to brag about ;-)

> ...
> This patch was also fast->unsafe translations; I identified two above
> that I think should get some tweaks.

Thanks for carefully reading.

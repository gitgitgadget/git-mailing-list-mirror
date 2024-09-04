Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02D82863
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487748; cv=none; b=m2FVExB7eCdHYTN1QH7nJFaXzBagxhMfiKw1OlWCSjyOSLpIKUmgtEb5FcEA1vTS95zOcGqrv/6hvzn6dimxT+q+skKklFZz+6I6X+JaYC86YGHoNHiApCi4txFgblgUAYynIWopz9v3H0jAVbly+sOIEml3EDfD094dVqJP6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487748; c=relaxed/simple;
	bh=5gw1OiPhm0U2u+Vdry1FKpc5uGCOH/NrhfoaiB0HYOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sikp0CrWzwp7cWGn4jhc1zshFysQ49uImlQKj9b+dSy121wlISisZDbVsA2deA83NrqKRDbMgktzGW8OoL/REXH6k4Vvnv0dMKX7tB7ARHkAHjZRmi4LaqkCh1+MC/+jv0vQv4NS3fQvpVs4Kayd/ZXyN4M9lLO9PXgNOA8+yQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=m/tUQnsJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m/tUQnsJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6319A1A1B4;
	Wed,  4 Sep 2024 18:09:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5gw1OiPhm0U2u+Vdry1FKpc5uGCOH/NrhfoaiB
	0HYOg=; b=m/tUQnsJ8nMSk3bRo3E6GqKqwtZq8Y7IRuWOtWjGC2f5DVIsN7WX4c
	Tvpx9ZThib8oOpzKVP9dKl23vnkIfDoNpeJnwg/uY8bQPbMM1LhRwU/3JfQNf6Cz
	ZBb7W6FpIf75+FKj2/lxWOeqoCFr0B4VJSzwIdNbXghK0H+F/77Hc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 546B61A1B3;
	Wed,  4 Sep 2024 18:09:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EB3A1A1B1;
	Wed,  4 Sep 2024 18:09:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/22] gpg-interface: fix misdesigned signing key
 interfaces
In-Reply-To: <a1fca8104b345bff4005fcd7e4c8edb67424fd20.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:22:07 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<a1fca8104b345bff4005fcd7e4c8edb67424fd20.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 15:09:04 -0700
Message-ID: <xmqqmskn6phb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4CC1DEF2-6B0A-11EF-AE94-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The interfaces to retrieve signing keys and their IDs are misdesigned as
> they return string constants even though they indeed allocate memory,
> which leads to memory leaks. Refactor the code to instead always return
> allocated strings and let the callers free them accordingly.

Makes sense.

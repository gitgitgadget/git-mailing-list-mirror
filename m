Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779D42A91
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551562; cv=none; b=svMV2QNV+cKyG6VkuCV5oC76eOOZOGPxsoBqDPscjqeo7aEzpJwasYr6gMXZSQqRXKEdoz4VoeSh0ioOZJ26seRoc3YmvIlUctpbML/Cnrrt7cXOPIZDEnch7wO3Hnl75vI+XeasRmJG59ST6Tj2Zq0iPpuM/EUTz8aAJsgduPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551562; c=relaxed/simple;
	bh=ndzFOlWtmCn9SwudFLez8P7pRsOkfVRjuZ42kSabiaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyIniqsiRkhUf2LQlA0We19C9U6pOwphQCrHo5PMji1OUv1hfuuNLRI59hpQ1pzIcBQ7YZts7qshVPUDZORvd+eVJxNDt6SghMorcm7f8yYabyhr1ZUvS2Tc/oVE2/kOKMMY/7GYvgbvjP4bZHUDeqYiYH4j17/sSOHT4ry91rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RwacWrZH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RwacWrZH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F0271E1139;
	Wed, 27 Mar 2024 10:59:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ndzFOlWtmCn9SwudFLez8P7pRsOkfVRjuZ42kS
	abiaA=; b=RwacWrZH0R6DX2+868nczbKQevkX7kYu+NpbYt3EGfYuxD94cImBjZ
	WTim6oelm6coS5eF9QxKRg4KXFlHYQiYrYXFkyGj5kYhgo+V43Ebn1EPtOAVAq0M
	c3YtLRQjqO8TAY04cjSBrrABDisrUbgL7VbzBaEWXI4KIDx8h8dcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 379101E1138;
	Wed, 27 Mar 2024 10:59:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E0031E1137;
	Wed, 27 Mar 2024 10:59:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Han Young <hanyang.tony@bytedance.com>
Subject: Re: [PATCH 0/1] quote: quote space
In-Reply-To: <20240327091742.GA847537@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 27 Mar 2024 05:17:42 -0400")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<20240327091742.GA847537@coredump.intra.peff.net>
Date: Wed, 27 Mar 2024 07:59:18 -0700
Message-ID: <xmqqttkr4t6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96CA7566-EC4A-11EE-AD44-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I think it may be OK because true absolute paths imply that the first
> entry would start with "/", and we would already have bailed earlier in
> the function. So:
>
>   diff --git /foo /bar
>
> will already be rejected at the start of "/foo". And in broken input
> like:
>
>   diff --git a/foo /bar
>
> we must assume that the start of "/bar" is a possible name, which is
> what your patch is fixing. And in broken mixed input like that, we would
> fail to find a valid split point, and correctly return NULL.

Correct.

> I guess these happen in practice with "/dev/null" as the left-hand side.
> But there we'd never need the names from this line, since we'd have a
> separate "deleted file mode ..." header line.

Correct.  Besides, /dev/null appears on the ---/+++ line but not on
the "diff --git" line that is being parsed here.


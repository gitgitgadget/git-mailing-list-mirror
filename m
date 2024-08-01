Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254614A4E0
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 05:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722489678; cv=none; b=ARa6Jg51BSVNrzDYK5oR8JBLPAKmOinRJHpKhm5QXmZU/f63bAmUxfWDfFLMC+2NVPtpx4GAYB18l4sHJQGJryfvVXSnjKshB4BltLKTW9jS8mpYbpDcLd0VnZUK/2vf4B89Q7IM9MIe28eFJCbaViS6BgmwELFlhXbQkuIWTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722489678; c=relaxed/simple;
	bh=X3OPLcMQELbhXItXTiekK0C/M1K8MgpY+cBq7lmFj1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rpC8O47a2n/JM5fitoyRl7KQTsmbOjXtK20bSVehz1sq2OdDSe40ESzmjIxdSjnuWRVXtnlVZ31Vl8ZNTBEgv4Xu7FizV0k5PCWenKwy0S8HNYZG5z847NxDCl+FAnjQZpka1RlHjhHm9ZcDFj5vC3D7v97zONjUsGKWDju8gwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wD+K0Lt5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wD+K0Lt5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99E203F45A;
	Thu,  1 Aug 2024 01:21:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=X3OPLcMQELbhXItXTiekK0C/M1K8MgpY+cBq7l
	mFj1Y=; b=wD+K0Lt5vgDdV51pnKkNZiimi7hOZpGmAgsXHnGmgMtMvgT8OIEBzh
	EaYnmnUa6dndovXPEfVYltj0oCcsweXlUsT/ITWiFyH4x3xkUmNc3+hreYbq3NaB
	hHYMPmN1GYg0VcgFExknl6dkdhf6s+nmX2wuLQL+DWQay2ZXK2wUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 929CC3F459;
	Thu,  1 Aug 2024 01:21:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 019193F458;
	Thu,  1 Aug 2024 01:21:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http: do not ignore proxy path
In-Reply-To: <9ffa9bf5-f799-400f-5e45-ccbc5316ee42@alum.mit.edu> (Ryan
	Hendrickson's message of "Wed, 31 Jul 2024 23:44:08 -0400 (EDT)")
References: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
	<pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
	<xmqqle1hyzcu.fsf@gitster.g>
	<9ffa9bf5-f799-400f-5e45-ccbc5316ee42@alum.mit.edu>
Date: Wed, 31 Jul 2024 22:21:13 -0700
Message-ID: <xmqqplqsyg1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF98E58C-4FC5-11EF-8F07-BAC1940A682E-77302942!pb-smtp2.pobox.com

Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:

>> We insist that it must be "localhost", so let's not do strcasecmp()
>> but just do strcmp().
>
> I don't see the wisdom of being more restrictive than curl is in this
> respect.

Ah, if curl is doing case insensitivity, then matching its behaviour
is perfectly fine.  I was just reacting to this message ...

> +	die("Invalid proxy URL '%s': host must be localhost if a path is present",

... that results when strcasecmp() does not like it.

Thanks.

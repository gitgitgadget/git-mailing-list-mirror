Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA4A50
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392285; cv=none; b=OQuXTg1bm4khW9iOFogZWy2VFtRqmdcsziKrvh6KaOxixlzG4HOLlrK01xOo6tEyQaimN/ej/EHXfausAi6kl6qBcVAFaYuYfsDmVOVqqSBo94/eQsiwIsUKXBmxYQ7QtGoItYiT60C24JpQkQsmyoRAuV1sTEEAM1HHStClo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392285; c=relaxed/simple;
	bh=HXWwyLi79WNC7F0SyEPUDKp3I7I7J7oLDKPo6sNGP7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NTBe7LQfLhguJ1C4+5F227jyOPVaYra9Z+/NL1F0V7Kkqsrv7Of5yfx8kt6z9XSFhEBEvEZadwZPnIa3CY1WEQFY09Yv31VIPpQ9P2Z6NNba9fDMntUTNAlIZUjx+FE6EnMUViTSoBX7JkpNCEIh8y8cpc1TLRn3u5YHqqy4EwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r8YEh0yK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r8YEh0yK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 225BE1E9410;
	Mon, 25 Mar 2024 14:44:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HXWwyLi79WNC7F0SyEPUDKp3I7I7J7oLDKPo6s
	NGP7k=; b=r8YEh0yKsjEeaHbg+FUS7RntUlpaG2+zQ0PqpoT0VjMji/30q28DHr
	bSdq1SLRmKQkgQXGJYv4gJ1PeuGyTF+dZL9b87l0Jt875qgHWsJ22DYwbYfvS3P1
	xKktKAdYUJllcjVoRq+0p4icRC4edn6P1CbBam5n3Kfp/FVlkvnZ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B50B1E940F;
	Mon, 25 Mar 2024 14:44:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8649E1E940E;
	Mon, 25 Mar 2024 14:44:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: use child_process_clear() to clean
In-Reply-To: <20240322233656.GB2049941@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 22 Mar 2024 19:36:56 -0400")
References: <20240322103502.GA2045297@coredump.intra.peff.net>
	<xmqqedc218to.fsf@gitster.g>
	<20240322233656.GB2049941@coredump.intra.peff.net>
Date: Mon, 25 Mar 2024 11:44:41 -0700
Message-ID: <xmqqedbykv6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BE3DEE58-EAD7-11EE-A204-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>> I wonder what are in .env array at this point, though, but that is
>> mere curiosity and not a problem with this patch.
>
> It's $GIT_REFLOG_ACTION for the sub-process.

Ah, OK.

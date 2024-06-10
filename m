Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6414E2E3
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050091; cv=none; b=WZe+lj2VHcQ6tBx6k7/aEN5o5f85RfaCvRIjLeirklLOavu7mvA7NYTeSEARM9cQAhwmIOeOJn4KkK3g2MPp6c3lS6HLL4F+Bx3w2GdvGDIFg5NJD0tuuVhyakXCPqbpk54xmUhSJOiOdQ248/VI7HKz+JH2GcrHB49G7a2BiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050091; c=relaxed/simple;
	bh=V43iojzdw9K5cIxqpQfGjI8ZIDZvNZJS7XdvTcm63Rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iaV+8xVS8RhoLeUY+2EoJjIKwepVm/PP9krfTUR/fuP+2hfp05uSYbld4C1bA1b1FD6n84NuaGnKF9m9xP83f4EPnvDO7Pjo0fi832JcrRw4PhJp2MeCgzZlbMeZ1RRqAiA6+JKzMLJTQrnOncmlq9CL6a/e+WBSIpirOngy4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWlUBVc2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWlUBVc2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 61D9630B4E;
	Mon, 10 Jun 2024 16:08:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V43iojzdw9K5cIxqpQfGjI8ZIDZvNZJS7XdvTc
	m63Rg=; b=BWlUBVc24oYWSxN40nItkSV/vCVQnRpQIiFTVPtKGif4v+GosJNBoq
	U0eSxNXMtVA8i2S0MOyyJqYut+eERP4D/Jik8NxgUXN0IOBRdxebAg8jo3RnRw/I
	Hr6xXykGiSPTLJtu0YnLtfMMSE2s0i9NI5X13UgUXvuoniYlKejwM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B4BA30B4D;
	Mon, 10 Jun 2024 16:08:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1138430B4C;
	Mon, 10 Jun 2024 16:08:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: phillip.wood@dunelm.org.uk,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Jeff King
 <peff@peff.net>,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <1a9f8385377d3aadfeb07ad62810b2df@manjaro.org> (Dragan Simic's
	message of "Mon, 10 Jun 2024 21:28:40 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<20240604101700.GA1781455@coredump.intra.peff.net>
	<xmqqikyo207f.fsf@gitster.g>
	<20240605090935.GF2345232@coredump.intra.peff.net>
	<6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
	<a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
	<219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
	<9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
	<1a9f8385377d3aadfeb07ad62810b2df@manjaro.org>
Date: Mon, 10 Jun 2024 13:08:04 -0700
Message-ID: <xmqqle3c1ryz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26616194-2765-11EF-9AF2-8F8B087618E4-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> If you want to see an example of the garbled output, as a result of the
> coloring escape sequences not being processed correctly, just "cd" into
> your favorite Git repository and run the following commands (assuming
> you're using bash, if not, please adjust the first command):
>
>   export GIT_PAGER='less'
>   git log --patch
>
> I hope that will make more clear why I'm "advocating" for three separate
> new commands for "git add -p", i.e. "P", "|xyz" and ">xyz".

We are talking about folks who use a pager in the context of Git,
and to them, your example is totally made-up and irrelevant one.

Either they use a color-enabled pager (like "less -R") or they have
configured color.ui to disable coloring.  So I do not see this quite
as a safety issue.


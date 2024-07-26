Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB311C6BE
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015920; cv=none; b=kAbbvGDisACAnggQgDcK/SNJtQMWRqewy37Usz++TZG7JuvUAsTcIRU5/AjyykiY8dr3zpUICGOQk0detj8AnxOHnu8rlR1H10lMZGerRnr884X5+c95mP0uUXU4ZCLNWHOv1DYeetcBuPZQxkRf1o97ZZudwXLXBC/hAtdceRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015920; c=relaxed/simple;
	bh=jYyzNF/B7Cnre47ZPciN/TFYmcFehvRKuBl0JMBFptc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZereXRcCWKHVzPkMW+XIb7AQ85JBZ3LEwK+6oYl7yE3xJjVGBdx5cqdmUJPxpb2eZkgLTPC1QXQ/FxfiVJ1EZ9Md6VB4wfloqcWzc1jJ931tmn6WhYh1oue9hh/L3KfnzRs/XBw/Mi7h2Jam8yemZXQRBLAPp5eayqnBTrHXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rRjBA/d4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rRjBA/d4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A8193597C;
	Fri, 26 Jul 2024 13:45:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jYyzNF/B7Cnre47ZPciN/TFYmcFehvRKuBl0JM
	BFptc=; b=rRjBA/d4vUrMQnIDsX7oe29+cv1CTG9g+lKbgTyovsLZm2X5VaHfcV
	SZxWvp5N/4PdqTZ+zROSvkA9BiwuEeloZ1yLSjo49fwWzg8eWPaaLZO3Fu0k5bqv
	whTfpXN7VlFaHOaRI5SRhrxEFH3GzzFlh4gCnpMHnBet6b0YBd4/g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 634B73597B;
	Fri, 26 Jul 2024 13:45:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E219C3597A;
	Fri, 26 Jul 2024 13:45:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] http: do not ignore proxy path
In-Reply-To: <6b408a07-f2ff-1e04-5b3a-fd287fb1c151@alum.mit.edu> (Ryan
	Hendrickson's message of "Fri, 26 Jul 2024 13:12:51 -0400 (EDT)")
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
	<xmqqr0bgw1z1.fsf@gitster.g>
	<6b408a07-f2ff-1e04-5b3a-fd287fb1c151@alum.mit.edu>
Date: Fri, 26 Jul 2024 10:45:13 -0700
Message-ID: <xmqq5xssvyhi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D094597A-4B76-11EF-AA44-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> writes:

> For what it's worth, I was following the precedent set by the
> if-statement starting at line 1256 (a few lines above this patch):

It is worth nothing.  Existing violation does not make it a good
idea to add more of them.  It makes it more work to clean them all
up later.

>> Could existing users have been taking advantage of the fact that the
>> extra /path at the end of http.proxy (and $http_proxy and friends)
>> are ignored?  For them, this change will appear as a regression.
>
> That is possible, though I have difficulty imagining a scenario in
> which it would be intentional.
>
> What do you recommend I do about that possibility?

I have no idea.  I already said that I am not familiar with this
code path, and it is likely I am a worse person than you are to find
a potential creative (ab)uses of the mechanism to take advantage of
the fact that the current code ignores the path part.

Having said that, given that http.proxy falls back to environment
variables that have been established a lot longer than Git itself,
like HTTPS_PROXY etc., if we _know_ that setting HTTPS_PROXY to such
a value with /path part causes curl (or other popular programs) to
try using such a value without stripping the path part (and even
better if that causes them to fail), then such an observation would
make a very good argument why it is extremely unlikely that existing
users used such a setting, hence it is unlikely this patch would
make a regression.

Thanks.

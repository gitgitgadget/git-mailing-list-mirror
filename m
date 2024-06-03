Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770D13791F
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435805; cv=none; b=jh3kOu1IfiwETMxgG1HjjYpP0uHXccCAsrGoUZUhCREzSwORTeKIUi1mJ7jTz3G4h3Hji4GhO8rLN/dk4l0K9hx5u9z200K8uBWY+a8MmwZ6N7ZyJfb5uoeT7FgfJ0/n3OxLwU7S6Oyd2ZAXMkbu/b7qdEWd3Er3GSwvQqEXOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435805; c=relaxed/simple;
	bh=LDtYQwBjkge7D6KryxNxVgcCRFT1Qgixzc/GEPEjzCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJvZYFKf+cX4QEOiK8U9yBTvisyEGjg04nkCnkjDMdKmSNQoVXAAXGYALyLLYpjpPROvXIvnLAjOMSkXZXplxsS+2bQ9Ftm18YD7HMjdMJXj9SxQ80MrT8rpZCGxzTTXCt7fIQnQROTQOPSXn5HUkPyTO5JZmzJtn5M4EKoJT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hzrDbeAM; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hzrDbeAM"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F6CC3417F;
	Mon,  3 Jun 2024 13:29:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LDtYQwBjkge7D6KryxNxVgcCRFT1Qgixzc/GEP
	EjzCM=; b=hzrDbeAMycQ/HG+0d2rw5X2R0ppWi0a9Og1FuZ3OYJ0kRIjI4FF9Dm
	F7h9mroW/euDkB/f31uIuKQsQuNy7ZuBSnv2nnnheGsNxRh7lpTzdQIs/QyV6nJX
	k8Si9pr0vhLZ4MdcEUjOxlZnnzv8qCE7j7SPmMs/rIM199eyAZ4hs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F1C53417E;
	Mon,  3 Jun 2024 13:29:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91CBB3417B;
	Mon,  3 Jun 2024 13:29:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
In-Reply-To: <CAP8UFD0aiBY27_8HqjyMtze1ZcME2gZVTMyB=botNErmu_CJDg@mail.gmail.com>
	(Christian Couder's message of "Mon, 3 Jun 2024 17:01:10 +0200")
References: <20221012135114.294680-1-christian.couder@gmail.com>
	<20240515132543.851987-1-christian.couder@gmail.com>
	<20240515132543.851987-4-christian.couder@gmail.com>
	<xmqqv83fvw7p.fsf@gitster.g>
	<CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
	<xmqqjzjikhdz.fsf@gitster.g>
	<CAP8UFD1_aHwbhF12v-miCTWEbbgjtpjTCmkRmFHu4Vusezq6dA@mail.gmail.com>
	<xmqq34q27wzg.fsf@gitster.g>
	<CAP8UFD18Y=NhnnzcHoBOiO7bu_VrxnHOeLgUeqiADQPcgtMW=A@mail.gmail.com>
	<xmqqwmn9athc.fsf@gitster.g>
	<CAP8UFD0aiBY27_8HqjyMtze1ZcME2gZVTMyB=botNErmu_CJDg@mail.gmail.com>
Date: Mon, 03 Jun 2024 10:29:55 -0700
Message-ID: <xmqq1q5e3pf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E55256EA-21CE-11EF-B135-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Alternatively, if C would pass a new option called for example
> --known-promisor=X on top of all other options, then that could be Ok
> too?

Why do you need a new option "--known-promisor=X" in the first
place?  Doesn't it known by the repository already and you do not
have to bother the end user to supply it from the command line, no?

In any case, a protocol extension that lets S tell C that S wants C
to fetch missing objects from X (which means that if C knows about X
in its ".git/config" then there is no need for end-user interaction
at all), or a protocol extension that C tells S that C is willing to
see objects available from X omitted when S does not have them
(again, this could be done by looking at ".git/config" at C, but
there may be security implications???).  Either would work OK and I
offhand do not see much preference between the two.  

What is important is to ensure that such deliberate omission by S is
safe and acceptable by C.

Thanks.


[Footnote]

By the way, I briefly wondered: would "X" that is valid for "C" be
always valid for "S" these days?

I as "S" may prefer you as "C" to go ssh://gitlab.com/x.git but you
may only be able to go https://gitlab.com/x.git for networking
reasons.  Silly situation like that may make communicating "X"
between "S" and "C" a bit harder than we would like.  Of course this
is not a high priority issue as the user with such networking need
are probably already using url.X.insteadof to rewrite the submodule
paths recommended in .gitmodules after they clone a superproject,
iow, even if it were a problem, it is a solved one.

So, in short, yes, exchanging the known promisor "X" between "S" and
"C", regardless of which side speaks first, as long as the negotiation
makes sure both sides agree, would be a good direction to go, I
would think.



Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA303EA8E
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557629; cv=none; b=q4zTTwr2jaWhaPxjKLfaDb3rEMtc40KbZgk3ucgcT6MwtLrqwOhIXoHcGA0idGZHUR+AJH9DR9EvfB+Tx7ocS7bmGpXDwrauFWTgpaHdtRzh682CYyE05JOw+dVF4MPR5R51xAUvreGSU6ijVP59SbnZ6+4SywjAQQzNyOkxFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557629; c=relaxed/simple;
	bh=EUlCnQi5DnNo9L5beAFGJBTyUap8U+I7lWRzUE4qL5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lR6Q/szGBOABusaFbfL2kvVHzP3Yi03wtHgqCzCHRjh6fJccP4sL1RF6FLrzl5kRRdCaPLbxO0hDKJc2w8+GJwZ0XfpXbFoUdPRpWE3PMoe4CjRX7sdd/aQ4ZAnXCJdaEKsKBEsvJxmE5V3jphVd2e0Uu+htbYYnDa6dzZv41mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZJZUGKks; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZJZUGKks"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CEEA1339B2;
	Wed, 21 Feb 2024 18:20:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EUlCnQi5DnNo9L5beAFGJBTyUap8U+I7lWRzUE
	4qL5o=; b=ZJZUGKksnR1SIf6QigCdaFXKPAlH7dAvi1o/+2/SjnIZL+xILtCFN4
	6d2JDUgOjpqvWGJMJIpwZsuGlQ+e00uvKwAFeFxTyPHN3xDNGNhJwUdkRvhWEIPp
	Qv+To6uFY3+EzXAQDo5ddOlfXoNDY8AFZ8wENJUwnPXtVg1zlXh8k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C65F1339B1;
	Wed, 21 Feb 2024 18:20:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64B7E339AD;
	Wed, 21 Feb 2024 18:20:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: script to pre-build all commits in a git-bisect, and use them
 during testing
In-Reply-To: <CAC4O8c-tgDQ42upWorMi3Cw+KdPoHT2YxvZEirt_dtjQXreXAw@mail.gmail.com>
	(Britton Kerin's message of "Wed, 21 Feb 2024 13:57:55 -0900")
References: <CAC4O8c-tgDQ42upWorMi3Cw+KdPoHT2YxvZEirt_dtjQXreXAw@mail.gmail.com>
Date: Wed, 21 Feb 2024 15:20:22 -0800
Message-ID: <xmqqo7c9l809.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CA543882-D10F-11EE-9108-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Britton Kerin <britton.kerin@gmail.com> writes:

> Problem: it's annoying to have to build each commit when
> git-bisect'ing for something that isn't being tested automatically (so
> no git bisect run).
>
> Solution: https://github.com/bkerin/git-batch-bisect

So, because "git bisect run" would not be usable for whatever reason
to run a "build and then test" from the command line, you would
build all revisions using

    git batch-bisect runinall 'autoreconf --install && ./configure && make'

before starting to test any revision, and then after building
everything, you would do:

    git batch-bisect runincurrent ./test_program
    git batch-bisect good
    git batch-bisect runincurrent ./test_program
    git batch-bisect bad
    ...

where ./test_program cannot signal if it is good or bad mechanically
(e.g., by exiting with non-zero status for failure) but the testers
need to judge the good/bad manually before they can say "git
batch-bisect good/bad", I presume.

It's an interesting workaround for a test program that cannot be
automated.  You are willing to waste CPU cycles and diskspace to
build upfront and hold the build products for all N revisions in the
range, where with bisection you would have to build far fewer
revisions (which is the point of bisection), to optimize for
developer/tester latency, which tends to be more expensive.  The
trade-off may make good sense.

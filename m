Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726F38DCC
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373286; cv=none; b=FMsUbD8YMFqSiipAVhr3/IdGlKkIRdqojmRzzGx0QYU1TU5On3ARiF6duldDkW01SfU5y6WuX2/w4PnGpL+1VHsux/kVlHQkCEF2vG8j0ej/SEHPnKIbxdInlnRpoC6JG43GguKKT2eBKh1iXppaxjStFSCdelOFgNev/ZHexF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373286; c=relaxed/simple;
	bh=aB4jhtWCDPgjXS4RvubZeqS7oVfCFfK9v6LuxBZL11M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/jTmCy9HP4iOzjKR0BoSeg9Ue2VVryyIoPMBKyIotCSc4SOEFy0eo7y+MPZSOF1y+BSx16RR18f9l9pqzmCOVFD6ct39hHWi2D/jVHq56DcAVhki3l7/k0KJWLYb5jmnO9OI8OMsmhpuO4aKTBczA4+SrcczLRzeDp+HY80QFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y5fJFEeK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5fJFEeK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FF27337FE;
	Fri, 10 May 2024 16:34:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aB4jhtWCDPgjXS4RvubZeqS7oVfCFfK9v6LuxB
	ZL11M=; b=Y5fJFEeKm9rw+WPtvn8PasZBdOCQIIuWkGP2qn3G2G33Hx5NLUOAr/
	gD4sQ3PBzUieCuh387yr9M/hh6XmzVZNuZUOFZd17BTjd8FkVU0cBEXSZ4Esyk+Y
	G+04NaIzEMrS64nvZ5BHM+JFuJqSb+BPNxNzAaCq5qywY5i7bwLbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 083D8337FD;
	Fri, 10 May 2024 16:34:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A4EB337F9;
	Fri, 10 May 2024 16:34:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  git@jeffhostetler.com
Subject: Re: [PATCH] trace2: intercept all common signals
In-Reply-To: <CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>
	(Emily Shaffer's message of "Fri, 10 May 2024 12:34:07 -0700")
References: <20240510172243.3529851-1-emilyshaffer@google.com>
	<xmqqv83l4i86.fsf@gitster.g>
	<CAJoAoZmvzZaLN6cQkH4XeD9-=OwWFjT1adRA1oFHaUVyVWwLXQ@mail.gmail.com>
Date: Fri, 10 May 2024 13:34:42 -0700
Message-ID: <xmqqle4h4d99.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BBAD4E78-0F0C-11EF-AA3F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> While I'm at it, since you pointed out ! instead of test_must_fail, I
> wondered if I should change "! test_grep" as well - but when I grep t/
> it looks like it's not usual to use `test_must_fail test_grep`, but
> instead to use `test_grep ! <omitted pattern> <file>`. I'll change
> that too.

"! test_grep" is an anti-pattern.  We should have a documentation
somewhere in t/README or nearby (if we don't, somebody please add
one).

The point of test_grep is "when we expect to see hits, we do show
them to the standard output even if we just used a bare 'grep', but
when such a test fails, we can easily miss the failure, because the
failure is signalled only by $? and no output---hence, test_grep
helper loudly says that we expected to find something but we did not
see any".  Using "! test_grep" will make "! grep" louder in a wrong
case.  That is the whole reason why "test_grep !" exists.

> I also wonder - do we want to capture SIGKILL as well?

An eternally interesting question is "How would you catch an
uncatchable signal?" ;-)

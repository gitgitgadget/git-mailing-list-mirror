Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0411CF81
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124516; cv=none; b=HQbYpdX57tWZ6O4x1fXbhdU3k1IkZsGADidshM9FrHXxYvYnNv1UfUteJoUJWwv1KiCB/0Wwf30EDy3I7HpeCZGar1QrA82k3GrD2loo7pEsoUMme4tjqjEUqY7OJin5vAIfuJOF+xK5lCY4U4eCprtQQRkjitpoimWW+/JEF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124516; c=relaxed/simple;
	bh=lXiwLS5sY2cWHxcQqMwOucCJV87j5dU//XEBDzqGTpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z523wdhgFg6rdHw9wcWCjljGhx99NaCB8l2E+3UM/pjOlNSLa0xxjraYF5sZp0Nl7diJI9cLNeW281UnSzCZ6YK5lydU3nuUTBKha9t4j7mKS6PFRz+aFlQvQ7BSwNX5Vax2fvTOPkKqcPxM9+qOZ+/wz6MMaaLkzzxay8NpceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TRn8x6lR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TRn8x6lR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D43D36E42;
	Fri, 16 Feb 2024 18:01:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lXiwLS5sY2cWHxcQqMwOucCJV87j5dU//XEBDz
	qGTpI=; b=TRn8x6lRtsnBklFW19Kio/MDLQNyRpu3KOtZD8lq+VsJyQwrWP0Vtm
	DUgbNXou2F/DKJ0Xkre+uZtbNqY6wFSFZhEkA2Or/y8Ey7sTD7Y3eBdLQh3eUJix
	6cZxv8n8lqoxhQ7h3gGb9A2JBvAelYp8a0Kf+UjpV0jyJdNoGC3i0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 56C9536E41;
	Fri, 16 Feb 2024 18:01:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E77A36E40;
	Fri, 16 Feb 2024 18:01:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
In-Reply-To: <owlyh6i882k4.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Fri, 16 Feb 2024 14:30:35 -0800")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<20240215053056.GD2821179@coredump.intra.peff.net>
	<xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g>
	<xmqqr0hcglpk.fsf_-_@gitster.g> <owlyh6i882k4.fsf@fine.c.googlers.com>
Date: Fri, 16 Feb 2024 15:01:48 -0800
Message-ID: <xmqq7cj4ggir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E54DBEE-CD1F-11EE-9FB4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

> FWIW, I see some typos. Otherwise this patch along with your "git:
> document GIT_NO_REPLACE_OBJECTS environment variable" one both LGTM for
> wording/readability. I must defer to Peff and others for "is this patch
> actually doing the right thing?" ;).
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Modeling after how the `--no-replace-objects` option is made usable
>> across subprocess spawning (e.g., cURL based remote helpers are
>> spawned as a separate process while running "git fetch"), allow the
>> `--no-lazy-fetch` option to be passed across process boundary.
>
> s/boundary/boundaries

Right; thanks.

>
>> Do not model how the value of GIT_NO_REPLACE_OBJECTS environment
>> variable is ignored, though.  Just use the usual git_env_bool() to
>> allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
>> to be equivalents.
>
> s/equivalents/equivalent

I meant to say that these two are "equivalents" (noun, plural).

I can rephrase to

	Just use git_env_bool() to make "export GIT_NO_LAZY_FETCH=0"
	an equivalent to "unset GIT_NO_LAZY_FETCH".

though, of course.

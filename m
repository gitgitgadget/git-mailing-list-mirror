Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61461AE878
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910254; cv=none; b=BLn5aQLHrt74HZKHpQp0AqofMNa1DvxVTnV34ukkuF05q8HfozQ9kGETjx3fl0C0W3Ud6Z8QMRlcZkDs8lAnv39zf0JhxyZcjDdULrzwLDiR96hk+CD9XAZw2+/jYYs7/fnbf5NncioR1X72qYgI+vr/x8rGeGcUJobKQN8a3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910254; c=relaxed/simple;
	bh=AXqRl/8sMAyuLbMGgk4uOZlM4Ue+brswHDIlpsdhC9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+6iiSLmIaqw33wC/MglE+ymU/7la9zd7/Dafq+yZZQfA5Gk7a36QBD5m37rxCYAVLskqPUs+79kXJ4Sa3B2NtLFckzDtESAWgi8fgOcgFn159oexQn4fhErUQqbos7GmbI5RPIa7pCEcfKYb2ldyZ98aNmZiO7FJJ47kfyRA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AG+A8sPg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AG+A8sPg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A672D1923C;
	Thu, 20 Jun 2024 15:04:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AXqRl/8sMAyu
	LbMGgk4uOZlM4Ue+brswHDIlpsdhC9I=; b=AG+A8sPgdi7bcSvLOCCTxsaJsvT/
	IgHSeUHeEDzYtNLW5hDhyJJK7/qDIC7Zdk1t30ENWYcbLj73Kpd8QP6BujF/YLxx
	qnHiYQ4D3W/5kiBBeVVHo/UbKcxGZQvCWVB8GHquT208QjuzTIcHbew1JKY4vldK
	aiROLwQ3ow4sW0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 96A531923B;
	Thu, 20 Jun 2024 15:04:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C10771923A;
	Thu, 20 Jun 2024 15:04:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] pager: die when paging to non-existing command
In-Reply-To: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 20 Jun 2024 19:25:43 +0200")
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
Date: Thu, 20 Jun 2024 12:04:03 -0700
Message-ID: <xmqqsex7tp0c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DCEE7760-2F37-11EF-A064-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Finally, it's worth noting that we are not changing the behavior if the
> command specified in GIT_PAGER is a shell command.  In such cases, it
> is:
>
>     $ GIT_PAGER=3D:\;non-existent t/test-terminal.perl git log
>     :;non-existent: 1: non-existent: not found
>     died of signal 13 at t/test-terminal.perl line 33.

IOW, the behaviours between the case where pager is spawned via the
shell and bypassing the shell are different , and the case where the
shell is involved behaves in a way that is easier to realize the
mistake, so change the other case to match.  WHich makes sense.

This seems to be an ancient regression introduced in bfdd9ffd
(Windows: Make the pager work., 2007-12-08), which did not really
affect anybody but MinGW users, but ea27a18c (spawn pager via
run_command interface, 2008-07-22) inherited the "if we failed to
start the pager, just silently return" from it when non-MinGW code
was unified to use the run_command() codepath (the latter is
attributed to Peff, which I presume is the reason why you cc'ed
him?).

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  pager.c          |  2 +-
>  t/t7006-pager.sh | 15 +++------------
>  2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/pager.c b/pager.c
> index e9e121db69..e4291cd0aa 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -137,7 +137,7 @@ void setup_pager(void)
>  	pager_process.in =3D -1;
>  	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
>  	if (start_command(&pager_process))
> -		return;
> +		die("unable to start the pager: '%s'", pager);

If this error string is not used elsewhere, it probably is a good
idea to "revert" to the original error message lost by ea27a18c,
which was:

		die("unable to execute pager '%s'", pager);

But I do not think of a reason why we want to avoid dying here.

Just in case there is a reason why we should instead silently return
on MinGW, I'll Cc the author of bfdd9ffd, though.

Will queue.  Thanks.

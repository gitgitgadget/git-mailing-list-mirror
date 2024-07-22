Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8017BCD
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692471; cv=none; b=p0107ivzbnSdgL4RTcRWa2ZmjI4z+iA09+GzyArbZKPKVr+faxyWSYut2lM7bfJAmvaS+dCoxv67PYPDf4KjBMpOW8Gqejj6IUfG8RhgfKbtouewfliyM5eIbcA8odoQns/vpBGVudEA4ddGSLczHPLW/qj5tR+rVUglNhESznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692471; c=relaxed/simple;
	bh=1M2c9BCYi7xJmr3YWdhB+yFU7RHnFyafT0NATyibwXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcmTdOo+VxYLjaHBTq1Fn1CmkaZVGfNIFvtgRiw6Ghba70PUOfYn9tCZ/HlTLIS5xZfVqIvZs1rTTl0wadfDv4JHaJLvChLOWkm2zEGg1Zk5IgnO6E68Pwj1eRDnOHh9KWQK0b5jrEBCTyZCTtorHf9vhnYbrlapR0Y2fI6koaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dFX9cJyh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dFX9cJyh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CAB952721A;
	Mon, 22 Jul 2024 19:54:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1M2c9BCYi7xJ
	mr3YWdhB+yFU7RHnFyafT0NATyibwXs=; b=dFX9cJyhzKjU0wzRoQ2w//pHxHQn
	oVQziSjeeVHZfAk3jnIn8p2FLv01PSaOy9rzXv9NzPs4x7udeVTOJ0XZ9bPLVQfU
	SBYnlHdYrLz2iuWjzI5x0IH1r2pMJg/nLUzuuiPK9szTef++3cvAiwhwEWdTTv+K
	NNtjxskTnsPbTI8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C2DD227219;
	Mon, 22 Jul 2024 19:54:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4EEE27217;
	Mon, 22 Jul 2024 19:54:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pager: make wait_for_pager a no-op for "cat"
In-Reply-To: <c37f0d54-4ead-422c-8193-f0c2ec84ca4a@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 23 Jul 2024 01:24:45 +0200")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
	<xmqqv80xcpe5.fsf@gitster.g>
	<079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
	<xmqq7cdd9l0m.fsf@gitster.g>
	<43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com>
	<c37f0d54-4ead-422c-8193-f0c2ec84ca4a@gmail.com>
Date: Mon, 22 Jul 2024 16:54:22 -0700
Message-ID: <xmqqikwx6l01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B8C4E7CC-4885-11EF-AE38-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> If we find that the configured pager is an empty string [*1*] or simply
> "cat" [*2*], then we return from `setup_pager()` silently without doing
> anything, allowing the output to go directly to the normal stdout.

I'm tempted to suggest inserting two extra paragraphs here to avoid
too big a leap in logic flow.

    Even though the caller may properly make matching calls to
    setup_pager() and wait_for_pager(), setup_pager() may return early
    without doing much, and the call to wait_for_pager() would segfault.

    This condition can be detected by old_fd1 being -1 (not modified in
    setup_pager())

> Let's make the call to `wait_for_pager()` for these cases, or any other
> future optimizations that may occur, also exit silently without doing
> anything.
>
>    1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.=
,
>                    2006-04-16)
>
>    2.- caef71a535 (Do not fork PAGER=3Dcat, 2006-04-16)
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---

I am not 100% sure about the "would segfault", but we'd need to be
explicit about what badness it causes to call wait_for_pager()
without starting a pager.  Other than that, well explained.

Thanks.

>  pager.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/pager.c b/pager.c
> index bea4345f6f..896f40fcd2 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -46,6 +46,9 @@ static void wait_for_pager_atexit(void)
> =20
>  void wait_for_pager(void)
>  {
> +	if (old_fd1 =3D=3D -1)
> +		return;
> +
>  	finish_pager();
>  	sigchain_pop_common();
>  	unsetenv("GIT_PAGER_IN_USE");

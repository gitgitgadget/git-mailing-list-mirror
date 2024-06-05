Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A619D893
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620277; cv=none; b=taMUi2ixqJrGGFMJXO+7AKYQehC5iAvhRImXMcTIVBcje5tJfGGHDlCyNgst/QwC7eMse9X9h4k1zqC2jTMg3T/Nqp990KW6Bf6BwBo/eQze9mh3FYsfUIbXIWu+8jSBbo3e9/t0DN5D4PF8PLDxVtU8H4sACK4ARdQ7uGxRZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620277; c=relaxed/simple;
	bh=jGaiCMUpNd7UvHbhvO68SV9ZayJSgZO1RbMjGCIykwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHB/FsJZZ5R2TTWzoYLlV9Ap6Cp5sebmGDm4zTMDkY18UPa4a2BEuzNvS9sqPx6+5O4S8ZDAL8RJl3tX4XZNrC52zdStAoI88NZcpCfQfTk3pzkh3G9VdFWaScXGw58JVd5n0uqRD/Nn7FHYQBhuItvUyFbg5UhCv49HLVA5xoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L6/pQthE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L6/pQthE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C159B1FC0A;
	Wed,  5 Jun 2024 16:44:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jGaiCMUpNd7U
	vHbhvO68SV9ZayJSgZO1RbMjGCIykwk=; b=L6/pQthEw4LfNnt9lsMHrc7Xwxlo
	NZCHltNjBkOFPrLGnqjXcj14FIsv16jtVE5dE/8MmJVR2qLaWbKwf+Jg8/DDTPSl
	kW5xSHyHg0pAuyYTINSbfhZlHpr91GFweqYflXHjmQiONXxsQuv0Pk422RPQ5ZP+
	S0B57lMgaR8vSOU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B899F1FC09;
	Wed,  5 Jun 2024 16:44:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 209681FC07;
	Wed,  5 Jun 2024 16:44:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] format-patch: assume --cover-letter for diff in
 multi-patch series
In-Reply-To: <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 5 Jun 2024 22:27:41 +0200")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
	<cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
Date: Wed, 05 Jun 2024 13:44:27 -0700
Message-ID: <xmqqr0dbqfv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6785CD00-237C-11EF-B2AE-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> +test_expect_success "format-patch --range-diff, implicit --cover-lette=
r" '
> +	test_must_fail git format-patch --no-cover-letter \
> +		-v2 --range-diff=3Dtopic main..unmodified &&
> +	test_must_fail git -c format.coverLetter=3Dno format-patch \
> +		-v2 --range-diff=3Dtopic main..unmodified &&
> +	git format-patch -v2 --range-diff=3Dtopic main..unmodified &&
> +	test_when_finished "rm v2-000?-*" &&
> +	test_grep "^Range-diff against v1:$" v2-0000-cover-letter.patch
> +'

Isn't this doing three separate things in a single test?  Unless it
is the local convention in this script, let's split them to three.
If "--no-cover-letter" fails to prevent v2-* files from getting
created, it would fail without hitting test_when_finished.  v2 was
already bad enough in that regard, but piling two more things that
could fail on top is making it even worse, no?

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index ba85b582c5..b96348eebd 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -2492,6 +2492,16 @@ test_expect_success 'interdiff: solo-patch' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'interdiff: multi-patch, implicit --cover-letter' =
'
> +	test_must_fail git format-patch --no-cover-letter \
> +		--interdiff=3Dboop~2 -2 -v23 &&
> +	test_must_fail git -c format.coverLetter=3Dno format-patch \
> +		--interdiff=3Dboop~2 -2 -v23 &&
> +	git format-patch --interdiff=3Dboop~2 -2 -v23 &&
> +	test_grep "^Interdiff against v22:$" v23-0000-cover-letter.patch &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'format-patch does not respect diff.noprefix' '
>  	git -c diff.noprefix format-patch -1 --stdout >actual &&
>  	grep "^--- a/blorp" actual

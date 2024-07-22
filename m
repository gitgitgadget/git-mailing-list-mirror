Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32418042
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691883; cv=none; b=fc0M0sM6lvMvZtfenNHw8hP+UQMTU4sJyd+fLroWJEvphzVvkPwqgL+uVxopmBRqwyzB/xvdGxRrN4drWHUgtGYYg5tMUqFkBWO2aHxMmROrKiDLyvaB6m7vjoWFx1QpVJhxAcswVA6Y5PFT2VU7r/6Ji8bo/zzOKvj0UK/4+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691883; c=relaxed/simple;
	bh=7P20hHFTsTls+IlAxBFoEn0McJ3pK8YtzEEc0+bib4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jbBKez7JBbKC9ADbnI/oNvy1whoTS2IoSwBK2w2u+uJN2JvZvIXq9PgHMRWEYBp3yW6zgZtMIXKwS0ObRSQkHAAJfyv1bwuYADJVHwyWIM0aWy1GJBxiafU7peZVLsPNNm4X7ca3Kh9vleuV6VbHc+fB1SOewslwpbLMm8fRLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fcRYpuJZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcRYpuJZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BCFD24085;
	Mon, 22 Jul 2024 19:44:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7P20hHFTsTls
	+IlAxBFoEn0McJ3pK8YtzEEc0+bib4I=; b=fcRYpuJZ3wiT92sDTwMKWRULuH9b
	NVUi0nhdcJkiwqkluqB02x/JnlrR8jSvyy4/XsQoILcfFn9XEN2gX7laPL4JXTlr
	Z94wrvQajHBamAp9VvYQjRpPKZxfxwqhkcEtvUhXRW5Wo2hFYHv7nTMyuDREhunZ
	XvzzOPFDbITU6e8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7262124084;
	Mon, 22 Jul 2024 19:44:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9ED524083;
	Mon, 22 Jul 2024 19:44:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3701: avoid one-shot export for shell functions
In-Reply-To: <5536b336-5122-47fd-be57-42c299abe60c@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 23 Jul 2024 01:24:20 +0200")
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
	<5536b336-5122-47fd-be57-42c299abe60c@gmail.com>
Date: Mon, 22 Jul 2024 16:44:38 -0700
Message-ID: <xmqqsew16lg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5CA685BE-4884-11EF-A9FF-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> The common construct:
>
>     VAR=3DVAL command args
>
> it's a common way to define one-shot variables within the scope of
> executing a "command".

"it's a" -> "is a".
"define" -> "set and export".

> However, when "command" is a function which in turn executes the
> "command", the behavior varies depending on the shell:
>
>  ** Bash 5.2.21 **
>
>     $ f () { bash -c 'echo A=3D$A'; }
>     $ A=3D1 f
>     A=3D1
>
>  ** dash 0.5.12-9 **
>
>     $ f () { bash -c 'echo A=3D$A'; }
>     $ A=3D1 f
>     A=3D1
>
>  ** dash 0.5.10.2-6 **
>
>     $ f () { bash -c 'echo A=3D$A'; }
>     $ A=3D1 f
>     A=3D
>
> One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
> 0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
> tested did not get our custom GIT_PAGER, which broke the test.
>
> Work it around by explicitly exporting the variable in a subshell.

Nicely described.

>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  t/t3701-add-interactive.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index c60589cb94..1b8617e0c1 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -616,7 +616,11 @@ test_expect_success TTY 'P handles SIGPIPE when wr=
iting to pager' '
>  	test_when_finished "rm -f huge_file; git reset" &&
>  	printf "\n%2500000s" Y >huge_file &&
>  	git add -N huge_file &&
> -	test_write_lines P q | GIT_PAGER=3D"head -n 1" test_terminal git add =
-p
> +	test_write_lines P q | (
> +		GIT_PAGER=3D"head -n 1" &&
> +		export GIT_PAGER &&
> +		test_terminal git add -p
> +	)
>  '
> =20
>  test_expect_success 'split hunk "add -p (edit)"' '

Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF1149C7D
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519392; cv=none; b=cRCw2SCeWN6aO1XzZPUQ5NrKYU20VpDlQdVusA66J2gi9bdq6dacpdthf4QGlPeiWXMsSkAxKxa61fmZR6D0dTMn4nOq+vpfOrJaEcDFJSaf9V5B+2IgSQUOFPAsfRr/tk3QlzK1NWpwXvodxURw3huHw6WSuS6xSwdN/1aa1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519392; c=relaxed/simple;
	bh=AG+foCOOj8brNS6yEgXrBFYgwxA7DM9Tbg7DmHy3pF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L5CFxkyFU091Ynmt8E1Opqsic2haLf7UVaYIPZc1GNotjeIzaiUmnJLYT3Avye5NX4JNqUs1D9GPPCaj31Dy0NWVJCsCum0tfZOU1SH94utpcq+1xhT8NxPXSUKRydo1BgmxsSo5sRmQqFKvLPD1KeS/FpaHjWb463EgLapoFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FkhZJZVo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FkhZJZVo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9F091CA7F;
	Tue,  4 Jun 2024 12:43:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AG+foCOOj8br
	NS6yEgXrBFYgwxA7DM9Tbg7DmHy3pF8=; b=FkhZJZVo8K/wQStXFOrIbzaFLm78
	v6nLH7CeI1slKjRzE/cv57iej96Vl5jq0K3Qcp/+scSSLTrPbOb/iMOT8i0yXgMQ
	7RbpduLjOdGMviLzeJaHG95jL0DmSzCWLSZwrjq09nIcYlT7sfATK2WcrsF8VSQ1
	irXnPZP00qKgdIk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0F141CA7E;
	Tue,  4 Jun 2024 12:43:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 247941CA7C;
	Tue,  4 Jun 2024 12:43:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 4/6] pager: introduce setup_custom_pager
In-Reply-To: <3fa0ade6-d710-47ce-8bcd-81d7821dfffb@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 3 Jun 2024 22:38:27 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
	<3fa0ade6-d710-47ce-8bcd-81d7821dfffb@gmail.com>
Date: Tue, 04 Jun 2024 09:43:04 -0700
Message-ID: <xmqq8qzkzmjr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8493F638-2291-11EF-8075-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Introduce a new function setup_custom_pager() to allow setting up our
> pager mechanism using a custom pager.  If the custom pager specified is
> NULL or an empty string, use the normal pager as setup_pager() currentl=
y
> does.

We often see "if the pointer is NULL or points at an empty string"
in code that were originally ported from the scripted Porcelain, but
I doubt we would want to follow that pattern in new code paths.

>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  pager.c | 17 +++++++++++------
>  pager.h |  6 +++++-
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/pager.c b/pager.c
> index 925f860335..21a7d9cd60 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -74,14 +74,13 @@ static int core_pager_config(const char *var, const=
 char *value,
>  	return 0;
>  }
> =20
> -const char *git_pager(int stdout_is_tty)
> +static const char *git_pager_custom(int stdout_is_tty, const char* pag=
er)

Call it git_custom_pager(), to be more grammatical and also match
the other one, setup_custom_pager().

The asterisk should stick to "pager", not its type.

>  {
> -	const char *pager;
> -
>  	if (!stdout_is_tty)
>  		return NULL;
> =20
> -	pager =3D getenv("GIT_PAGER");
> +	if (!pager || !*pager)
> +		pager =3D getenv("GIT_PAGER");

We often see "if the pointer is NULL or points at an empty string"
in code that were originally ported from the scripted Porcelain, but
I doubt we would want to follow that pattern in new code paths.

> @@ -97,6 +96,11 @@ const char *git_pager(int stdout_is_tty)
>  	return pager;
>  }
> =20
> +const char *git_pager(int stdout_is_tty)
> +{
> +	return git_pager_custom(stdout_is_tty, NULL);
> +}

OK.

> @@ -132,10 +136,11 @@ void prepare_pager_args(struct child_process *pag=
er_process, const char *pager)
>  	pager_process->trace2_child_class =3D "pager";
>  }
> =20
> -void setup_pager(void)
> +void setup_custom_pager(const char* pager)

The asterisk should stick to "pager", not its type.

>  {
>  	static int once =3D 0;
> -	const char *pager =3D git_pager(isatty(1));
> +
> +	pager =3D git_pager_custom(isatty(1), pager);

This feels a bit too convoluted.  This thing already knows if it got
a custom one from its caller because "*pager" is _its_ parameter.
Perhaps rip out all the changes before and including the hunk
"@@ -132,10 +136,11 @@" and start it like so, perhaps?

	void setup_custom_pager(const char *pager)
	{
		if (!pager)
			pager =3D git_pager(isatty(1));
		...

> diff --git a/pager.h b/pager.h
> index 103ecac476..2166662361 100644
> --- a/pager.h
> +++ b/pager.h
> @@ -4,7 +4,11 @@
>  struct child_process;
> =20
>  const char *git_pager(int stdout_is_tty);
> -void setup_pager(void);
> +void setup_custom_pager(const char*);
> +static inline void setup_pager(void)
> +{
> +	setup_custom_pager(NULL);
> +}

A good approach to help existing callers---there are more than half
a dozen existing callers to setup_pager() in the code base.  We
could migrate them all away to pass NULL but it would be totally
outside the scope of this topic.

Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1D1487C9
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518339; cv=none; b=fGmaWflJn5sqCCywhS/wAZ7A5VSXujx1L31jJ1RuZQkPAbHlxNmh4CzQCQxqei1vYsU0RaIDHlWWlR7yn2shGbxdWnkjLZDfh0mhzrwbDK8c1X2E2oPwhcYzeuVPT7zQ19G7nlcAP0dF95BXLEdkN8ZsTiXm+MKlAQ7KdUquQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518339; c=relaxed/simple;
	bh=VR/0wf8ejm3UMYV9KGr0ndaC3HKbil3RlwlDBw0x0D8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PLiL/OqSgu4Q+5SILWS4KaJGVVemp5Wswh2tiYp/aIYTtWwpraih2AVKqWP/a4OUlibMnETUDIdY+2OLwfT2R+HCUd0zMj8iFFsPHf2Bj5E3XSDfvZNOGQ729swWuJ/nxlsGKKYRZuNboQUft8vVlPLxK6xTIrqJUaaHuc0q0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DznaDb1i; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DznaDb1i"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6586353D5;
	Tue,  4 Jun 2024 12:25:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VR/0wf8ejm3U
	MYV9KGr0ndaC3HKbil3RlwlDBw0x0D8=; b=DznaDb1i1MC1Rxp6V4yyn2VbUwex
	GAHvZ0OArnXHICyDKkxd+2vDfnx9Uk20rPuOBGYTIhSFnN7YjIUBK2PExPrRVpua
	RkCX+5fVnPtaCA2/FrVl3RSSck9txn0PsuS2pAApswPn3feIQ6X8XmM/RMG/ad0J
	bUxQD4mizEMHZ7o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E890353D4;
	Tue,  4 Jun 2024 12:25:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08736353D3;
	Tue,  4 Jun 2024 12:25:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/6] pager: introduce wait_for_pager
In-Reply-To: <76c725b4-1bc4-4916-81d8-98cad8fc4ca0@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 3 Jun 2024 22:38:19 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
	<76c725b4-1bc4-4916-81d8-98cad8fc4ca0@gmail.com>
Date: Tue, 04 Jun 2024 09:25:34 -0700
Message-ID: <xmqqsexszncx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 12A92F4A-228F-11EF-80F5-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>  static struct child_process pager_process;
>  static const char *pager_program;
> -static int close_fd2;
> +static int old_fd1 =3D -1, old_fd2 =3D -1;

;-)

Presumably when old_fd2 does not have a valid value (i.e. -1) it
means we did not do dup2() to save it away, and we refrain from
closing #2 in that case?

It is curious that #1 did not have similar problem 2/6 addressed,
as we never redirected it with dup() to save it away.  But now we
do for some reason that the proposed log message did not explain.
We should say something like

    We need to take back the standard output and the standard error
    stream after we are done with an invocation of the pager.  For
    that, save away the original file descriptors 1 and 2 when
    spawning the pager, and restore them once the pager exits.  The
    presence of saved fd#2 can be used to replace the "close_fd2"
    flag introduced in the previous patch.

perhaps.

>  /* Is the value coming back from term_columns() just a guess? */
>  static int term_columns_guessed;
> @@ -24,20 +24,41 @@ static void close_pager_fds(void)
>  {
>  	/* signal EOF to pager */
>  	close(1);
> -	if (close_fd2)
> +	if (old_fd2 !=3D -1)
>  		close(2);
>  }

OK.

>  static void wait_for_pager_atexit(void)
>  {
> +	if (old_fd1 =3D=3D -1)
> +		return;
> +
>  	fflush(stdout);
>  	fflush(stderr);
>  	close_pager_fds();
>  	finish_command(&pager_process);
>  }
> =20
> +void wait_for_pager(void)
> +{
> +	if (old_fd1 =3D=3D -1)
> +		return;
> +
> +	wait_for_pager_atexit();
> +	unsetenv("GIT_PAGER_IN_USE");
> +	dup2(old_fd1, 1);
> +	old_fd1 =3D -1;
> +	if (old_fd2 !=3D -1) {
> +		dup2(old_fd2, 2);
> +		old_fd2 =3D -1;
> +	}
> +}

Presumably these use old_fd1's validity as a signal to see if have
pager running that need to be cleaned up?  It feels a bit unnatural
why we do not ask about such a process the structure that is set up
to control it, namely, the pager_process structure, but this is OK
for now.

It is just a naming issue, but it smells strange that the normal
code path (wait_for_pager()) calls a function that is an atexit
handler, which is more specific and only to be called atexit.

I would have made

	static void finish_pager(void)
	{
		fflush(stdout);
		fflush(stderr);
		close_pager_fds();
		finish_command(&pager_process);
	}

and then called it from the atexit handler and wait_for_pager().

> @@ -113,6 +134,7 @@ void prepare_pager_args(struct child_process *pager=
_process, const char *pager)
> =20
>  void setup_pager(void)
>  {
> +	static int once =3D 0;
>  	const char *pager =3D git_pager(isatty(1));
> =20
>  	if (!pager)
> @@ -142,16 +164,18 @@ void setup_pager(void)
>  		return;
> =20
>  	/* original process continues, but writes to the pipe */
> +	old_fd1 =3D dup(1);
>  	dup2(pager_process.in, 1);
>  	if (isatty(2)) {
> -		close_fd2 =3D 1;
> +		old_fd2 =3D dup(2);
>  		dup2(pager_process.in, 2);
>  	}
>  	close(pager_process.in);

Can dup(2) fail and return -1?

> =20
> -	/* this makes sure that the parent terminates after the pager */
> -	sigchain_push_common(wait_for_pager_signal);
> -	atexit(wait_for_pager_atexit);
> +	if (!once++) {
> +		sigchain_push_common(wait_for_pager_signal);
> +		atexit(wait_for_pager_atexit);
> +	}
>  }

Can we give a name better than "once" to this thing? =20

>  int pager_in_use(void)
> diff --git a/pager.h b/pager.h
> index b77433026d..103ecac476 100644
> --- a/pager.h
> +++ b/pager.h
> @@ -5,6 +5,7 @@ struct child_process;
> =20
>  const char *git_pager(int stdout_is_tty);
>  void setup_pager(void);
> +void wait_for_pager(void);
>  int pager_in_use(void);
>  int term_columns(void);
>  void term_clear_line(void);

Other than that, overall it looks good.

Thanks, will queue.

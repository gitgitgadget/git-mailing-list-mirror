Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512E1C32
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719426; cv=none; b=VcTy4FCEj0ZQegII+qLA+Y+tfexAWa6UWZl/+3Fyvg7boNreTp01vIW1+UUSzmpNASz4ehlZDer7LAxlNYb5krlH1aR/dV/MP5pkaaHt26qATRpg0Zz2+rjP8nvThpfQGdqDZdifl0HdvQWtL2g2ehCkRiAM7u8YbQsGZtBv3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719426; c=relaxed/simple;
	bh=L2P2rYaiB7sVLJ4RFMP9ZeYBHOK3mzE13KtvQ8ly60g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dm3ARkhT0EdFwM7lmizD7XfnYY6wHvTwpK9ppzFMjWjyoYa9XvCjvv/TPGo4sdL4+4h6ofVHKcenmJYI7lqMa0o6e+joEB0LqsQ4DSq7LxUf61PbBQ0LIspL8fZLCbrJ9r9gSM8AQfprF4FD2+TuO3xABjQh/H3OD4rNj8jx4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VtvL82m4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VtvL82m4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B9052AA9D;
	Mon, 26 Aug 2024 20:43:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L2P2rYaiB7sV
	LJ4RFMP9ZeYBHOK3mzE13KtvQ8ly60g=; b=VtvL82m47SG24srdtEBph/44DqnE
	CrbHSqJi/3SCJWb92TeTGQIl1eNpvYh3tJ+MfOEun4rWNNYuczB7ihUsbvF8Za1y
	Vegi6doaI3OQ1h8u8yzLAe2Tt7tk2+gcKK66plRRGDnTuxKGLeg7qJPMCKFrdTY0
	nelGlVxOiVxjoz0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 53B2E2AA9A;
	Mon, 26 Aug 2024 20:43:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D965C2AA99;
	Mon, 26 Aug 2024 20:43:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] apply: whitespace errors in context lines if we have
In-Reply-To: <5da09529-e95b-407b-9e66-34ebac4b4128@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 25 Aug 2024 12:18:44 +0200")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<5da09529-e95b-407b-9e66-34ebac4b4128@gmail.com>
Date: Mon, 26 Aug 2024 17:43:39 -0700
Message-ID: <xmqqo75eeqx0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 67B52FF6-640D-11EF-8544-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> If the user says `--no-ignore-space-change`, there's no need to
> check for whitespace errors in the context lines.
>
> Don't do it.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  apply.c                  | 3 ++-
>  t/t4124-apply-ws-rule.sh | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 0cb9d38e5a..e1b4d14dba 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1734,7 +1734,8 @@ static int parse_fragment(struct apply_state *sta=
te,
>  			trailing++;
>  			check_old_for_crlf(patch, line, len);
>  			if (!state->apply_in_reverse &&
> -			    state->ws_error_action =3D=3D correct_ws_error)
> +			    state->ws_error_action =3D=3D correct_ws_error &&
> +			    state->ws_ignore_action !=3D ignore_ws_none)
>  				check_whitespace(state, line, len, patch->ws_rule);
>  			break;

Hmph.  0a80bc9f (apply: detect and mark whitespace errors in context
lines when fixing, 2015-01-16) deliberately added this check because
we will correct the whitespace breakages on these lines after
parsing the hunk with this function while applying.

It is iffy that this case arm for " " kicks in ONLY when applying in
the forward direction (which is not what you are changing).  When
applying a patch in reverse, " " is still an "unchanged" context
line, so we should be treating it the same way regardless of the
direction.

But at least the call to check_whitespace() from this place when we
are correcting whitespace rule violations is not iffy, as far as I
can tell.



> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 573200da67..e12b8333c3 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -569,7 +569,8 @@ test_expect_success 'whitespace=3Dfix honors no-ign=
ore-whitespace' '
>  	+A
>  	 BZZ
>  	EOF
> -	git apply --no-ignore-whitespace --whitespace=3Dfix patch
> +	git apply --no-ignore-whitespace --whitespace=3Dfix patch 2>error &&
> +	test_must_be_empty error
>  '
> =20
>  test_expect_success 'whitespace check skipped for excluded paths' '

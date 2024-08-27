Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA01FB4
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719895; cv=none; b=NlMChEea3J2wD1BZw3vZp1C7pCBKeeK+B/5M0LdDHpA1N9j/26o6Mm+TTePswwru/cjJaMncp+xU5GjbSbstXEWwGk4684m/LcdBQQjltltmODtDqXn/6srWyysMpaeMqe0V9saWfbz/h/y65EoP8vYMeJNIA4g+YTTFOE3kQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719895; c=relaxed/simple;
	bh=CBCJguEftdvjuCJuv4MhnW/EdScck706Vs+3+R7Cr3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XTRu9+quv3m8e8SgKT69ExStYYx9016EBvx0Mf4E+1TnZq0l/i4/GGOezgQDJmJ2FKKLSEPIB0El2SCKh9ZFlyr9q/LSBBmuzVPjx4FS2ByF4bKThxSxUkLhxNfx+HZlrk8H+Ul8jusDGbIILHSaoc4k+DDqkkJTV9p9d5HOrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OQfZTw50; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OQfZTw50"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 729702AB8C;
	Mon, 26 Aug 2024 20:51:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CBCJguEftdvj
	uCJuv4MhnW/EdScck706Vs+3+R7Cr3U=; b=OQfZTw50KomLtXndno0en7nXqJUX
	GdVbocWcv6cYTI6I9JobhlfS6EiAGf7f85DBtFD0p/AXekfIBiwN/t9mLfaX0Qqf
	wl0BecrA+OUiY+CDbXNafzDbRNPm9IntniOnb/zezR3kol03no0p98ted9e4shgq
	uNQQoTFkI29UPqo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BE882AB8B;
	Mon, 26 Aug 2024 20:51:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DDA092AB8A;
	Mon, 26 Aug 2024 20:51:28 -0400 (EDT)
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
Date: Mon, 26 Aug 2024 17:51:27 -0700
Message-ID: <xmqqbk1eeqk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7EAAF7A8-640E-11EF-9983-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> If the user says `--no-ignore-space-change`, there's no need to
> check for whitespace errors in the context lines.

Because the default is *not* to ignore space change, the command
should behave exactly the same way between two cases: (1) the user
uses the default and does not give the "--ignore-space-change"
option, and (2) the user gives the "--no-ignore-space-change" option
explicitly.  So I am very much convinced that [1/5] is unneeded, and
"If the user says `--no-*`" in the above proposed log message is
insufficient (at least it also needs to say "or uses the default and
does not say "--ignore-space-change").

> Don't do it.

No need to say this, when the paragraphs above clearly and
unambiguously leads to this conclusion.

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

I am not 100% convinced that this change is _wrong_, but it does
smell like reverting a necessary change as I pointed out in another
reply.

Thanks.


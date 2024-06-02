Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E521362
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346206; cv=none; b=TYtxsBAp9Ts+XsyJ+Z8U3USre5VCCiOK3oqv/eg5rTxFIxwnmXV1KXZwbpBSoVoNnpp2Dl68cUKwUydy5jA+3QogUVFvV/MCmVRV7ogBrZQSXTF/QKYyksBr4bqnnecQmtb332A1i07YVNnJyzawIW6FeOjZjjqNK4HwWlMfQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346206; c=relaxed/simple;
	bh=kaptjU44B+FFwPMGIRSfULnQvv30GYNK0IkMCFSDW6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AwjmQz+inSsD0eHNuaJmc4sg4BZNZhOlkE+nHdTEVg21IS/3g0D9T5IcDbTbHFH7AJSf1onaxpdcV/qZYru1aTVVBEiBaAqF6B8bTj+oGQA4wZW85VXr/ZVs8h6KJhrHlLWTypVVuEBg/95rVZ4R8JjYep96tHYZ4qqCN0Hofz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fzvw4Xkb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fzvw4Xkb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D3A12B72B;
	Sun,  2 Jun 2024 12:36:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kaptjU44B+FF
	wPMGIRSfULnQvv30GYNK0IkMCFSDW6U=; b=fzvw4Xkb+yalGSNlIlyvEQiTJtI6
	P+L6oDNjx8xPcpxy9iUE143Y+sdvR3jRrP8BsBWiPMrk8vEHITx+p4fU5D8fhOFY
	zgYiW1JgAr0HOCljOWIodUdVCwAKAIplQv4A12hnQtAG7PlN0W3i8v5Dsbuy95wC
	Z+OjaIkBKqq3Ivw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2527F2B72A;
	Sun,  2 Jun 2024 12:36:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D3352B729;
	Sun,  2 Jun 2024 12:36:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 2 Jun 2024 17:38:42 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Date: Sun, 02 Jun 2024 09:36:35 -0700
Message-ID: <xmqqwmn79u98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 478C36EA-20FE-11EF-9AE8-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Hopefully, we'll find a way to avoid sending ANSI codes, on demand,
> without disabling it entirely with color.ui=3Dnever or any other global
> option.  To make this usable:
>
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | vim -
>
> However, the current functionality meets my current needs, so I'm happy
> with it.

Yup, if it really is needed we could do || or anything "unusual" to
signal the unusual nature of the command.

Or ">" command can send the output to specified file without
coloring, and the user can do whatever they want to it. =20

In any case, unlike "Let's not just do pager, but have a facility to
pipe to anything and make the pager a default destination" that was
a natural match to the originally proposed behaviour, these two are
quite different and can be left totally outside the scope of the
topic.

> One final note;  I preferred to model the help text this way:
>
>     y - stage this hunk
>     n - do not stage this hunk
> ...
>     g - select a hunk to go to=20
>     / - search for a hunk matching the given regex
> ...
>     | - pipe the current hunk to the pager, or |<program> to use a prog=
ram'
>     ? - print help

That's fine.

The 'g' and '/' commands take _mandatory_ arguments, but we do not
even mention it in the help text.  But we need to say something for
this new thing, because it is _optional_ and if you do not give a
program, it does not ask.

A possibility is to phrase it like so:

    | - pipe the current hunk to the program (or "%s" by default)

and fill %s with the program you'd use if not given, i.e. initially
the value of the GIT_PAGER but updated to the last used program
after the user uses "|<program>" form to specify one.

Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912E5FB97
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844019; cv=none; b=MuMW00XHsFr5Y5q240/z31dGMeXHmqs5Xm7mrJW6R9PBolWQHZEcFpH4ZHmlreTcJL9mjPi5dk4ZwY9k21EAFHsZk4mhBGJAW68gFtchkDB3CYmpinUVwsbaTWeIBVRZXEJuz7XNZ9LL5oP69IfNYPE7SQ7SWeVf1sruQgpTrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844019; c=relaxed/simple;
	bh=sncvxtsMy6IatGyMLZkhcS/j9m7TSE66HxmlZtTgWds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTUV5fsOeWtmpMkxntD4Zd0oYpBnYeNy59VlL2TA+3wrf8/RqIqI3lr+K96AAVgZhW/vppICfSrqx35Tj3KrRFLVsAC1E4PZrp2E7KXChguhcvVZpljDskZpL2LE0Ejc6ougYiHdGMQC03x7gYfx5gJ7ROOUKeuZHENc1yv0ocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=T5UBdyMk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T5UBdyMk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 917F534B4F;
	Tue, 13 Feb 2024 12:06:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sncvxtsMy6Ia
	tGyMLZkhcS/j9m7TSE66HxmlZtTgWds=; b=T5UBdyMkct6liqWeUCiAJWa5WEk6
	wuLTC+sytkmf7lbfD8Rmngz1z4/DgD5u0daLgPgIut4lViTDA45TbW9DF4VLdfhJ
	yCOHZktk9oSFpRyBIEpmM8sEsqlhLEldbHl0zdromIeILCigpvp12zTOvaw79PYN
	UHjB7MSuNSp8et4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AF0C34B4E;
	Tue, 13 Feb 2024 12:06:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32E2034B4C;
	Tue, 13 Feb 2024 12:06:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v3 2/2] column: guard against negative padding
In-Reply-To: <9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Tue, 13 Feb 2024 17:01:21 +0100")
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
	<cover.1707839454.git.code@khaugsbakk.name>
	<9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
Date: Tue, 13 Feb 2024 09:06:46 -0800
Message-ID: <xmqqcyt08fa1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 45ECF4CC-CA92-11EE-BD82-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Make sure that client code can=E2=80=99t pass in a negative padding by =
accident.
>
> Suggested-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Apparently these are the only publicly-visible functions that use t=
his
>     struct according to `column.h`.
>
>  column.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/column.c b/column.c
> index ff2f0abf399..50bbccc92ee 100644
> --- a/column.c
> +++ b/column.c
> @@ -182,6 +182,8 @@ void print_columns(const struct string_list *list, =
unsigned int colopts,
>  {
>  	struct column_options nopts;
> =20
> +	if (opts && (0 > opts->padding))
> +		BUG("padding must be non-negative");

The only two current callers may happen to be "git branch" that
passes NULL as opts, and "git clean" that passes 2 in opts->padding,
so this BUG() will not trigger.  Once we add new callers to this
function, or update the current callers, this safety start to matter.

The actual breakage from a negative padding happens in layout(),
so another option would be to have this guard there, which will
protect us from having new callers of that function as well, or
its caller display_table(), but these have only one caller each,
so having the guard print_columns() here, that is the closest to
the callers would be fine.

>  	if (!list->nr)
>  		return;
>  	assert((colopts & COL_ENABLE_MASK) !=3D COL_AUTO);
> @@ -361,6 +363,8 @@ int run_column_filter(int colopts, const struct col=
umn_options *opts)
>  {
>  	struct strvec *argv;
> =20
> +	if (opts && (0 > opts->padding))
> +		BUG("padding must be non-negative");

This one happens to be safe currently because "git tag" passes 2 in
opts->padding, but I do not think this is needed.

We will pass these through to "git column" and the negative padding
will be caught as an error there anyway, no?  So whether "git tag"
is updated or a new caller of run_column_filter() is added, the
developer will already notice it (and they will have to protect
themselves just like the [1/2] of your series did for "git column"
itself).

>  	if (fd_out !=3D -1)
>  		return -1;

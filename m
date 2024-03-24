Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE481426F
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296416; cv=none; b=sZGeG+IqTO2zgqq9dOsrxQY+Da4yebQpRCFDHkms6S/Mv0RJhnDN0kDAXBBa/Lbi++wabhyQid9xJiSvN6pt93fTFjklktK4B4fdvr1fW1Yn70BEtV3ZO9Fd4O8aE4JisfXnLQTiJPj8wOfdxTd44svnNE5P211xVfT8xK4dmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296416; c=relaxed/simple;
	bh=f8TS1cGRXE5rG44sAeGrKWC4Vm0To4vlpoewONPA7nY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OeFM54XXLae7Gh/lTACTVynZJQjyZO6VXPhhjEJifYOneN/0NGFdM7dxNYJyPhLWcJfbT4mTXo/2xxjk1uCdczOZ99RpFUHWoqFucqBIs2iAL72lsrrEb2VjUJcuuN16yJziYKdVpnqQs2soeqVDy1ze3k2m5CGE8yXtKdMHpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wxPTxVoB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wxPTxVoB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61C9D1DEDD6;
	Sun, 24 Mar 2024 12:06:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f8TS1cGRXE5r
	G44sAeGrKWC4Vm0To4vlpoewONPA7nY=; b=wxPTxVoBuE2rTEWKvQdkxdMxwp9U
	af4Q4Mc2yTkO/amGdrJyAirirSl/q2/ThcVjDJGogcrr8iGaFk2GrMz2jjIs32Ea
	rfKk9A9/vwP9dDCtnwyfECZy9L8mkix0UDbDXpalqyW/Y2oJHJwo/182dfzCwFGu
	KXNRUfj/U+9MZEA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 595B11DEDD5;
	Sun, 24 Mar 2024 12:06:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ABF7A1DEDD4;
	Sun, 24 Mar 2024 12:06:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] factor out strbuf_expand_bad_format()
In-Reply-To: <cf8f2256-d954-4a3e-bc2a-31b2de4c8e1d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 24 Mar 2024 12:19:40 +0100")
References: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
	<cf8f2256-d954-4a3e-bc2a-31b2de4c8e1d@web.de>
Date: Sun, 24 Mar 2024 09:06:49 -0700
Message-ID: <xmqqa5mnty06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 862BC772-E9F8-11EE-B6FA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> @@ -274,12 +273,6 @@ static void show_ce_fmt(struct repository *repo, c=
onst struct cache_entry *ce,
>  			strbuf_addch(&sb, '%');
>  		else if ((len =3D strbuf_expand_literal(&sb, format)))
>  			format +=3D len;
> -		else if (*format !=3D '(')
> -			die(_("bad ls-files format: element '%s' "
> -			      "does not start with '('"), format);
> -		else if (!(end =3D strchr(format + 1, ')')))
> -			die(_("bad ls-files format: element '%s' "
> -			      "does not end in ')'"), format);

We used to do these two checks upfront, before the cascade of checks
that follow from here to the "else die()".

But we do not even take advantage of the fact that we already
checked these two in the following tests.  We do not take advantage
of the fact that we know where the placeholder ends by computing
"end" early, and all the checks in the "else if" cascade check that
the placeholder is enclosed inside a pair of parentheses again and
again.

So there is no point in optimizing to fail fast by having these two
tests early.

> +void strbuf_expand_bad_format(const char *format, const char *command)
> +{
> +	const char *end;
> +
> +	if (*format !=3D '(')
> +		/* TRANSLATORS: The first %s is a command like "ls-tree". */
> +		die(_("bad %s format: element '%s' does not start with '('"),
> +		    command, format);
> +
> +	end =3D strchr(format + 1, ')');
> +	if (!end)
> +		/* TRANSLATORS: The first %s is a command like "ls-tree". */
> +		die(_("bad %s format: element '%s' does not end in ')'"),
> +		    command, format);
> +
> +	/* TRANSLATORS: %s is a command like "ls-tree". */
> +	die(_("bad %s format: %%%.*s"),
> +	    command, (int)(end - format + 1), format);
> +}
> +

Now these "pair of parentheses" checks are removed from the "else
if" cascade, and we check them only to give a different message that
tells _how_ the format was bad in expand_bad_format().

Looks good.

Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EE1E53A
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939683; cv=none; b=XTfyrikoVkjSHbGEYovB/dm0/DWwYrIFpNBP+CaHoVUW77pkMdIEgLGt+3PUe+cllAAOGa4GHEfwW6Qt+gYlX3sLyrtefb2W89g+J9RdBcsE0iW2kqzR4GxYfNkcTX5sGGROKaaE8knVTTVRGxPgVZyi05vbAfoIIU+IhrOFs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939683; c=relaxed/simple;
	bh=1m3cTP8uZc2PfpcTZFFjK2WXMtl99Q0hF6kSdE8mdiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IT+Yxc8kdaUt9qdFP3LwEkh0gYp39eMfuMTJbFmk+CGWiP1yWgbrONZtTPBSUTjgWt3S5QPGWY4HpmtKmWhu+ZHjEBrnXEn/hq5RDLBogZ9ZAe7odVH38Xtp6AwsjSzhmHFQkMgR4VNuViXPebdQTsupqkwM9wIEQzztQOD7q+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JRtfO51y; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JRtfO51y"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B9DD218F4C;
	Fri, 12 Apr 2024 12:34:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1m3cTP8uZc2PfpcTZFFjK2WXMtl99Q0hF6kSdE
	8mdiU=; b=JRtfO51yoQ+RkXp/PneksmXNCD9uDQOqS+Ew5aojVUNOnKljo1SUi5
	IRg1qAQvCg1DIZJLg4FXN1+1w7veKbTmdDYtxUeIuTA+Bc0/mXbm2LIiBVymNdFc
	odQQT/+yIZsqUULSvSmEx8MRIz0uaFgRbpsjk/MTYnWBdOjeDA61k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B1F7518F4B;
	Fri, 12 Apr 2024 12:34:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA13C18F47;
	Fri, 12 Apr 2024 12:34:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 1/8] fast-import: tighten path unquoting
In-Reply-To: <d6ea8aca465eaed4b18b546b5d484bc98fdaa377.1712907684.git.thalia@archibald.dev>
	(Thalia Archibald's message of "Fri, 12 Apr 2024 08:02:56 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<cover.1712907684.git.thalia@archibald.dev>
	<d6ea8aca465eaed4b18b546b5d484bc98fdaa377.1712907684.git.thalia@archibald.dev>
Date: Fri, 12 Apr 2024 09:34:28 -0700
Message-ID: <xmqqle5io7zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 890242AE-F8EA-11EE-98AF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Thalia Archibald <thalia@archibald.dev> writes:

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 782bda007c..ce9231afe6 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2258,10 +2258,56 @@ static uintmax_t parse_mark_ref_space(const char **p)
>  	return mark;
>  }
>  
> +/*
> + * Parse the path string into the strbuf. It may be quoted with escape sequences
> + * or unquoted without escape sequences. When unquoted, it may only contain a
> + * space if `include_spaces` is nonzero.
> + */

It took me three reads to understand the last sentence.  It would
have been easier if it were written as "it may contain a space only
if ...".  I'd also named it "allow_unquoted_spaces"---it is not like
this function includes extra spaces on top of whatever was given.

> +static void parse_path(struct strbuf *sb, const char *p, const char **endp,
> +		int include_spaces, const char *field)
> +{
> +	if (*p == '"') {
> +		if (unquote_c_style(sb, p, endp))
> +			die("Invalid %s: %s", field, command_buf.buf);
> +	} else {
> +		if (include_spaces)
> +			*endp = p + strlen(p);
> +		else
> +			*endp = strchrnul(p, ' ');
> +		strbuf_add(sb, p, *endp - p);
> +	}
> +}

A very straigtht-forward implementation.  Makes sense.

> +/*
> + * Parse the path string into the strbuf, and complain if this is not the end of
> + * the string. It may contain spaces even when unquoted.
> + */
> +static void parse_path_eol(struct strbuf *sb, const char *p, const char *field)
> +{
> +	const char *end;
> +
> +	parse_path(sb, p, &end, 1, field);
> +	if (*end)
> +		die("Garbage after %s: %s", field, command_buf.buf);
> +}

OK.

> +/*
> + * Parse the path string into the strbuf, and ensure it is followed by a space.
> + * It may not contain spaces when unquoted. Update *endp to point to the first
> + * character after the space.
> + */
> +static void parse_path_space(struct strbuf *sb, const char *p,
> +		const char **endp, const char *field)
> +{
> +	parse_path(sb, p, endp, 0, field);
> +	if (**endp != ' ')
> +		die("Missing space after %s: %s", field, command_buf.buf);
> +	(*endp)++;
> +}

OK.

The updated callers that use the above helper functions do read a
lot more easily, while filling the gaps in the original
implementation.  Very nicely done.

Thanks.


Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C911DFC1
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965574; cv=none; b=SIAbg+iYU6lnXY0NLAj9XDxxjQV5BSVnIMAQuq3yXudRK5YNwEHCGrS3V8n2vwF6dnO2GTvXyHvh8fvl4GYdGo3B3+aKWdvSY40V8jBeREMPos34mMjUo10/3mX8JvgoWz9qxvqxnALHQbrfhZrXydv4URH2cjdlxl3FefUUie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965574; c=relaxed/simple;
	bh=i1EMgjUl8pXRzjY5usFQBeCrwBAXWVg6+4Muxo9InzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UMKRYeeZ+hj/tih9eESjFapwIwHI4UI5+eC4DT4nmM3ecMh7G3Jxy86ru+9rXhZgbe3Cmyn+p7F09zyfXnVD5Tfaud2qzJUQq9ZbVMQnHq/2QFh5K0YUtPztbdRBIHtMYU2DGU/X48//IED/cL1HnQdn7W1dzZ46r/k/8mY7fwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GKh4nVv2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GKh4nVv2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF5A21A938;
	Mon, 26 Feb 2024 11:39:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i1EMgjUl8pXRzjY5usFQBeCrwBAXWVg6+4Muxo
	9InzA=; b=GKh4nVv2W19qSCDTcWYIKcJTgmZQYH7yaGj4MlF3wfNUzh3t20gVKf
	Fvxewb0i9uO1V/Tbp44Pg9wekjkhEoF9aTejEj/aoJMd85NLas7FfYSJB8qGuj5G
	mF4y/DS3ZiT0pZnH7eKJ+WKZ3Uywa5LaHqx8dMR/euMTDPeWLX9xU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D7E001A937;
	Mon, 26 Feb 2024 11:39:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79E7C1A936;
	Mon, 26 Feb 2024 11:39:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [Outreachy][PATCH 1/2] strbuf: introduce strbuf_addstrings() to
 repeatedly add a string
In-Reply-To: <20240226143350.3596-1-ach.lumap@gmail.com> (Achu Luma's message
	of "Mon, 26 Feb 2024 15:33:49 +0100")
References: <20240226143350.3596-1-ach.lumap@gmail.com>
Date: Mon, 26 Feb 2024 08:39:25 -0800
Message-ID: <xmqqil2bdvsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B5B5038-D4C5-11EE-8B91-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Achu Luma <ach.lumap@gmail.com> writes:

> In a following commit we are going to port code from
> "t/helper/test-sha256.c", t/helper/test-hash.c and "t/t0015-hash.sh" to
> a new "t/unit-tests/t-hash.c" file using the recently added unit test
> framework.
>
> To port code like: perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;"
> we are going to need a new strbuf_addstrings() function that repeatedly
> adds the same string a number of times to a buffer.

We do not need to call such a function "addstrings", though.  The
name on the subject line made me expect a varargs function:

 (bad)	strbuf_addstrings(&sb, "foo", "bar", "baz", NULL);

It would have been clearer if the name hinted what it does, clearer
than just a single "s" that says it is talking about plural.  What
would be a good name that hints "n times add a single same string"?
I dunno.

I also would have expected that the order of parameters are
repeat-count followed by what gets repeated.

Having said all of the above, we already have "addchars" that is
equally strange, so let's let it pass ;-).

> diff --git a/strbuf.c b/strbuf.c
> index 7827178d8e..eb2b3299ce 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -302,6 +302,17 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
>  	strbuf_setlen(sb, sb->len + len);
>  }
>
> +void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n)
> +{
> +	size_t len = strlen(s);

Let's have a blank line here to separate decls from the first
statement.

> +	if (unsigned_mult_overflows(len, n))
> +		die("you want to use way too much memory");
> +	strbuf_grow(sb, len * n);

The error message given by

	strbuf_grow(sb, st_mult(len, n));

would be equally informative and takes only a single line.

> +	for (size_t i = 0; i < n; i++)
> +		memcpy(sb->buf + sb->len + len * i, s, len);

Wouldn't it be sufficient to run strbuf_add() n times at this point,
as we have already called strbuf_grow() to avoid repeated
reallocation?  Repeated manual memcpy() that involves manual offset
computation makes me nervous.

> +	strbuf_setlen(sb, sb->len + len * n);
> +}
> +
>  void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
>  {
>  	strbuf_grow(sb, sb2->len);
> diff --git a/strbuf.h b/strbuf.h
> index e959caca87..0fb1b5e81e 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -310,6 +310,11 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
>  	strbuf_add(sb, s, strlen(s));
>  }
>
> +/**
> + * Add a NUL-terminated string the specified number of times to the buffer.
> + */
> +void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n);
> +
>  /**
>   * Copy the contents of another buffer at the end of the current one.
>   */
> --
> 2.43.0.windows.1

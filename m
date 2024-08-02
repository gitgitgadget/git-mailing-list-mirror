Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0821ABEDC
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633520; cv=none; b=IiErO2L2M55nWnmtlTgI6VKYwO0e78xhIhRWQk9treY4PPWiHc3JMSOykGqyjHGMct6W2PDDtriytLQRn2klpoxIGB/Cp3l1S1LdCB6QBeJVj8aHpum/7pA8FXGi18UF5nZEHzT1amIPcMxNFU3g8YbKhLtlUdQUwwUNya7WkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633520; c=relaxed/simple;
	bh=0wJvGVybT2AMppxRZIyL7MkihO0hhDP3R0n2mu1dMDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uqzyAkahG+1+p5a7GjDOzhrJnUdxTqoOZncDu7l3I9Q3647WSvq63+HpPrG5I/pDX0CCDLjxDBfQKVTceUKxJUzSp25OOsI9o36qFIk4WHErYY6avLIpHBcSTWcc08T3sMdcpc6e/Q5JG2WuSpZaOkPqWKg+IoGN/Ky6oyu8OR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ErIEMXtd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ErIEMXtd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C7B661C99E;
	Fri,  2 Aug 2024 17:18:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0wJvGVybT2AMppxRZIyL7MkihO0hhDP3R0n2mu
	1dMDc=; b=ErIEMXtdFv/9w1aw0riQGnmd1nBmVecdzparEXmWlvAR7DR441e0ot
	kLuMeJdbjaQj9UzFntU96+xODbxVghLGWYMMPfD3fIFFAuYTPhrNHUnQRYWaxhEK
	SpJbNTw0XqYs92HBWTsxdYc6T5tZR3dLHuRBaDcHtUPzHX5HhCJwY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C0DE01C99D;
	Fri,  2 Aug 2024 17:18:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ABF831C99C;
	Fri,  2 Aug 2024 17:18:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kyle Lippincott
 <spectral@google.com>
Subject: Re: [PATCH v2 1/3] set errno=0 before strtoX calls
In-Reply-To: <4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722632287.git.gitgitgadget@gmail.com>
	(Kyle Lippincott via GitGitGadget's message of "Fri, 02 Aug 2024
	20:58:05 +0000")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722632287.git.gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 14:18:31 -0700
Message-ID: <xmqqbk2abp3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C623801C-5114-11EF-BC96-9625FCCAB05B-77302942!pb-smtp21.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> To detect conversion failure after calls to functions like `strtod`, one
> can check `errno == ERANGE`. These functions are not guaranteed to set
> `errno` to `0` on successful conversion, however. Manual manipulation of
> `errno` can likely be avoided by checking that the output pointer
> differs from the input pointer, but that's not how other locations, such
> as parse.c:139, handle this issue; they set errno to 0 prior to
> executing the function.
>
> For every place I could find a strtoX function with an ERANGE check
> following it, set `errno = 0;` prior to executing the conversion
> function.
>
> Signed-off-by: Kyle Lippincott <spectral@google.com>
> ---
>  builtin/get-tar-commit-id.c | 1 +
>  ref-filter.c                | 1 +
>  t/helper/test-json-writer.c | 2 ++
>  t/helper/test-trace2.c      | 1 +
>  4 files changed, 5 insertions(+)

Clearilng before strtoX() call like these changes make perfect sense
(within the constraint of strtoX() API, which is horrible as pointed
out by others many times in the past ;-)

Thanks, will queue.

> diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
> index 66a7389f9f4..7195a072edc 100644
> --- a/builtin/get-tar-commit-id.c
> +++ b/builtin/get-tar-commit-id.c
> @@ -35,6 +35,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv UNUSED, const char *prefix
>  	if (header->typeflag[0] != TYPEFLAG_GLOBAL_HEADER)
>  		return 1;
>  
> +	errno = 0;
>  	len = strtol(content, &end, 10);
>  	if (errno == ERANGE || end == content || len < 0)
>  		return 1;
> diff --git a/ref-filter.c b/ref-filter.c
> index 8c5e673fc0a..54880a2497a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1628,6 +1628,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
>  	timestamp = parse_timestamp(eoemail + 2, &zone, 10);
>  	if (timestamp == TIME_MAX)
>  		goto bad;
> +	errno = 0;
>  	tz = strtol(zone, NULL, 10);
>  	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
>  		goto bad;
> diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
> index ed52eb76bfc..a288069b04c 100644
> --- a/t/helper/test-json-writer.c
> +++ b/t/helper/test-json-writer.c
> @@ -415,6 +415,7 @@ static void get_i(struct line *line, intmax_t *s_in)
>  
>  	get_s(line, &s);
>  
> +	errno = 0;
>  	*s_in = strtol(s, &endptr, 10);
>  	if (*endptr || errno == ERANGE)
>  		die("line[%d]: invalid integer value", line->nr);
> @@ -427,6 +428,7 @@ static void get_d(struct line *line, double *s_in)
>  
>  	get_s(line, &s);
>  
> +	errno = 0;
>  	*s_in = strtod(s, &endptr);
>  	if (*endptr || errno == ERANGE)
>  		die("line[%d]: invalid float value", line->nr);
> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> index cd955ec63e9..c588c273ce7 100644
> --- a/t/helper/test-trace2.c
> +++ b/t/helper/test-trace2.c
> @@ -26,6 +26,7 @@ static int get_i(int *p_value, const char *data)
>  	if (!data || !*data)
>  		return MyError;
>  
> +	errno = 0;
>  	*p_value = strtol(data, &endptr, 10);
>  	if (*endptr || errno == ERANGE)
>  		return MyError;

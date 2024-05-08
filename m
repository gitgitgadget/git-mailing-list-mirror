Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028F82862
	for <git@vger.kernel.org>; Wed,  8 May 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207370; cv=none; b=SD6y3SGGP6npY9ekmF1H+HACDOd9ZysAIaK0/tbxykJ24Bepm3clrrFv5V1Mx9pG9dJr+Qt5cuT55hTAz7FKE1NUiYA1M0XG9ZT5g+VwzEIxyHZmZqvxI8nAaHN6Si4eof9qZkgpsbpQD2xAb+0zusIHslYIzi4FO+SXFTddVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207370; c=relaxed/simple;
	bh=kp8l+A2vp72ahJdCM69VL/M8li1EKl8qn2EDMBosDnY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gESstZLUZdMsUhW2zpFTI8I7HCN3s099ZmFHgJTj/lGy6bIHbLJ8SM0eO16mjRfJApEyvMJhWWFcl0OXrspWLJfyXmIGXItD0bSKlkKoInoop8JR/f4oCbW3Y0nFKnqEwMhtipEOHy22ebjcvK7UKmjCOdgzJztptckeeZWrN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WAPTPl/I; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WAPTPl/I"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B64DA360DF;
	Wed,  8 May 2024 18:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kp8l+A2vp72ahJdCM69VL/M8li1EKl8qn2EDMB
	osDnY=; b=WAPTPl/I5/qzBUQH5CtFfx85uDO5N0yVmeOw15e6iE2/DTokGzf063
	9wjznUR2EsT+edfPhy9BvcKtWJbFUlUg9ltSSgDrjF6FKK4t/yeYvHdy1DjkxdQZ
	SEozRzqent9tBKLlx9wtntzgEDQlf6d+beO80ynb6iuxn4wZIcP7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADC94360DE;
	Wed,  8 May 2024 18:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CEE0360DD;
	Wed,  8 May 2024 18:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] remote-curl: optionally show progress for HTTP get
In-Reply-To: <20240508124453.600871-4-toon@iotcl.com> (Toon Claes's message of
	"Wed, 8 May 2024 14:44:52 +0200")
References: <20240508124453.600871-1-toon@iotcl.com>
	<20240508124453.600871-4-toon@iotcl.com>
Date: Wed, 08 May 2024 15:29:20 -0700
Message-ID: <xmqq5xvox7i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6ADD8392-0D8A-11EF-8F54-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Toon Claes <toon@iotcl.com> writes:

> git-remote-curl supports the `option progress` basically since it's

"it's" -> "its".

> inception. But this option had no effect for regular HTTP(S) downloads.
>
> Add progress indicator when downloading files through curl HTTP GET.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  remote-curl.c       |  8 +++++++-
>  t/t5557-http-get.sh | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 0b6d7815fd..9fc7c3580c 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1293,6 +1293,7 @@ static void parse_get(const char *arg)
>  {
>  	struct strbuf url = STRBUF_INIT;
>  	struct strbuf path = STRBUF_INIT;
> +	struct http_get_options http_options = {0};
>  	const char *space;
>  
>  	space = strchr(arg, ' ');
> @@ -1303,7 +1304,12 @@ static void parse_get(const char *arg)
>  	strbuf_add(&url, arg, space - arg);
>  	strbuf_addstr(&path, space + 1);
>  
> -	if (http_get_file(url.buf, path.buf, NULL))
> +	http_options.initial_request = 1;
> +
> +	if (options.progress)
> +		http_options.progress = 1;
> +
> +	if (http_get_file(url.buf, path.buf, &http_options))
>  		die(_("failed to download file at URL '%s'"), url.buf);
>  
>  	strbuf_release(&url);
> diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
> index 76a4bbd16a..92a138caaf 100755
> --- a/t/t5557-http-get.sh
> +++ b/t/t5557-http-get.sh
> @@ -36,4 +36,19 @@ test_expect_success 'get by URL: 200' '
>  	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
>  '
>  
> +test_expect_success 'get by URL with progress' '
> +	echo hello >"$HTTPD_DOCUMENT_ROOT_PATH/hello.txt" &&
> +
> +	url="$HTTPD_URL/hello.txt" &&
> +	cat >input <<-EOF &&
> +	capabilities
> +	option progress true
> +	get $url file3
> +
> +	EOF
> +
> +	git remote-http $url <input 2>err &&
> +        test_grep "^Downloading via HTTP: 100%" err
> +'

Are we sure that by the time we finish the transfer we know the
total?  Does this rely on the fact that somehow we are in
control of the server and can force it to use content-length:
(instead of chunked encoding without any explicit indication of the
total length)?

Also, I am curious if we know how often the progress indicator is
updated by cURL library with the API used in [2/4] (and if we can
control the frequency if we wanted to).  Note that this is me just
being curious, not a request to make it tweakable.  The findings may
help polish the [2/4], though.

Thanks.

> +
>  test_done

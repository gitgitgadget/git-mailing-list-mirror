Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF31272DA
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387007; cv=none; b=hKCZpLW6ceMNiCcHJY5nWOjv+EG4fX9Ldr8JNMEsMLdxOhrlQEny36Is9NO8vXVlShXdqs1WMCQYzW7dn1nrXigS0wPIlZXXhvuHEcqBaAzuFg9fmBcd5aoUnjD/TqEwVx8X19dz4UC1INN/be3Dy+Ubdnu6UulMY1FSr7RPoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387007; c=relaxed/simple;
	bh=btG+xk3+8+8Q3/pFbum7ITk58c7F59aN9dLyYX7Y7tY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0uQWYE+t6Ckj/kaT+Zq+QIeifgVnYUwzc2U6t55Or3b9cNwdTuUDDc+auE18EvKwwZ+RXR1FEZYMyek7cy95flykhL6WUvqflHHIMs/ZznorSZs6kLn6UDqxXYwYZ0vTofJNdpS69F2Aeaa+vWBi5DafnT7qTPpf9o+SVxBgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uv4AwQWx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uv4AwQWx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F8081E7465;
	Mon, 25 Mar 2024 13:16:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=btG+xk3+8+8Q3/pFbum7ITk58c7F59aN9dLyYX
	7Y7tY=; b=uv4AwQWxtbs/A50K9gE9EATfPaIYzjC2ktqwz60y/AXPU34hqD65mO
	zAXuBDNjtonU6nk3otv8nJU/IQFEPejru2ck8EvRyiSav4yQGbTJle2YC5CZ/Elu
	n+g7EgcoSXlmErlzG7yOOCCIT7l+/ZeAqou7ISV4Rj37s4qZgDVHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 275E71E7464;
	Mon, 25 Mar 2024 13:16:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92F321E7463;
	Mon, 25 Mar 2024 13:16:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 1/5] MyFirstObjectWalk: use additional arg in
 config_fn_t
In-Reply-To: <0eeb4b78ac91c2bddf775fdea34ce5c0515ff205.1711368499.git.dirk@gouders.net>
	(Dirk Gouders's message of "Mon, 25 Mar 2024 13:33:32 +0100")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net>
	<0eeb4b78ac91c2bddf775fdea34ce5c0515ff205.1711368499.git.dirk@gouders.net>
Date: Mon, 25 Mar 2024 10:16:42 -0700
Message-ID: <xmqqcyrimdtx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73BEC1D8-EACB-11EE-A6C2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth

In your next topic, use "git show -s --pretty=reference a4e7e317" to
show "a4e7e317f8 (config: add ctx arg to config_fn_t, 2023-06-28)"
with dates.  It makes it easier to see how long what is being fixed
is broken, giving reviewers a sense of urgency for a fix.  It is not
necessary to reroll this commit only to update the reference, though.

> argument to config_fn_t but did not change relevant function calls
> in Documentation/MyFirstObjectWalk.txt.
>
> Fix those calls and the example git_walken_config() to use
> that additional argument.
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  Documentation/MyFirstObjectWalk.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index c68cdb11b9..cceac2df95 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -210,13 +210,14 @@ We'll also need to include the `config.h` header:
>  
>  ...
>  
> -static int git_walken_config(const char *var, const char *value, void *cb)
> +static int git_walken_config(const char *var, const char *value,
> +			     const struct config_context *ctx, void *cb)
>  {
>  	/*
>  	 * For now, we don't have any custom configuration, so fall back to
>  	 * the default config.
>  	 */
> -	return git_default_config(var, value, cb);
> +	return git_default_config(var, value, ctx, cb);
>  }
>  ----
>  
> @@ -389,10 +390,11 @@ modifying `rev_info.grep_filter`, which is a `struct grep_opt`.
>  First some setup. Add `grep_config()` to `git_walken_config()`:
>  
>  ----
> -static int git_walken_config(const char *var, const char *value, void *cb)
> +static int git_walken_config(const char *var, const char *value,
> +			     const struct config_context *ctx, void *cb)
>  {
> -	grep_config(var, value, cb);
> -	return git_default_config(var, value, cb);
> +	grep_config(var, value, ctx, cb);
> +	return git_default_config(var, value, ctx, cb);
>  }
>  ----

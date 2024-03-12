Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD641191
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202690; cv=none; b=dyY5kXXQIlozeSdt28dpa94CjIOR982sCiaaoAh/JJteDWfhUTWyU0XPT0JM7oe6Go6ZoRoERsAvYBxUXEWkJ5KYMGvIsWGisPUOFh6jzBP+IgDbV0CDohhtNtIXSTovEr3fue3ke5/0LvYuGkDc73wyPPwXJVPv08pbPTJ10us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202690; c=relaxed/simple;
	bh=G3Kd3Vz8pmjADrbLhsZmQs/b8QRJO5vZwyx1HMpPSVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSW8O+eSJ49GOBh63tsY4mhI9r89yGg3xyXkK0bRAzFrIOHKSav6oik85kVrrTKeGR6JjvmrdQd1/LCeYpcc1PxS19PI2lHDwd3esS3G6SrRtkP1QVrt2hXhjuIWCZ/bD8sU1DjnA9XQxF143TMUyFLZeYKbkW5pnGWU0XZIY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HYZ65gJ+; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HYZ65gJ+"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91BF31FFE3B;
	Mon, 11 Mar 2024 20:18:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G3Kd3Vz8pmjADrbLhsZmQs/b8QRJO5vZwyx1HM
	pPSVU=; b=HYZ65gJ+ZlOETPIs+NEKd7wADipVQJcNoD3w4eLTjQFg37WBGzYOe0
	XwKwRX2N4LFd3rA1Uiy0yaSpKyMUcV+iwS+u7YF1wZHpXLmStfkdk436OqCyDGOf
	GlV4T161tuwmJ0aIqn5JnzfwMNVwUfhMFb9/KGn5bx/jIWEGJhZqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A2431FFE3A;
	Mon, 11 Mar 2024 20:18:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3E2E1FFE39;
	Mon, 11 Mar 2024 20:18:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  Glen Choo <glencbz@gmail.com>
Subject: Re: [PATCH 1/5] MyFirstObjectWalk: use additional arg in config_fn_t
In-Reply-To: <15b74566e07a39902556cd620e5cd6df1da3c7df.1710192973.git.dirk@gouders.net>
	(Dirk Gouders's message of "Mon, 11 Mar 2024 11:11:11 +0100")
References: <cover.1710192973.git.dirk@gouders.net>
	<15b74566e07a39902556cd620e5cd6df1da3c7df.1710192973.git.dirk@gouders.net>
Date: Mon, 11 Mar 2024 17:18:05 -0700
Message-ID: <xmqq4jdcmhfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FFF628BA-E005-11EE-BADB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> Commit a4e7e317 (config: add ctx arg to config_fn_t) added a fourth
> argument to config_fn_t but did not change relevant function calls
> in Documentation/MyFirstObjectWalk.txt.
>
> Fix those calls and the example git_walken_config() to use
> that additional argument.


> Fixes: a4e7e317 (config: add ctx arg to config_fn_t)
> Cc: Glen Choo <glencbz@gmail.com>

I know what you wanted to convey with these, but in this project we
do not use them.  Both becomes unnecessary once you write the first
part of the log message above ;-)

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

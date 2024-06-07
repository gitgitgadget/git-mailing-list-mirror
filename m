Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078715ACB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782012; cv=none; b=tmO4jLxnbKW+dgin0xUFcvIV9tbJFjT+5c3dT6Ei/3yb+FYoMYsZ/4UFMERPicj9Rwv9MzM0zvkweQNI5Ia3AMxiUYW1lzTeocb4ntDrrEsQUjOLuv7xcr2jBm2rTmwhm8GirgOkwqphhOgyowMjAucHqhQPvtw39uyBZz57bJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782012; c=relaxed/simple;
	bh=/sCQOlJ7RLQqxOtVyFpkEInKHfYmd+ofSjfkZqquUa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzXZtwSQnRwclu0VKkTGARe91aQbigbHnbUzTo3Q6IwxDbHOybjOCHaV60XfKgJl1LMIz17uCKYCdY3PHTuyGbZFvylNF4jQoJCF+l5egyVHjEToZXeh6elQ8zqN6QkVeJ7BDP2PSjxNLv9bG1Y0qI8ZfAOtlNAiwN4pV6Rkg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f8PhSR7M; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8PhSR7M"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 72DC62FEDB;
	Fri,  7 Jun 2024 13:40:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/sCQOlJ7RLQqxOtVyFpkEInKHfYmd+ofSjfkZq
	quUa0=; b=f8PhSR7MlkRBWseTP320mNCS8CrSOX387dENopO7tvqgNBVeNme/nl
	GwOrhFhiR3Brc4lYbWlrvjQc577iCbGUBmQNOhamN5/F35zDHnktLyOmKqOkxdnw
	gAtndQ942WHtleoMEmie+7iRX+CLQYh+35nApnsh4Sl9/dwffZB10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA3352FED9;
	Fri,  7 Jun 2024 13:40:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C108A2FED8;
	Fri,  7 Jun 2024 13:40:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "darcy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  darcy <acednes@gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
In-Reply-To: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	(darcy via GitGitGadget's message of "Fri, 07 Jun 2024 00:17:08
	+0000")
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
Date: Fri, 07 Jun 2024 10:40:03 -0700
Message-ID: <xmqq1q58ejnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA24F9A0-24F4-11EF-A3DE-6488940A682E-77302942!pb-smtp2.pobox.com

"darcy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: darcy <acednes@gmail.com>

This ident should match what is used on "Signed-off-by:" line.

> Overriding the date of a commit to be close to "1970-01-01 00:00:00"
> with a large enough positive timezone for the equivelant GMT time to be
> before the epoch is considered valid by `parse_date_basic`. Similar
> behaviour occurs when using a date close to "2099-12-31 23:59:59" (the
> maximum date allowed by `tm_to_time_t`) with a large enough negative
> timezone offset.
>
> This leads to an integer underflow or underflow respectively in the

"underflow or underflow respectively"?

> commit timestamp, which is not caught by `git-commit`, but will cause
> other services to fail, such as `git-fsck`, which, for the first case,
> reports "badDateOverflow: invalid author/committer line - date causes
> integer overflow".
>
> Instead check the timezone offset and fail if the resulting time comes
> before the epoch "1970-01-01T00:00:00Z" or after the maximum date
> "2099-12-31T23:59:59Z".

Nicely described otherwise.

> +
> +/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
> +static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;

I wonder if this should be of timestamp_t type instead, as the check
is done against *timestamp in parse_date_basic() where *timestamp is
of type timestamp_t to match?

>  int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
> @@ -937,8 +941,14 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>  		}
>  	}
>  
> -	if (!tm_gmt)
> +	if (!tm_gmt) {
> +		if (*offset > 0 && *offset * 60 > *timestamp)
> +			return -1;
> +		if (*offset < 0 && -*offset * 60 > timestamp_max - *timestamp)
> +			return -1;
>  		*timestamp -= *offset * 60;
> +	}
> +
>  	return 0; /* success */
>  }

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD881F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFTVHx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:07:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57413 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFTVHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:07:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE32462DCD;
        Thu, 20 Jun 2019 17:07:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5xp1mdUEBiyR
        D/QWthTkP4bC5dE=; b=OOS8LiZJYJynQGIE77NoElzD9Rc6+1uJuVofxIepE2Jr
        2oUJD6u44VhUiGb3XPubEaKvqiKG2C0jJKdK7z0nDxJYAPlA/sXSboZZlW55H70K
        OJTdshxcv/Bq6vR3VJcOGGoztIFX9O5FoEf3kDcgdJzrssVq2HJFvXM+AjXOGR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GnB8rN
        mZBFBssXdufEiL143dPlCrDB616v+ivaj7qJIAiNNMttnhGQeYNllfgMDSlPNZGg
        r/kRK1rd+d1rlbqfnV+lSSmsGpVR8tKWgQwdxePj5ZHa6d6JCz+MHALcmls96gF9
        yd5bqQ4fgn57xCRaC3EPeIvbj+4pj3qmi4dsU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6D6162DCC;
        Thu, 20 Jun 2019 17:07:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCAFE62DCB;
        Thu, 20 Jun 2019 17:07:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
References: <pull.265.git.gitgitgadget@gmail.com>
        <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
        <03a68560-8058-7436-6edb-38e276a37190@web.de>
        <f22599d4-148f-212c-282c-790f5bde1706@web.de>
        <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
        <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
        <ebe4176d-1b51-fc82-7bce-713d098dbcf3@web.de>
Date:   Thu, 20 Jun 2019 14:07:45 -0700
In-Reply-To: <ebe4176d-1b51-fc82-7bce-713d098dbcf3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 20 Jun 2019 21:58:37 +0200")
Message-ID: <xmqqtvckklsu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74BD7738-939F-11E9-8C4A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> How about this?

Sounds sensible.

> -- >8 --
> Subject: [PATCH] config: simplify unit suffix handling
>
> parse_unit_factor() checks if a K, M or G is present after a number and
> multiplies it by 2^10, 2^20 or 2^30, respectively.  One of its callers
> checks if the result is smaller than the number alone to detect
> overflows.  The other one passes 1 as the number and does multiplicatio=
n
> and overflow check itself in a similar manner.
>
> This works, but is inconsistent, and it would break if we added support
> for a bigger unit factor.  E.g. 16777217T expands to 2^64 + 2^40, which
> is too big for a 64-bit number.  Modulo 2^64 we get 2^40 =3D=3D 1TB, wh=
ich
> is bigger than the raw number 16777217 =3D=3D 2^24 + 1, so the overflow
> would go undetected by that method.
>
> Move the multiplication out of parse_unit_factor() and rename it to
> get_unit_factor() to signify its reduced functionality.  This partially
> reverts c8deb5a146 ("Improve error messages when int/long cannot be
> parsed from config", 2007-12-25), but keeps the improved error messages=
.
> Use a return value of 0 to signal an invalid suffix.
>
> And use unsigned_mult_overflows to check for an overflow *before* doing
> the actual multiplication, which is simpler and can deal with larger
> unit factors.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Patch generated with --function-context for easier reviewing.
>
>  config.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/config.c b/config.c
> index 01c6e9df23..61a8bbb5cd 100644
> --- a/config.c
> +++ b/config.c
> @@ -834,51 +834,46 @@ static int git_parse_source(config_fn_t fn, void =
*data,
>  	return error_return;
>  }
>
> -static int parse_unit_factor(const char *end, uintmax_t *val)
> +static uintmax_t get_unit_factor(const char *end)
>  {
>  	if (!*end)
>  		return 1;
> -	else if (!strcasecmp(end, "k")) {
> -		*val *=3D 1024;
> -		return 1;
> -	}
> -	else if (!strcasecmp(end, "m")) {
> -		*val *=3D 1024 * 1024;
> -		return 1;
> -	}
> -	else if (!strcasecmp(end, "g")) {
> -		*val *=3D 1024 * 1024 * 1024;
> -		return 1;
> -	}
> +	if (!strcasecmp(end, "k"))
> +		return 1024;
> +	if (!strcasecmp(end, "m"))
> +		return 1024 * 1024;
> +	if (!strcasecmp(end, "g"))
> +		return 1024 * 1024 * 1024;
>  	return 0;
>  }
>
>  static int git_parse_signed(const char *value, intmax_t *ret, intmax_t=
 max)
>  {
>  	if (value && *value) {
>  		char *end;
>  		intmax_t val;
>  		uintmax_t uval;
> -		uintmax_t factor =3D 1;
> +		uintmax_t factor;
>
>  		errno =3D 0;
>  		val =3D strtoimax(value, &end, 0);
>  		if (errno =3D=3D ERANGE)
>  			return 0;
> -		if (!parse_unit_factor(end, &factor)) {
> +		factor =3D get_unit_factor(end);
> +		if (!factor) {
>  			errno =3D EINVAL;
>  			return 0;
>  		}
>  		uval =3D val < 0 ? -val : val;
> -		uval *=3D factor;
> -		if (uval > max || (val < 0 ? -val : val) > uval) {
> +		if (unsigned_mult_overflows(factor, uval) ||
> +		    factor * uval > max) {
>  			errno =3D ERANGE;
>  			return 0;
>  		}
>  		val *=3D factor;
>  		*ret =3D val;
>  		return 1;
>  	}
>  	errno =3D EINVAL;
>  	return 0;
>  }
> @@ -886,26 +881,28 @@ static int git_parse_signed(const char *value, in=
tmax_t *ret, intmax_t max)
>  static int git_parse_unsigned(const char *value, uintmax_t *ret, uintm=
ax_t max)
>  {
>  	if (value && *value) {
>  		char *end;
>  		uintmax_t val;
> -		uintmax_t oldval;
> +		uintmax_t factor;
>
>  		errno =3D 0;
>  		val =3D strtoumax(value, &end, 0);
>  		if (errno =3D=3D ERANGE)
>  			return 0;
> -		oldval =3D val;
> -		if (!parse_unit_factor(end, &val)) {
> +		factor =3D get_unit_factor(end);
> +		if (!factor) {
>  			errno =3D EINVAL;
>  			return 0;
>  		}
> -		if (val > max || oldval > val) {
> +		if (unsigned_mult_overflows(factor, val) ||
> +		    factor * val > max) {
>  			errno =3D ERANGE;
>  			return 0;
>  		}
> +		val *=3D factor;
>  		*ret =3D val;
>  		return 1;
>  	}
>  	errno =3D EINVAL;
>  	return 0;
>  }
> --
> 2.22.0

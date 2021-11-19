Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4D7C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDD361AD0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKSTRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:17:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62393 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKSTRh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 14:17:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F20210AAF5;
        Fri, 19 Nov 2021 14:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6chzaIdsg5ok
        PHn8LyBsMXKXjUWomx+4k/GL+FtrK30=; b=qYV6pyPdnHQzuSSqL12dZWJ+1+8X
        PQgsSM2oWPabe+tyjbYT8UDNLRXXLre2onMG6BpOI3aZEaMVtoS/WbEvNmN3x6Mr
        1XFK3v03Ssct+pxL0mUQ/PtnxX+xN6vUDgNYo/GjqU58J0mNsD+eWKPfTEzOpYmC
        rq3jnxAaioTmPgA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96CC210AAF4;
        Fri, 19 Nov 2021 14:14:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F08A510AAF3;
        Fri, 19 Nov 2021 14:14:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] strbuf: remove unused istarts_with() function
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
        <patch-5.6-642eec3d77c-20211119T124420Z-avarab@gmail.com>
Date:   Fri, 19 Nov 2021 11:14:32 -0800
In-Reply-To: <patch-5.6-642eec3d77c-20211119T124420Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 19 Nov
 2021 13:46:25 +0100")
Message-ID: <xmqqtug8ot47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE017F7E-496C-11EC-89A9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> It's arguably slightly odd to have a skip_prefix() and iskip_prefix(),
> but not both variants when it comes to starts_with(), but this is easy
> enough to resurrect should we ever need it, so let's drop it for now.

Let's not go there.  It is not easy at all to know that it used to
exist in the first place, which is more important part than knowing
that it is there and resurrect it.  We'd end up hearing from people
that the API is uneven, and seeing a patch that reinvents it, which
we have to review again.

Leaving an unused implementation is not without risk of going it
stale (imagine: when iskip_prefix() learns to honor locale aware
case insensitive comparison, istarts_with() that nobody uses may
be left behind without anybody noticing), so carrying an unused
function is not cost-free, but in this particular case, I think
keeping it is much better economy than removing it, even without
counting the cost of writing this response.

Thanks.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  git-compat-util.h | 1 -
>  strbuf.c          | 9 ---------
>  2 files changed, 10 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index d70ce142861..7117024a28b 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -512,7 +512,6 @@ report_fn get_warn_routine(void);
>  void set_die_is_recursing_routine(int (*routine)(void));
> =20
>  int starts_with(const char *str, const char *prefix);
> -int istarts_with(const char *str, const char *prefix);
> =20
>  /*
>   * If the string "str" begins with the string found in "prefix", retur=
n 1.
> diff --git a/strbuf.c b/strbuf.c
> index b22e9816559..1b52e3c8250 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -12,15 +12,6 @@ int starts_with(const char *str, const char *prefix)
>  			return 0;
>  }
> =20
> -int istarts_with(const char *str, const char *prefix)
> -{
> -	for (; ; str++, prefix++)
> -		if (!*prefix)
> -			return 1;
> -		else if (tolower(*str) !=3D tolower(*prefix))
> -			return 0;
> -}
> -
>  int skip_to_optional_arg_default(const char *str, const char *prefix,
>  				 const char **arg, const char *def)
>  {

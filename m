Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19914C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 05:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7296193E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 05:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhC1Ff2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 01:35:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55659 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC1FfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 01:35:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01A4411713B;
        Sun, 28 Mar 2021 01:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Pgn4RZMMAW8p
        vwuRn2QoRy6WG4s=; b=mg5Z6q7tNV1D/gGMynIpdyLMrXtTozatIsFdnVunEV3v
        XhWTipTtjqokAkLZIBpnlGmQWNBYHklatVymEkO29Zvl2VxHrY3hYjCdSUXup1S2
        v7I5qms1R3QksJHuUuB0cQEvrNbALolRbQf1YmChjHkqSPfySqDZaodyxBojB1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nxYsO1
        SAN/8FqtT2gV/Jx2t/+FIxNr9faDLphaxy/CJ6InUeAFlh7M8hAxTg5Ld+5v9po0
        3E/DL+Akn0q7a+eEUV7DBJ9qYm4lDWwL4QQY7kfXeip6PdDmE7aSir7iny6JMIHA
        KKcDVG18yvExPKWaxsCSIkEgsSawSAGkY/Aig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE42111713A;
        Sun, 28 Mar 2021 01:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A962117139;
        Sun, 28 Mar 2021 01:35:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/10] object.c: stop supporting len == -1 in
 type_from_string_gently()
References: <20210308200426.21824-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
        <patch-01.11-e51c860a65d-20210328T021238Z-avarab@gmail.com>
Date:   Sat, 27 Mar 2021 22:35:02 -0700
In-Reply-To: <patch-01.11-e51c860a65d-20210328T021238Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 28 Mar
 2021 04:13:31
        +0200")
Message-ID: <xmqqy2e7on7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5910F0F6-8F87-11EB-AEDA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the type_from_string() macro into a function and drop the
> support for passing len < 0.
>
> Support for len < 0 was added in fe8e3b71805 (Refactor
> type_from_string() to allow continuing after detecting an error,
> 2014-09-10), but no callers use that form. Let's drop it to simplify
> this, and in preparation for simplifying these even further.

Given the recent fallout of oversimplifying we've seen in other
topic, this line of thinking makes me nauseated, but let's see how
well this works this time around.

At least, replacing an already queued topic with v2 would not
increase the number of topics that are supposedly in-flight but not
quite moving due to lack of reviews and responses, unlike bunch of
totally new patches ;-)

Will replace.  Thanks.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  object.c | 10 +++++++---
>  object.h |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/object.c b/object.c
> index 78343781ae7..65446172172 100644
> --- a/object.c
> +++ b/object.c
> @@ -39,9 +39,6 @@ int type_from_string_gently(const char *str, ssize_t =
len, int gentle)
>  {
>  	int i;
> =20
> -	if (len < 0)
> -		len =3D strlen(str);
> -
>  	for (i =3D 1; i < ARRAY_SIZE(object_type_strings); i++)
>  		if (!strncmp(str, object_type_strings[i], len) &&
>  		    object_type_strings[i][len] =3D=3D '\0')
> @@ -53,6 +50,13 @@ int type_from_string_gently(const char *str, ssize_t=
 len, int gentle)
>  	die(_("invalid object type \"%s\""), str);
>  }
> =20
> +int type_from_string(const char *str)
> +{
> +	size_t len =3D strlen(str);
> +	int ret =3D type_from_string_gently(str, len, 0);
> +	return ret;
> +}
> +
>  /*
>   * Return a numerical hash value between 0 and n-1 for the object with
>   * the specified sha1.  n must be a power of 2.  Please note that the
> diff --git a/object.h b/object.h
> index 59daadce214..3ab3eb193d3 100644
> --- a/object.h
> +++ b/object.h
> @@ -94,7 +94,7 @@ struct object {
> =20
>  const char *type_name(unsigned int type);
>  int type_from_string_gently(const char *str, ssize_t, int gentle);
> -#define type_from_string(str) type_from_string_gently(str, -1, 0)
> +int type_from_string(const char *str);
> =20
>  /*
>   * Return the current number of buckets in the object hashmap.

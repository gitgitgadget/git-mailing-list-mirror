Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8608CC4332F
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E0A61100
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbhIQTbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:31:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52231 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343793AbhIQTbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:31:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0CD2F72E4;
        Fri, 17 Sep 2021 15:30:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=02+GPndkkeSs
        DJ6SFNH/1f+wMhY3ZZ5lYGGT3TCRPdg=; b=S7xRCXv80OnSjq3LBLc340dWlBXW
        Bta5Xyqgc8tDZu+n2c3pQ4+yaDRBnxlQn5Q4kBPAwSJe/RlLUCkKHVqonUzl5CPT
        p5Oxu40BtanLGd9rE5c9XLO7m77FQQxmfvSuQOGJvHe2CHaHJvmk1xAcqlXw1SGE
        0zdkw/vL+92oces=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A77DAF72E3;
        Fri, 17 Sep 2021 15:30:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04CAFF72E2;
        Fri, 17 Sep 2021 15:30:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] read-cache & fetch-negotiator: check "enum"
 values in switch()
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
        <patch-v2-3.5-9f1bb0496ed-20210916T182918Z-avarab@gmail.com>
Date:   Fri, 17 Sep 2021 12:30:21 -0700
In-Reply-To: <patch-v2-3.5-9f1bb0496ed-20210916T182918Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 16 Sep
 2021 20:30:34
        +0200")
Message-ID: <xmqqsfy3gfua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3A722A8-17ED-11EC-B983-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change tweak_untracked_cache() in "read-cache.c" to use a switch() to
> have the compiler assert that we checked all possible values in the
> "enum untracked_cache_setting" type, and likewise remove the "default"
> case in fetch_negotiator_init() in favor of checking for
> "FETCH_NEGOTIATION_UNSET" and "FETCH_NEGOTIATION_NONE".
>
> See ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
> for when the "unset" and "keep" handling for core.untrackedCache was
> consolidated, and aaf633c2ad1 (repo-settings: create
> feature.experimental setting, 2019-08-13) for the addition of the
> "default" pattern in "fetch-negotiator.c".

Covering all possibility is good, but ...

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fetch-negotiator.c |  3 ++-
>  read-cache.c       | 15 ++++++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-negotiator.c b/fetch-negotiator.c
> index 57ed5784e14..e7b5878be7c 100644
> --- a/fetch-negotiator.c
> +++ b/fetch-negotiator.c
> @@ -19,7 +19,8 @@ void fetch_negotiator_init(struct repository *r,
>  		return;
> =20
>  	case FETCH_NEGOTIATION_DEFAULT:
> -	default:
> +	case FETCH_NEGOTIATION_UNSET:
> +	case FETCH_NEGOTIATION_NONE:
>  		default_negotiator_init(negotiator);
>  		return;
>  	}
> diff --git a/read-cache.c b/read-cache.c
> index 9048ef9e905..9dd84d69f00 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1944,13 +1944,18 @@ static void tweak_untracked_cache(struct index_=
state *istate)
> =20
>  	prepare_repo_settings(r);
> =20
> -	if (r->settings.core_untracked_cache  =3D=3D UNTRACKED_CACHE_REMOVE) =
{
> +	switch (r->settings.core_untracked_cache) {
> +	case UNTRACKED_CACHE_REMOVE:
>  		remove_untracked_cache(istate);
> -		return;
> -	}
> -
> -	if (r->settings.core_untracked_cache =3D=3D UNTRACKED_CACHE_WRITE)
> +		break;
> +	case UNTRACKED_CACHE_WRITE:
>  		add_untracked_cache(istate);
> +		break;
> +	case UNTRACKED_CACHE_UNSET:
> +	case UNTRACKED_CACHE_KEEP:
> +		break;
> +	}

... this change makes me wonder if

	default:
		BUG(...);

might have been more appropriate?  Are we sure these the flow will
reach here with these two values?

> +	return;
>  }

I do not see why we want to add a no-op return that wasn't there in
the original.  Perhaps later, but definitely not as a part of this
change.

> =20
>  static void tweak_split_index(struct index_state *istate)

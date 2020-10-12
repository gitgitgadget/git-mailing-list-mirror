Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA7C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1C720878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mNwypAmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgJLTxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:53:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61708 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgJLTxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:53:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C821E8D7B2;
        Mon, 12 Oct 2020 15:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M/fZGZ+fshnz
        ikrQXXv9zKNOJ08=; b=mNwypAmAGY+5GhqEki55DXaBJCJqM1vAErWlCd1RUsK/
        h0Vr2f/haNNvauHuP6cj/K1OVZWKgDin0DgVdUNLtOmz5x+5ttreL8qo9+MOv3Vx
        LHOOetUmsSJQAkUGoSNO3BI8mLEwKtoLe0iC7EKyYGH+cvju0wmgDGolBWIcSdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZScEkl
        EKVHlHgDnCOI77VAHCwHRQ0+jw5+gQOxpzHKf2w2xNyssm57FB+M3tqd4bWE+AXp
        rIsYxPD5KoH8MCBznct0y3Wvhaah5Jl4ShGKX4snThwnBMtjaesR0p+Mnnol3wzQ
        h6jVjmog0MSX8oKN/tdPtKk1EnNnflBq7YApg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 993FF8D7AE;
        Mon, 12 Oct 2020 15:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE7FB8D7AD;
        Mon, 12 Oct 2020 15:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] merge-base, xdiff: zero out xpparam_t structures
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-2-michal@isc.org>
Date:   Mon, 12 Oct 2020 12:52:59 -0700
In-Reply-To: <20201012091751.19594-2-michal@isc.org> (=?utf-8?B?Ik1pY2hh?=
 =?utf-8?B?xYIgS8SZcGllxYQiJ3M=?=
        message of "Mon, 12 Oct 2020 11:17:49 +0200")
Message-ID: <xmqqsgajnrvo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88024A0E-0CC4-11EB-9898-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index e72714a5a8..de8520778d 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -109,6 +109,7 @@ static void show_diff(struct merge_list *entry)
>  	xdemitconf_t xecfg;
>  	xdemitcb_t ecb;
> =20
> +	memset(&xpp, 0, sizeof(xpp));
>  	xpp.flags =3D 0;
>  	memset(&xecfg, 0, sizeof(xecfg));
>  	xecfg.ctxlen =3D 3;

The existing "xpp.flags=3D0" can then go away, and as Dscho hinted,

	xpparam_t xpp =3D {
		.flags =3D 0,
	};

may also be a valid way to write this.  What it says is that we want
the entirety of xpp to be reasonably initialized, but we do care
that its .flags field to be exactly zero.

> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index c7b35a9667..e694bfd9e3 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -235,6 +235,8 @@ static int fall_back_to_classic_diff(xpparam_t cons=
t *xpp, xdfenv_t *env,
>  		int line1, int count1, int line2, int count2)
>  {
>  	xpparam_t xpparam;
> +
> +	memset(&xpparam, 0, sizeof(xpparam));
>  	xpparam.flags =3D xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;

Likewise.  Giving an initializer to the local variable def, e.g.

	xpparam_t xpparam =3D {
		.flags =3D xpp->flags & ~XDF_DIFF_ALGORITHM_MASK,
	};

would allow us to lose one line.

>  	return xdl_fall_back_diff(env, &xpparam,
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 3c5601b602..20699a6f60 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -318,6 +318,8 @@ static int fall_back_to_classic_diff(struct hashmap=
 *map,
>  		int line1, int count1, int line2, int count2)
>  {
>  	xpparam_t xpp;
> +
> +	memset(&xpp, 0, sizeof(xpp));
>  	xpp.flags =3D map->xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;

Likewise.

>  	return xdl_fall_back_diff(map->env, &xpp,

But the patch is good as-is, given especially the way how xecfg is
cleared the same way in builtin/merge-tree.c::show_diff().

Will queue.  Thanks.

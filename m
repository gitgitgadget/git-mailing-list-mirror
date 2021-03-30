Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C1C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7A2619C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhC3XuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:50:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60975 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3XuK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:50:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C626B0BB6;
        Tue, 30 Mar 2021 19:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PRu7T/+fOJe/
        YHjh1O1jjWAnY78=; b=q8SNaI5MLOLLP8pgoANcBOeJzJb/2sUZdabIamKi51N7
        5ZSyPeOIVbHhiEzuvbs0cchqSKuXHSmtCXbuJxoWJhKelcOay5vhFEJNqlOKo8u5
        j+AZP2QJ9WC/rurRgAwIAQz28S6Wlk3ssQaEWcMGxA97pRCkKh1sxhCWHLvqPmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LG3Dbv
        YOXa9fvo4te7QNijaa0kPWsu0Gcv3lgkx4daQWp08IfsWsZvYLs/+blBp1pZa2L4
        0ysrqW0M/lbSbpYVOFgCq5xZWOqlJJjCoNwps919vmKoIl02HNET9s5/OZh1a3dH
        seOCBIMcxcyH3NSwTR2zuYlackGbZgI9jZ8Tk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40379B0BB5;
        Tue, 30 Mar 2021 19:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C5E5B0BB4;
        Tue, 30 Mar 2021 19:50:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 15/22] pickaxe: assert that we must have a needle
 under -G or -S
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-16-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:50:07 -0700
In-Reply-To: <20210216115801.4773-16-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:54 +0100")
Message-ID: <xmqqmtuk9p74.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8956E22-91B2-11EB-BA71-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index cff46f9f8f7..dd1b5c72332 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -132,9 +132,6 @@ static int pickaxe_match(struct diff_filepair *p, s=
truct diff_options *o,
>  			 oidset_contains(o->objfind, &p->two->oid));
>  	}
> =20
> -	if (!o->pickaxe[0])
> -		return 0;

So -S"" could pass o->pickaxe a non-NULL pointer, but the string
pointed by that pointer could be 0-length.  And that is not what we
want to see happen.

>  	if (o->flags.allow_textconv) {
>  		textconv_one =3D get_textconv(o->repo, p->one);
>  		textconv_two =3D get_textconv(o->repo, p->two);
> @@ -230,6 +227,8 @@ void diffcore_pickaxe(struct diff_options *o)
>  	kwset_t kws =3D NULL;
>  	pickaxe_fn fn;
> =20
> +	if (opts & ~DIFF_PICKAXE_KIND_OBJFIND && !needle)
> +		BUG("should have needle under -G or -S");

Here, needle was picked up at the beginning of this function like
so:

        void diffcore_pickaxe(struct diff_options *o)
        {
                const char *needle =3D o->pickaxe;

The two checks seem to be protecting from different things.
Shouldn't the new BUG() condition be more like

	if ((opts & ~DIFF_PICKAXE_KIND_OBJFIND) && (!needle || !*needle))

instead?

>  	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
>  		int cflags =3D REG_EXTENDED | REG_NEWLINE;
>  		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE)
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index bcaca7e882c..4b65b89e7a5 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -56,6 +56,12 @@ test_expect_success setup '
>  '
> =20
>  test_expect_success 'usage' '
> +	test_expect_code 129 git log -S 2>err &&
> +	test_i18ngrep "switch.*requires a value" err &&
> +
> +	test_expect_code 129 git log -G 2>err &&
> +	test_i18ngrep "switch.*requires a value" err &&
> +
>  	test_expect_code 128 git log -Gregex -Sstring 2>err &&
>  	test_i18ngrep "mutually exclusive" err &&

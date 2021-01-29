Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B8C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E47E64DDB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhA2Hus (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:50:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58751 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhA2Huq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 02:50:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30A5FF87A6;
        Fri, 29 Jan 2021 02:49:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZPQzg4X4hAW+
        ldFiHuoNEKXUxlo=; b=c85W27tmPK+zPsSJPzYxQgxU6n1jUVQMi5Uf/gTRLYlK
        ocktN2pNaiNFNemQb0DbatyiGxMirFDjhSvltBYbrYbXmYgcQPc76l3IdHaajfJt
        Ggk9PWXswTv/xi2xoRzEgFyXaoB9fyWKbtpp43kFmB0LyKfeNB4tyInZ4/UGYOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z7Vb5u
        M9mI1ly/pjpum5AvwEtnNr25+SYLEhtnKHlgppJ5FQrxFrVNMhF/CyUn0L58qHX6
        qfxN/ueZ+l85cPMS1BNBVxqeLigpXlWf+53OK+C/8zBJYUW+P4VS6IkaBOvTupTM
        E1fQHuh16aHlrngzCSdxL3mcNPVOj+DjZo9jQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D268F87A5;
        Fri, 29 Jan 2021 02:49:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 58A99F87A1;
        Fri, 29 Jan 2021 02:49:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] Makefile: guard against TEST_OBJS in the environment
References: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
        <20210128182310.26787-3-avarab@gmail.com>
Date:   Thu, 28 Jan 2021 23:49:13 -0800
In-Reply-To: <20210128182310.26787-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 28 Jan 2021 19:23:06 +0100")
Message-ID: <xmqqbld8tc7a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7BF2E420-6206-11EB-8D76-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add TEST_OBJS to the list of other *_OBJS variables we reset. We had
> already established this pattern when TEST_OBJS was introduced in
> daa99a91729 (Makefile: make sure test helpers are rebuilt when headers
> change, 2010-01-26), but it wasn't added to the list in that commit
> along with the rest.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)

Makes sense.  I have only seen [1&2/6], and so far these look good.
Hopefully I'll see [3-6/6] as well.

> diff --git a/Makefile b/Makefile
> index 65e600713c1..63fa5c30b45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -591,6 +591,7 @@ SCRIPT_PYTHON =3D
>  SCRIPT_SH =3D
>  SCRIPT_LIB =3D
>  TEST_BUILTINS_OBJS =3D
> +TEST_OBJS =3D=20
>  TEST_PROGRAMS_NEED_X =3D
>  THIRD_PARTY_SOURCES =3D

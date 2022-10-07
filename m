Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34846C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 18:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJGSMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJGSMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 14:12:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C618B3D
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 11:12:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93EA41B691C;
        Fri,  7 Oct 2022 14:12:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0cHVblL6l8j2
        V5FhwMnJahLUmir1w8lC3JsnfbgI12w=; b=oPwo8ypz5HMhxlxV8I4TunlRteUm
        Zj4zlJmd90zBH1W1mfSPDHPHXkslGpbSO9o1MYIckpTOiHtUgDdWlS5mias2leOi
        uHpHwrLudFiAeDijVQMEZV6Gt4aP9NJbm38D/pAmT74khTVaHX7ZOkAO2t9dRJiH
        3rZoDoMdsdGL15o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C2E41B6912;
        Fri,  7 Oct 2022 14:12:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C38261B6910;
        Fri,  7 Oct 2022 14:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/5] CodingGuidelines: allow declaring variables in for
 loops
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
        <patch-3.5-80afc246666-20221007T092505Z-avarab@gmail.com>
Date:   Fri, 07 Oct 2022 11:12:40 -0700
In-Reply-To: <patch-3.5-80afc246666-20221007T092505Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 7 Oct
 2022 11:30:32 +0200")
Message-ID: <xmqq5ygvfqp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2620DA2-466B-11ED-B0FF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/revision.c b/revision.c
> index 36e31942cee..8f2623b3b5a 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -47,13 +47,6 @@ static inline int want_ancestry(const struct rev_inf=
o *revs);
>  void show_object_with_name(FILE *out, struct object *obj, const char *=
name)
>  {
>  	fprintf(out, "%s ", oid_to_hex(&obj->oid));
> -	/*
> -	 * This "for (const char *p =3D ..." is made as a first step towards
> -	 * making use of such declarations elsewhere in our codebase.  If
> -	 * it causes compilation problems on your platform, please report
> -	 * it to the Git mailing list at git@vger.kernel.org. In the meantime=
,
> -	 * adding -std=3Dgnu99 to CFLAGS may help if you are with older GCC.
> -	 */
>  	for (const char *p =3D name; *p && *p !=3D '\n'; p++)
>  		fputc(*p, out);
>  	fputc('\n', out);

Good.  Thanks for not forgetting to remove this.

> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-option=
s.c
> index 506835521a4..f8a62d892d9 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -195,8 +195,7 @@ int cmd__parse_options(int argc, const char **argv)
> =20
>  static void print_args(int argc, const char **argv)
>  {
> -	int i;
> -	for (i =3D 0; i < argc; i++)
> +	for (int i =3D 0; i < argc; i++)
>  		printf("arg %02d: %s\n", i, argv[i]);
>  }

This does not belong to this patch.  If the current code as written
is acceptable, it is not worth patch churn to rewrite it.

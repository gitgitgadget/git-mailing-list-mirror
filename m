Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557981F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfGZUeg (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:34:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57061 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfGZUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:34:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3608D150F88;
        Fri, 26 Jul 2019 16:34:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0aoi5RBQ9ylY
        wmRXATVtnjBIzZs=; b=kVd1oFaKni403QouJWelFgTMlz2BybgZV2AmqQjTn7un
        HlvBpdFCvQFEiFeX3SLmMPWLXU+cx/nnQK59KRuirtgzDGOyVQGVvawN4YS2DrXn
        Q0R6RITNUMpkCeZxRo2fmQf13NHLo6VBWTd85eIeICF84xyf5UujxepRYLDgt6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=krhw6U
        RWXW3bFgX5lasmL7pkYmeyvLt5P9yVLwad0h6+ohEOO8OB1xbXJcKUDVx0Gp1Ead
        JDfZ4AbtBRTNZPskQmJS74kQs4gtUS+sH/pcyGTCvzZcthHATBX91CzEGvPgXXm9
        KuDknStmm9uTrKUqkdkhEBhLh31KIxJcIjecU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D9E2150F87;
        Fri, 26 Jul 2019 16:34:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91E2F150F86;
        Fri, 26 Jul 2019 16:34:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 6/8] grep: stess test PCRE v2 on invalid UTF-8 data
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-7-avarab@gmail.com>
Date:   Fri, 26 Jul 2019 13:34:29 -0700
In-Reply-To: <20190726150818.6373-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Jul 2019 17:08:16 +0200")
Message-ID: <xmqqlfwkmt62.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C52032D6-AFE4-11E9-B9F8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/grep.c b/grep.c
> index 6d60e2e557..5bc0f4f32a 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -615,6 +615,16 @@ static void compile_regexp(struct grep_pat *p, str=
uct grep_opt *opt)
>  		die(_("given pattern contains NULL byte (via -f <file>). This is onl=
y supported with -P under PCRE v2"));
> =20
>  	p->is_fixed =3D is_fixed(p->pattern, p->patternlen);
> +#ifdef USE_LIBPCRE2
> +       if (!p->fixed && !p->is_fixed) {
> +	       const char *no_jit =3D "(*NO_JIT)";
> +	       const int no_jit_len =3D strlen(no_jit);
> +	       if (starts_with(p->pattern, no_jit) &&
> +		   is_fixed(p->pattern + no_jit_len,
> +			    p->patternlen - no_jit_len))
> +		       p->is_fixed =3D 1;

It is unfortunate that is_fixed() takes a counted string.
Otherwise, using skip_prefix() to avoid "+no_jit_len" would have
made it much easier to read. i.e.

	/* an illustration that does not quite work */
	char *pattern_body;
	if (skip_prefix(p->pattern, "(*NO_JIT)", &pattern_body) &&
            is_fixed(pattern_body))
		p->is_fixed =3D 1;
=09
> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: setup invalid UT=
F-8 data' '
> +	printf "\\200\\n" >invalid-0x80 &&
> +	echo "=C3=A6var" >expected &&
> +	cat expected >>invalid-0x80 &&
> +	git add invalid-0x80
> +'
> +
> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from =
invalid UTF-8 data' '
> +	git grep -h "var" invalid-0x80 >actual &&
> +	test_cmp expected actual &&
> +	git grep -h "(*NO_JIT)var" invalid-0x80 >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII f=
rom invalid UTF-8 data' '
> +	test_might_fail git grep -h "=C3=A6" invalid-0x80 >actual &&
> +	test_cmp expected actual &&
> +	test_must_fail git grep -h "(*NO_JIT)=C3=A6" invalid-0x80 &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII f=
rom invalid UTF-8 data with -i' '
> +	test_might_fail git grep -hi "=C3=86" invalid-0x80 >actual &&
> +	test_cmp expected actual &&
> +	test_must_fail git grep -hi "(*NO_JIT)=C3=86" invalid-0x80 &&
> +	test_cmp expected actual
> +'
> +
>  test_done

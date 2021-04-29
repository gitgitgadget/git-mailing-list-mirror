Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3826C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25F561405
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhD2EQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 00:16:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62636 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhD2EQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 00:16:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F01AED0A73;
        Thu, 29 Apr 2021 00:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U8y5y5vcgJpD
        4OZrdRohJV1D4HEhZUz6sMQpglFJZ9g=; b=fLWi8IAIB4OI0FdhtEwsLCWK8FEO
        bkEhq0Q0Yq8th9wjyJtn7uplzXUuhKaF3JBQAhQrTt5SFBn4qhkwvODQnY+EtpWU
        5cJd4lIl8AyxsFxUPjx8j0Zj3Q8CKWXijNQO9nBu7iAGAKlwM2HVP8kE56CQRTng
        vkWxFhJuYBfLfSE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6EA1D0A71;
        Thu, 29 Apr 2021 00:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15D23D0A70;
        Thu, 29 Apr 2021 00:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 01/10] cat-file tests: test for bogus type name handling
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
        <patch-01.10-5818eca45d-20210420T124428Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 13:15:16 +0900
In-Reply-To: <patch-01.10-5818eca45d-20210420T124428Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:50:34 +0200")
Message-ID: <xmqqim459163.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80EBC492-A8A1-11EB-B465-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a test of how "cat-file" behaves when given a bogus type in its
> "git cat-file <TYPE> <OBJECT>" mode. There were existing tests (just
> below this one) for "-t bogus" or "--allow-unknown-type" modes, but
> none for the switch-less mode.
>
> This test is similar to the one that exists for "git hash-object"
> already, see b7994af0f92 (type_from_string_gently: make sure length
> matches, 2015-04-17).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t1006-cat-file.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 5d2dc99b74..908797dcae 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -315,6 +315,22 @@ test_expect_success '%(deltabase) reports packed d=
elta bases' '
>  	}
>  '
> =20
> +test_expect_success 'cat-file complains about bogus type name' '
> +	test_must_fail git cat-file co HEAD >out 2>err &&
> +	test_must_be_empty out &&
> +	cat >expected <<-\EOF &&
> +	fatal: invalid object type "co"
> +	EOF
> +	test_cmp expected err &&
> +
> +	test_must_fail git cat-file bogus HEAD >out 2>err &&
> +	test_must_be_empty out &&
> +	cat >expected <<-\EOF &&
> +	fatal: invalid object type "bogus"
> +	EOF
> +	test_cmp expected err
> +'

I am not 100% sure if it is worth testing both "co" and "bogus", but
if it were, then I'd prefer to have these two as independent test
pieces, because a convincing "we need to have both of these tested
for this reason" would very much likely say that these two kinds of
bugs can come from different/independent bug sources.

FWIW, the commit b7994af0 (type_from_string_gently: make sure length
matches, 2015-04-17) used as a model for this patch uses two
separate tests (one for truncated, the other for bogus).

>  bogus_type=3D"bogus"
>  bogus_content=3D"bogus"
>  bogus_size=3D$(strlen "$bogus_content")

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7300FC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4240F600CC
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbhCAVgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:36:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51606 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbhCAVdk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:33:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D95F12453B;
        Mon,  1 Mar 2021 16:32:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nCFUlA30hi7B
        mQjEF/tiBnu6BAc=; b=yHTEH12toAopVy7mnQeox5n2ktslQY/wUhxr23CIkuYz
        PrP30GNT7pAxFICUisyyVxBN9KDqord4wkn1KCOrVZnVRYOnnPsam9ztP9IEprHG
        G+hd+Wdmf68v6IJ1RPZkl1WtGuQfTBERC+GgGQBv86TaJtCnGqfqpEzKIsv+dsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FJYL6a
        xyV3oOrYRVWn9+L/2j5jHIuNRmF9mfMvfSyy/cKb/bPId0SGYj+c+ml3AdTk8/kj
        OCUKbZV/LGpI5fXESvBSBw0DeymCi2q1qN3td/IY5XlJsgWxxq0ltBmDHt7c0vbS
        GJTzAPUYRTZRoGaQFQWgMRoiK7hz8zIIxXNr0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37EFE12453A;
        Mon,  1 Mar 2021 16:32:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B3A5124539;
        Mon,  1 Mar 2021 16:32:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 03/10] describe tests: always assert empty stderr from
 "describe"
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-4-avarab@gmail.com>
Date:   Mon, 01 Mar 2021 13:32:53 -0800
In-Reply-To: <20210228195414.21372-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 28 Feb 2021 20:54:07 +0100")
Message-ID: <xmqqwnuqo8ze.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF740BF2-7AD5-11EB-BDE9-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Invert a test added in 3291fe4072e (Add git-describe test for "verify
> annotated tag names on output", 2008-03-03) to make checking that we
> don't have warnings the rule rather than the exception.
>
> There was only one case where we expected and got a warning. Let's
> test for that case explicitly, and assert no warnings or other stderr
> output for all the rest.

When we are expecting an error from "describe", we would want to
make sure that we will see an expected explanation of the failure
(e.g. "you passed a non-commit") in the standard error stream, but I
am somewhat skeptical about the value of a change like this that
insists that there is nothing on the standard error stream when the
command succeeds.

It is unlikely to trigger auto GC during the operation of "git
describe" and seeing some output in the standard error stream, but
it is easy to imagine that we may add an "automatically cache
precomputed topology information" feature and trigger during a
history traversal operation like this one, with some note to the
standard error output.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t6120-describe.sh | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index e4fd5d567f..ef70c695be 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -21,7 +21,8 @@ check_describe () {
>  	shift
>  	describe_opts=3D"$@"
>  	test_expect_success "describe $describe_opts" '
> -		git describe $describe_opts 2>err.actual >raw &&
> +		git describe $describe_opts 2>err >raw &&
> +		test_must_be_empty err &&
>  		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
>  		echo $expect >expect &&
>  		test_cmp expect actual
> @@ -122,20 +123,17 @@ test_expect_success 'describe --contains defaults=
 to HEAD without commit-ish' '
>  '
> =20
>  check_describe tags/A --all A^0
> -test_expect_success 'no warning was displayed for A' '
> -	test_must_be_empty err.actual
> -'
> =20
> -test_expect_success 'rename tag A to Q locally' '
> -	mv .git/refs/tags/A .git/refs/tags/Q
> -'
> -cat - >err.expect <<EOF
> -warning: tag 'Q' is externally known as 'A'
> -EOF
> -check_describe A-8-gHASH HEAD
> -test_expect_success 'warning was displayed for Q' '
> -	test_cmp err.expect err.actual
> -'
> +test_expect_success 'renaming tag A to Q locally produces a warning' "
> +	mv .git/refs/tags/A .git/refs/tags/Q &&
> +	git describe HEAD 2>actual >out &&
> +	cat >expected <<-\EOF &&
> +	warning: tag 'Q' is externally known as 'A'
> +	EOF
> +	test_cmp expected actual &&
> +	grep -E '^A-8-g[0-9a-f]+$' out
> +"
> +
>  test_expect_success 'misnamed annotated tag forces long output' '
>  	description=3D$(git describe --no-long Q^0) &&
>  	expr "$description" : "A-0-g[0-9a-f]*$" &&

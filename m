Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01433C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C8D2083B
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UOmjCQGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391547AbgJPSQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:16:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54398 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391542AbgJPSQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 14:16:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCA26100480;
        Fri, 16 Oct 2020 14:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ysiwTGRI0Izx
        metz8T/yYt6Vb0k=; b=UOmjCQGmTZ55Ar6K75Q4DQuIhxfM5EJbJGIBg3iM7lzg
        5zgs8GqRKt1kqp6IVD+lQfKaKmNtc6X1SK1XYemTTNk9WdPlDrohkWRGhN9UCHcK
        DDe4wj2qVxC3hTQUbrQgYn7MO85bKUyRhDdTTD2RsYBfooGuRxfp8suGrf4tmG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qV0VAU
        zEM00GzX7pxM30aNju5RnwaA9GZ3nui2cd21t0Su6ZSH+6Mttl68pmiJb24spmhN
        RZwB28hyxFtOUChpE9gKrQ8NZa0GdsvUhITSh0IxcnA2FkB7VisCAF1BcJrjRc6u
        kToDJ0UxhuGvm2O8JmZt6DKvYoN+t4IIO8mzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C54CE10047E;
        Fri, 16 Oct 2020 14:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0320810047B;
        Fri, 16 Oct 2020 14:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] diff: add -I<regex> that ignores matching changes
References: <20201012091751.19594-1-michal@isc.org>
        <20201015072406.4506-1-michal@isc.org>
        <20201015072406.4506-3-michal@isc.org>
Date:   Fri, 16 Oct 2020 11:16:47 -0700
In-Reply-To: <20201015072406.4506-3-michal@isc.org> (=?utf-8?B?Ik1pY2hh?=
 =?utf-8?B?xYIgS8SZcGllxYQiJ3M=?= message
        of "Thu, 15 Oct 2020 09:24:06 +0200")
Message-ID: <xmqqa6wmc9yo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1E613C6-0FDB-11EB-9354-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

> +test_expect_success 'diff -I<regex>' '
> +	test_seq 50 >I.txt &&
> +	sed -e "s/13/ten and three/" -e "/7\$/d" <I.txt >J.txt &&
> +	echo >>J.txt &&
> +
> +	test_expect_code 1 git diff --no-index --ignore-blank-lines -I"ten.*e=
" -I"^[124-9]" I.txt J.txt >actual &&

Please wrap an overly long line like this oned, perhaps like:

	test_expect_code 1 git diff --no-index --ignore-blank-lines \
		-I"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&

> +	test_expect_code 1 git diff --stat --no-index --ignore-blank-lines -I=
"ten.*e" -I"^[124-9]" I.txt J.txt >actual &&

> +	test_expect_code 129 git diff --no-index --ignore-matching-lines=3D"^=
[124-9]" --ignore-matching-lines=3D"^[124-9" I.txt J.txt >output 2>&1 &&

Cramming unrelated tests into a single one made me puzzled, staring
at this line for longer than necessary before realizing that this is
an attempt to catch a malformed regexp.  If this were in a separate
test with its own title, e.g.

	test_expect_success 'diff -I<regex>: setup' '
		... set up the sample input, perhaps sample history ...
		... perhaps prepare the expected output in "expect" ...
	'

	test_expect_success 'diff -I<regex> -p' '
		git diff --I"ten.*e" ... >actual &&
		test_cmp expect actual
	'

	test_expect_success 'diff -I<regex> --stat' '
		git diff --stat --I"ten.*e" ... >actual &&
		test_cmp expect actual
	'

	test_expect_success 'diff -I<regex>: detect malformed regex'
		test_must_fail git diff -I=3D"[^124-9" ... 2>error &&
		test_i18ngrep "invalid regex" error
	'
	=09
It would have been much easier to follow.

It also is curious that it only tests --no-index, which is a bolted
on feature that may not exercise the codepath the users depend on
working correctly.  If this were tested with "git log -p" for a few
commits, the early destruction of regexp may have been caught,
especially with ASAN build.

Other than that, and also the premature destruction of regexp
pointed out by Phillip already, looks reasonably done.

Thanks.

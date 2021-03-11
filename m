Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A611C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF93E64FC4
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCKBX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:23:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56660 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCKBXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 20:23:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0948511B7AD;
        Wed, 10 Mar 2021 20:23:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GkOc3o9z7oi6
        TLHkxjxfcX1K3po=; b=YiW1o1/iacuo1RzG86+aeSNqYZCapFVaNJR0rwcOJgH9
        bMnLQE3ONxXf+hpYRQwkmeHrTG4nzqTMxOHDy0EPW25tbYlTlGuWiKBL5Ew8zdP6
        BozoQgDiKEHrzu5Zuo5QFULWTvJvvhjbXWcmDNPW1rFiQOq5Lv3EfW9EfdPYzBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TTRiXd
        +qWNnbjOAzB/UjzbET4EvkT0TkINV3jfuRGJ1wkvM6F1Gum7/+jd+F86UtVblisq
        r3ttVzYkA3vcepRQj1IJg7SXTuKj+Xu1lkcTdohOtlICSN2QtJ9DAunwlfPQsP5E
        3WuxGBYzwsIZfBYQPP8Qqe+LtwBDagV8/Wc5Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0119811B7AC;
        Wed, 10 Mar 2021 20:23:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3FEEF11B7AA;
        Wed, 10 Mar 2021 20:23:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/4] tests: get rid of $_x05 from the test suite
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
        <20210311001447.28254-5-avarab@gmail.com>
Date:   Wed, 10 Mar 2021 17:23:33 -0800
In-Reply-To: <20210311001447.28254-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 Mar 2021 01:14:47 +0100")
Message-ID: <xmqq8s6uh4a2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 664F960A-8208-11EB-88E5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the last users of the $_x05 variable from the tests. It turns
> out that all of these tests can be rewritten unambiguously to simply
> use [0-9a-f]* instead.

I am unsure about the "unambiguously" part, e.g.

> -	sed -e "s/ $_x05[0-9a-f]*	/ X	/" <current >check &&
> +	sed -e "s/ [0-9a-f]*	/ X	/" <current >check &&

does't the preimage say "we expect at least 5 hexdigits to be shown
here"?  The postimage lets even an empty string to pass.=20

> In the case of the tree matching we're relying on there being a <TAB>
> after the SHA (but a space between the modes and type), then in some
> of the other tests here that an abbreviated SHA is at the start of the
> line, etc.

Sure, but these being tests, I am not sure we should be assuming the
correct input to these transformations.

>  test_expect_success 'ls-tree --abbrev=3D5' '
>  	git ls-tree --abbrev=3D5 $tree >current &&
> -	sed -e "s/ $_x05[0-9a-f]*	/ X	/" <current >check &&
> +	sed -e "s/ [0-9a-f]*	/ X	/" <current >check &&
>  	cat >expected <<\EOF &&
>  100644 blob X	1.txt
>  100644 blob X	2.txt

This one is particularly iffy.  The --abbrev=3D5 test is designed to
ensure that the resulting abbreviated object names are at least 5
hexdigits long, even when the repository is so small that only 4
hexdigits are sufficient to avoid ambiguity, while allowing the
output to be longer than specified 5 (when 5 turns out to be
insufficient for disambiguation).

So, I dunno.

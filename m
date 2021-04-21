Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26D2C43460
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7B26144C
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhDUQcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:32:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54336 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbhDUQct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 12:32:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03D2613381F;
        Wed, 21 Apr 2021 12:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ci07BD7L1Rfr
        8iDG2/CZ5dr0pxY=; b=W7ePAkEgHWWkmvddM7ByIYE5V4lgl5qcX/QnmloEmOcR
        R0u4E1yAlDqFdFSTZgPDTaD8sSbRX18m5eoJ8Ovf0KPQmDLUiGHsCCOAF3S7PXY3
        jPiXRbXh6h6DHZwNV4BYNnbQoi6HIjIQZdTolnzAzfsWZqGxe1o+WZcwewm9J8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PW9lRR
        5/gNMXV/tT0oqMxJCp+7Yc3EJe65f+QoWXYmExQY//Kyr3a7l6Lk9M3MQ0UsFjwu
        YlZZsukPgXVo1M+A4ipbA2Vu7W5nrh6yZXWdCbTtYO2EJX5iYMn7oSXO235e2rLK
        u/gBx/G2y6NprpCxZRCyXcdoikOKncQIVwuys=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFA0813381E;
        Wed, 21 Apr 2021 12:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3BAD113381A;
        Wed, 21 Apr 2021 12:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/12] check-non-portable-shell: check for "test
 <cond> -a/-o <cond>"
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
        <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
        <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
        <xmqqwnsw3872.fsf@gitster.g> <87r1j42ffz.fsf@evledraar.gmail.com>
        <YIAAzJTG1UitiWyu@danh.dev> <87czun3en0.fsf@evledraar.gmail.com>
Date:   Wed, 21 Apr 2021 09:32:11 -0700
In-Reply-To: <87czun3en0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 21 Apr 2021 16:18:11 +0200")
Message-ID: <xmqqmttrzjhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 207F6C90-A2BF-11EB-9F9A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> 	t6402-merge-rename.sh:865: error: "test A || test B" preferred to "t=
est A -o B": test 0 -eq $(git ls-files -o | wc -l) &&
>>
>> With: 7dbe8c8003, (check-non-portable-shell.pl: `wc -l` may have
> ...
> I think those patches are good in their own right, i.e. replacing thing=
s
> with more incremental helpers and test_cmp-like functions.
>
> But I believe the code you're changing is not non-portable. It was usin=
g
> the output of "wc -l" with the "=3D" operator that wasn't portable.

Not necessarily.  The last one shown above

	test 0 -eq $(git ls-files -o | wc -l) &&

is still valid and correct with s/-eq/=3D/.  It lets shell to remove
excess whitespaces around output from some implementations of "wc",
so textual '=3D' is perfectly fine.

> These ones are all occurances that use "-eq".
>
> And:
>
>     test "0" -eq " 0"
>
> etc., is true, which is why these pass on OSX and beyond.

Perhaps, but I am not sure how portable it is to rely on "-eq"
ignoring the leading whitespaces.

A more conventional (read: time tested) way is to $(... | wc -l)
*NOT* enclosed inside dq, so that the shell will strip out any
excess spaces around it, and use '=3D', i.e.

    test 3 =3D $(... | wc -l)

and that is what we end up evaluating when we write

    test_line_count =3D 3 file

This does rely on that "wc -l" will run and produce _some_ output to
be syntactically correct, though.

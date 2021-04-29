Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523BDC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FFC61446
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhD2D76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 23:59:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60624 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbhD2D76 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 23:59:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03060D098B;
        Wed, 28 Apr 2021 23:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4cEdDw7n3eU7
        naAIbDKyv7K+PpGXgaumctcbyCUCHbI=; b=wTd2CTzi9u6/CkM5AYBOHp/rU4XG
        on8MzfVZ6UgmVeU8QyDpGJgC2jSk2hJLZD4L/yOqHtXzPQ2DkEk0MNFSsnRSvYNa
        ecSozQ78Da7pPq/+wIpMDqTA19kCViYMONEDscG5MIhvJlmh83mj3+GA4ujy8GDS
        0FzphfhDTgkIZ8Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAD60D098A;
        Wed, 28 Apr 2021 23:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DA11D0989;
        Wed, 28 Apr 2021 23:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 2/4] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
        <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
        <patch-2.4-3a570321770-20210423T072824Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 12:59:10 +0900
In-Reply-To: <patch-2.4-3a570321770-20210423T072824Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 23 Apr
 2021 09:29:44 +0200")
Message-ID: <xmqqmtth91wx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 415AE7C4-A89F-11EB-B703-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The goal here is to get rid of the verbosity of having e.g. a "test 2
> -ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
> to intentionally feed the "test" operator too many arguments if the
> functions are called with too many arguments, thus piggy-backing on it
> to check the number of arguments we get.
>
> Before this for each test_cmp invocation we'd emit:
>
>     + test_cmp expect actual
>     + test 2 -ne 2
>     + eval diff -u "$@"
>     + diff -u expect actual

Quite honestly, I do not see what's bad about that and am not all
that sympathetic to the cause behind this series.

The developer is asking to debug the test script by passing '-x',
and see where the test script is broken.  Especially since ...

> Now we'll get just:
>
>     + test_cmp expect actual
>     + eval diff -u "$@"
>     + diff -u expect actual

... we are not removing the 'eval diff -u "$@"' line, I do not think
how a few extra trace output lines coming from sanity check hurts
all that much.  It is worth paying for to have such basic sanity
checks expressed in a more natural way (than "oh, this hack would
not work when 'one -a two' is used as a path"), I would think.

Thanks.

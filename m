Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FC1C433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5416F22209
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAPVvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 16:51:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63524 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbhAPVve (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 16:51:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFD5410D99B;
        Sat, 16 Jan 2021 16:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5Lxn0j2LuzRU
        WvrVABYuBHy8SAI=; b=qxOGbMrToILCxRAh0HkYo2WOHLZs/Xsrc0NqjjIiNN4k
        08rh8FgFnlbCVtY+Il+7x4WfHz8XHytlhqlBIgOSps7hjjF1BYpMzvkoN2c/qS1r
        xpmqkUHvqXzc2WrTYHnvA4EXNuk1SQRsK26ynxi4DsQ9mjUwBZWyIXgpt/4+3gs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CvVT05
        JJt8+3FHT0tbaXzWhX7ywnjZxkF1LvCzJvxwfxfKV5R2gGoBbm0iidzXXvEN2FTO
        Ihven0zKdQOaE5QntLrlghs5dtVGa0afnDU9gjjyoUA7Uxknh3gqPIAi8rORo8gQ
        ORjsikDZQoi/so0z3Z9z3q/HkD7MtEkmpv+84=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8B6010D99A;
        Sat, 16 Jan 2021 16:50:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40DE310D999;
        Sat, 16 Jan 2021 16:50:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/11] tests: add a bash "set -o pipefail" test mode
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-1-avarab@gmail.com>
Date:   Sat, 16 Jan 2021 13:50:47 -0800
In-Reply-To: <20210116153554.12604-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 16 Jan 2021 16:35:43 +0100")
Message-ID: <xmqqturgo8js.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E54A1C48-5844-11EB-BF45-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> An unstated aim of v1 of this series was to fix up the tests on
> vanilla bash's "set -o pipefail" enough that the test suite would have
> some failures, but wouldn't look like a complete dumpster fire.
>
> But this was confusing and relied on a side-quest to change the
> test_{must,might}_fail helpers. See
> https://lore.kernel.org/git/YAFntgQE3NZ3yQx5@coredump.intra.peff.net/
>
> I've now ejected all of that, in favor of just fixing some of the
> tests instead as Jeff suggested. Jeff, I added your Signed-off-by to
> 06/11 which you're mostly the author of. Please Ack that you're OK
> with that (the original diff-for-discussin didn't have a SOB).

I didn't read the last two pieces that are bash specific, but
everything else was a pleasant read.  I did have a few comments,
though.

Thanks.

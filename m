Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B7FC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DF1601FA
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 16:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhJLQrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:47:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59654 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhJLQrY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 12:47:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D60ED14A11B;
        Tue, 12 Oct 2021 12:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=23idlU7JOYEV
        SKHa5mG8vwUP1bkcbYZ7sy3S8MRUMnE=; b=A6OMdR/H+pv0UC4TM/d2lbM5tWqJ
        nfr/UV6e9WHxS4qLyajY/ORa4lQDMsAlCeHbJ4g+gRCVO8ipokSskETW6jvBK+8P
        d3IXE24aoUGlskEMxE9um1cFJ2K2ojVIXi8bg2U520TrNIyP6iJJZTzmoO8Vm0q5
        PbGqFdMPhNa5GNg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA7B814A11A;
        Tue, 12 Oct 2021 12:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F15714A119;
        Tue, 12 Oct 2021 12:45:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: test-lib.sh musings: test_expect_failure considered harmful
References: <87tuhmk19c.fsf@evledraar.gmail.com>
Date:   Tue, 12 Oct 2021 09:45:19 -0700
In-Reply-To: <87tuhmk19c.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 12 Oct 2021 11:23:40 +0200")
Message-ID: <xmqq4k9m6vkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C978B10E-2B7B-11EC-95CF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Oct 11 2021, Junio C Hamano wrote:
>
> [Removed "In-reply-to: <xmqq5yu3b80j.fsf@gitster.g>" with the Subject
> change]

Please do not do the former, although it is welcome to change Subject.

> Presumably with test_expect_failure.
>
> I'll change it, in this case we'd end up with a test_expect_success at
> the end, so it doesn't matter much & I don't care.

I do agree with you that compared to expect_success, which requires
_all_ steps to succeed, so an failure in any of its steps is
immediately noticeable, it is harder to write and keep
expect_failure useful, because it is not like we are happy to see
any failure in any step.  We do not expect a failure in many
preparation and conclusion steps in the &&-chain in expect_failure
block, and we consider it is an error if these steps fail.  We only
want to mark only a single step to exhibit an expected but undesirable
behaviour.

But even with the shortcomings of expect_failure, it still is much
better than claiming that we expect a bogus outcome.

Improving the shortcomings of expect_failure would be a much better
use of our time than advocating an abuse of expect_sucess, I would
think.

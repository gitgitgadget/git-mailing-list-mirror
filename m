Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47E0C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CFE611C0
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhKDAA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:00:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50742 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKDAAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:00:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33594168359;
        Wed,  3 Nov 2021 19:57:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=teIAV58feZYbvMy1x6Xmojw2w
        LrauUfSVE1g0DJTjXs=; b=ucggGgu1oBcBPo7kAZYjqSRFZ+QgmrPhEpvUKnyJi
        8FP5O8OHjKp9YxFZF+uNSrzevVfQIfxtQqknVNpNrmoqhRydq8MrHJYNphHwvWch
        ONxfwNVrazVAvkf1p9A9e+H2+aEFG/gemi6i10z3yRkDca8/7X7krbRfxFRCm1Hh
        us=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B688168358;
        Wed,  3 Nov 2021 19:57:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CC38168357;
        Wed,  3 Nov 2021 19:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: Re* [PATCH v8 2/2] tests: add a test mode for SANITIZE=leak,
 run it in CI
References: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
        <cover-v8-0.2-00000000000-20210923T091819Z-avarab@gmail.com>
        <patch-v8-2.2-90ecd49c910-20210923T091819Z-avarab@gmail.com>
        <xmqq4k8s6eri.fsf_-_@gitster.g>
Date:   Wed, 03 Nov 2021 16:57:41 -0700
Message-ID: <xmqqee7w4wsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5BFD5EA-3D01-11EC-919A-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue test
>> mode. When running in that mode, we'll assert that we were compiled
>> with SANITIZE=3Dleak. We'll then skip all tests, except those that we'=
ve
>> opted-in by setting "TEST_PASSES_SANITIZE_LEAK=3Dtrue".
>> ...
>> This is how tests that don't set "TEST_PASSES_SANITIZE_LEAK=3Dtrue" wi=
ll
>> be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue:
>
> I've been playing with this locally, but cannot shake the nagging
> feeling that GIT_TEST_PASSING_SANITIZE_LEAK must default to true.
> Otherwise, it is one more thing they need to find out and set when
> they do
>
>     make SANITYZE=3Dleak test
>
> because they want to be a good developer and to ensure that they did
> not introduce new leaks.
>
> If we want to encourage folks to locally run the leak checks before
> declaring their own work "done", that is.
>
> Those who are hunting for and cleaning up existing leaks can and
> should set it to false, no?

Another thing while I am at it, I have a feeling that the polarity
of the TEST_PASSES_SANITIZE_LEAK declaration is the other way
around.

Marking the tests that do not yet pass the leak check with a special
annotation will make it easier to find not-yet-clean tests for those
who have too much time on their hands ;-) to find ones that are
affected by the leaky tests.

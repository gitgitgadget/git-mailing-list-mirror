Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F45CC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 03:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DF06109E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 03:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFUDqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 23:46:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51514 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhFUDqT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 23:46:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E59F14C11D;
        Sun, 20 Jun 2021 23:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=o0fGq0Gza9DUFHp+5pMr2/jjB
        qcXJoWEf5/G8QYwOXQ=; b=DZs2yS+f3S3VVbEVKmHsx1ErnneuxUtgNf4NVqW+S
        v1pXlynxgZSBz6k/73iH6dcVLCc6KjEBC7EVrGR01mAtXLBxG+S0KjQrw5lXpS+O
        J+2asaMNGgYe/e5Qdu40jt7ly+mhbGo5Lg0btPFDk/NUU1N0NLb32tXiGajmkjlY
        vM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 470A414C11C;
        Sun, 20 Jun 2021 23:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E85B14C11B;
        Sun, 20 Jun 2021 23:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
        <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
        <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
        <YMfLO9CT+iIDR3OA@google.com> <87lf7bzbrk.fsf@evledraar.gmail.com>
        <YM0alLP5U81D+ZI0@google.com> <87im2848pn.fsf@evledraar.gmail.com>
Date:   Mon, 21 Jun 2021 12:44:02 +0900
Message-ID: <xmqqk0mnj30d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC1E7212-D242-11EB-A67A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think since Junio picked up the "base" version of this and it looks
> like we're going that way first that's not something we need to discuss
> now if you'd like to punt it, but I'd really like to get that cleared u=
p
> post-base topic.

I queued this 'base' thing only because (1) Emily promised to review
it and I wanted to give her a version of "seen" she can try to build
on the part beyond "refactoring", (2) I wanted to see how the 'base'
looks myself and (3) I wanted to see what possible interactions with
other topics in flight I should anticipate, if we were to decide to
go that route.  Please do not read more than that into what is and
what is not in 'seen'.


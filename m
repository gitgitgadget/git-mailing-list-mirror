Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F4C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF5E60F5B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhH3Tw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:52:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63452 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhH3Tw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 15:52:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84B2F14E8FA;
        Mon, 30 Aug 2021 15:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/WETRBzE+9OzrY5oRZrBIj1F7th8odOM+i064D
        zJH0w=; b=R1B7PsP/YKMlztSQL/rLkZ/FACuSbdeNtPYSJqxon7v7DZuS6ipswq
        htR8enLcKyEYpQEoyiFyYsPiQWMm6FsoVDkQ6gKFDFepDtFAVoip4E8DAbjqiv/V
        rcVylJiCMGrVIxv8oCkKTwC3tkCDyEZnv+qC+E9zdkMevGQ3Wluy8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D7C814E8F9;
        Mon, 30 Aug 2021 15:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BEF1D14E8F4;
        Mon, 30 Aug 2021 15:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
        <xmqq8s0rpwiw.fsf@gitster.g> <20210824185942.GE2257957@szeder.dev>
        <YSWeeEgzCCT/3kxR@coredump.intra.peff.net>
        <xmqqsfyxjyfe.fsf@gitster.g> <20210828094726.GG2257957@szeder.dev>
        <xmqqilzm6g10.fsf@gitster.g>
        <YS0qbgQhRP6XI7aj@coredump.intra.peff.net>
Date:   Mon, 30 Aug 2021 12:51:58 -0700
In-Reply-To: <YS0qbgQhRP6XI7aj@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 30 Aug 2021 14:58:54 -0400")
Message-ID: <xmqqwno23e3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD248A62-09CB-11EC-B5DE-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just throwing "set -u" at the top of test-lib.sh shows many issues:
>
>   - we don't initialize some known variables, like say, verbose_only. It
>     might be reasonable to have a big list of:
>
>       verbose_only=
>       verbose=
>
>     etc. That would probably be an improvement, though a slight
>     maintenance burden.
>
>       : ${GIT_TEST_CMP:=}
>
>     near the top of the script to pre-declare all such variables.

These two are sensible clean-up, I would think, whether we aim to
achieve "set -u" cleanness.  The original issue triggered this
thread was about $D that can be confused by a leaked environment
variable, but these "known variables" that are not assigned to in
the early part of the tests are inviting similar troubles.

Thanks.

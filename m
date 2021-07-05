Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F405DC07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D080A61474
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhGEOME (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 10:12:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56759 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGEOMD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 10:12:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C362013C5F3;
        Mon,  5 Jul 2021 10:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=604QYxp0+nlqkJmkRXtwN1fBm
        Beq/3iqHHD3LRWzk2I=; b=aWg6JSbRJTDoTwTFoYm+bJ6OVqFZkdjX5Z9kwaGtq
        99MQW8yGv4K3a8LM3HanQolOUKRe5cWDYHAFa+K9wsFo5qUm0Utsu+fG72TXFETN
        99VLgDN2pedcI1AucmUJvIMnmmAtXRYKoAYP4ap3ZoiciMl8Uy1Lyq4dTXgQeGQG
        4g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB5BA13C5F2;
        Mon,  5 Jul 2021 10:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38E7B13C5F1;
        Mon,  5 Jul 2021 10:09:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
        <20210620200303.2328957-5-szeder.dev@gmail.com>
        <87a6nk41wy.fsf@evledraar.gmail.com>
        <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
        <87h7hr2cx0.fsf@evledraar.gmail.com>
        <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
        <87a6ncy9aq.fsf@evledraar.gmail.com>
        <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
        <874kdkxot4.fsf@evledraar.gmail.com>
        <ca3eba46-7c83-51fd-2d65-c55309ac7182@web.de>
Date:   Mon, 05 Jul 2021 07:09:22 -0700
Message-ID: <xmqqtul8n97x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 99F33DFC-DD9A-11EB-91E5-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> ...  A more
> fine-grained report of the preparation steps would help, but seeing
> "stalled" would just scare me.

True.

> The convenience of having one less display_progress() call is only a
> slight advantage.

True, too.

> "2/3 (33%)" means something else to me than to you by default.  So a
> solution could be to state the model explicitly.  I.e. "2/3 (66%) done"
> or "working on 2/3 (66%)", but the percentage doesn't quite fit in the
> latter case.  Thoughts?


I still see "2/3 done" is how we should look at it, but either way,
that's a good way to view at the problem.

Thanks.


[Unrelated Tangent]

> ...  Recently I learned that in Arabic a person's age is given
> using the count-iterations model.  I.e. on the day of your birth
> your age is one.

East Asign age reckoning is shared among EA countries and works the
same way, not just Arabic.

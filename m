Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B965C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F9261356
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFPDab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 23:30:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53194 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 23:30:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EFC514436A;
        Tue, 15 Jun 2021 23:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N/J31nWT2rUi
        lRHD98aJRepDZ9Y+qbgPdQpvCc4mM5M=; b=YvSb3pVpp+lyuPjjrS4uCwL1WPP4
        cJ5f72NQSIlU0MUxe61L1ai/W6LGrIQf2XA9+05IXT8O9m8IdiMPNxHpR8/gqrFS
        wEvzc6v71pLcrGgeCHuu2Xn1jXYwb3i1lN+3zAtbxU2ioJJTXOHc9rwC3j5DazeR
        WXaM910pGYsYYkc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 478B6144368;
        Tue, 15 Jun 2021 23:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9815144367;
        Tue, 15 Jun 2021 23:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] range expressions in GIT_SKIP_TESTS are broken in master
 (was [BUG] question mark in GIT_SKIP_TESTS is broken in master)
References: <1d003cac-83fa-0b63-f60e-55513ac45cf9@gmail.com>
        <6980e906-8076-1436-ecdb-6775eff55d39@gmail.com>
Date:   Wed, 16 Jun 2021 12:28:21 +0900
In-Reply-To: <6980e906-8076-1436-ecdb-6775eff55d39@gmail.com> (Andrei Rybak's
        message of "Wed, 16 Jun 2021 01:28:33 +0200")
Message-ID: <xmqqa6nqsd2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E74700C2-CE52-11EB-81A9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> I sent this originally with incorrect subject. Question marks, e.g.
>
>     $ GIT_SKIP_TESTS=3D't000?' make
>
> work.  It is the range expressions, like [0-9] that are broken:
>
>     $ GIT_SKIP_TESTS=3D't[0-9]000' make

This reproduces for me, and

      $ GIT_SKIP_TESTS=3Dt?000' sh t0000-basic.sh
      $ GIT_SKIP_TESTS=3Dt0?00' sh t0000-basic.sh
      $ GIT_SKIP_TESTS=3Dt00?0' sh t0000-basic.sh

tells me that "Question marks work" above is not exactly correct.
It is an exception that this

      $ GIT_SKIP_TESTS=3Dt000?' sh t0000-basic.sh

happens to skip.

Interestingly enough, edc23840b0 (test-lib: bring $remove_trash out
of retirement, 2021-05-10) cleanly reverts without being depended on
by anything else in the series.

=C3=86var?

Thanks.

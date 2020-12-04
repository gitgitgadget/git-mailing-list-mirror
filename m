Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B919C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F286E22582
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgLDTnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:43:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59780 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbgLDTnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:43:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BF1211AAA4;
        Fri,  4 Dec 2020 14:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LT4MicBD63O4
        CldBr+YMBx9YE3U=; b=uBiLsSEWhTB3R5EnOI5ayHEu9JKdgLKyt5DO12v3S/sF
        J2P+2DA9BvijfhQFtb0hVLztyIn7uk9VxrGMoUecENVIgzA9qyC+ai7S4cvBEeZS
        ZcAjmJ/rWdSjV7C2HcpjoV7YuSp2otCTjrMjTA/m2Rs3ZTLOEHbEBku987543wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uHob6M
        QUmXiPJL2TCP0Aur22j8sqqr75dQNg3S4fMtwhfbkFRpMv4zoxlEtkjc9G57zTHz
        Y/3k2q3ikdoTtixeLfio3KoYv/JJVVuvJGR/phmivNhfOb6Ydv5Pn0CUQnYCQvXF
        ERj6eqNz/2yTvgylmxgc/eP71j0rf0tz+xSK0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 548F111AAA3;
        Fri,  4 Dec 2020 14:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A1FD511AAA2;
        Fri,  4 Dec 2020 14:42:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/15] Refactor chunk-format into an API
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
        <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de>
Date:   Fri, 04 Dec 2020 11:42:25 -0800
In-Reply-To: <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 4 Dec 2020 13:48:31 +0100")
Message-ID: <xmqq7dpxfjdq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D66B62DE-3668-11EB-B874-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>  Documentation/technical/chunk-format.txt      |  54 ++
>>  .../technical/commit-graph-format.txt         |   3 +
>>  Documentation/technical/pack-format.txt       |   3 +
>>  Makefile                                      |   1 +
>>  chunk-format.c                                | 105 ++++
>>  chunk-format.h                                |  69 +++
>>  commit-graph.c                                | 298 ++++++-----
>>  midx.c                                        | 466 ++++++++---------=
-
>>  t/t5318-commit-graph.sh                       |   2 +-
>>  t/t5319-multi-pack-index.sh                   |   6 +-
>>  10 files changed, 623 insertions(+), 384 deletions(-)
>
> 623-384-54-3-3-1-69-2-6 =3D 101
>
> So if we ignore changes to documentation, headers, tests and build
> script this spends ca. 100 more lines of code than the current version.
> That's roughly the size of the new file chunk-format.c -- from this
> bird's-eye-view the new API seems to be pure overhead.
>
> In the new code I see several magic numbers, use of void pointers and
> casting as well as repetition -- is this really going in the right
> direction?  I get the feeling that YAGNI.

Hmph, two existing users consolidated into one and still not losing
lines is not a very convincing sign.  Perhaps a third existing user
would purely lose lines when converted to use this (do we have a
third or fourth one?)  I dunno.


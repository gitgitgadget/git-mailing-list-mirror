Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50FC433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D9F61936
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhC0Rnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 13:43:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63878 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhC0RnY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 13:43:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9984CA5CE2;
        Sat, 27 Mar 2021 13:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=t/XeeErNB0lXSKtGah91kb2O1
        aQ=; b=IOeCUCrKqar5yhgWuMpbLJ6gq5is2rt4b+/jzie9662YW9Zl2dH2NY49N
        tBug8rNfoQ+Ao7yDK/T0VdgWwo8GH+TO1pJW8T0ok7DStk4W7Fq8dc4B2coqjFPW
        R9uk7HhSCoCpJ/JMoDW1eBzmgP+gjU0PEkHQdAtBtyR4Thys1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=hoIvCsfswiUrew4+10l
        R/SO5aslNxbplysCzDgzVumHKq5X4g07GUMpYFHFSRh8ogwWzW9r043AEx9FKry1
        bRDqB83S072+twFuptlMFXAee2JuuNKe/8cXFsfzzFu/ljTQbpZZSv++C7UGL6cu
        pjuTO8B8aY3WCxNrAP5COyAI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91DE4A5CE1;
        Sat, 27 Mar 2021 13:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A60CA5CE0;
        Sat, 27 Mar 2021 13:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 0/4] Makefile/coccicheck: fix bugs and speed it up
References: <20210306192525.15197-1-avarab@gmail.com>
        <cover.1616414951.git.avarab@gmail.com>
Date:   Sat, 27 Mar 2021 10:43:22 -0700
Message-ID: <xmqqpmzkqypx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED3617DE-8F23-11EB-9AF5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A v4 (I'm counting the 5/4 patch I sent to v2 as a v3) which produces
> the exact same end result as that v2 + 5/4 patch, but with a rewritten
> commit message/squash as requested by Junio.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>   Makefile/coccicheck: add comment heading for all SPATCH flags
>   Makefile/coccicheck: speed up and fix bug with duplicate hunks
>   Makefile/coccicheck: allow for setting xargs concurrency
>   Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>
>  Makefile | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

It seems that after some back and forth, nobody is talking about
this series anymore since Wednesday 24th.

Am I correct to assume that we are now all waiting for a cleaned-up
new iteration to get us closer to the finalized version?

Thanks.

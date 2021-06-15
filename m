Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF5FC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 04:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC8E611CE
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 04:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFOEFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 00:05:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65429 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhFOEFs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 00:05:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A5CB312588C;
        Tue, 15 Jun 2021 00:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d/eunVZpcVtl6E+vDXtjS9kE9fj22uddthFS7u
        P+7ws=; b=KK9IJa42vthSUf5ZEz3vo6BATypWoKAGKddOSfiTL+38HACozX39qc
        HlCNEMIHOJc9nLCVBm8zLkJAukpGsWy4BBBECmxrxjtj1Q+LLR1oRK1NRyTiYDyL
        /FxkeEPcGq6M5qInxJIR7KDzqMVxsCy2fIrY/CGwYTmoYvJjWGbmQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EDCA12588B;
        Tue, 15 Jun 2021 00:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC6A812588A;
        Tue, 15 Jun 2021 00:03:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
        <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
        <60c647c1d9b5c_41f452089@natae.notmuch>
        <60c677a2c2d24_f5651208cf@natae.notmuch> <xmqq7divzxrr.fsf@gitster.g>
        <CABPp-BFY7uU5Ugypv4xCHq+XHTc3UROWPdV1v-JbN7xBycDZTA@mail.gmail.com>
Date:   Tue, 15 Jun 2021 13:03:40 +0900
In-Reply-To: <CABPp-BFY7uU5Ugypv4xCHq+XHTc3UROWPdV1v-JbN7xBycDZTA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 14 Jun 2021 20:43:54 -0700")
Message-ID: <xmqqr1h3wz8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC0315C4-CD8E-11EB-AB03-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This is going to sound harsh, but people shouldn't waste (any more)
> time reviewing the patches in this thread or the "merge: cleanups and
> fix" series submitted elsewhere.  They should all just be rejected.
>
> I do not think it is reasonable to expect reviewers to spend time
> responding to re-posted patches when:
>   * no attempt was made to make sure they were up-to-date with current
> code beyond compiling (see below)
>   * no attempt was made to address missing items pointed out in
> response to the original submission[1]
>   * no attempt was made to handle or even test particular cases
> pointed out in response to the original submission (see [1] and below)
>   * the patches were posted despite knowing they caused segfaults, and
> without even stating as much![2]
>   * the segfault "fixes" are submitted as a separate series from the
> patch introducing the segfault[3], raising the risk that one gets
> picked up without the other.

Fair enough.  Thanks.

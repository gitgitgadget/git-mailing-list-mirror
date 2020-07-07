Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B54C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0EA206BE
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sQI+QJq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgGGVgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:36:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64599 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgGGVgC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 17:36:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68D0AD5183;
        Tue,  7 Jul 2020 17:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KY1TOn+wddgG6X/koooc5njH2U0=; b=sQI+QJ
        q+rRzItRBeVJR1JR9sZ8OWoP40wi+CL/80Gwm6WFr2I1wVlHIm39Xa9C3/YFn93t
        M2I/iLRmX1YbdkqbIfmr9xKIB0Ym4GHJCN5DHtRxxc4Ry1TzR6S1TVqZY7GXwEpW
        VlvstoV2+UK0YbE/2abRuIb4e8EL490JAysoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YkwboAhbeJtCC79XLOk4K32TA+SnGCvn
        EM4REyz4Cz/Q6V/6omCd7QCfu53kUjOGzFDKRZdeU0UCeMasZ2RyFxUSyJ1DptT8
        xr/SEp+Nz3NOjaD7ur6ZMByHiT0ySLawZYFQ+HvaW6uGxoURLlWdV3H1YWX/XiZZ
        3+FR8wkCVdw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52926D5182;
        Tue,  7 Jul 2020 17:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85710D5180;
        Tue,  7 Jul 2020 17:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Make some commit hashes in tests reproducible
References: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com>
        <xmqqfta33y0m.fsf@gitster.c.googlers.com>
        <20200707205418.GB1396940@coredump.intra.peff.net>
Date:   Tue, 07 Jul 2020 14:35:57 -0700
In-Reply-To: <20200707205418.GB1396940@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 7 Jul 2020 16:54:18 -0400")
Message-ID: <xmqq1rln3t4y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9409384-C099-11EA-A3C1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That's using the same start point as test_tick, though really it could
> be anything. I've intentionally _not_ called test_tick at the beginning
> of each script, because that would throw off all of the scripts that do
> use it by one tick (whereas the first test_tick will overwrite these
> values).

Yup, I think that is a sensible approach.

> Trying to devil's advocate against this line of reasoning:
>
>   - using the current timestamp introduces more randomness into the test
>     suite, which could uncover problems. I'm somewhat skeptical, as the
>     usual outcome I see here is that we realize a test's expected output
>     is simply racy, and we remove the raciness by using test_tick

True.

>   - using the current timestamp could alert us to problems that occur
>     only as the clock ticks forward (e.g., if we had a Y2021 bug, we'd
>     notice when the clock rolled forward).

True.

>   - some tests may rely on having a "recent" timestamp in commits (e.g.,
>     when looking at relative date handling). I think all of the
>     relative-time tests already use a specific date, though, because
>     otherwise we have too many problems with raciness.

True.

Another thing we could do is under DEVELOPER=YesPlease we can set
timestamps you just added here to some random time.

The ones that do care about reproducibility guarantee by using
test_tick would not be affected, and those that were happy with the
current time should be happy with such a random timestamp.  Or we
could just drop what this patch does only under DEVELOPER=YesPlease
which amounts to be the same as setting random time.

> Note that the patch above does seem to cause two tests to fail. One of
> them I _suspect_ is a raciness problem (order of commits output changes,
> which implies the original was expecting the time to increment between
> two commits without running test_tick).

Ahh, ok, "git commit && git commit" without these environment
variable set and exported may or may not get the same timestamp from
the wallclock during the testing.  With your patch, they are
guaranteed to get the same timestamp.  On the surface, it sounds
like a valid approach to smoke out any tests that rely on the
passage of time, but realistically the machines are fast enough that
it won't be a rare occasion for these two "git commit" invocations
to be done within a single second, so I am not sure how much we
would be gaining.  We _are_ getting more reproducible test
environment, though, which may be a plus.

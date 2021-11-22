Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9C3C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 02:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhKVCUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 21:20:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53111 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVCUM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 21:20:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5CBE102C2A;
        Sun, 21 Nov 2021 21:17:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a5rt40V7tygVndBG1khCilITm53YEjZhdUnmQ6
        4FPgQ=; b=Y+1HNajmI8VczX0GCAE0i0g6zD7SWaZiDtNKLJdiH0/Cey5uOX50tg
        CgfCRv1wynX8tyjRvLiutD5vi3XGsPwtSrR94wvAtWrBGuB6gCqXxXz7PvqtqcvC
        AlmvECGEzsQzCeFOtw3QLxeDskXKhhTrG0L5NyVxhE6YJzhce9880=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC922102C29;
        Sun, 21 Nov 2021 21:17:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 154FF102C28;
        Sun, 21 Nov 2021 21:17:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests
References: <xmqq1r4b8ezp.fsf@gitster.g> <20211024170349.GA2101@szeder.dev>
        <YZqSgu4XjPWnURju@coredump.intra.peff.net>
        <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
        <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
Date:   Sun, 21 Nov 2021 18:17:04 -0800
In-Reply-To: <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 21 Nov 2021 17:54:39 -0500")
Message-ID: <xmqqa6hxlysf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49DCF2C8-4B3A-11EC-8D79-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not 100% sure this fixes any possible races, as the race Junio
> initially reported seemed to be in the "propagated signals from pager"
> test, which I don't think has these flaky-SIGPIPE problems. But I think
> it's at least correcting some of the confusion. And we can see if it
> happens again (I haven't been able to trigger any failures with --stress
> myself).

Applying this (or this and the follow-up) seems to make t7006, which
used to be flaky, to consistently fail at test "git returns SIGPIPE
on propagated signals from pager" for me ;-)

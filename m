Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8801C433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 23:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359663AbhK1Xn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 18:43:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50519 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241517AbhK1Xl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 18:41:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F573E822D;
        Sun, 28 Nov 2021 18:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QMaYqctazcnbkzuGKPrDtJdSW9aTRO8zyr6Ux4
        ty9mw=; b=DSw5/pU4uI7n1eWyw6DSH/ityJIGOfvuwxTa3eDclTkciLKiOubkYt
        vE0Rl5jhHH62xzmhrodgSk3jwznwKXxKrsa1t7UMlzkvQ5g9stI0lflXMb5SJkFN
        NrPMilLHy47qUmunFv+aY302V39Onz8ddp1VI+rGP7LkmwjR0o7Bk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66DA7E822B;
        Sun, 28 Nov 2021 18:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCEA8E8229;
        Sun, 28 Nov 2021 18:38:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
References: <20211117090410.8013-3-fs@gigacodes.de>
        <20211120150401.254408-1-fs@gigacodes.de>
        <20211120150401.254408-4-fs@gigacodes.de>
        <211122.86y25gz9q7.gmgdl@evledraar.gmail.com>
        <xmqqh7c4i0jh.fsf@gitster.g> <20211126095509.weeknmg4p6sx7bdn@fs>
        <xmqqy25a636c.fsf@gitster.g> <20211127124733.ulicqyiudur3s5h4@fs>
Date:   Sun, 28 Nov 2021 15:38:08 -0800
In-Reply-To: <20211127124733.ulicqyiudur3s5h4@fs> (Fabian Stelzer's message of
        "Sat, 27 Nov 2021 13:47:33 +0100")
Message-ID: <xmqqo8634zrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EB4CB22-50A4-11EC-9661-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>>I was expecting something along the lines of ...
>>
>># What is written by tests to their FD #1 and #2 are sent to
>># different places depending on the test mode (e.g. /dev/null in
>># non-verbose mode, piped to tee with --tee option, etc.)  Original
>># FD #1 and #2 are saved away to #5 and #7, so that test framework
>># can use them to send the output to these low FDs before the
>># mode-specific redirection.
>>
>>... but this only talks about the output side.  The final version
>>needs to mention the input side, too.
>>
>
> I like to use the term stdin/err/out since that is what i would grep for
> when trying to find out more about the test i/o behaviour.

I do not mind phrasing "original FD #1" as "original standard
output" at all.  I just wanted to make sure it is clear to readers
whose FD #1 and FD #5 we are talking about. In other words, the
readers should get a clear understanding of where they are writing
to, when the code they write in test_expect_success block outputs to
FD #1, and what the code needs to do if it wants to always show
something to the original standard output stream.

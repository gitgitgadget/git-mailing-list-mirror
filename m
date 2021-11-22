Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035BDC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 06:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhKVGIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 01:08:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51924 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKVGIM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 01:08:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8791A16C33B;
        Mon, 22 Nov 2021 01:05:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4VGYWBin0KR4KCD3TPjeFH0gNop2iscVTZ+3Bm
        O1FWo=; b=J38tf8OnabpOFmLWAwCzeYeHc1CfNLPALAs8C5K5rVdMmEjPp5SzrI
        AE1QnmjXdKY39G0DU79nt5U5DYzxC4n+vWXr5IiOqQ6gPqQx7HINAuJsA2iGT7Lu
        M8YKRhtDVHgHhG8bkZobwY5o2j7JHjTpLYoV3a6NAVURbD55Hre4M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 804E816C33A;
        Mon, 22 Nov 2021 01:05:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE2BE16C339;
        Mon, 22 Nov 2021 01:05:03 -0500 (EST)
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
        <xmqqa6hxlysf.fsf@gitster.g>
        <YZsh6mnjuKbbIrw8@coredump.intra.peff.net>
        <YZsih3ar+g1ZTZOc@coredump.intra.peff.net>
        <xmqq5yskn3ir.fsf@gitster.g>
Date:   Sun, 21 Nov 2021 22:05:02 -0800
In-Reply-To: <xmqq5yskn3ir.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        21 Nov 2021 21:49:32 -0800")
Message-ID: <xmqq1r38n2sx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2270BB82-4B5A-11EC-A326-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> That's a lot more tedious "if (!in_signal)" checks, but:
>>
>>   - we don't have to duplicate any of the actual application logic
>>
>>   - we'd now cover the extra cases for waitpid failing or returning the
>>     wrong pid (previously if waitpid() failed we'd still look at status,
>>     which could contain complete garbage!)
> ...
> Yeah, the repeated "if (!in_signal)" look a bit ugly, but fixing
> that "we only deal with ifexited in in_signal case" to do the right
> thing would make the code even more annoying and harder to maintain.

Eh, what I meant was that it would be annoying and harder to
maintain, if done inside the single "if (in_signal) { ... }" near
the beginning. (IOW, I am completely in agreement with your
reasoning above).


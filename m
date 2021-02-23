Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002B6C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B351E60235
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBWVE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:04:56 -0500
Received: from [93.83.142.38] ([93.83.142.38]:58120 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S234592AbhBWVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 16:02:55 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id B0ECF27B15;
        Tue, 23 Feb 2021 22:02:30 +0100 (CET)
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-10-avarab@gmail.com>
 <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
 <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
 <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
 <87h7mba3h3.fsf@evledraar.gmail.com> <xmqqk0r6ldrn.fsf@gitster.g>
 <877dmz7wtv.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1c5f8cb8-2d99-4279-ba61-4f7720ece277@kdbg.org>
Date:   Tue, 23 Feb 2021 22:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <877dmz7wtv.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.02.21 um 14:11 schrieb Ævar Arnfjörð Bjarmason:
> On Wed, Feb 17 2021, Junio C Hamano wrote:
>> Sounds good.  It shouldn't be too hard to satisfy both camps,
>> i.e. the quoted demonstrates one way to allow test writers to
>> give expectation in-place in the single test file, and replacing
>> how it uses "grep" to check the output with test_cmp or whatever
>> wouldn't make the resulting tests too hard to write and maintain.
> 
> It doesn't satisfy both camps, because I'd like to convert all these
> tests to test_cmp because for a subsequent refactoring of userdiff.c by
> me or others I don't know in advance what might break, so I'd like to
> assert the exact current behavior.
> 
> Whereas your patch provides a way to opt-in individual tests to a
> test_cmp-alike, but leaves the rest at grepping for the "RIGHT"
> substring. Failures in the tests who aren't opted-in will be hidden.
> 
> It also means that subsequent changes to the behavior in the form of
> submitted patches won't be as self-documenting, e.g. I've wondered if we
> could introduce a case to balance parens in this code (sometimes C
> function declarations stretch across lines), and there's e.g. the
> arbitrary limit of 80 bytes on the line (which to be fair, we don't
> curretly have tests for).
> 
> Anyway, as noted in [1] I don't see how this custom format of grepping
> stuff out of plain-text files is simpler, particularly when its behavior
> would start to rely on other things like "# HEADER |right()|" whose
> behavior is a function of what we grep/sed when/where in the logic
> driving the tests.
> 
> But if you & Johannes S. disagree with that I don't really say a way
> forward with this series. I think e.g. squashing 09/27 into the rest
> would make things simpler/less verbose, but the end-state would still be
> matching the full hunk line, and if that's not something that's wanted
> in any shape or form as a default...
> 
> 1. https://lore.kernel.org/git/87h7mba3h3.fsf@evledraar.gmail.com/

I could live with a version of Junio's suggestion that is not opt-in,
i.e., the checks are mandatory and exact. The important point is that
there is only one file per test case; that would still count as
"sufficiently simple" in my book.

-- Hannes

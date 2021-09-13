Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B5C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6959E61056
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbhIMLoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:44:07 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:38120 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234635AbhIMLoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:44:07 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mPkMM-000BsT-4J; Mon, 13 Sep 2021 12:42:50 +0100
Subject: Re: [PATCH] strvec: use size_t to store nr and alloc
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <YTzEvLHWcfuD20x4@coredump.intra.peff.net>
 <87o88z82pc.fsf@evledraar.gmail.com>
 <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <YT54mskEIir2gXc2@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c9f76d8f-7b49-d4da-eec2-320ffa523144@iee.email>
Date:   Mon, 13 Sep 2021 12:42:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YT54mskEIir2gXc2@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2021 23:00, Jeff King wrote:
> On Sat, Sep 11, 2021 at 11:48:38PM +0100, Philip Oakley wrote:
>
>> I'm particularly interested in the int -> size_t change problem as part
>> of the wider 4GB limitations for the LLP64 systems [0] such as the
>> RaspPi, git-lfs (on windows [1]), and Git-for-Windows[2]. It is a big
>> problem.
> Note that a lot of the Windows LLP64 problems are really a separate
> issue. They come from a misuse of "unsigned long" as "gee, this should
> be big enough for anything". Most of that is due to its use for object
> sizes, which of course infected a whole bunch of other code.

I don't see it (root cause) as independent though. This is a nicely
separated issue (effect), which helps.

> Which isn't to say it's not important. But my main goal here was making
> sure we use size_t for growth allocations to avoid integer overflow
> leading to under-allocation (and thus heap overflow).

It's also been helpful in highlighting some of the wider issues and
approaches.

Thank you

Philip


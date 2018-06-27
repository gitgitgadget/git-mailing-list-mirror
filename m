Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C831F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965648AbeF0SRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:17:46 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:14630 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934492AbeF0SRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:17:44 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41GB3B2bbYz5tlG;
        Wed, 27 Jun 2018 20:17:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AEEC31CBC;
        Wed, 27 Jun 2018 20:17:41 +0200 (CEST)
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase
 -i and strategy options
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Newsgroups: gmane.comp.version-control.git
References: <20180607050845.19779-1-newren@gmail.com>
 <20180627073623.31725-1-newren@gmail.com>
 <20180627073623.31725-2-newren@gmail.com>
 <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
 <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com>
 <xmqqh8logofg.fsf@gitster-ct.c.googlers.com>
 <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <eb66b6da-a306-3f65-abf3-9b845fba32cd@kdbg.org>
Date:   Wed, 27 Jun 2018 20:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.2018 um 19:27 schrieb Elijah Newren:
> On Wed, Jun 27, 2018 at 9:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Having said that, it would be simpler for at least the latter to
>> write it using a single-shot environment assignment, perhaps?  I.e.
>>
>>          PATH=./test-bin:$PATH git rebase --continue &&
>>
>> without running in a subshell?
> 
> Seems reasonable.  Since these tests were essentially copies of other
> tests within the same file, just for rebase -i instead of -m, should I
> also add another patch to the series fixing up the rebase -m testcase
> to also replace the subshell with a single-shot environment
> assignment?

Pitfalls ahead!

	PATH=... git rebase ...

is OK, but

	PATH=... test_must_fail git rebase ...

is not; the latter requires the subshell, otherwise the modified PATH 
variable survives the command because test_must_fail is a shell 
function. Yes, it's silly, but that's how it is.

-- Hannes

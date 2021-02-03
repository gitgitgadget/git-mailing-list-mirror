Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D46C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C390964F93
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBCRTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:19:55 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:11233 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhBCRTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:19:55 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4DW7hJ6jF6z5tlC;
        Wed,  3 Feb 2021 18:19:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5DBBA49F0;
        Wed,  3 Feb 2021 18:19:12 +0100 (CET)
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
 <87czxjomn8.fsf@evledraar.gmail.com>
 <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
 <87wnvrefbv.fsf@evledraar.gmail.com>
 <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
 <87tuqvdy1b.fsf@evledraar.gmail.com>
 <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
 <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
 <87r1lxeuoj.fsf@evledraar.gmail.com>
 <xmqq35ydeu94.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <160415b7-3196-7653-7417-4d5af97a2567@kdbg.org>
Date:   Wed, 3 Feb 2021 18:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq35ydeu94.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.02.21 um 03:54 schrieb Junio C Hamano:
> I guess we just want to take just a half of your [WIP/PATCH v2 5/5],
> ignoring the return values from finish_command*() and exiting with 0
> when we got SIGPIPE (that would mean that there will be no change on
> the atexit codepath).  Unlike Denton's change directly on the current
> codebase, the resulting code would clearly show that we only care about
> the signal codepath, thanks to the refactoring [PATCH v2 1/5] has
> done.

Note though, that we cannot call exit() from a signal handler: it is not
async-signal safe.

https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_04_03

-- Hannes

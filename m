Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17AA20357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbdGJVLi (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:11:38 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:16191 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbdGJVLi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:11:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3x5yZJ2n2Qz5tlC;
        Mon, 10 Jul 2017 23:11:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E148C135;
        Mon, 10 Jul 2017 23:11:35 +0200 (CEST)
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
Date:   Mon, 10 Jul 2017 23:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.07.2017 um 22:38 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> It's a pity, though, that you do not suggest something even more
>> useful, such as C++14.
> 
> I cannot tell if this part is tongue-in-cheek (especially the "++"),
> so I will ignore it to avoid wasting time.

Actually, I'm serious.

>>> Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT
>>
>>> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
>>> +#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
>>
>> While this may serve as a test balloon, changing STRBUF_INIT, or any
>> of those _INIT macros, is actually the least interesting. The
>> interesting instances are initializations for which we do *not* have a
>> macro.
> 
> I am not sure what negative impact you think the macro-ness would
> have to the validity of the result from this test balloon.  An old
> compiler that does not understand designated initializer syntax
> would fail to compile both the same way, no?
> 
> 	struct strbuf buf0 = STRBUF_INIT;
> 	struct strbuf buf1 = { .alloc = 0, .len = 0, .buf = strbuf_slopbuf };

I said it is uninteresting, not that there is a negative impact. There 
is simply nothing gained for strbuf users: They would use STRBUF_INIT 
before and after the change and would not benefit from designated 
initializers.

This change may serve well as a test balloon, but not as an example of 
the sort of changes that we would want to see later (of the kind "change 
FOO_INIT macro to use designated initializers"; they are just code churn).

-- Hannes

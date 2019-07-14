Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB41E1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 08:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfGNIa3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 04:30:29 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:19571 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfGNIa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 04:30:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45mfxH5d83z5tl9;
        Sun, 14 Jul 2019 10:30:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5BFB71D1E;
        Sun, 14 Jul 2019 10:30:27 +0200 (CEST)
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
 <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
 <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
 <20190714005129.GA4525@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
Date:   Sun, 14 Jul 2019 10:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714005129.GA4525@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.07.19 um 02:51 schrieb Jeff King:
> I wonder if we could come up with a definition of INIT_ZERO such that:
> 
>   struct foo bar = { INIT_ZERO };
> 
> worked everywhere. IMHO that is more readable than "{}" anyway.

Not when = {} becomes a well-established way to express
zero-initialization. At that point, your suggested macro would obfuscate
the construct.

> But it does seem a real shame there is no way to say "zero-initialize
> this struct" in C without providing at least a single member value.

Indeed. For this reason, I'm arguing for the second-best form that
places a 0 between the braces.

> Ordering struct definitions to put an arithmetic type at the start is an
> OK workaround (to just let "0" work everywhere).
Why would you re-order members? There's nothing wrong when a pointer is
initialized by 0.

> But it does fall down
> when the first element _has_ to be a struct (like, say, any user of our
> hashmap.[ch] interface).

No, it does not. It is not necessary to spell out nested structs in the
initializer.

-- Hannes

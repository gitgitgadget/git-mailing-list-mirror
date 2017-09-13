Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDF020286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdIMWn4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:43:56 -0400
Received: from avasout07.plus.net ([84.93.230.235]:32788 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdIMWn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:43:56 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 9Ajt1w0050M91Ur01AjuUu; Wed, 13 Sep 2017 23:43:54 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=6eRnYTneNukW-bxTUPcA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
To:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
 <20170913182431.GE27425@aiede.mtv.corp.google.com>
 <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ef20628e-b7c0-8909-31a0-cc126d0c40ba@ramsayjones.plus.com>
Date:   Wed, 13 Sep 2017 23:43:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/09/17 19:58, Jeff King wrote:
> On Wed, Sep 13, 2017 at 11:24:31AM -0700, Jonathan Nieder wrote:
> 
>> For what it's worth,
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks, and thank you for questioning the ptrdiff_t bits that didn't
> make sense. I _thought_ they felt like nonsense, but couldn't quite
> puzzle it out.
> 
>> Compilers' signed/unsigned comparison warning can be noisy, but I'm
>> starting to feel it's worth the suppression noise to turn it on when
>> DEVELOPER=1 anyway.  What do you think?  Is there a way to turn it on
>> selectively for certain functions on the LHS (like read() and write()
>> style functions)?
> 
> Obviously we couldn't turn them on for -Werror at this point. Let me see
> how bad "-Wsign-compare -Wno-error=sign-compare" is.
> 
>   $ make 2>&1 | grep -c warning:
>   1391
> 
> Ouch. I'm afraid that's probably not going to be very helpful. Even if I
> were introducing a new problem, I'm not likely to see it amidst the mass
> of existing complaints.

Hmm, about three or four years ago, I spent two or three evenings
getting git to compile -Wextra clean. I remember the signed/unsigned
issue was the cause of a large portion of the warnings issued by
the compiler. I was surprised that it took such a relatively short
time to do. However, it affected quite a large portion of the code, so
I didn't think Junio would even consider applying it. Also, I only used
gcc and was anticipating having additional warnings on clang (but I
didn't get around to trying).

Maybe I should give it another go. :-D

ATB,
Ramsay Jones


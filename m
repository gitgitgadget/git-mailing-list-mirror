Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714F01FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 21:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbcFXVcs (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 17:32:48 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:47009 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbcFXVcq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 17:32:46 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rbs4X1qq5z5tlL;
	Fri, 24 Jun 2016 23:32:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A424629B1;
	Fri, 24 Jun 2016 23:32:43 +0200 (CEST)
Subject: Re: [PATCH 1/4] tests: factor portable signal check out of t0005
To:	Jeff King <peff@peff.net>
References: <20160624193924.GA6282@sigill.intra.peff.net>
 <20160624194357.GA6441@sigill.intra.peff.net> <576D9D90.3070605@kdbg.org>
 <20160624210541.GC6282@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <576DA6FB.1050108@kdbg.org>
Date:	Fri, 24 Jun 2016 23:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160624210541.GC6282@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 24.06.2016 um 23:05 schrieb Jeff King:
> On Fri, Jun 24, 2016 at 10:52:32PM +0200, Johannes Sixt wrote:
>> The Windows behavior is most closely described as having signal(SIGPIPE,
>> SIG_IGN) at the very beginning of the program.
>
> Right, but then we would get EPIPE. So what does git do in such cases?
> I'd expect it generally to either hit the check_pipe() part of
> write_or_die(), or to end up complaining via die() that the write didn't
> go as expected.

Ah, I have forgotten about this code path. Looks like it will trigger 
exactly the same raise() as test_sigchain. Then the check for exit code 
3 makes a bit more sense. But I'm sure we have code paths that do not go 
through checK_pipe(). Those would proceed through whatever error 
handling we have and most likely die().

>> IMO there is too much danger to trigger a false positive if exit code 3 is
>> treated special in this generality.
>
> Yeah, I agree. But what _should_ it do? E.g., what happens to git-daemon
> when it is killed via TERM?

Frankly, I don't know how bash's 'kill -TERM' and a Windows program 
interact. I've avoided this topic like the plague so far.

-- Hannes


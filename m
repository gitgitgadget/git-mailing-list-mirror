Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A101FAA8
	for <e@80x24.org>; Tue, 16 May 2017 12:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbdEPM3J (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 08:29:09 -0400
Received: from avasout08.plus.net ([212.159.14.20]:47233 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbdEPM2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 08:28:08 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id M0Tv1v0031keHif010TwV0; Tue, 16 May 2017 13:27:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=yMsKtGV55RrB6pmmZJgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] usage: fix a sparse 'redeclared with different type'
 error
To:     Jeff King <peff@peff.net>
References: <52ef158a-0719-c71a-b72b-4961cf8f96d5@ramsayjones.plus.com>
 <20170516030200.fivl7p5iukfxk2jb@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <22dd8932-3086-f50d-3620-7ab336270b84@ramsayjones.plus.com>
Date:   Tue, 16 May 2017 13:27:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170516030200.fivl7p5iukfxk2jb@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/05/17 04:02, Jeff King wrote:
> On Tue, May 16, 2017 at 02:11:40AM +0100, Ramsay Jones wrote:
> 
>>
>> If you need to re-roll your 'jk/bug-to-abort' branch, could you please
>> squash this into the relevant patch (commit d8193743e0 "usage.c: add
>> BUG() function", 12-05-2017).
>>
>> [Just FYI, sparse complains thus:
>>   usage.c:212:6: error: symbol 'BUG_fl' redeclared with different type
>>   (originally declared at git-compat-util.h:1076) - different modifiers
>> ]
> 
> Hmm. Our model here is the die() function, which gets noreturn and
> format attributes in the declaration, but only noreturn at the
> definition.

Yes, in this case, it's only noreturn that matters (sparse only
cares about a subset of attributes).

> Your patch here adds both attributes to the definition:
> 
>> +__attribute__((format (printf, 3, 4))) NORETURN
>>  void BUG_fl(const char *file, int line, const char *fmt, ...)

Yes, my initial patch only added the NORETURN, but I decided it
didn't hurt to make the header and c-file 'match' in this case. ;-)

> There probably isn't a downside to repeating the format attribute, I
> guess. Except that I'm not sure what happens if the two ever got out of
> sync (gcc doesn't seem to complain, though in practice you'd probably
> change the order or number of arguments at the same time, which is
> likely to cause a mismatch).

If you prefer, you can simply add the NORETURN, since that eliminates
the error message just as well.

ATB,
Ramsay Jones



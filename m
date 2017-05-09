Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39F62018D
	for <e@80x24.org>; Tue,  9 May 2017 20:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbdEIUNF (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 16:13:05 -0400
Received: from avasout08.plus.net ([212.159.14.20]:54181 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdEIUNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 16:13:05 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id JLD11v0081keHif01LD3xf; Tue, 09 May 2017 21:13:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=N659UExz7-8A:10 a=EBOSESyhAAAA:8 a=1EXLD2x9LzD5l57MLF8A:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] archive-tar: fix a sparse 'constant too large' warning
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com>
 <alpine.DEB.2.21.1.1705091223190.146734@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5068a9b6-c77a-737d-9d80-40108c5f22c3@ramsayjones.plus.com>
Date:   Tue, 9 May 2017 21:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705091223190.146734@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 09/05/17 11:24, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Mon, 8 May 2017, Ramsay Jones wrote:
> 
>> Commit dddbad728c ("timestamp_t: a new data type for timestamps",
>> 26-04-2017) introduced a new typedef 'timestamp_t', as a synonym for an
>> unsigned long, which was used at the time to represent timestamps in
>> git. A later commit 28f4aee3fb ("use uintmax_t for timestamps",
>> 26-04-2017) changed the typedef to use an 'uintmax_t' for the timestamp
>> representation type.
>>
>> When building on a 32-bit Linux system, sparse complains that a constant
>> (USTAR_MAX_MTIME) used to detect a 'far-future mtime' timestamp, is too
>> large; 'warning: constant 077777777777UL is so big it is unsigned long
>> long' on lines 335 and 338 of archive-tar.c. Note that both gcc and
>> clang only issue a warning if this constant is used in a context that
>> requires an 'unsigned long' (rather than an uintmax_t). (Since TIME_MAX
>> is no longer equal to 0xFFFFFFFF, even on a 32-bit system, the macro
>> USTAR_MAX_MTIME is set to 077777777777UL, which cannot be represented as
>> an 'unsigned long' constant).
>>
>> In order to suppress the warning, change the definition of the macro
>> constant USTAR_MAX_MTIME to use an 'ULL' type suffix.
>>
>> In a similar vein, on systems which use a 64-bit representation of the
>> 'unsigned long' type, the USTAR_MAX_SIZE constant macro is defined with
>> the value 077777777777ULL. Although this does not cause any warning
>> messages to be issued, it would be more appropriate for this constant
>> to use an 'UL' type suffix rather than 'ULL'.
> 
> 	The reason for the current situation is that an earlier fix for
> 	the USTAR_MAX_MTIME constant was applied to the USTAR_MAX_SIZE
> 	constant by mistake.

Yeah, I had a similar comment in the commit message (but much more
verbose than your concise addition above), but I edited it several
times, without finding a wording that I liked. I eventually removed
it, because it didn't really add any value. :(

>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> 
> With that addition to the commit message: ACK

This patch is now in the 'next' branch, so I guess it's too late
to add this to the commit message (which I would be quite happy to do).

Well, at the beginning of the next cycle, 'next' will be rebuilt, so
I guess (if we remember!) this patch could be updated then.

ATB,
Ramsay Jones


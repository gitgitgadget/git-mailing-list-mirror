Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F361FF30
	for <e@80x24.org>; Mon, 22 May 2017 02:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbdEVCNi (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 22:13:38 -0400
Received: from avasout08.plus.net ([212.159.14.20]:41212 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdEVCNh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 22:13:37 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id PEDa1v0021keHif01EDc3G; Mon, 22 May 2017 03:13:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=th3ZsJhWrsiD9-egcbcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
 <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <11cae8d7-46a6-9ab5-5bee-a7e6897c0a88@ramsayjones.plus.com>
Date:   Mon, 22 May 2017 03:13:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/05/17 02:43, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Commit d8193743e0 ("usage.c: add BUG() function", 12-05-2017) added the
>> BUG() functions and macros as a replacement for calls to die("BUG: ..").
>> The use of NORETURN on the declarations (in git-compat-util.h) and the
>> lack of NORETURN on the function definitions, however, leads sparse to
>> complain thus:
>>
>>       SP usage.c
>>   usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type
>>   (originally declared at git-compat-util.h:1074) - different modifiers
>>
>> In order to suppress the sparse error, add the NORETURN to the function
>> definitions.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Junio,
>>
>> This is built on 'next', which has now merged the 'jk/bug-to-abort'
>> branch.
> 
> Thanks.  
> 
> I cannot seem to cause sparse (v0.5.0-207-g14964df) to complain the
> same way, though.

Hmm, interesting... I have an older version installed:

  $ sparse --version
  v0.5.0-60-g6c283a0
  $ sparse usage.c
  usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type
  (originally declared at git-compat-util.h:1074) - different modifiers
  $ 

... but a more up-to-date version agrees:

  $ ~/sparse/sparse --version
  v0.5.0-237-g51de1cc
  $ ~/sparse/sparse usage.c
  usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type
  (originally declared at git-compat-util.h:1074) - different modifiers
  $ 

So, I don't know. Wait let me try your specific version:

$ ~/sparse/sparse --version
v0.5.0-207-g14964df
$ ~/sparse/sparse usage.c
usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type (originally declared at git-compat-util.h:1074) - different modifiers
$ 

Er, dunno. (This is on Linux Mint 18.1).

ATB,
Ramsay Jones


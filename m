Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231862018E
	for <e@80x24.org>; Mon,  8 Aug 2016 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcHHSwK (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 14:52:10 -0400
Received: from avasout07.plus.net ([84.93.230.235]:46633 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbcHHSwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 14:52:09 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout07 with smtp
	id Uis61t00523PrXV01is7jX; Mon, 08 Aug 2016 19:52:07 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=UYYTc+aN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=mDV3o1hIAAAA:8 a=Mnx1bPq1H0mAw92CQi8A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=k75galYh9lEA:10 a=_FVE-zBwftR9WsbkzFJk:22
X-AUTH:	ramsayjones@:2500
Subject: Re: Forward declaration of enum iterator_selection?
To:	Johannes Sixt <j6t@kdbg.org>
References: <933f540f-7752-cfce-5785-b67728fea987@kdbg.org>
 <0604cf0a-2b94-93b3-3a01-213ea5b9849b@ramsayjones.plus.com>
 <57A8B3BD.1000002@kdbg.org>
 <c1ef8a65-844f-b676-cae0-abba87930063@ramsayjones.plus.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <53ab8626-f862-a732-b369-abeab69a468f@ramsayjones.plus.com>
Date:	Mon, 8 Aug 2016 19:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <c1ef8a65-844f-b676-cae0-abba87930063@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/08/16 19:28, Ramsay Jones wrote:
> 
> 
> On 08/08/16 17:30, Johannes Sixt wrote:
>> Am 07.08.2016 um 22:34 schrieb Ramsay Jones:
>>> On 05/08/16 23:26, Johannes Sixt wrote:
> [snip]
>>> At this point 'enum iterator_selection' is an incomplete type and may
>>> be used when the size of the object is not required. It is not needed,
>>> for example, when a typedef name is being declared as a pointer to, or
>>> as a function returning such a type. However, such a type must be
>>> complete before such a function is called or defined.
>>
>> All you say is true when it is a struct type, of course. But I doubt that there exists such a thing called "incomplete enumeration type" in C. In fact, with these keywords I found https://gcc.gnu.org/onlinedocs/gcc/Incomplete-Enums.html which indicates that this is a GCC extension.
> 
> Ah, well spotted!
> 
> You prompted me to look at the C99 (and C11) standards, in particular
> sections 6.7.2.2 (Enumeration specifiers) and 6.7.2.3 (Tags).
> 
> So, while (technically) enumeration types are incomplete prior to the
> closing } in its definition, the constraint imposed in 6.7.2.3-2 states:
> 
> 	"A type specifier of the form
> 		enum identifier
> 	without an enumerator list shall only appear after
> 	the type it specifies is complete"
> 
> which pretty much rules out its use here.

BTW, you can make gcc be that 'pickier compiler' you mentioned, thus:

$ rm refs.o
$ make CFLAGS='-g -O2 -Wall -std=c99 -pedantic' refs.o
    * new build flags
    CC refs.o
In file included from refs.c:8:0:
refs/refs-internal.h:363:14: warning: ISO C forbids forward references to ‘enum’ types [-Wpedantic]
 typedef enum iterator_selection ref_iterator_select_fn(
              ^
$ 

:-D

ATB,
Ramsay Jones


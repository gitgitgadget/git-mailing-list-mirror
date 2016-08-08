Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1052018E
	for <e@80x24.org>; Mon,  8 Aug 2016 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbcHHQbD (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 12:31:03 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:8989 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbcHHQbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 12:31:02 -0400
Received: from [178.114.91.225] (smtpout17.drei.com [109.126.64.17])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s7NFZ4XCbz5tlD;
	Mon,  8 Aug 2016 18:30:58 +0200 (CEST)
Subject: Re: Forward declaration of enum iterator_selection?
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <933f540f-7752-cfce-5785-b67728fea987@kdbg.org>
 <0604cf0a-2b94-93b3-3a01-213ea5b9849b@ramsayjones.plus.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <57A8B3BD.1000002@kdbg.org>
Date:	Mon, 8 Aug 2016 18:30:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <0604cf0a-2b94-93b3-3a01-213ea5b9849b@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 07.08.2016 um 22:34 schrieb Ramsay Jones:
> On 05/08/16 23:26, Johannes Sixt wrote:
>> When refs.c is being compiled, the only mention of enum
>> iterator_selection is in this piece of code pulled in from
>> refs-internal.h(have a look at the preprocessed code):
>>
>> typedef enum iterator_selection ref_iterator_select_fn(
>>          struct ref_iterator *iter0, struct ref_iterator *iter1,
>>          void *cb_data);
>>
>> This looks like a forward declarations of an enumeration type name,
>> something that I thought is illegal in C. Am I wrong? (That may well be
>> the case, my C-foo is quite rusty.)
>
> At this point 'enum iterator_selection' is an incomplete type and may
> be used when the size of the object is not required. It is not needed,
> for example, when a typedef name is being declared as a pointer to, or
> as a function returning such a type. However, such a type must be
> complete before such a function is called or defined.

All you say is true when it is a struct type, of course. But I doubt that 
there exists such a thing called "incomplete enumeration type" in C. In 
fact, with these keywords I found 
https://gcc.gnu.org/onlinedocs/gcc/Incomplete-Enums.html which indicates 
that this is a GCC extension.

> [...] I would rather the 'enum iterator_selection' be defined
> before this declaration. One solution could be to #include "iterator.h"
> prior to _all_ #include "refs/refs-internal.h" in all compilation units
> (Note it is in the opposite order in refs/iterator.c). Alternatively, you
> could put the #include "../iterator.h" into refs/refs-internal.h directly
> (some people would object to this).

I concur. Which one is the correct way to do, I do not know, either. It's 
a matter how the interface is intended to be used. Perhaps the typedef 
must be moved to iterator.h?

-- Hannes


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2D71FD99
	for <e@80x24.org>; Sun,  7 Aug 2016 20:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbcHGUeW (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 16:34:22 -0400
Received: from avasout08.plus.net ([212.159.14.20]:60558 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbcHGUeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 16:34:21 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout08 with smtp
	id ULaC1t00423PrXV01LaD86; Sun, 07 Aug 2016 21:34:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y6S6iVWN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=zuKluJ3P30mePTtUzPAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
X-AUTH:	ramsayjones@:2500
Subject: Re: Forward declaration of enum iterator_selection?
To:	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
References: <933f540f-7752-cfce-5785-b67728fea987@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0604cf0a-2b94-93b3-3a01-213ea5b9849b@ramsayjones.plus.com>
Date:	Sun, 7 Aug 2016 21:34:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <933f540f-7752-cfce-5785-b67728fea987@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 05/08/16 23:26, Johannes Sixt wrote:
> When refs.c is being compiled, the only mention of enum iterator_selection is in this piece of code pulled in from refs-internal.h (have a look at the preprocessed code):
> 
> typedef enum iterator_selection ref_iterator_select_fn(
>         struct ref_iterator *iter0, struct ref_iterator *iter1,
>         void *cb_data);
> 
> This looks like a forward declarations of an enumeration type name, something that I thought is illegal in C. Am I wrong? (That may well be the case, my C-foo is quite rusty.)

At this point 'enum iterator_selection' is an incomplete type and may
be used when the size of the object is not required. It is not needed,
for example, when a typedef name is being declared as a pointer to, or
as a function returning such a type. However, such a type must be
complete before such a function is called or defined.

> My compiler does not complain (it's gcc 4.8), but I thought I mention it before someone with a pickier compiler stumbles over it...

So, I think this is correct.

Having said that, I would rather the 'enum iterator_selection' be defined
before this declaration. One solution could be to #include "iterator.h"
prior to _all_ #include "refs/refs-internal.h" in all compilation units
(Note it is in the opposite order in refs/iterator.c). Alternatively, you
could put the #include "../iterator.h" into refs/refs-internal.h directly
(some people would object to this).

ATB,
Ramsay Jones


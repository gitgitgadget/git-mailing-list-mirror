Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBA81F855
	for <e@80x24.org>; Fri,  5 Aug 2016 05:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbcHEFkw (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 01:40:52 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:45562 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030221AbcHEFkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 01:40:51 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s5Fym6H6gz5tlG;
	Fri,  5 Aug 2016 07:40:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 651065062;
	Fri,  5 Aug 2016 07:40:48 +0200 (CEST)
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
To:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1470326812.git.johannes.schindelin@gmx.de>
 <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de>
 <57A3BA26.5080601@web.de> <xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
 <5ce2ec67-aa7d-0079-54fe-d73a70a46825@kdbg.org>
Cc:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <68c24062-7fcc-758f-373f-2f123c5eb78b@kdbg.org>
Date:	Fri, 5 Aug 2016 07:40:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <5ce2ec67-aa7d-0079-54fe-d73a70a46825@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 05.08.2016 um 07:36 schrieb Johannes Sixt:
> Am 05.08.2016 um 00:39 schrieb Junio C Hamano:
>> @@ -955,12 +955,10 @@ void **nedpindependent_comalloc(nedpool *p,
>> size_t elems, size_t *sizes, void **
>>   */
>>  char *strdup(const char *s1)
>>  {
>> -    char *s2 = 0;
>> -    if (s1) {
>> -        size_t len = strlen(s1) + 1;
>> -        s2 = malloc(len);
>> +    size_t len = strlen(s1) + 1;
>> +    s2 = malloc(len);
>> +    if (s1)
>
> It does not make sense to check s1 for NULL when it was passed to
> strlen() earlier; strlen() does not accept NULL, either...

Oh! This is a typo. You meant to check s2 for NULL.

And the declaration for s2 should remain, of course.

>
>>          memcpy(s2, s1, len);
>> -    }
>>      return s2;
>>  }
>>  #endif

-- Hannes


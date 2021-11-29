Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA2C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhK2XwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:52:25 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:23375 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233008AbhK2XwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:52:24 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mrqON-000Ar0-Ee; Mon, 29 Nov 2021 23:49:04 +0000
Message-ID: <384f10ca-81c5-dd89-b66c-6e49d7f23f70@iee.email>
Date:   Mon, 29 Nov 2021 23:49:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/4] mergesort.c: LLP64 compatibility, upcast unity for
 left shift
Content-Language: en-GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20211126113614.709-1-philipoakley@iee.email>
 <20211126113614.709-2-philipoakley@iee.email>
 <9c3d6d3c-1f3b-f51c-6856-b5ced44a8f4b@web.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <9c3d6d3c-1f3b-f51c-6856-b5ced44a8f4b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/11/2021 07:32, René Scharfe wrote:
> Am 26.11.21 um 12:36 schrieb Philip Oakley:
>> Visual Studio reports C4334 "was 64-bit shift intended" size mismatch
>> warning because of size miss-match.
>>
>> Promote unity to the matching type to fit with the `&` operator.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>>
>> ---
>> This is the same fix that René Scharfe provided in 42c456ff81
>> (mergesort: avoid left shift overflow, 2021-11-16)
>>
>> Use size_t to match n when building the bitmask for checking whether a
>> rank is occupied, instead of the default signed int.
> Fine with me -- it's just nicer to take the whole set.
>
> René

Thanks, I'm happy either way if others feels it belongs better with your
mergesort series.
>
>> ---
>>  mergesort.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mergesort.c b/mergesort.c
>> index 6216835566..bd9c6ef8ee 100644
>> --- a/mergesort.c
>> +++ b/mergesort.c
>> @@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
>>  		void *next = get_next_fn(list);
>>  		if (next)
>>  			set_next_fn(list, NULL);
>> -		for (i = 0; n & (1 << i); i++)
>> +		for (i = 0; n & ((size_t)1 << i); i++)
>>  			list = llist_merge(ranks[i], list, get_next_fn,
>>  					   set_next_fn, compare_fn);
>>  		n++;
>>
Philip

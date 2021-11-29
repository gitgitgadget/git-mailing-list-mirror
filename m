Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B84C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhK2XxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:53:22 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:43151 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232378AbhK2XxW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:53:22 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mrqPJ-000BGi-Fy; Mon, 29 Nov 2021 23:50:02 +0000
Message-ID: <833261c1-2369-92bc-3c97-5e548e52cf01@iee.email>
Date:   Mon, 29 Nov 2021 23:50:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] diffcore-delta.c: LLP64 compatibility, upcast unity
 for left shift
Content-Language: en-GB
To:     Derrick Stolee <stolee@gmail.com>, GitList <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20211126113614.709-1-philipoakley@iee.email>
 <20211126113614.709-4-philipoakley@iee.email>
 <f721bc99-6d79-e2f2-7810-dd77b777161f@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <f721bc99-6d79-e2f2-7810-dd77b777161f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/11/2021 14:44, Derrick Stolee wrote:
> On 11/26/2021 6:36 AM, Philip Oakley wrote:
>> Visual Studio reports C4334 "was 64-bit shift intended" warning
>> because of size miss-match.
>>
>> Promote unity to the matching type to fit with its subsequent operation.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  diffcore-delta.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/diffcore-delta.c b/diffcore-delta.c
>> index 5668ace60d..a4e86dfa38 100644
>> --- a/diffcore-delta.c
>> +++ b/diffcore-delta.c
>> @@ -133,10 +133,10 @@ static struct spanhash_top *hash_chars(struct repository *r,
>>  
>>  	i = INITIAL_HASH_SIZE;
>>  	hash = xmalloc(st_add(sizeof(*hash),
>> -			      st_mult(sizeof(struct spanhash), 1<<i)));
>> +			      st_mult(sizeof(struct spanhash), (size_t)1<<i)));
> This could use spaces around "<<"
OK.
>
>>  	hash->alloc_log2 = i;
>>  	hash->free = INITIAL_FREE(i);
>> -	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
>> +	memset(hash->data, 0, sizeof(struct spanhash) * ((size_t)1 << i));
> Especially because you correctly add them here.
True. The spacing isn't that consistent in the code base, but adding the
spaces here does look better.
>
> Thanks,
> -Stolee

Philip

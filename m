Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973352023D
	for <e@80x24.org>; Wed, 24 May 2017 07:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935918AbdEXHRa (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 03:17:30 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:60717 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933229AbdEXHR3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 May 2017 03:17:29 -0400
X-AuditID: 12074412-a67ff70000003a21-21-59253385f33f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.A6.14881.58335295; Wed, 24 May 2017 03:17:26 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC990.dip0.t-ipconnect.de [87.188.201.144])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4O7HKq6017703
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 24 May 2017 03:17:22 -0400
Subject: Re: [PATCH v2 25/25] cache_ref_iterator_begin(): avoid priming
 unneeded directories
To:     Jeff King <peff@peff.net>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
 <0d6a608a62026352c1496239bab02122f123f2e1.1495460199.git.mhagger@alum.mit.edu>
 <20170523194519.luhuej3rerzb57t7@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <33ffee8b-22da-ced4-95c6-ab68d4557f1d@alum.mit.edu>
Date:   Wed, 24 May 2017 09:17:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170523194519.luhuej3rerzb57t7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqNtmrBppcH+9icXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9ds66y+6xYFOpx8NXXewe
        Xe1H2Dye9e5h9Lh4Sdnj8ya5APYoLpuU1JzMstQifbsEroyTE3sZC2YKVHx7/IulgfETTxcj
        J4eEgInEuVNdTF2MXBxCAjuYJB73NDODJIQELjBJTJ7o38XIwSEsECex4EIySFhEQFbi++GN
        jBD1hxglllzoYQZxmAU6mCW+7p/JBlLFJqArsainmQnE5hWwl2hadYoFxGYRUJWY8WkHmC0q
        ECHxsHMXO0SNoMTJmU/A4pwCLhI7f00FO4JZQF3iz7xLULa8xPa3c5gnMPLPQtIyC0nZLCRl
        CxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKERIHQDsb1J+UOMQpwMCrx
        8CY4qEQKsSaWFVfmHmKU5GBSEuVNeA4U4kvKT6nMSCzOiC8qzUktBvqdg1lJhFdTRzVSiDcl
        sbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgrfFCKhRsCg1PbUiLTOnBCHN
        xMEJMpwHaHgvSA1vcUFibnFmOkT+FKOilDjvYZCEAEgiozQPrheWpF4xigO9Isw7C6SKB5jg
        4LpfAQ1mAhrselcZZHBJIkJKqoGxyUOtZHtYxN+/bTKe2xLcrMQvvk/N5s8Jrr75ddcalfCP
        hbp21z7aG588lFVrMefE9dusM5c+tdwm9uVhec764NDJPffzDFu++Ooz2O24fOb3e/6HAU9f
        RTteSn1vc/sjK//EytStksVJbfOmLFeTPa0/iXu+c+FnuZ2Xjs7Rl924fXt95BsTJZbijERD
        Leai4kQAlbWgDy0DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/23/2017 09:45 PM, Jeff King wrote:
> On Mon, May 22, 2017 at 04:17:55PM +0200, Michael Haggerty wrote:
> 
>> So:
>>
>> * Move the responsibility for doing the prefix check directly to
>>   `cache_ref_iterator`. This means that `cache_ref_iterator_begin()`
>>   never has to wrap its return value in a `prefix_ref_iterator`.
>>
>> * Teach `cache_ref_iterator_begin()` (and `prime_ref_dir()`) to be
>>   stricter about what they iterate over and what directories they
>>   prime.
>>
>> * Teach `cache_ref_iterator` to keep track of whether the current
>>   `cache_ref_iterator_level` is fully within the prefix. If so, skip
>>   the prefix checks entirely.
> 
> As promised, I came back to this one with a more careful eye. These
> changes all make sense to me, and the implementation matches.
> 
> My only question is:
> 
>> @@ -511,9 +582,12 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
>>  	level->index = -1;
>>  	level->dir = dir;
>>  
>> -	if (prefix && *prefix)
>> -		ref_iterator = prefix_ref_iterator_begin(ref_iterator,
>> -							 prefix, 0);
>> +	if (prefix && *prefix) {
>> +		iter->prefix = xstrdup(prefix);
>> +		level->prefix_state = PREFIX_WITHIN_DIR;
>> +	} else {
>> +		level->prefix_state = PREFIX_CONTAINS_DIR;
>> +	}
> 
> Who frees the prefix? Does this need:
> 
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index fda3942db..a3efc5c51 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -542,6 +542,7 @@ static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
>  	struct cache_ref_iterator *iter =
>  		(struct cache_ref_iterator *)ref_iterator;
>  
> +	free(iter->prefix);
>  	free(iter->levels);
>  	base_ref_iterator_free(ref_iterator);
>  	return ITER_DONE;

Yes, you are right. Thanks for catching this.

Note: it has to be

        free((char *)iter->prefix);

because `prefix` is const.

Junio, if a reroll is not needed for other reasons, would you mind
squashing this into the last patch of my series?

Michael


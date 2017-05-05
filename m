Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F1C207D6
	for <e@80x24.org>; Fri,  5 May 2017 01:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbdEEBVx (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 21:21:53 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43655 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdEEBVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 21:21:53 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id GRMq1v0031keHif01RMrN4; Fri, 05 May 2017 02:21:51 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=HP2zLslv c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=N659UExz7-8A:10 a=pQQh5aZd5nucW1oqH6wA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] archive-tar: fix a sparse 'constant too large' warning
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <252ddd6a-3516-6619-8ea6-d3897f13d93d@ramsayjones.plus.com>
 <alpine.DEB.2.21.1.1705041121520.4905@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <70b431dc-c5cc-e376-b63e-6a58ee1385f1@ramsayjones.plus.com>
Date:   Fri, 5 May 2017 02:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705041121520.4905@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/05/17 10:26, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Thu, 4 May 2017, Ramsay Jones wrote:
> 
>> diff --git a/archive-tar.c b/archive-tar.c
>> index 319a5b1c7..6dddc0cff 100644
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -33,7 +33,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
>>  #if TIME_MAX == 0xFFFFFFFF
>>  #define USTAR_MAX_MTIME TIME_MAX
>>  #else
>> -#define USTAR_MAX_MTIME 077777777777UL
>> +#define USTAR_MAX_MTIME 077777777777ULL
>>  #endif
>>  
> 
> Funny. This problem was pointed out by Hannes Sixt (IIRC) and I fixed this
> very thing in v6.
> 
> Except I did not. I changed the wrong constant! Instead of
> USTAR_MAX_MTIME, I adjusted USTAR_MAX_SIZE. D'oh.

Ah, I did wonder about that.

> I just saw that my patch series already hit `next`, so I fear you are
> right that we need a follow-up patch. Maybe we want this diff, though?
> 
> -- snipsnap --
> diff --git a/archive-tar.c b/archive-tar.c
> index 319a5b1c7cd..073e60ebd3c 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -28,12 +28,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
>  #if ULONG_MAX == 0xFFFFFFFF
>  #define USTAR_MAX_SIZE ULONG_MAX
>  #else
> -#define USTAR_MAX_SIZE 077777777777ULL
> +#define USTAR_MAX_SIZE 077777777777UL

Sure, I can add this. (Although, I don't think it actually
matters).

Hmm, unless somebody objects in the meantime, I will re-roll
the patch (tomorrow, it's late!).

>  #endif
>  #if TIME_MAX == 0xFFFFFFFF
>  #define USTAR_MAX_MTIME TIME_MAX
>  #else
> -#define USTAR_MAX_MTIME 077777777777UL
> +#define USTAR_MAX_MTIME 077777777777ULL
>  #endif
>  
>  /* writes out the whole block, but only if it is full */
> 

ATB,
Ramsay Jones



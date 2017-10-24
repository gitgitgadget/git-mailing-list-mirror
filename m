Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA171FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 20:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdJXUXs (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 16:23:48 -0400
Received: from mout.web.de ([212.227.15.14]:63889 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbdJXUXr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 16:23:47 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6QBP-1dHd0n2Wct-00yRrN; Tue, 24
 Oct 2017 22:23:42 +0200
Subject: Re: [PATCH 3/4] xdiff: use stronger hash function internally
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20171024185917.20515-1-sbeller@google.com>
 <20171024185917.20515-4-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <16718615-c5df-24dd-fa62-2b42f5d83a02@web.de>
Date:   Tue, 24 Oct 2017 22:23:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171024185917.20515-4-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bt5rGtlsPSyCN97ao2JV6TxIDFEI9AdvCzb5SRP6whRS9q1aBB7
 ku2CS9eeHjoqMf4R/t+0zuDnyQymh+g/f/5Om/Fya1zzCUHIZxpWdNAjbKL2wXHtDHbSMEU
 NmpwREIfNosVHTavdZEUFEmJQuF/eqDxlXRjwWn08nGoiHtvYZM6YgIjI3HzRIIR64ln5co
 mIxLSMGdJz8ywSKyw+yYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bKs9lCNcxZw=:260McKIqlAKSD2HoWOqmQG
 F2tT8JMUNn10bBRwKwwNIo/kIeqoU0DfwaBcgrYS8k7swI9jAfg7q/YJLCZGSSiLQeM6SlWVE
 CetFFIwaWTEDCPNQq+A6UeHjdB2rL0gJBSAA4Ify31ciARfncuElr4hIKF9QTRzWZ556B+N6E
 Ic2JjVYvysk8GOOM4on+nxWm2mX4m5M5MFmhe1h3UFZhWt6L/vplTTjmMlIBQqeQNnw2fU7+c
 +cRIzW6tJ3FYu2xGky8lavLbysbva1q+F707qoKp5UHxzB8YW9vsnfFvRbyDmTb0ikgeMSk9t
 DWhg+uBqlEql/rPw81ZWtfu4jVz+mrsafez+E+59aIH+AKEYddT+XSxO1sU4Vn0leD4PBKmI+
 l4phveVvTsGBSNbIPcvuTV4J/LzT3oXPTavJ2zzOS+8nV/qRo/vaZc5Zapc4REXec+FYkHXt4
 Tf8WSjyVZsXxZSqOoNsG7H2unv2xvO9e5YULTaC/aYq4P6R/Waq2ZxWm3/p45E89LoRD/fjDc
 yfphgO82GAlLPJwOW6cw6BRY42Ts8cqhCNFAFoqN3XfQzHbuLhgog9Iv33Q7TYnEsTm030sd7
 BGrRUhWQhGeS4AlWRNWuNDUFELem7buoqlS485XHDCbeQFGD9kteMAsDeNfZNIKSZUUq5XOhd
 r3H+4Z/r1YLEN2i5YCf/AI2busv3oR5YrJWQuWuV0mQTHRa7kDCHiq2tvIO9myovFuYklS5eZ
 Y2sUMnWmWMzUmq91W3uiW3u3rAL8J3Ne8P08AgXdFPWeTdmMX19yBQVumhIXamFiHgJ/Mhhn1
 2VOxbYiTBjAHa1akphCK/HY8cORAR0yFdxof2F3+eBtatxtbVs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2017 um 20:59 schrieb Stefan Beller:
> Instead of using the hash seeded with 5381, and updated via
> `(hash << 5) ^ new_byte`, use the FNV-1 primitives as offered by
> hashmap.h, which is seeded with 0x811c9dc5 and computed as
> `(hash * 0x01000193) ^ new_byte`.

The hash function you're replacing is called DJB2; I think that's worth
mentioning.

Performance test results would be nice.  No idea how to find edge cases,
though, or better: demonstrate a lack thereof.

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   xdiff/xutils.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 04d7b32e4e..a58a28c687 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -24,7 +24,8 @@
>   #include <assert.h>
>   #include "xinclude.h"
>   
> -
> +#include "cache.h"
> +#include "hashmap.h"

Ouch.  Defining FNV32_BASE and FNV32_PRIME here would be much easier
overall.  And if that's too much duplication then those definitions
could be extracted into a new header file (fnv32.h?) included by both
hashmap.h and xutils.c.

>   
>   
>   long xdl_bogosqrt(long n) {
> @@ -228,7 +229,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>   
>   static unsigned long xdl_hash_record_with_whitespace(char const **data,
>   		char const *top, long flags) {
> -	unsigned long ha = 5381;
> +	unsigned long ha = memhash(NULL, 0);
>   	char const *ptr = *data;
>   
>   	for (; ptr < top && *ptr != '\n'; ptr++) {
> @@ -243,21 +244,18 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
>   				; /* already handled */
>   			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
>   				 && !at_eol) {
> -				ha += (ha << 5);
> -				ha ^= (unsigned long) ' ';
> +				ha = memhash_feed(ha, (unsigned char) ' ');

All the memhash_feed() callers in this file cast to unsigned char.  A
macro or a function (possibly inline) defined at the top could do
that for them.

>   			}
>   			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
>   				 && !at_eol) {
>   				while (ptr2 != ptr + 1) {
> -					ha += (ha << 5);
> -					ha ^= (unsigned long) *ptr2;
> +					ha = memhash_feed(ha, (unsigned char) *ptr2);
>   					ptr2++;
>   				}
>   			}
>   			continue;
>   		}
> -		ha += (ha << 5);
> -		ha ^= (unsigned long) *ptr;
> +		ha = memhash_feed(ha, (unsigned char) *ptr);
>   	}
>   	*data = ptr < top ? ptr + 1: ptr;
>   
> @@ -265,15 +263,14 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
>   }
>   
>   unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
> -	unsigned long ha = 5381;
> +	unsigned long ha = memhash(NULL, 0);
>   	char const *ptr = *data;
>   
>   	if (flags & XDF_WHITESPACE_FLAGS)
>   		return xdl_hash_record_with_whitespace(data, top, flags);
>   
>   	for (; ptr < top && *ptr != '\n'; ptr++) {
> -		ha += (ha << 5);
> -		ha ^= (unsigned long) *ptr;
> +		ha = memhash_feed(ha, (unsigned char) *ptr);
>   	}
>   	*data = ptr < top ? ptr + 1: ptr;
>   
> 

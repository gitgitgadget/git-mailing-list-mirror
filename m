Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0791FBB0
	for <e@80x24.org>; Sun, 23 Oct 2016 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755833AbcJWQHG (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 12:07:06 -0400
Received: from avasout02.plus.net ([212.159.14.17]:43132 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbcJWQHF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 12:07:05 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id z4721t0060zhorE01473dF; Sun, 23 Oct 2016 17:07:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=dIu3SnmMAAAA:8 a=mhNtw-EXX8Tx6v6wn98A:9 a=QEXdDO2ut3YA:10
 a=Ua9G7VpiFza3u12uuhVB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v1 10/19] read-cache: regenerate shared index if necessary
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-11-chriscool@tuxfamily.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c30212bd-c454-f1a1-d01c-d6a12d20d17d@ramsayjones.plus.com>
Date:   Sun, 23 Oct 2016 17:07:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161023092648.12086-11-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/10/16 10:26, Christian Couder wrote:
> When writing a new split-index and there is a big number of cache
> entries in the split-index compared to the shared index, it is a
> good idea to regenerate the shared index.
> 
> By default when the ratio reaches 20%, we will push back all
> the entries from the split-index into a new shared index file
> instead of just creating a new split-index file.
> 
> The threshold can be configured using the
> "splitIndex.maxPercentChange" config variable.
> 
> We need to adjust the existing tests in t1700 by setting
> "splitIndex.maxPercentChange" to 100 at the beginning of t1700,
> as the existing tests are assuming that the shared index is
> regenerated only when `git update-index --split-index` is used.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  read-cache.c           | 33 ++++++++++++++++++++++++++++++++-
>  t/t1700-split-index.sh |  1 +
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index bb53823..a91fabe 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2216,6 +2216,36 @@ static int write_shared_index(struct index_state *istate,
>  	return ret;
>  }
>  
> +static const int default_max_percent_split_change = 20;
> +
> +int too_many_not_shared_entries(struct index_state *istate)

This function is a file-loacal symbol; could you please make it
a static function.

Thanks.

ATB,
Ramsay Jones

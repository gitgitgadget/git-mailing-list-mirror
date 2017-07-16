Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CCC2082F
	for <e@80x24.org>; Sun, 16 Jul 2017 00:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdGPA2H (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 20:28:07 -0400
Received: from avasout06.plus.net ([212.159.14.18]:52330 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGPA2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 20:28:06 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id lCU41v00218PUFB01CU5dl; Sun, 16 Jul 2017 01:28:05 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=o_FnH1Q4Xe-GMyY47OIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] ls-files: don't try to prune an empty index
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8fdcc21d-ccf9-7594-4d69-dfcad580da32@ramsayjones.plus.com>
Date:   Sun, 16 Jul 2017 01:28:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/07/17 21:11, René Scharfe wrote:
> Exit early when asked to prune an index that contains no
> entries to begin with.  This avoids pointer arithmetic on
> istate->cache, which is possibly NULL in that case.
> 
> Found with Clang's UBSan.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/ls-files.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index b8514a0029..adf572da68 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -362,7 +362,7 @@ static void prune_index(struct index_state *istate,
>      int pos;
>      unsigned int first, last;
> 
> -    if (!prefix)
> +    if (!prefix || !istate->cache_nr)
>          return;
>      pos = index_name_pos(istate, prefix, prefixlen);
>      if (pos < 0)

My patch looked like:

-       if (!prefix)
+       if (!prefix || !istate->cache || istate->cache_nr == 0)

... which is probably a bit 'belt-n-braces'. ;-)

ATB,
Ramsay Jones



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F59202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 20:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbdGEUF2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 16:05:28 -0400
Received: from avasout08.plus.net ([212.159.14.20]:54318 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbdGEUF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 16:05:27 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id h85E1v0021keHif0185FFN; Wed, 05 Jul 2017 21:05:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=Il7bZkTrJJdOnp6dCdIA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c4a4df1c-bf38-fbad-e7c2-9236fde87417@ramsayjones.plus.com>
Date:   Wed, 5 Jul 2017 21:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/07/17 09:00, Jeff King wrote:
> Since its inception, the general strategy of the reflog-walk
> code has been to start with the tip commit for the ref, and
> as we traverse replace each commit's parent pointers with
> fake parents pointing to the previous reflog entry.
> 
> This lets us traverse the reflog as if it were a real
> history, but it has some user-visible oddities. Namely:
> 
>   1. The fake parents are used for commit selection and
>      display. So for example, "--merges" or "--no-merges"
>      are useful, because the history appears as a linear
>      string. Likewise, pathspec limiting is based on the
>      diff between adjacent entries, not the changes actually
>      introduced by a commit.
> 
>      These are often the same (e.g., because the entry was
>      just running "git commit" and the adjacent entry _is_
>      the true parent), but it may not be in several common
>      cases. For instance, using "git reset" to jump around
>      history, or "git checkout" to move HEAD.
> 
>   2. We reverse-map each commit back to its reflog. So when
>      it comes time to show commit X, we say "a-ha, we added
>      X because it was at the tip of the 'foo' reflog, so
>      let's show the foo reflog". But this leads to nonsense
>      results when you ask to traverse multiple reflogs: if
>      two reflogs have the same tip commit, we only map back
>      to one of them.
> 
>      Instead, we should show each reflog individually, in
>      the order the user gave us on the command line.
> 
>   2. If the tip of the reflog and the ref tip disagree on
    ^^
It seems hard to get off the second point! ;-)

ATB,
Ramsay Jones


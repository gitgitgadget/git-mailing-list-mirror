Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D3A1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbdLNVte (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:49:34 -0500
Received: from siwi.pair.com ([209.68.5.199]:26445 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbdLNVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:49:33 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C3E8D84515;
        Thu, 14 Dec 2017 16:49:32 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6CCCD84512;
        Thu, 14 Dec 2017 16:49:32 -0500 (EST)
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>,
        Jameson Miller <jameson.miller81@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Subject: Question about the ahead-behind computation and status
Message-ID: <030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com>
Date:   Thu, 14 Dec 2017 16:49:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


We working with the (enormous) Windows repo, we observed
a performance problem in the ahead-behind computation and
were considering a few options.

We had a local repo with a local branch that was 150K
commits behind the upstream branch[*].  There was a ~20
second different in the run times for these 2 commands:

     $ git status --porcelain=v2
     $ git status --porcelain=v2 --branch

Profiling showed the additional time was spent computing
the ahead/behind values for the branch.  (The problem is
not specific to porcelain V2, that was just the command
where we discovered it; for example, there is a similar
perf problem in "git branch" vs "git branch -vv".)

I don't want to jump into the graph algorithm at this time,
but was wondering about adding a --no-ahead-behind flag (or
something similar or a config setting) that would disable
the a/b computation during status.

For status V2 output, we could omit the "# branch.ab x y"
line.  For normal status output, change the prose a/b
message to say something like "are [not] up to date".

Thoughts or suggestions ???

Thanks,
Jeff


[*] Sadly, the local repo was only about 20 days out of
     date (including the Thanksgiving holidays)....

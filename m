Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A045EC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 18:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiI0ShZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 14:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiI0ShY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 14:37:24 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489BD1BEA56
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 11:37:21 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 69935CA124E;
        Tue, 27 Sep 2022 14:37:20 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 23BFACC832A;
        Tue, 27 Sep 2022 14:37:20 -0400 (EDT)
Subject: Re: [PATCH] pack-bitmap: remove trace2 region from hot path
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4c4954d8-82ea-8674-542e-865c514a7ae5@jeffhostetler.com>
Date:   Tue, 27 Sep 2022 14:37:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/23/22 9:00 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The trace2 region around the call to lazy_bitmap_for_commit() in
> bitmap_for_commit() was added in 28cd730680d (pack-bitmap: prepare to
> read lookup table extension, 2022-08-14). While adding trace2 regions is
> typically helpful for tracking performance, this method is called
> possibly thousands of times as a commit walk explores commit history
> looking for a matching bitmap. When trace2 output is enabled, this
> region is emitted many times and performance is throttled by that
> output.
> 
> For now, remove these regions entirely.
> 
> This is a critical path, and it would be valuable to measure that the
> time spent in bitmap_for_commit() does not increase when using the
> commit lookup table. The best way to do that would be to use a mechanism
> that sums the time spent in a region and reports a single value at the
> end of the process. This technique was introduced but not merged by [1]
> so maybe this example presents some justification to revisit that
> approach.
> 
> [1] https://lore.kernel.org/git/pull.1099.v2.git.1640720202.gitgitgadget@gmail.com/

I'll dust off my "timers and counters" series, address the
various issues that were raised back in December, and resubmit.

Thanks for the reminder.
Jeff


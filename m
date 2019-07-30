Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395091F462
	for <e@80x24.org>; Tue, 30 Jul 2019 18:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfG3SA6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 14:00:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:44045 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfG3SA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 14:00:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B6363F4090;
        Tue, 30 Jul 2019 14:00:52 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:d44c:ac32:59e2:7221] (unknown [IPv6:2001:4898:a800:1010:8582:ac32:59e2:7221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 49C9E3F4051;
        Tue, 30 Jul 2019 14:00:52 -0400 (EDT)
Subject: Re: [RFC PATCH] trace2: don't overload target directories
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9ccf15ac-0e53-7044-e7b0-03bb229824d8@jeffhostetler.com>
Date:   Tue, 30 Jul 2019 14:00:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/29/2019 6:20 PM, Josh Steadmon wrote:
> trace2 can write files into a target directory. With heavy usage, this
> directory can fill up with files, causing difficulty for
> trace-processing systems.

I'm routing data in my org to a daemon via a Named Pipe or UD Socket,
so I'm not seeing the thousands of files problems that you're seeing.
However, we were being overwhelmed with lots of "uninteresting" commands
and so I added some whitelisting to my post-processing daemon.  For
example, I want to know about checkout and push times -- I really don't
care about rev-parse or config times or other such minor commands.

I went one step further and allow either "(cmd_name)" or
the pair "(cmd_name, cmd_mode)".  This lets me select all checkouts
and limit checkouts to branch-changing ones, for example.  I drop
any events in my post-processor that does not match any of my whitelist
patterns.

Perhaps you could run a quick histogram and see if something would
be useful to pre-filter the data.  That is, if we had whitelisting
within git.exe itself, would you still have too much data and/or
would you still need the overload feature that you've proposed in
this RFC?

Thanks,
Jeff


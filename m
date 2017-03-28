Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9803B1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbdC1TvZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:51:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:20571 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932243AbdC1TvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:51:24 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6A9F3845D1;
        Tue, 28 Mar 2017 15:50:35 -0400 (EDT)
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
To:     Jeff King <peff@peff.net>
References: <20170328190732.59486-1-git@jeffhostetler.com>
 <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
Date:   Tue, 28 Mar 2017 15:50:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/28/2017 3:16 PM, Jeff King wrote:
> On Tue, Mar 28, 2017 at 07:07:30PM +0000, git@jeffhostetler.com wrote:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Version 3 of this patch series simplifies this effort to just turn
>> on/off the hash verification using a "core.checksumindex" config variable.
>>
>> I've preserved the original checksum validation code so that we can
>> force it on in fsck if desired.
>>
>> It eliminates the original threading model completely.
>>
>> Jeff Hostetler (2):
>>   read-cache: core.checksumindex
>>   test-core-checksum-index: core.checksumindex test helper
>>
>>  Makefile                            |  1 +
>>  read-cache.c                        | 12 ++++++
>>  t/helper/.gitignore                 |  1 +
>>  t/helper/test-core-checksum-index.c | 77 +++++++++++++++++++++++++++++++++++++
>
> Do we still need test-core-checksum-index? Can we just time ls-files or
> something in t/perf?

It was a convenient way to isolate, average, and compare
read_index() times, but I suppose we could do something
like that.

I did confirm that a ls-files does show a slight 0.008
second difference on the 58K file Linux tree when toggled
on or off.

But I'm tempted to suggest that we just omit my helper exe
and not worry about a test -- since we don't have any test
repos large enough to really demonstrate the differences.
My concern is that that 0.008 would be lost in the noise
of the rest of the test and make for an unreliable result.

Jeff

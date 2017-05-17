Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21445201A7
	for <e@80x24.org>; Wed, 17 May 2017 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbdEQSPH (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 14:15:07 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:39317 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753490AbdEQSPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 14:15:06 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wSjCW64RRz5tlD;
        Wed, 17 May 2017 20:15:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4732542E7;
        Wed, 17 May 2017 20:15:03 +0200 (CEST)
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
 <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
 <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
 <29122818-71fb-5af9-59b1-03387f014151@gmail.com>
 <134ea57f-3a64-f7b5-67dd-8b14ff3cc04a@kdbg.org>
 <0a3f38b7-788b-b364-3fef-83191e4b9bea@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2e5ea82d-3b8f-f508-e2af-5f193241a573@kdbg.org>
Date:   Wed, 17 May 2017 20:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <0a3f38b7-788b-b364-3fef-83191e4b9bea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.05.2017 um 16:26 schrieb Ben Peart:
> On 5/16/2017 3:13 PM, Johannes Sixt wrote:
>> Am 16.05.2017 um 19:17 schrieb Ben Peart:
>>> OK, now I'm confused as to the best path for adding a get_be64.  This
>>> one is trivial:
>>>
>>> #define get_be64(p)    ntohll(*(uint64_t *)(p))
>>
>> I cringe when I see a cast like this. Unless you can guarantee that p is
>> char* (bare or signed or unsigned), you fall pray to strict aliasing
>> violations, aka undefined behavior. And I'm not even mentioning correct
>> alignment, yet.
> 
> Note, this macro is only used where the CPU architecture is OK with 
> unaligned memory access.

I'm not worried about the unaligned memory access: It either works, or 
we get a SIGBUS. The undefined behavior is more worrisome because the 
code may work or not, and we can never be sure which it is.

-- Hannes

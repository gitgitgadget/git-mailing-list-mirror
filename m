Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4671F404
	for <e@80x24.org>; Mon, 19 Feb 2018 13:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeBSNBv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 08:01:51 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:62580 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeBSNBh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 08:01:37 -0500
Received: from [192.168.2.201] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id nl4YeA0gIoNnDnl4YeU8wi; Mon, 19 Feb 2018 13:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519045295;
        bh=++V2uZ8tL7w+gXmTd6wGww40Fqiyt4VUCGOBbvKycyo=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=dNRK5SCSMRanySPYF340FNMf4CC2JR8zCCcNge3dEZwTmGTcEktyt1KaVEw4puH5W
         tiMpBR38k/aiCaNXcfle6UPqPqXdqRPTKYfJHAkaWnGdtYyMMmInzw7HLRCRwOIrQR
         oLoj/HY7ThLO+3yh15qbUSKskkuoeWGfipaWIR/g=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=N659UExz7-8A:10 a=evINK-nbAAAA:8
 a=wVsNTyUSwQVMGWEdgTAA:9 a=pILNOxqGKmIA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] Correct offsets of hunks when one is skipped
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180213235642.GD1022467@genre.crustytoothpaste.net>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <21bc3131-9432-537f-9e60-8cb3166572eb@talktalk.net>
Date:   Mon, 19 Feb 2018 13:01:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213235642.GD1022467@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF6hTe4qpLIU9n6mhRYVWwD/0kPv01+AiYuN6ZlMaYpWUZGfFNmTidRb7V6FQueBrSU+ARRDCuEE0q984zWoMTrFr6+fpJr0/PKOBexRGX7rU2Qy20LD
 EKVQxI4XzNHJ45YvSfV6RmRpUNyqPuFlQrd7c08D+qS/x11FvxjJ6z7al6bFpMyw1HV0DTH+dMf1Bmn5TPu63AbBFeGEdNyndorsDwKbxzMivflZ5QLct1PE
 /6HbLKUTpnLztaeI2FOskJzYszoUHxRo02qS80xViuI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/02/18 23:56, brian m. carlson wrote:
> On Tue, Feb 13, 2018 at 10:44:04AM +0000, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> While working on a patch series to stage selected lines from a hunk
>> without having to edit it I got worried that subsequent patches would
>> be applied in the wrong place which lead to this series to correct the
>> offsets of hunks following those that are skipped or edited.
>>
>> Phillip Wood (4):
>>   add -i: add function to format hunk header
>>   t3701: add failing test for pathological context lines
>>   add -p: Adjust offsets of subsequent hunks when one is skipped
>>   add -p: calculate offset delta for edited patches
>>
>>  git-add--interactive.perl  | 93 +++++++++++++++++++++++++++++++++++-----------
>>  t/t3701-add-interactive.sh | 30 +++++++++++++++
>>  2 files changed, 102 insertions(+), 21 deletions(-)
> 
> This looks reasonably sane to me.  I really like that you managed to
> produce failing tests for this situation.  I know pathological cases
> like this have bit GCC in the past, so it's good that you fixed this.
> 

Thanks Brain, it's interesting to hear that GCC has been bitten in the past

Best Wishes

Phillip

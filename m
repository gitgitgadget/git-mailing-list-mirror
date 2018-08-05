Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5930E1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeHEQGg (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 12:06:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:45769 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbeHEQGg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 12:06:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 19F9E3F4024;
        Sun,  5 Aug 2018 10:01:54 -0400 (EDT)
Received: from [192.168.1.6] (204.sub-174-231-156.myvzw.com [174.231.156.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9AD143F4002;
        Sun,  5 Aug 2018 10:01:52 -0400 (EDT)
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=c5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
 <20180731203746.GA9442@sigill.intra.peff.net>
 <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
 <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
 <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
 <20180802190644.GE23690@sigill.intra.peff.net>
 <xmqqmuu4zd1l.fsf@gitster-ct.c.googlers.com>
 <20180802212819.GA32538@sigill.intra.peff.net>
 <5b17454b-7fa7-7a9c-92d9-214e6e697785@jeffhostetler.com>
 <20180803185325.GA27977@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9eb6caf1-b4aa-766d-922e-b2b24b391b33@jeffhostetler.com>
Date:   Sun, 5 Aug 2018 10:01:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180803185325.GA27977@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/3/2018 2:53 PM, Jeff King wrote:
> On Fri, Aug 03, 2018 at 02:23:17PM -0400, Jeff Hostetler wrote:
> 
>>> Maybe. It might not work as ino_t. Or it might be expensive to get.  Or
>>> maybe it's simply impossible. I don't know much about Windows. Some
>>> searching implies that NTFS does have a "file index" concept which is
>>> supposed to be unique.
>>
>> This is hard and/or expensive on Windows.  Yes, you can get the
>> "file index" values for an open file handle with a cost similar to
>> an fstat().  Unfortunately, the FindFirst/FindNext routines (equivalent
>> to the opendir/readdir routines), don't give you that data.  So we'd
>> have to scan the directory and then open and stat each file.  This is
>> terribly expensive on Windows -- and the reason we have the fscache
>> layer (in the GfW version) to intercept the lstat() calls whenever
>> possible.
> 
> I think that high cost might be OK for our purposes here. This code
> would _only_ kick in during a clone, and then only on the error path
> once we knew we had a collision during the checkout step.
> 

Good point.

I've confirmed that the "file index" values can be used to determine
whether 2 path names are equivalent under NTFS for case variation,
final-dot/space, and short-names vs long-names.

I ran out of time this morning to search the directory for equivalent 
paths.  I'll look at that shortly.

Jeff

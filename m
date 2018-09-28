Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C1A1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 15:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeI1V4F (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 17:56:05 -0400
Received: from avasout07.plus.net ([84.93.230.235]:37885 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbeI1V4F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 17:56:05 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 5ujcgY1N0jlDz5uk7g7wZX; Fri, 28 Sep 2018 16:31:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=49dTPssbX5TUBygoor8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] read-cache: fix division by zero core-dump
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <476b5678-41b2-d2f8-1890-ba315354ebc0@ramsayjones.plus.com>
 <8a76234e-fcf8-f435-33e9-1846c3b6ad14@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <da607bd3-c91b-556d-b342-927cb2f773c7@ramsayjones.plus.com>
Date:   Fri, 28 Sep 2018 16:31:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a76234e-fcf8-f435-33e9-1846c3b6ad14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJc1Mnh84HgScjSqmZ6z7QXZRs7Zn/b6o3mWFRomPN2pXePBB+cbXaa/+Bb9sXpoCWcx9TOjRN0DJdDZHIvvrUjZWP+u8ysb8rgf0r+a4HTcH6o35bKW
 dabiGOIgS7PyqDnyJJ832igbYRe4a/FoQXCTH7FXGw1Q8xeoQlA1TKr22I34KluAaCgNZlTjS+go8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/09/18 02:20, Ben Peart wrote:
> 
> 
> On 9/27/2018 6:24 PM, Ramsay Jones wrote:
>>
>> commit 225df8a468 ("ieot: add Index Entry Offset Table (IEOT)
>> extension", 2018-09-26) added a 'DIV_ROUND_UP(entries, ieot_blocks)
>> expression, where ieot_blocks was set to zero for a single cpu
>> platform. This caused an SIGFPE and a core dump in practically
>> every test in the test-suite, until test t4056-diff-order.sh, which
>> then went into an infinite loop!
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Ben,
>>
>> Could you please squash this into the relevant commits on your
>> 'bp/read-cache-parallel' branch. (The first hunk fixes a sparse
>> warning about using an integer as a NULL pointer).
>>
> 
> Absolutely - thanks for the patch.
> 
> I don't know how long it's been since I've been on a single core CPU - I'm sad for you. ;-)

Heh, don't be - whilst I do still have a single cpu laptop about
the place _somewhere_, I haven't booted it up in about 15 years! :-D

I used to regularly test git (and other software) on my old 32-bit
laptop (windows xp/Linux Mint 17.x, Core2 duo), but just lately
I have taken to using a 32-bit VM on my current laptop (4th gen i5)
instead. (The git test-suite would take approx 50 min to run on
the 32-bit hardware, whereas it only takes 8 min on the VM!).

I have configured the 32-bit VM with a single cpu, because when
the VM was configured with two cpus the git test-suite would take
longer to run (approx. 8 -> 10 min)! Taking more resources from
the host, but increasing the running time, didn't seem like a good
return. ;-)

Also, this is not the first time some multi-threaded code in git
has 'failed' by assuming more than one cpu, so ...

ATB,
Ramsay Jones



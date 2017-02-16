Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771971FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbdBPSMX (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:12:23 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:30434 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932567AbdBPSMW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:12:22 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vPPPv46vLz5tlK;
        Thu, 16 Feb 2017 19:12:19 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C94CB1D16;
        Thu, 16 Feb 2017 19:12:17 +0100 (CET)
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <xmqqbmublyo0.fsf@gitster.mtv.corp.google.com>
 <31bb0b9f-d498-24b3-57d5-9f34cb8e3914@kdbg.org>
 <alpine.DEB.2.20.1702131815351.3496@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0080edd6-a515-2fe9-6266-b6f6bbedfdde@kdbg.org>
Date:   Thu, 16 Feb 2017 19:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702131815351.3496@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.02.2017 um 18:16 schrieb Johannes Schindelin:
> On Sat, 11 Feb 2017, Johannes Sixt wrote:
>> Am 10.02.2017 um 00:41 schrieb Junio C Hamano:
>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>>
>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>
>>>> Use OpenSSL's SHA-1 routines rather than builtin block-sha1
>>>> routines.  This improves performance on SHA1 operations on Intel
>>>> processors.
>>>> ...
>>>>
>>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>> ---
>>>
>>> Nice.  Will queue as jh/mingw-openssl-sha1 topic; it is a bit too
>>> late for today's integration cycle to be merged to 'next', but let's
>>> have this by the end of the week in 'master'.
>>
>> Please don't rush this through. I didn't have a chance to cross-check the
>> patch; it will have to wait for Monday. I would like to address Peff's
>> concerns about additional runtime dependencies.
>
> I never meant this to be fast-tracked into git.git. We have all the time
> in our lives to get this in, as Git for Windows already carries this patch
> for a while, and shall continue to do so.

I've been working with this patch for the past few days, and I did not 
notice any disadvantage during interactive work even though there is a 
new dependency on libcrypto.dll.

Here are some unscientific numbers collected during test suite runs:

bash -c "time make -j4 -k test"

with this patch:

real    34m47.242s
user    9m55.827s
sys     25m20.483s

without this patch:

real    34m2.330s
user    9m56.556s
sys     25m5.520s

It looks like BLK_SHA1 has some advantage, but I would not count on 
these figures too much. (I certainly did not sit idly in front of the 
workstation during these tests, for example. That may have skewed the 
numbers somewhat.) (And, no, I'm not going to measure best-of-five 
timings, not even best-of-two. ;)

In summary: Interactive response times do not decline noticably. I do 
not object the patch.

-- Hannes


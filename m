Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432BFC433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AA5206E2
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 13:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgGHN6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:58:21 -0400
Received: from siwi.pair.com ([209.68.5.199]:17487 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgGHN6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 09:58:21 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 09:58:20 EDT
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0225A3F4096;
        Wed,  8 Jul 2020 09:49:06 -0400 (EDT)
Received: from MININT-86BFOFO.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BA9F83F4088;
        Wed,  8 Jul 2020 09:49:05 -0400 (EDT)
Subject: Re: [PATCH v12 5/5] read-cache: speed up has_dir_name (part 2)
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Brandon Williams <bwilliamseng@gmail.com>
References: <20170419170618.16535-1-git@jeffhostetler.com>
 <20170419170618.16535-6-git@jeffhostetler.com>
 <20200704172708.GC11341@szeder.dev> <xmqqr1tp9mf8.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <be8dec3e-087e-b973-280d-3d0d2e481de6@jeffhostetler.com>
Date:   Wed, 8 Jul 2020 09:49:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1tp9mf8.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/6/20 2:39 AM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>>> +				 * last: xxx/yy-file (because '-' sorts before '/')
>>> +				 * this: xxx/yy/abc
>>
>> This is problematic, because the index can already contain 'xxx/yy' as
>> a file, when adding 'xxx/yy/abc', but since 'xxx/yy' as a file sorts
>> before 'xxx/yy-file', the short-circuiting here doesn't see it and
>> thus leaves the d-f collision undetected.  Consequently, even Git
>> porcelain commands can create tree objects with duplicate entries, as
>> demonstrated in the tests below.
> 
> Yeah, the "optimization" is quite bogus.  Thanks for catching it.
> 

yes, thanks!
Jeff

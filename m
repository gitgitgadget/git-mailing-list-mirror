Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3050D1F462
	for <e@80x24.org>; Tue, 21 May 2019 16:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfEUQz2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 12:55:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:21115 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfEUQz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 12:55:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EED1A3F4051;
        Tue, 21 May 2019 12:55:26 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:101d:dfe8:f4b5:4e4b] (unknown [IPv6:2001:4898:a800:1012:c150:dfe8:f4b5:4e4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9F6E93F4024;
        Tue, 21 May 2019 12:55:26 -0400 (EDT)
Subject: Re: [Breakage] 2.22.0-rc1 - t0211-trace2-perf.sh
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Duy Nguyen' <pclouds@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     'Git Mailing List' <git@vger.kernel.org>
References: <019e01d50fc2$324bd400$96e37c00$@nexbridge.com>
 <87a7fguiwn.fsf@evledraar.gmail.com>
 <CACsJy8DhsU6CL95W9gsWaTSnN+_7Z_+Q7yPjhuDRRKfCrhnz2w@mail.gmail.com>
 <000501d50fd6$24c0f0e0$6e42d2a0$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <92cfdf43-8841-9c5a-7838-dda995038908@jeffhostetler.com>
Date:   Tue, 21 May 2019 12:55:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <000501d50fd6$24c0f0e0$6e42d2a0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/21/2019 9:07 AM, Randall S. Becker wrote:
> On May 21, 2019 07:59, Duy Nguyen wrote:
>> On Tue, May 21, 2019 at 6:51 PM Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>>> But the real bug looks like the trace2 code unconditionally depending
>>> on pthreads, even though NonStop has 'NO_PTHREADS =
>> UnfortunatelyYes'
>>> defined.
>>>
>>> That's why we get this th%d:unknown stuff, the trace2/tr2_tls.c code
>>> using pthreads is failing with whatever pthread-bizarro NonStop has.
>>>
>>> That seems easy enough to "fix", just always fake up "main" if we
>>> don't have pthreads, but perhaps Jeff H. has another opinion on it...
>>
>> That's not NonStop. thread-utils.h (re)defines pthread_getspecific() to return
>> NULL when NO_PTHREADS, which triggers this I think.
> 
> The platform *is* NonStop, which has SPT and PUT pthreads, but we have never been able to make them work with git, so did not include them in the configuration.
> 

I just reproduced this on my Mac with NO_PTHREADS defined.
I'll post a fix shortly.

Jeff

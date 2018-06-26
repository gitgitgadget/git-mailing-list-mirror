Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2418A1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 18:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeFZSF7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 14:05:59 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:51873 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbeFZSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 14:05:58 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41FYr41f7Xz5tl9;
        Tue, 26 Jun 2018 20:05:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DD1D91CBC;
        Tue, 26 Jun 2018 20:05:55 +0200 (CEST)
Subject: Re: [PATCH 17/29] t: use test_must_fail() instead of checking exit
 code manually
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-18-sunshine@sunshineco.com>
 <CABPp-BFmfN6=E+3BAKt-NH5hmU-368shgDnrnkrnMRvKnx07BQ@mail.gmail.com>
 <CAPig+cRTG625H3CF1Zw30vQt2W8uKf1xLxVaQni2YbJ=xAif2g@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <29d090a2-bbe4-0d87-6dda-037ae675d4a3@kdbg.org>
Date:   Tue, 26 Jun 2018 20:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRTG625H3CF1Zw30vQt2W8uKf1xLxVaQni2YbJ=xAif2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.06.2018 um 11:21 schrieb Eric Sunshine:
> On Tue, Jun 26, 2018 at 4:58 AM Elijah Newren <newren@gmail.com> wrote:
>> On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +               p4 help client &&
>>> +               test_must_fail p4 help nosuchcommand
>>
>> same question?
> 
> Same answer. Not shown in this patch, but just above the context lines
> you will find this comment in the file:
> 
>      # We rely on this behavior to detect for p4 move availability.
> 
> which means that the test is really interested in being able to
> reliably detect if a sub-command is or is not available. So, despite
> the (somewhat) misleading test title, this test doesn't care about the
> exact error code but rather cares only that "p4 help nosuchcommand"
> errors out, period. Hence, test_must_fail() again agrees with the
> spirit of the test.

test_must_fail ensures that only "proper" failures are diagnosed as 
expected; failures due to signals such as SEGV are not expected failures.

In the test suite we expect all programs that are not our "git" to work 
correctly; in particular, that they do not crash on anything that we ask 
them to operate on. Under this assumption, the protection given by 
test_must_fail is not needed.

Hence, these lines should actually be

		p4 help client &&
		! p4 help nosuchcommand

-- Hannes

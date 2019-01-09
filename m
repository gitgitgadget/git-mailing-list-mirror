Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C3A1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 06:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfAIG6h (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 01:58:37 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:8865 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbfAIG6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 01:58:32 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43ZKj20zqpz5tlJ;
        Wed,  9 Jan 2019 07:58:30 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B294020C3;
        Wed,  9 Jan 2019 07:58:29 +0100 (CET)
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20181231003150.8031-4-ischis2@cox.net>
 <a8a586d9-dad7-606f-948c-06725ac3e062@kdbg.org>
 <6530822.TNJIEUz5BA@thunderbird>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <42e521e3-8a12-17c9-cb7f-bfba226ca126@kdbg.org>
Date:   Wed, 9 Jan 2019 07:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <6530822.TNJIEUz5BA@thunderbird>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.01.19 um 01:44 schrieb Stephen P. Smith:
> On Tuesday, January 8, 2019 2:27:22 PM MST Johannes Sixt wrote:
>> Am 31.12.18 um 01:31 schrieb Stephen P. Smith:
>>> +
>>> +TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'
> <snip>
>> The $...REGEX expansions must be put in double-quotes to protect them
>> from field splitting. But then the tests do not pass anymore (I tested
>> only t4202). Please revisit this change.
> 
> I will later figure out why you are seeing the fields splitting but I am not.
> In the mean time I will change the quoting.

In this line

TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'

no field splitting occurs. The quoting is fine here. But notice that the 
value of $TODAY_REGEX contains blanks.

In this line

check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX

the value of $TODAY_REGEX is substituted and then the value is split 
into fields at the blanks because the expansion is not quoted.

As a consequence, function check_human_date considers only the first 
part of $TODAY_REGEX, i.e. 'A-Z][a-z][a-z]' (which is parameter $2), but 
ignores everything else (because it does not use $3 or $4).

-- Hannes

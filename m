Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD33A1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbeBGSmt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:42:49 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:54772 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753941AbeBGSms (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:42:48 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zc9Dk5dSGz5tlB;
        Wed,  7 Feb 2018 19:42:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 53B4B1D02;
        Wed,  7 Feb 2018 19:42:46 +0100 (CET)
Subject: Re: [PATCH] t0050: remove the unused $test_case variable
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20180206231303.8483-1-avarab@gmail.com>
 <bf3ad52d-4aa3-8678-9466-3996f6cba11c@kdbg.org>
 <87fu6dz0h6.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a8bc404e-fca8-6d64-21c4-df6d6879bee7@kdbg.org>
Date:   Wed, 7 Feb 2018 19:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87fu6dz0h6.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.02.2018 um 09:07 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Wed, Feb 07 2018, Johannes Sixt jotted:
> 
>> Am 07.02.2018 um 00:13 schrieb Ævar Arnfjörð Bjarmason:
>>> The $test_case variable hasn't been used since
>>> decd3c0c28 ("t0050-*.sh: mark the rename (case change) test as
>>> passing", 2014-11-28) when its last user went away.
>>>
>>> Let's remove the "say" as well, since it's obvious from subsequent
>>> output that we're testing on a case sensitive filesystem.
>>
>> Am I misunderstanding the message? I think it reports properties of
>> the test environment. And the tests do run on case-insensitive
>> filesystems. IMO, the message should be kept.
> 
> It's obvious from subsequent output whether the FS is case sensitive or
> not, so I thought it was redundant to keep this report at the top since
> we didn't have the variable setting anymore.

There are test cases that do different things depending on whether the 
CASE_INSENSITIVE_FS prerequisite is set. I think it was the intent to 
report whether it is set and not whether one or the other value of the 
(now unused) variable is used somewhere.

BTW, the message texts do not show which variant is taken (these are 
without your patch):

On Windows:

t>sh t0050-filesystem.sh
will test on a case insensitive filesystem
will test on a filesystem lacking symbolic links
ok 1 - detection of case insensitive filesystem during repo init
ok 2 - detection of filesystem w/o symlink support during repo init
ok 3 - setup case tests
ok 4 - rename (case change)
ok 5 - merge (case change)
not ok 6 - add (with different case) # TODO known breakage
ok 7 - setup unicode normalization tests
ok 8 - rename (silent unicode normalization)
ok 9 - merge (silent unicode normalization)
# still have 1 known breakage(s)
# passed all remaining 8 test(s)
1..9

On Linux:

t@master:1002> ./t0050-filesystem.sh
ok 1 - detection of case insensitive filesystem during repo init
ok 2 - detection of filesystem w/o symlink support during repo init
ok 3 - setup case tests
ok 4 - rename (case change)
ok 5 - merge (case change)
ok 6 # skip add (with different case) (missing CASE_INSENSITIVE_FS)
ok 7 - setup unicode normalization tests
ok 8 - rename (silent unicode normalization)
ok 9 - merge (silent unicode normalization)
# passed all 9 test(s)
1..9

I'd even argue that there should be messages on Linux, too.

-- Hannes

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551C72027C
	for <e@80x24.org>; Tue, 30 May 2017 13:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdE3NkK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 09:40:10 -0400
Received: from avasout07.plus.net ([84.93.230.235]:52048 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdE3NkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 09:40:09 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id Sdg41v00A1keHif01dg6NB; Tue, 30 May 2017 14:40:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=LoG4C5gyAAAA:8 a=UI62F6zQfZVIbar_Ef8A:9
 a=QEXdDO2ut3YA:10 a=Vr7qJMbYMNsA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=szc4L7tIoTp4SOWyBAQL:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote
 nicknames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
 <20170526033510.1793-14-gitster@pobox.com>
 <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
 <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
 <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
 <bc145b9d-96cc-325a-8df3-af87d23c8727@ramsayjones.plus.com>
 <xmqqo9ubfby1.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <acfefc80-7176-c7a8-374c-fc82152ba5d5@ramsayjones.plus.com>
Date:   Tue, 30 May 2017 14:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9ubfby1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/05/17 01:03, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> See commit c7018be509 ("test: allow skipping the remainder", 18-05-2017)
>> which is currently merged to the 'next' branch (merge 03b8a61e47 of the
>> 'jc/skip-test-in-the-middle' branch).
>>
>> (see also http://testanything.org)
>>
>> If you look at http://testanything.org//tap-specification.html, it shows
>> that you are allowed to annotate a plan of '1..0' with a SKIP directive
>> to explain why no tests in a file were run. However, a plan with '1..n'
>> (for any n > 0) must not have any annotation. (Back in 2012, when I wrote
>> commit bf4b721932, I found much better documentation than the above!)
>>
>> So, after commit c7018be509, you can now use the 'skip_all' facility
>> after having run some tests; it now converts that into an 'SKIP comment'
>> just before the test plan, effectively skipping the remainder of the
>> tests in the file. (since we are using a 'trailing plan', and have thus
>> not declared how many tests we had intended to run, we can output an
>> accurate plan).
> 
> Yes, but I consider that c7018be509 is an ugly workaround, not a
> part of a properly designed framework.  Unless it is absolutely
> necessary to run some tests before we may conditionally want to say
> "skip_all/test_done", we should strive to add tests _after_ these
> conditional skil_all/test_done is done.

yes, I don't disagree with that (which is why I said that I would
have split t5545 into two files). ;-)

> In this case, I do not see there is a strong reason why the new test
> must come before the "setup" test.  Sure, it does not use UNCPATH so
> the new test may be able to run even when the current path cannot be
> spelled as UNC, but that is a natural fallout of (ab)using the test
> script that was meant for UNC testing for something else, so I think
> a proper way out would be either (1) to use a separate script, if
> the new test wants to run whether UNC path can be determined,

Yes, I had intended to suggest this (or an existing script, protected
by the MINGW prerequisite), but forgot!

>                                                              or (2)
> just accept the fact that the new test will only be run when UNC
> paths are tested.

I prefer (1).

>                   Relying on the hack c7018be509 did is much less
> appealing.

ATB,
Ramsay Jones


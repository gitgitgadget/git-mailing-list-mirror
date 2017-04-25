Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FEE207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 05:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980432AbdDYFv4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 01:51:56 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:5930 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S980429AbdDYFvy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 01:51:54 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wBsm773sPz5tlB;
        Tue, 25 Apr 2017 07:51:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7B2E442E0;
        Tue, 25 Apr 2017 07:51:51 +0200 (CEST)
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
To:     Christian Couder <christian.couder@gmail.com>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
 <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1704211135430.3480@virtualbox>
 <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
 <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org>
 <CAP8UFD1r9TFE9ns5pobDOpugF8MBiJAYgrRALCqGVmgWud=QjQ@mail.gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3bd4a2d7-ada9-6198-8cf1-573d80cae1b4@kdbg.org>
Date:   Tue, 25 Apr 2017 07:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1r9TFE9ns5pobDOpugF8MBiJAYgrRALCqGVmgWud=QjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2017 um 04:00 schrieb Christian Couder:
> On Sat, Apr 22, 2017 at 3:37 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 21.04.2017 um 14:29 schrieb Christian Couder:
>>>
>>> First bisect should ask you to test merge bases only if there are
>>> "good" commits that are not ancestors of the "bad" commit.
>>
>>
>> That's a tangent, but I have never understood why this needs to be so.
>> Consider this:
>>
>>     o--o--o--o--o--o--o--o--B
>>    /           /
>>  -o--o--o--o--g--o--o--o--o--G
>>
>> When I mark B as bad and G as good, why would g have to be tested first?
>
> It is because g could be bad if the bug has been fixed between g and G.
> If this happens and we don't test g, we would give a wrong result.

Gah! So, a typical messy workflow "requires" this behavior. A clean 
branchy workflow like Git's does not because we know that a breakage is 
either on a topic branch, B, or a (the?) bad commit is an ancester of 
(the integration branch) G.

>
>> This is exactly what I do when I bisect in Git history: I mark the latest
>> commits on git-gui and gitk sub-histories as good, because I know they can't
>> possibly be bad. (In my setup, these two histories are ahead of pu and
>> next.)
>
> Yeah, it is safe to do that in this case as we test the merge bases.

The idea of marking git-gui and gitk histories that none of their 
commits is checked out: it erases all Git source code from the working 
directory, and a later bisection step places all code back and it 
requires a full build. Not a big deal with Git, but there are much 
larger code bases.

The current bisect behavior makes this idea unworkable. For me, it was a 
big step backwards when it was implemented. :-(

-- Hannes


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003D01F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 00:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeGDAMs (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 20:12:48 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35935 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeGDAMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 20:12:47 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id aVPUfERyvjlDzaVPVfP79n; Wed, 04 Jul 2018 01:12:45 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=z23upLkTAAAA:8 a=hR-PrDIbnsUMQAlOTYoA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=Dsv3lYUHObwL8zqxSzzR:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
 <20180703143416.GA23556@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
Date:   Wed, 4 Jul 2018 01:12:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703143416.GA23556@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOElSI6x1S8BVqSyhY59Yv5/802/6yPMwTLrEBODboYGi14e80FecoYVIqy3c1dlhoKToBAboRnGKcf4eQuIXG3qnatRrXffcprAbQFSUTp1/2G8rgjt
 +c9ZrwumFhGoTXadi3gqJpx6zM+MxNli4WfP1yFwYPnhZ1b5bxl4Einm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/07/18 15:34, Jeff King wrote:
> On Fri, Jun 29, 2018 at 02:10:59AM +0100, Ramsay Jones wrote:
> 
>> On 28/06/18 23:03, Jeff King wrote:
>>> On Thu, Jun 28, 2018 at 07:53:27PM +0100, Ramsay Jones wrote:
>> [snip]
>>> Yes, it can go in quickly. But I'd prefer not to keep it in the long
>>> term if it's literally doing nothing.
>>
>> Hmm, I don't think you can say its doing nothing!
>>
>>     "Yeah, this solution seems sensible. Given that we would
>>      never report any error for that blob, there is no point
>>      in even looking at it."
>>
>> ... is no less true, with or without additional patches! ;-)
> 
> True that we don't even bother doing the parsing with your patch. But I
> think I talked myself out of that part being a significant savings
> elsewhere.

[Sorry for the late reply - watching football again!]

I'm not interested in any savings - it would have to be a pretty
wacky repo for there to be much in the way of savings!

Simply, I have found (for many different reasons) that, if there
is no good reason to execute some code, it is _far_ better to not
do so! ;-)

> I guess it would be OK to leave it in. It just feels like it would be
> vestigial after the rest of the patches.
> 
[snip]

>>> Yes, it would include any syntax error. I also have a slight worry about
>>> that, but nobody seems to have screamed _yet_. :)
>>
>> Hmm, I don't think we can ignore this. :(
> 
> I'm not sure. This has been running on every push to GitHub for the past
> 6 weeks, and this is the first report. It's hard to say what that means,
> and technically speaking of course this _is_ a regression.

Hmm, are you concerned about old clients 'transmitting' the
bad data via large hosting sites? (New clients would complain
about a dodgy .gitmodules file, no matter were it came from,
right?)

Has the definition of the config file syntax changed recently?
If not, then old client versions will see the same syntax errors
as recently 'fixed' versions. So they should error out without
'looking' at the bad data, right? (ignoring the 'lets fix the
obvious syntax error' idea).

> There's a nearby thread of interest, too, which I cc'd you on:
> 
>   https://public-inbox.org/git/20180703070650.b3drk5a6kb4k4tnp@glandium.org/

Yeah, I don't quite follow what's going on there - I would have
to read up some more. ;-)

>> So, FWIW, Ack!
>>
>> [I still think my original patch, with the 'to_be_skipped'
>> function name changed to 'object_on_skiplist', should be
>> the first patch of the series!]
> 
> Thanks. If we're going to do any loosening, I think we may want to
> address that _first_, so it can go directly on top of the patches in
> v2.17.1 (because it's a bigger issue than the stray message, IMHO).

Agreed. I probably haven't given it sufficient thought, but my
immediate reaction is to loosen the check - I don't see how
this could be exploited to significantly reduce security. (My lack
of imagination has been noted several times in the past, however!)

Having said that, I am no security expert, so I will let those who
have security expertise decide what is best to do in this situation.

Thanks!

ATB,
Ramsay Jones





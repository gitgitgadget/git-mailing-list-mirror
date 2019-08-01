Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178AC1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfHAVwP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:52:15 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37759 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfHAVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:52:14 -0400
X-Originating-IP: 1.186.12.38
Received: from localhost.localdomain (unknown [1.186.12.38])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D45131C0005;
        Thu,  1 Aug 2019 21:52:11 +0000 (UTC)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
 <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet>
From:   Pratyush Yadav <me@yadavpratyush.com>
Message-ID: <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
Date:   Fri, 2 Aug 2019 03:22:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Junio

On 8/1/19 1:12 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 29 Jul 2019, Pratyush Yadav wrote:
> 
>> On 29/07/19 7:58 AM, Mark Levedahl wrote:
>>> On 7/28/19 6:49 PM, brian m. carlson wrote:> On 2019-07-28 at
>>> 22:10:29, Pratyush Yadav wrote:
>>>>> The function is not documented, and I only started spelunking
>>>>> the code a couple days back, so I'll try to answer with what I
>>>>> know. It might not be the full picture.
>>>>>
>>>>> Running git-gui --trace, these commands are executed during a rescan:
>>>>>
>>>>> /usr/lib/git-core/git-rev-parse --verify HEAD
>>>>> /usr/lib/git-core/git-update-index -q --unmerged --ignore-missing --refresh
>>>>>
>>>>
>>>> Great. This sounds like a well-reasoned change. I'll let other folks who
>>>> use git-gui more chime in to see what they think as well.
>>>>
>>>
>>> I'm assuming this does what is currently done by F5.
>>> A simple rescan from git-gui in the git repository takes about 8 seconds on
>>> my corporate laptop running Windows, making this happen on change of window
>>> focus is definitely not a friendly change from my view point.
>>>
>>
>> This is a Windows problem maybe? On my Linux machine with an almost dead hard
>> drive, it takes under 10ms to do a refresh on the git repository (which has
>> about 56,000 commits).
> 
> I would be _extremely_ cautious to base an argument on one particular
> setup, using on particular hardware with one particular OS and one
> particular repository.
> 

Agreed. That's why I asked for benchmarks from other people. 
Unfortunately, no one replied.

I am worried about exactly this problem that other users will have 
performance problems. I usually reserve judgment till I see some actual 
benchmarks, but since in this case we aren't getting any, it is probably 
better to err on the side of caution.

> When it comes to repositories that are worked on actively, git.git is
> not actually a representative example, it is way smaller than what users
> deal with.

Out of curiosity, what would you consider large enough? The Linux kernel 
(855,753 commits as of writing this)?

> 
> You might be one of those developers privileged enough to have a fast
> computer. Trying to extrapolate from such a vantage point does the rest
> of us Git users a big disservice.

Yes I have a pretty powerful machine in the processor department, but I 
have a rather slow hard disk. I assumed most people would have faster 
hard disks than me, but in hindsight, that might not be a good 
assumption to make.

> 
> At this point, I am gently inclined against the presented approach, in
> particular given that even context menus reportedly trigger the re-scan
> (which I suspect might actually be a Linux-only issue, as context menus
> are top-level windows on X11, at least if I remember correctly, and I
> also seem to remember that they are dependent windows on Aqua and Win32,
> just to add yet another argument against overfitting considerations onto
> a single, specific setup).

All right, the patch in its current state can't fly. So what is the 
correct way to do this? I see the following options:

1. Add this as an option that is disabled by default, but people who 
don't mind it can enable it. This is the easiest to implement. But I 
leave it to you and Junio (and anyone else who wants to pitch in :)) to 
decide if it is a good idea.

2. Watch all files for changes. Atom does this for their git gui [0]. We 
can probably use watchman [1] for this, but this adds another external 
dependency.

3. Leave this feature out. I of course don't like this option very much, 
and will probably have to run a fork, but if it is better for the 
project, it is better for the project.

Which option do you want to go with?

Naturally, my favourite option is number 1 because it will be the 
easiest to implement ;)

[0] 
https://discuss.atom.io/t/how-does-atom-refresh-git-state-when-some-external-editor-changes-it/67210
[1] https://github.com/facebook/watchman

-- 
Regards,
Pratyush Yadav

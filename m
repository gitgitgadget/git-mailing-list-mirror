Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DD01F731
	for <e@80x24.org>; Sun,  4 Aug 2019 12:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfHDMx1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 08:53:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45301 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfHDMx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 08:53:27 -0400
X-Originating-IP: 157.49.192.74
Received: from localhost.localdomain (unknown [157.49.192.74])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3E7901BF205;
        Sun,  4 Aug 2019 12:53:18 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
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
 <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1908021414530.46@tvgsbejvaqbjf.bet>
 <a68f09be-949f-b16b-a585-9ca2a1991a4f@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1908032225510.46@tvgsbejvaqbjf.bet>
Message-ID: <1489be05-ab18-a3e5-dd38-3d5729ebe67a@yadavpratyush.com>
Date:   Sun, 4 Aug 2019 18:23:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1908032225510.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/19 2:04 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 3 Aug 2019, Pratyush Yadav wrote:
> 
>> On 8/2/19 6:09 PM, Johannes Schindelin wrote:
>>>
>>> On Fri, 2 Aug 2019, Pratyush Yadav wrote:
>>>
>>>> On 8/1/19 1:12 AM, Johannes Schindelin wrote:
>>>>>
>>>>> I would be _extremely_ cautious to base an argument on one
>>>>> particular setup, using on particular hardware with one
>>>>> particular OS and one particular repository.
>>>>>
>>>>
>>>> Agreed. That's why I asked for benchmarks from other people.
>>>> Unfortunately, no one replied.
>>>
>>> What stops _you_ from performing more tests yourself? There are tons
>>> of real-world repositories out there, we even talk about options for
>>> large repositories to test with in Git for Windows' Contributing
>>> Guidelines:
>>> https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#performance-tests
>>
>> I thought the point was to not base all data off a single setup?
> 
> You misunderstood what I was saying: a single setup is bad, and you can
> make it moderately better by testing _at least_ with a moderately-sized
> repository [*1*] in addition to git.git.
> 
> So yes, it would still not be enough to test with, say, the git.git
> _and_ the Chromium repository _only_ on your setup, but if not even you
> can be bothered to test with more than one small repository, how can you
> possibly expect anybody else to add more testing?

All right, I'll see what repos I can test.

But my internet is pretty slow and unstable, so my clone of the Chromium 
repo failed mid-way multiple times. I assume we need to test on a large 
index, so is it all right if I use t/perf/repos/many-files.sh to 
artificially generate a large repo?

> 
>> [...]
>>> I wonder, however, whether you can think of a better method to
>>> figure out when to auto-refresh. Focus seems to be a low-hanging
>>> fruit, but as you noticed it is not very accurate. Maybe if you
>>> combine it with a timeout? Or maybe you can detect idle time in
>>> Tcl/Tk?
>>
>> Hm, I don't see a better alternative than file system watches.
>> Timeouts are a heuristic that can potentially be problematic.
> 
> Let me stress the fact that I suggested a timeout _in addition_ to the
> focus event?

Oh, my bad. I thought you suggested using timeouts exclusively.

But I'm not sure I understand what you mean by "using timeouts in 
addition to the focus event". My guess is that you mean we should 
activate a refresh-on-focus-in only after git-gui has been out of focus 
for a certain amount of time. Is my guess correct?

> 
> Yes, using a timeout on its own is stupidly problematic. That's why I
> did not suggest that.
> 
>> If you do a refresh too frequently, you hog up the user's resources
>> for little benefit.
> 
> Indeed. You want to find a heuristic that catches most of the cases
> where files were changed, while at the same time not even _trying_ to
> refresh automatically when probably nothing changed.

Like I said before, the best way of doing that that I can see is file 
system watches. But maybe we can get reasonable performance with a 
combination of timeouts and focus events.

> 
>> You don't refresh frequently enough, then sometimes the user sees an
>> updated view, sometimes a not-updated view. This inconsistency, if not
>> fine tuned properly, can prove detrimental to UX.
> 
> Right, exactly. And of course, since you are not changing your own Git
> fork only, but the Git that is the one that most users will use, you
> will have to consider carefully in which direction to strike the balance
> by default.

Yep, that's why I'm engaging you in this conversation :). I'm personally 
pretty happy with this change for my own use, but I'd like everyone 
enjoy it equally.

> 
> I would contend that you should err on the side of _not_ refreshing, as
> that would probably affect more users negatively than the opposite.
> 
> Ciao,
> Johannes
> 
> Footnote *1*: I don't expect you to test with the largest repositories,
> as you are unlikely to have access to anything approaching the size of
> the largest Git repository on the planet:
> https://devblogs.microsoft.com/bharry/the-largest-git-repo-on-the-planet/
> 

Ah yes, I read about it a while back on Reddit. Having a huge monolithic 
repo sounds backwards to me. Using submodules sounds like a better idea, 
but who am I to judge. They probably have their reasons that I'm not 
aware of.

-- 
Regards,
Pratyush Yadav

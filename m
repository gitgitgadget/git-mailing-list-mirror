Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C8C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E0723406
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhAGVti (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:49:38 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:11479 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbhAGVti (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:49:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4DBfxz6QX8z5tlB;
        Thu,  7 Jan 2021 22:48:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 79D6E4B5A;
        Thu,  7 Jan 2021 22:48:54 +0100 (CET)
Subject: Re: git gc ineffective
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <20201109092041.GV29778@kitsune.suse.cz>
 <87361ilv1a.fsf@igel.home> <20201109101738.GW29778@kitsune.suse.cz>
 <20201109104327.GX29778@kitsune.suse.cz> <87v9eekcd6.fsf@igel.home>
 <20210107183531.GB6564@kitsune.suse.cz>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <07798280-9818-0d21-5c63-dfc1c621082a@kdbg.org>
Date:   Thu, 7 Jan 2021 22:48:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107183531.GB6564@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.21 um 19:35 schrieb Michal Suchánek:
> Hello,
> 
> On Mon, Nov 09, 2020 at 12:17:57PM +0100, Andreas Schwab wrote:
>> On Nov 09 2020, Michal Suchánek wrote:
>>
>>> On Mon, Nov 09, 2020 at 11:17:38AM +0100, Michal Suchánek wrote:
>>>> On Mon, Nov 09, 2020 at 10:49:21AM +0100, Andreas Schwab wrote:
>>>>> On Nov 09 2020, Michal Suchánek wrote:
>>>>>
>>>>>> I noticed I am running out of disk space, and one repository taking up
>>>>>> about 38G. Did git gc --aggressive, and the used space *raised* to 42G,
>>>>>> and git would report it does gc after every commit.
>>>>>
>>>>> Do you have a lot of loose objects?
>>>> { for i in  .git/objects/?? ; do ls $i ; done ; } | wc -l
>>>> 53392
>>> And in the double-size repository it's doubled, too:
>>>  { for i in  .git/objects/?? ; do ls $i ; done ; } | wc -l
>>>  101167
>>
>> git count-objects also shows the size.
> $ git count-objects
> 59853 objects, 43249880 kilobytes
> $ du -hs .git
> 48G     .git
> $ git gc --aggressive
> Enumerating objects: 1825080, done.
> Counting objects: 100% (1825080/1825080), done.
> Delta compression using up to 4 threads
> Compressing objects: 100% (1803925/1803925), done.
> Writing objects: 100% (1825080/1825080), done.
> Total 1825080 (delta 1234005), reused 587969 (delta 0), pack-reused 0
> Removing duplicate objects: 100% (256/256), done.
> Checking connectivity: 2003814, done.
> Expanding reachable commits in commit graph: 337512, done.
> $ du -hs .git
> 172G    .git
> $ git count-objects
> 178734 objects, 175309572 kilobytes
> 
>> Does it help to prune them --exprire now?
> 
> $ git prune
> Checking connectivity: 1825478, done.
> $ du -hs .git
> 3.9G    .git
> $ git --version
> git version 2.26.2
> 
> So it is my wrong expectation that 'gc' comand removes garbage. It
> creates it en masse.
> 
> It just makes is in a way that the 'prune' command that really reoves
> garbage can now remove it.

It's an unfortunate default behavior of `git gc`. Set gc.pruneExpire to
'now' to countermand it, but watch out for the caveats.

See
https://stackoverflow.com/questions/55414916/how-to-avoid-that-git-gc-generates-garbage-loose-objects
for more details.

-- Hannes

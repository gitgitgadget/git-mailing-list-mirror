Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B781F516
	for <e@80x24.org>; Sun, 24 Jun 2018 10:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFXKHn (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 06:07:43 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:22411 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeFXKHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 06:07:42 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1fX1ve-0006Tv-Hx; Sun, 24 Jun 2018 12:07:30 +0200
Subject: Re: Unexpected ignorecase=false behavior on Windows
To:     Bryan Turner <bturner@atlassian.com>
Cc:     j6t@kdbg.org, Git Users <git@vger.kernel.org>
References: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
 <1c7e338e-157b-fd2f-5eb1-01373f627acd@kdbg.org>
 <2cf2d884-de1a-7b9b-5aca-1f396ad205a2@syntevo.com>
 <CAGyf7-GvcN8EhMgtaZcDJNYNdfLwVH8HVBDmZqJU40nze0NSEA@mail.gmail.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <c9a9167c-8528-c85a-e7aa-9197ab92e685@syntevo.com>
Date:   Sun, 24 Jun 2018 12:07:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGyf7-GvcN8EhMgtaZcDJNYNdfLwVH8HVBDmZqJU40nze0NSEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.06.2018 22:58, Bryan Turner wrote:
> On Fri, Jun 22, 2018 at 1:45 PM Marc Strapetz <marc.strapetz@syntevo.com> wrote:
>>
>> On 22.06.2018 19:36, Johannes Sixt wrote:
>>> Am 22.06.2018 um 14:04 schrieb Marc Strapetz:
>>>> On Windows, when creating following repository:
>>>>
>>>> $ git init
>>>> $ echo "1" > file.txt
>>>> $ git add .
>>>> $ git commit -m "initial import"
>>>> $ ren file.txt File.txt
>>>> $ git config core.ignorecase false
>>>
>>> This is a user error. core.ignorecase is *not* an instruction as in
>>> "hey, Git, do not ignore the case of file names". It is better regarded
>>> as an internal value, with which Git remembers how it should treat the
>>> names of files that it receives when it traverses the directories on the
>>> disk.
>>>
>>> Git could probe the file system capabilities each time it runs. But that
>>> would be wasteful. Hence, this probe happens only once when the
>>> repository is initialized, and the result is recorded in this
>>> configuration value. You should not change it.
>>
>> Sorry, it looks like my example was misleading. I'm actually questioning
>> current behavior in case of Windows repositories with core.ignorecase
>> initialized to false, like in following setup:
>>
>> $ git init
>> $ git config core.ignorecase false
>>
>> The repository is now set up to be case-sensitive on Windows. From this
>> point on, core.ignorecase won't change anymore and the repository will
>> be filled:
> 
> I don't think Hannes's point was _when_ you changed it; it was that
> you changed it _at all_.
> 
> Git on Windows is not designed to run with anything other than
> core.ignoreCase=true, and attempting to do so will cause unexpected
> behavior. In other words, it's not a behavior toggle so user's can
> request the functionality to work one way or the other; it's an
> implementation detail that `git init` and `git clone` set when a
> repository is created purely so they don't have to probe the file
> system each time you run a `git` command.
> 
> NTFS is case-preserving-but-case-insensitive by default[1]. So long as
> that's the case, the only mode for running Git on Windows is
> core.ignoreCase=true.
> 
> Hopefully this clarifies things!

Thanks, it does. In this case, I'd suggest to make this clear in the 
documentation, too. I've just sent a patch.

-Marc

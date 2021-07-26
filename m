Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667FFC432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D6B60F55
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhGZRlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:41:25 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:55276 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhGZRlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:41:25 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m85Ed-0007fS-Ey; Mon, 26 Jul 2021 19:21:52 +0100
Subject: Re: Files modified, even after: git reset --hard
To:     Martin <git@mfriebe.de>, Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
 <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
 <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
 <f454bf5b-c5ff-4140-02a8-b02dcd35c6b9@mfriebe.de>
 <5ca837f6-44dd-2b43-32dc-e1e134d18d61@mfriebe.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <67a3c7d0-a199-da8d-09f5-1ff25c0d24ae@iee.email>
Date:   Mon, 26 Jul 2021 19:21:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5ca837f6-44dd-2b43-32dc-e1e134d18d61@mfriebe.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/2021 14:57, Martin wrote:
> On 26/07/2021 12:31, Martin wrote:
>> On 26/07/2021 04:59, Chris Torek wrote:
>>> On Sun, Jul 25, 2021 at 6:34 PM Martin <git@mfriebe.de> wrote:
>>>> Actually there is something else.
>>>>
>>>> If a file has line-endings that will change, then
>>>>      git add --renormalize .
>>>>      git commit -m foo
>>>> will commit those files.
>>>>
>>>> But I am now also getting files, that show modified, but that can
>>>> not be
>>>> committed renormalized (0 lines changed).
>>>
>>> I believe (but can't demonstrate) that this is a temporary condition.
>>
>> I now found one, that does not seem temporary at all...
>>
>> git remote -v
>> origin  git://sourceware.org/git/binutils-gdb.git (fetch)
>> origin  git://sourceware.org/git/binutils-gdb.git (push)
>>
>> Switching to a far away commit
>> git switch -f --detach master
>> git rev-list master | wc -l
>> 93917
>>
>> git status shows no modified files
>>
>>
>> Then switching to  (this is on master branch)
>> git switch -f --detach a362ee23634
>> git rev-list a362ee23634 | wc -l
>> 4164
>>
>> git status --porcelain=v2
>> 1 .M N... 100644 100644 100644
>> 9e677a52ae690808165993a0f3f17ac49e3969df
>> 9e677a52ae690808165993a0f3f17ac49e3969df bfd/Makefile.dos
>> 1 .M N... 100644 100644 100644
>> ff24f19c0b6e0c7fb713c79e8f1765bc22fe7adc
>> ff24f19c0b6e0c7fb713c79e8f1765bc22fe7adc binutils/Makefile.dos
>> 1 .M N... 100644 100644 100644
>> 1d9541c2f896842d1bafe68ccf0a51e291d66688
>> 1d9541c2f896842d1bafe68ccf0a51e291d66688 gas/Makefile.dos
>> 1 .M N... 100644 100644 100644
>> 57fab985680ea151379069abe414bcb590cdd743
>> 57fab985680ea151379069abe414bcb590cdd743 ld/Makefile.dos
>
> This seems an issue with gitforwindows.

I doubt that it is Git-for-Windows (the .exe), but could easily believe
that the whole scenario is predicated on the Windows line endings and
personal .gitconfigs (some of which may be GfW norms) and the
repository's upstream norms (such as what is committed in the repo).

Given the repos/remotes listed your email in
https://public-inbox.org/git/f454bf5b-c5ff-4140-02a8-b02dcd35c6b9@mfriebe.de/,
What are all your differing configs between Windows & Linux testing and
their location (i.e. use ` git config --list --show-origin --show-scope`).

The comparison you suggest, I believe, is between
master:1b348b6b67dcdc120f5ac9dc409142b8ec2b4a09 (17 Apr 2021) and the
detached https://github.com/User4martin/binutils-gdb/commit/a362ee23634
"recording file death" (8 Dec 1992) (is that the commit you really
wanted to detach and compare with?)

The Github compare wasn't helpful as there are too many changes
[https://github.com/red-prig/binutils-gdb/compare/1b348b6..a362ee23634]

Just thinking about an MVCE.
>
> I checked on 2 linux distros (git 2.25 and 2.31.1) and both are fine.
>
> On Windows I set
> core.autocrlf false
> core.fscache false
>
> Made a new clone, some (applied config as above), issue still present.
>
> Tested with gitforwindow 2.32, 2.31.1 and 2.30.2
>
Philip

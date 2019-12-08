Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E4C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 15:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665120692
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 15:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLHPFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 10:05:46 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:33211 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLHPFp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 10:05:45 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1idy80-0007gw-7b; Sun, 08 Dec 2019 15:05:44 +0000
Subject: Re: How to determine age of HEAD commit
To:     Roger Gammans <rgammans@gammascience.co.uk>,
        Git List <git@vger.kernel.org>
References: <956e2efe-3426-f61e-7686-5416b51931b9@iee.email>
 <0a578dce37e8802b2022df80c336f61a264a33e3.camel@gammascience.co.uk>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <74d4a783-6196-08ce-b600-2eb2cacecac7@iee.email>
Date:   Sun, 8 Dec 2019 15:05:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <0a578dce37e8802b2022df80c336f61a264a33e3.camel@gammascience.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Roger,

On 08/12/2019 14:07, Roger Gammans wrote:
> On Sun, 2019-12-08 at 12:09 +0000, Philip Oakley wrote:
>> Is there a command that does return the numeric agedness of a commit
>> (e.g. now - commit_date, in seconds)?
> Hi
>
> I don't know a specific command for the age. But `git cat-file commit
> HEAD`, will give you the commit's timestamps in seconds from the the
> epoch. (Plus some timezone info).
>
> I can construct a bash script, shown below (warning: only had the most
> rudimentary testing), which turns that into an age. For your use case
> you might be better getting yesterdays unix-timestamp from date, if GNU
> date is available, and directly comparing it to the commit timestamp.
>
> ------
> #!/bin/bash
>
> now=$(date +"%s")
> commit=$(git cat-file commit HEAD | grep committer)
> commit=${commit##*>}
> commit=${commit%%+*}
> echo $(( $now-$commit ))
> #--------------
>
Thanks,
That has spurred me into looking at a few other ideas.
Unfortunately the script needs to run inside a DOS batch file as part of 
a Visual Studio pre-build step, hence the desire for a direct command.

That said I have now found, with a bit of rooting around, that

    `git log -1 --format=format:"%ct" HEAD`

does appear to give the right form of answer. Just need to see if I can 
fit it into the DOS pre-build script now ;-)
There may be extra tweaks needed.. (a merged pull has the pull date, but 
a fast forward pull has the original date)

Philip

Philip

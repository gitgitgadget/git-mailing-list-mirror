Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25551F424
	for <e@80x24.org>; Mon, 16 Apr 2018 09:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeDPJsX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 05:48:23 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:32991 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeDPJsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 05:48:20 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 80kDfMgntHCow80kDf8Dt4; Mon, 16 Apr 2018 10:48:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523872098;
        bh=9D+FLxVItxmzodjUKFCIQFUZhZluxd6h2uCQWBG1uQs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=da3/8NSxPXl8GCebezz046hnBqKbauvxYtGhw89aEWrMhWOY90y65ah6VLyjFVP4k
         FzHzKAMtGTkMYKm6m84Nl18odqQjngKNZu8WNeZJ9Bc9Y2wZvF08JsEBv/DIap+KxT
         y/kbHmCXj3Wap2Zcb+Fdf97mdUxw3i3+1jeJh+kk=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=SfXZiMZu c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=jN-XDxcjDrzCXfyQG4IA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
 <f56b84fa-9286-3a7b-fc5b-2307c9ff5b5e@philandanna.no-ip.org>
 <nycvar.QRO.7.76.6.1804141444060.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ba17074b-865e-32ba-908d-0d94bedc50ad@talktalk.net>
Date:   Mon, 16 Apr 2018 10:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804141444060.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFSULuO07+6j4x/k1t49DKU8bMnApWjHNxeFQYV2eut1h9dlqQnV50T3yC9oarLzG3xm7B4l06QH6aM7wNoaZz3SIYZBBIwkGB8jRJsYfUFrKQr3fpiH
 OxOHtP8CGeWzDX+LAv8D957Smer+lKp1/FHIDy73ezgqUwfp4QuwV6Ecb4C78oZq0gTzpZhhZoNrTSrnpHwiFefGI1PdCQhcIETrbwYLcXwmPHZM+b2iJsYp
 jDk9GkdbpaXJtr5/HCMajmX2a+t/qC9Ojvwlt5UrB4yg8tpFEs9i/eok4rG/s4Xw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/04/18 14:11, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 14 Apr 2018, Phillip Wood wrote:
> 
>> On 13/04/18 17:52, Johannes Sixt wrote:
>>>
>>> I just noticed that all commits in a 70-commit branch have the same
>>> committer timestamp. This is very unusual on Windows, where rebase -i of
>>> such a long branch takes more than one second (but not more than 3 or
>>> so thanks to the builtin nature of the command!).
>>>
>>> And, in fact, if you mark some commits with 'reword' to delay the quick
>>> processing of the patches, then the reworded commits have later time
>>> stamps, but subsequent not reworded commits receive the earlier time
>>> stamp. This is clearly not intended.
>>
>> Oh dear, I think this is probably due to my series making rebase commit
>> in-process when the commit message isn't being edited. I didn't realize
>> that git cached the commit date rather than using the current time when
>> calling commit_tree_extended(). I'll take a look at it next week.
> 
> Thanks.
> 
> However, a quick lock at `git log @{u}.. --format=%ct` in my
> `sequencer-shears` branch thicket (which I rebase frequently on top of
> upstream's `master` using the last known-good `rebase-merges` sub-branch)
> shows that the commits have different-enough commit timestamps. (It is
> satisfying to see that multiple commits were made during the same second,
> of course.)
> 
> So while I cannot find anything in the code that disagrees with Hannes'
> assessment, it looks on the surface as if I did not encounter the bug
> here.
> 
> Curious.

That's strange (I'd have expected the picks after recreated merges to
have the earlier timestamps than the merge), if I do 'git rebase -i
--force-rebase --exec="sleep 2" @~5' then all the new commits have the
same timestamp.

> FWIW I agree with Hannes' patch.
> 
>> I think 'git am' probably gives all patches the same commit time as well
>> if the commit date is cached though it wont suffer from the time-travel
>> problem.
> 
> I thought that `git am` was the subject of such a complaint recently, but
> I thought that had been resolved? Apparently I misremember...

I had a quick look and couldn't see anything about that, it looks to me
like it just calls commit_tree() and only does anything to change the
default commit date if '--committer-date-is-author-date' was given.

Best Wishes

Phillip
> Ciao,
> Dscho
> 


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6391F403
	for <e@80x24.org>; Tue, 12 Jun 2018 09:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933110AbeFLJxo (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 05:53:44 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:46950 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbeFLJxn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 05:53:43 -0400
Received: from [192.168.2.201] ([92.22.39.132])
        by smtp.talktalk.net with SMTP
        id SfzhfzNlLwhzSSfzhfj6ya; Tue, 12 Jun 2018 10:53:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528797222;
        bh=9quP1qRRA9PwT6aNWDHmPyk4zOzEmnudOB9NwV75+Rs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ntnQlthclpN37RmU0Uy3rJPgXW5LvfrIuP7HAnula5Q+eS8Qibd9/qnwEwynIuKcI
         OJ+cUOmeKuwmuS3wWI0eRfqX2K9hBVt4B4SdLtBSmqaUnRjs/olFr9j1JwN4nDHmtW
         nw1u4Q9MPatKv+c1ec6wUgMiZk3ehkpu9C75HD4A=
X-Originating-IP: [92.22.39.132]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=AATg4WxWBR3MjRzlB3y0Ow==:117
 a=AATg4WxWBR3MjRzlB3y0Ow==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=FuBv-MbV3LvX8plPUI4A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-rebase.sh: handle keep-empty like all other options
To:     Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050747.19726-1-newren@gmail.com>
 <8f19c8c2-d050-2d51-756d-d78b9f2bd335@talktalk.net>
 <CABPp-BF7POrGTRbVOZ-AGjRHKcpExMQcA4uSPvrRONbnG2CE8w@mail.gmail.com>
 <7e3d71e6-ae97-f47b-382c-085f6a281792@talktalk.net>
 <CABPp-BEuZDHDAxixrUUXyzbpBXoVfWhfdJR1g9eFN9MSAMjh_Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <c0e55982-0d75-0efe-4976-f48cb4bf5779@talktalk.net>
Date:   Tue, 12 Jun 2018 10:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEuZDHDAxixrUUXyzbpBXoVfWhfdJR1g9eFN9MSAMjh_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD1tAbiif0xTJshVm2jltvo4GmKZsbbGm9m6i07fxyfVk68bewsH88C4ugEQFbESRbV/U0XRzTMD1Ml8iLiO6N6buqarR5BewPB9zHEbySmJLS61KHh+
 KPC138DJPB5MQs1teidXQkWEbzvLOj2mc4u0BHDmaKXxeFQ45yUcSv/FLkdov7xq7c1Y+LsFbjf3IW66bMgVamz5RrXXbH9rCdVbDoO91wDaLm29HPAVPLo5
 ds0Oj4Q+jJqmkZrBVIiFZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/18 17:08, Elijah Newren wrote:
> Hi Phillip,
> 
> On Mon, Jun 11, 2018 at 8:16 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> On 11/06/18 15:42, Elijah Newren wrote:
> 
>>> However, we have a bigger problem with empty commits, in that there
>>> are really three modes rather than two:
>>>    * Automatically drop empty commits (default for am-based rebase)
>>>    * Automatically keep empty commits (as done with --keep-empty)
>>>    * Halt the rebase and tell the user how to specify if they want to
>>> keep it (default for interactive rebases)
>>>
>>> Currently, only the first option is available to am-based rebases, and
>>> only the second two options are available to interactive-based
>>> rebases.
>>
>>
>> I'm not sure that's the case, my understanding is that for an interactive
>> rebase unless you give '--keep-empty' then any empty commits will be
>> commented out in the todo list and therefore dropped unless they're
>> uncommented when editing the list.
> 
> Ah, yes, you are right; I was implicitly thinking about cases where
> the commit became empty rather than when the commit started
> empty...and mis-read --keep-empty (which as I learned now is only for
> started-empty cases).
> 
>> The third case happens when a commit
>> becomes empty when it's rebased (i.e. the original commit is not empty), I'm
>> not sure what the am backend does for this.
> 
> The am backend does not halt the rebase; it simply drops the commit
> and says "No changes -- Patch already applied."
> 
> It has always seemed jarring and confusing to me that one rebase mode
> stops and asks the user what to do and the other assumes.  I think
> both should have the same default (and have options to pick the
> alternate behavior).
> 
> I'm less certain what the default should be, though.

I'm not really sure either, on the one hand most of the time it is
convenient for rebase just to skip over it, on the other if you have
some important information in the commit message or a note then maybe
you want rebase to stop so you can selvage that information.

> 
>> cherry-pick has
>> '--keep-redundant-commits' for this case but that has never been added to
>> rebase.

On path forwards is to always stop, and implement
--keep-redundant-commits for rebase. That would be very easy for
interactive rebases as it shares the same code as cherry-pick. I've just
had a quick look at builtin/am.c and I think it would be fairly
straightforward to add some code to check if it's rebasing and stop if
the patch is already applied.

Best Wishes

Phillip

> Thanks for the pointer.
> 


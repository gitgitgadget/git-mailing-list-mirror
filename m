Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E222C3F2CF
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B099246A2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 08:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1IYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:24:47 -0500
Received: from mx1.uni-regensburg.de ([194.94.157.146]:39632 "EHLO
        mx1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgB1IYr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 03:24:47 -0500
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 3154D600004E
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 09:24:43 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id 0FEE86000048
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 09:24:43 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 28 Feb 2020 09:24:42 +0100
Message-Id: <5E58CE48020000A10003744D@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.2.0 
Date:   Fri, 28 Feb 2020 09:24:40 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: [EXT] Re: Q: submodules and detached HEAD
References: <5E578F2A020000A1000373EF@gwsmtp.uni-regensburg.de><5E578F2A020000A1000373EF@gwsmtp.uni-regensburg.de>
 (Ulrich Windl's message of "Thu, 27 Feb 2020 10:43:06 +0100")
 <23314_1582823592_5E57F8A7_23314_1178_1_xmqqsgiweyxs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <23314_1582823592_5E57F8A7_23314_1178_1_xmqqsgiweyxs.fsf@gitster-ct.c.googlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Junio C Hamano <gitster@pobox.com> schrieb am 27.02.2020 um 18:13 in
Nachricht
<23314_1582823592_5E57F8A7_23314_1178_1_xmqqsgiweyxs.fsf@gitster-ct.c.googlers.c

m>:
> "Ulrich Windl" <Ulrich.Windl@rz.uni‑regensburg.de> writes:
> 
>> I'm rather new to submodules, and I have a question on something I don't 
> understand (git‑2.12.3 from SLES12):
>> I had checked out tag v0.0.1 of my submodule.
>> When checking the status, I see:
>>
>> iptables> git status
>> HEAD detached at v0.0.1
>> nothing to commit, working tree clean
>> iptables> git checkout v0.0.1
>> HEAD is now at b23fbdc... .version: 0.0.1
> 
> I do not see anything special about "submodule" in the above.
> Assuming that v0.0.1 is a tag (i.e. refs/tags/v0.0.1 points at a
> commit whose object name is b23fbdc...), what we see in the above
> is quite expected.
> 
>> iptables> git checkout v0.0.2
>> Previous HEAD position was b23fbdc... .version: 0.0.1
>> HEAD is now at 5af0df5... v0.0.2: Fix issue with "xtables lock"
>> /iptables> git status
>> HEAD detached at v0.0.2
>> nothing to commit, working tree clean
>> iptables> git branch
>> * (HEAD detached at v0.0.2)
>>   master
> 
> So is the above, under the assumption that v0.0.2 is a tag and not a
> branch.  When you give a commit to "git checkout <what‑to‑checkout>"
> instead of giving it a branch name, the HEAD points directly at the
> given commit and the state is called "detached HEAD".
> 
> I do not quite get what the question is.  What was the end‑user
> expectation and how is the actual behaviour different from it?

Well the idea of checking out a tag instead of a branch is that the submodule
version is well-defined (assuming the tag won't be moved). Using a branch
however, I suspect that pushing to the branch vie routes outside the repository
using the submodule might cause some unwanted changes to the submodule.

Independent from that it seems that submodules always create a new branch
(this the detached head). I always felt when I see a "detached head" I've done
something fundamentally wrong.  Maybe the docs should point out more clearly if
it's part of the concept.

           checkout
               the commit recorded in the superproject will be checked out in
               the submodule on a detached HEAD.

Maybe add some explanation what this actually means.  Maybe clarify the
concept in DESCRIPTION.

I was following some instruction to add and update a submodule, and I thought
something went wrong (or the instructions were no longer up-to-date).


> 
> 
>> git reflog says:
>> 5af0df5 HEAD@{0}: checkout: moving from 
> b23fbdc0e18e570a4d9ec4cb8826afc82e2e0b64 to v0.0.2
>> b23fbdc HEAD@{1}: checkout: moving from 
> ec7dd70b59e039b49bb478a3134b713a2b0a279c to v0.0.1
>> ec7dd70 HEAD@{2}: checkout: moving from master to v0.0
>>
>> Config submodule.iptables.branch is not set.
>>
>> Who can explain?
> 
> Not me, especially without  knowing what to explain.  Everything I
> saw so far is expected.

So it seems to be a variation of expectation ;-)

Regards,
Ulrich



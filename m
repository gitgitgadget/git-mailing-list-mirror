Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638BBC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 21:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199CD20733
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 21:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgC3VxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:53:14 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17334 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgC3VxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 17:53:14 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jJ2LE-00035g-6F; Mon, 30 Mar 2020 22:53:09 +0100
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <0eef4721-1646-48f2-1102-71159d06b049@iee.email>
 <20200330181812.GB9199@SDF.ORG>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8f6fb826-7f9f-57ea-725f-dc3c512a4b18@iee.email>
Date:   Mon, 30 Mar 2020 22:53:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330181812.GB9199@SDF.ORG>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi George,

I wasn't suggesting that there already exists a complete solution...

On 30/03/2020 19:18, George Spelvin wrote:
> On Mon, Mar 30, 2020 at 03:01:28PM +0100, Philip Oakley wrote:
>> Perhaps we can go the other way on this one.
>>
>> I'd agree that attempting to nest (misunderstood mistaken) rebases is
>> digging a too deep hole that we'd not get out of. However we do have
>> other rebases available, specifically the "rebasing merges"
>> https://git-scm.com/docs/git-rebase#_rebasing_merges.

I was mainly saying that folks like their "all on one page, flow chart
sequence planning", and that we already have something close to that
that could be extended.  
>>
>> I know rebasing merges is way down the man page, but it has all the
>> power and flexibility needed _if_ we can step across from the mistaken
>> rebase step (we are at the command prompt aren't we?) into the rebasing
>> merge mode.
>>
>> This will require a little bit of expansion of the insn (instruction)
>> sheet so as to _include commented lines of the rebase steps completed_
>> so far, along with the labels, resets, merges, etc, so that the user can
>> _see_ where they they are within their failed progress (along with a
>> title line telling them their initial command and that they are now on a
>> rebasing merge insn;-).
>>
>> From there they can update the insn to reset back to the correct point,
>> redo the correct picks, and then get back to their remaining rebase steps.
>>
>> It's a thought anyway.
> I'm confused.  *How* does --rebase-merge mode help?  You're saying
> "hey, if we use this, it solves the issue" but I don't see how to
> pound this nail with that screwdriver.
Remember that rebasing is just a variant of creating and building a new
branch in our WORM (Write once Read many) repo..
So it is "just" a case of taking the partially complete rebase, and
re-working it, just like you can with an arbitrary merging rebase.
>
> I don't see how creating a branching history helps, and I don't see how to 
> use the reset/label/merge commands to do anything but create a branching 
> history.

It is more that we could create a full instruction sheet that spans time
from the start of the rebase (including labelling and resetting to get
started), upto and including the current state (so you can pick from
your new commits[*]), with those history steps being hash "#" commented,
as well as the remaining rebase instructions.
> I suppose it is possible to use the "reset" command in isolation
> to describe the jump to a new base.  So you could have a history of:
>
> # Command already executed:
#git rebase <command options> (for reference & immediate use)
> # reset base
> # pick A
> # pick B
> # pick C
> # label rebase-1  User asked for a nested rebase
> # reset A'
[*] We are missing a list of the current state of new commits,
# reset base (done, see above)
# placed A' (you'll need this listed if you need to pick/edit/reword
#  You are now at deadbeef, rebasing 23 of 75 commits .... (..suitable
status message)


> # Commands pending:
> pick B'
> pick C'
> # rebase-2 complete, resume rebase-1
> pick D
> pick E
>
> Is that what you were getting at?

Correct. Given the global state problem, and the mental picture issues,
let's give the user a full picture, flow chart style (it's a solid old
technique that works well, even for beginners)
>
> I was thinking of it being implicit, but it might be nice for the initial
> "reset" in each rebase to be explicit, *and not yet executed during
> the initial todo edit*.
>
> That makes it really clear that deleting the todo list entirely
> results in no change to the tree. (folks rarely notice omissions, we'll still need to tell them that it's a valid solution! sometimes empty means 'no change, carry on what you were doing';-)

Philip

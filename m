Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF4C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 08:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4D86141C
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 08:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhF3Iwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:52:43 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.101]:57394 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhF3Iwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 04:52:42 -0400
Received: from [79.233.231.178] (helo=[192.168.2.202])
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lyVug-0005By-3s; Wed, 30 Jun 2021 10:49:42 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
From:   Martin <git@mfriebe.de>
Message-ID: <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
Date:   Wed, 30 Jun 2021 10:50:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmw4uwh2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/06/2021 00:39, Junio C Hamano wrote:
> Martin <git@mfriebe.de> writes:
>
>> My text may indeed have lacked clarity. I was trying to emphasize to
>> hard, that this
>> command's "force" enables 2 actions that may both not be
>> wanted. Usually if one applies
>> "force" to a command only one such action is expected, or at least I
>> would only expect the one.
> Oh, I do agree wholeheartedly if two things are forced at the same
> time, things can become confusing.
>
> But the thing is, there are no such "two things are forced at once"
> in this case.  That is why I emphasized, in my response to you, that
> "switch -C <newbranch>" does not touch working tree, so "ok, the
> switch stops because it requires some working tree files with
> changes clobbered, and I can force it to make it happen" is not
> involved.  If it were, then it becomes fuzzy if --force is allowing
> an existing branch getting overwritten, or allowing a modification
> in a working tree file getting discarded, or both.
Well, yes and no. IMHO.

 From what I have seen, there are main 2 cases people use -C.

1) By accident, meaning to do something else. Most often meaning to do a 
rebase.
I.e. some one who is new, desperately to fix "branch has diverged".
For this, those people need to be made aware that -C does not move the 
commits.

2) Intentional, when the branch to be re-created points to a commit, 
which is hold
  by further branches. So no commit becomes unreachable.
In that case it is not a documentation issue. It is a, how can I enable 
the re-create,
but have git warn me, if I somehow misjudged the situation and on other 
branch
has the commit. That is, when I see this as 2 individually actions, out 
of which I want
to allow only one. Anyway that is not documentation, and I did sent 
another mail.

And yes, for the documentation, it *should* be clear that, removing a 
branch, removes the
commits on it.
But then it must be said, that the branch is first removed. That is not 
currently the case.
I proposed an alternate text to that nature in my last mail.

For the rest, it is a matter of opinion.
When I think a new user may read this, I believe such consequential 
implications should
be mention rather explicit.
But, if your view (the view of the git team is) a new user should have 
read up far enough
to be fully aware of those consequence, then so be it.

As per my previous mail, then maybe
       Force creating a branch, means that an existing branch of the 
same name is removed.
      A new branch is created at the specified <start point>. The 
new branch will not
      necessarily have all the commits that the existing branch used to 
have.

But without
      It therefore also means that commits from the old existing branch 
may be no longer reachable.

>> The actions being, giving up the link to the commit that is the tip of
>> the branch; and
>> making commits unreachable.  (for an expert in git tightly linked
>> together, but not for everyone)
> Sorry, I do not quite see how the removing the reference to a commit
> (i.e. the commit C that used to be pointed at by the branch would no
> longer be pointed at by that branch---that is by definition what
> moving the branch to point at a different commit means) and the
> commit becoming not reachable from the reference (i.e. such a commit
> C may not be reachable from the branch---unless the new commit it
> points at happens to be a descendant of C) are not one and the same
> thing.  I do not think there is distinction between expert vs
> everyone else involved here at all.
>
> Can you give an example where one of the two holds while the other
> one does not?
>
Well, if one creates a new feature branch, and instead of forking of 
master, one forks of some
random other branch. Then one can immediately re-create it at the 
original intended
branch point. No commits on the branch, none lost.
But teach that to a newbie, and they may have committed to the branch, 
before they
realize they forked at the wrong point. If the then do -C those commit 
will be gone. (well, yes the reflog).

Personally (that may not be a common pattern), I have used two branches 
for one feature
branch. One that holds the tip, and represents my local work.
One that I move forward and backward on the branch, to run tests, and 
decide what
I already want to push. Forward could be done by ff-merge, but backward 
not (it's reset, or switch -C).

---------
About your comment on changes in the worktree.
In none of my examples do I have any changes in my worktree.

I know that when I just try to switch a branch, git switch will refuse 
to overwrite my changes.
The doc for the -C section does not say if it will.
That is something I actually would still need to check, and if -C in 
addition to forcing the branch,
and consequently but only in some cases "making commits unreachable", 
does also
overwrite working dir changes that would be yet one more "forced" action.
That again not everyone may automatically be aware off.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444231F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 11:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfAOLQK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 06:16:10 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:11338 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfAOLQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 06:16:09 -0500
Received: from [192.168.2.201] ([92.28.143.98])
        by smtp.talktalk.net with SMTP
        id jMhQgEFEQdJAejMhRgyhfe; Tue, 15 Jan 2019 11:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547550966;
        bh=LfB+SII69dxDyLQC3yNAZE+TXG39PYiMLpGeDewNfac=;
        h=From:Subject:Reply-To:To:Cc:References:Date:In-Reply-To;
        b=oWNH6XfL8HxRY/eAu51vlQb0j5GilBwxc7yQm6PeL3cuws8Sc/TOVAmU+wjN6dW+I
         PcT9KhuJYHM0pgMqxRStKmMAKQ35fiFi3deTZa5Sh1lDSaoR9yK5ir2GWq/owFsyy9
         +uyUktNljAKpyM85uRcebxz2OIhG0WzTyrvVnqpA=
X-Originating-IP: [92.28.143.98]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=j7EZ+OPOvdswaUU3zPu4lA==:117
 a=j7EZ+OPOvdswaUU3zPu4lA==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=f8DeDPbQAAAA:8 a=1XWaLZrsAAAA:8 a=a2yu3S4znvnwW3wFOb0A:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=M1RoGzeAcGpUMdiviPwY:22
From:   Phillip Wood <phillip.wood@talktalk.net>
Subject: [PATCH] technical doc: add a design doc for the evolve command
Reply-To: phillip.wood@dunelm.org.uk
To:     Stefan Xenos <sxenos@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
References: <20181115005546.212538-1-sxenos@google.com>
 <a4c5d89c-cf82-6b1d-2690-82c7f8a95cc4@talktalk.net>
 <CAPL8ZivzMR30bt62SzOnmwmMnVZdMSiYSUhRSTg6uxyQUGcHLw@mail.gmail.com>
Message-ID: <c713efbf-10b3-b11e-5bde-344d767cbe09@talktalk.net>
Date:   Tue, 15 Jan 2019 11:16:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPL8ZivzMR30bt62SzOnmwmMnVZdMSiYSUhRSTg6uxyQUGcHLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDzatgSk06alzL1WUr4fANN645Od7z76bMkIhZX7+cNKu6it2Vi6/bBXfs2jle1dfSkOc/DTQDZ1T1oWuKwAV6P0po5JkEmqYuBnsj/udY6g0VZE7xxA
 VwjWVq+WwZK7daZdEymbdh0dgB8TOuh9ctec3pXNF7Z/1CUbXyHNRVHAroihg3FC51UDo3dVR2aY8l2ztHBqLVYKAqyY2Agz6e8wc4WZbgKF/L0kcRI5uvNP
 Das3q7O3zWjCQ0y/4UZDnUVTux7HuvseyqAe6/y2v1nvZ3XMu1UTDL1am4CsPsykc+yJ3EfY4YcTLmjW2jR6hP2u+02PQvZbvP9fVydxZ1ZXpGd2Ap7pwq8n
 iaAPh0HqfLWKPsTNmzzlUv02Zpd5294C/6zgdFc4luvIWoW/sZ7q8i50DRHERjlDa4ndjQKrS2GdWX+A1ZrCRLGY0V/JEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

Sorry for the delay in replying to your message, Christmas and the New
Year got in the way.

On 20/11/2018 20:19, Stefan Xenos wrote:
>> This explains why we have 'origin' fields in the meta commits, it might
>> be worth putting a forward reference or note earlier on to explain why
>> recording the origin is useful. (I didn't find gerrit needs it very
>> convincing on its own but it is actually more general than gerrit's
>> specific use case)
> 
> I'll add the forward reference.
> 
> TBH, gerrit is the main reason I added it - so I'm interested in why
> you didn't find the gerrit use-case convincing. Can you elaborate? (If
> there's some other way around the gerrit requirement, we might not
> need the origin parents)

As someone who does not use gerrit, it felt that the origin was just
being added to enable gerrit to remove change-id tags, it wasn't
immediately clear what the benefit to git was. I think being able to
evolve cherry-picks is a useful feature in its own right.

> 
>> Should this be meta/mychange:refs/for/master or have I missed something?
> 
> It should be metas/mychange/.... It's already fixed in the v2 patch.
> 
> I really wanted to use the namespace "changes", but gerrit is
> squatting on that. I tried "change", but that brakes the plural naming
> scheme and may get confused with gerrit's namespace, so I settled on
> "metas".

It's a shame "changes" is taken that would have been a good match.

>> I think it would make sense to have this next to the sections on commit
>> --amend and merge I was wondering what about rebase when I was reading
>> those sections.
> 
> Will do.
> 
>> I'm a bit confused why it is creating a meta ref per commit rather than
>> one for the current branch.
> 
> I tried to explain that later in the doc. meta refs serve two purposes
> - they act as stable names for changes (or at least the commits at the
> head of each change)

I think this is interesting, one thing I've thought might be useful but
never got round to experimenting with is names for commits so it is easy
to refer to them when creating fixups or rebasing.

> and they point to the metacommits that are
> currently in use. For both purposes, we need a ref per commit. For the
> "stable name" case, this should be obvious - something that just
> points to a branch couldn't provide different names for each commit on
> that branch. The metacommit case is less obvious - the set of
> metacommits for one change aren't connected to the metacommits for any
> other change. The "parents" of a metacommit are older versions of the
> same change. They don't point to the metacommits from the parent
> change. That means that there is no single ref we could create for a
> branch that would reach all the necessary metacommits.

Thanks for the explanation. So to push the evolution of a branch we have
to push a bunch of refs rather than just one and branches with many
commits will create many refs. I do wonder how well this scales in the
absence of something like reftable[1]. If the metacommits are only kept
around for things that are being actively worked on then hopefully there
shouldn't be any problems for individual developers, I'm not sure about
servers that are used by lots of different groups of developers all with
their own metacommits though. Is there a name spacing problem there if
two developers pushing to the same remote have commits with the same
names? (When I was thinking about the named commits above I had
envisaged them being prefixed with a branch name and for ease of use an
unqualified name would resolve to that name on the current branch.)

[1]
https://public-inbox.org/git/CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com/

>> I got the impression they had put quite a lot of effort
>> into having evolve automatically run and resolve divergences when
>> pulling and rebasing, is there a long term plan for git to do the same?
> 
> IMO, we should add anything to the plan if doing so improves the
> workflow of our users... but it sounds like you're referring to
> mercurial features I've never used. Could you point me to specific
> docs on the feature you want and/or make a concrete suggestion about
> how it might work?

There are some comments on the wiki page[2], there is a link at the
bottom to some more info for rebase but I only glanced at that.
Unfortunately the talk I watched which is linked to from another wiki
page[3] seems to have been taken down.

I think rebase automatically dropping commits that have been dropped
upstream when pulling and rebasing could be useful - I think your latest
draft[4] included support for that with the 'abandoned' parent-type.

[2]
https://www.mercurial-scm.org/wiki/ChangesetEvolutionDevel#Using_Obsolescence_Marker_during_Rebase

[3] https://www.mercurial-scm.org/wiki/ChangesetEvolution

[4] https://public-inbox.org/git/20181218164612.233602-1-sxenos@google.com/

> I never use pull so it slipped my mind. It would probably make sense
> to have the option of doing an automatic evolve after pull (actually,
> once the feature is stable, most users would probably want it to be
> the default). 

I think making it the default in the long term is a good goal. In the
mean time having pull tell users if they need to run evolve would be useful.

> How do you think it should be triggered? "git pull
> --evolve"? or perhaps "git pull --rebase=evolve"? We should probably
> also introduce a new "evolve" enum value to branch.<name>.rebase
> config value. I'll use "--evolve" for now. If may make sense to add
> "--evolve" to every git command that performs an automatic evolve when
> done.

I think using "--evolve" makes sense, the user will want to be able to
use the obsolescence graph with pull when merging as well as rebasing.

>> What happens if the original commit are currently checked out with local
>> changes?
> 
> For a start, I'll probably just display an error message if the
> current working tree is dirty ("Please stash"). Long term, I'd like it
> to work like rebase --autostash. It should stash your changes, do the
> evolve, return to the evolved version of the original change, and
> reapply the stash. I'll add this to the doc.
> 
>> Can I suggest using refs/remote/<remotenome>/metas. I
> 
> Ooh! Great idea! I'll update the doc.
> 
>> I think this could be useful (although I guess you can get the branches
>> you've been working on recently from HEAD's reflog quite easily).
> 
> The changes list is different from the reflog. It's a list of all your
> unsubmitted patches - regardless of their age or what branch they're
> on. They may not have corresponding branches: you may have been
> working on them with a detached head, or there may be multiple changes
> on the same branch. You might not have visited them recently, in which
> case they wouldn't be in the reflog at all. You may have reset to an
> older version of the change, in which case they'd be in the reflog but
> the reflog and change point to different places. If you've used gerrit
> before, the "changes" list will contain pretty much the same content
> as the gerrit dashboard, except that it works locally.

One thing I like to do sometimes to when I've rebased a lot and
something has gone wrong is
  git rev-list -g $branch | git log --oneline --graph --stdin ^$branch@{u}
which shows all the rebased versions coming off the upstream branch so I
can see when I accidentally dropped a commit etc. If I've been
developing on my laptop and desktop then I only get the history from
that machine, it would be nice to be able to get the complete history,
but I think that is subtly different from what evolve tracks as it wont
record resets.

>>> +Much like a merge conflict, divergence is a situation that requires user
>>> +intervention to resolve. The evolve command will stop when it encounters
>>> +divergence and prompt the user to resolve the problem. Users can solve the
>>> +problem in several ways:
>>> +
>>> +- Discard one of the changes (by deleting its change branch).
>>> +- Merge the two changes (producing a single change branch).
>>
>> I assume this wont create merge commits for the actual commits though,
>> just merge the meta branches and create some new commits that are each
>> the result of something like 'merge-recursive original-commit
>> our-new-version their-new-version'
> 
> It depends on which version of merge you use. I've proposed a new
> "merge --amend" argument specifically for resolving divergence. It
> avoids creating merge commits as long as there's only one parent
> remaining after combining the parents of the commits being merged.
> Basically, if the two things being merged are divergent commits, it
> would resolve the divergence without creating a new merge commit...
> but if the divergent commits had different parents or were themselves
> merge commits, the result may still be a merge commit.
> 
> If you run the normal version of merge, it *would* create a merge
> commit and leave the changes divergent. However, one of the
> transformations on the evolve command will look for this situation and
> resolve it. Specifically, if it encounters two divergent changes but
> exactly one child change contains a merge that would resolve that
> divergence, the transformation will merge all three changes, squash
> them together, and make all three changes point to the result. I'm not
> sure what to call this transformation, but it serves a useful purpose:
> it allows users to use either form of merge to resolve the divergence.
> If they use the "--amend" version of merge, no merge commit is created
> and the divergence is resolved immediately. If they use the normal
> version of merge, a merge commit is created (as it is now) and the
> evolve command figures out later whether that merge was intended to
> resolve divergence. This avoids putting any magic in the merge command
> itself, avoids changing the existing behavior of the merge command,
> and it means that most users won't need to learn about "merge --amend"
> and can't accidentally paint themselves into a corner by accidentally
> using the wrong kind of merge. Power users can disable this
> transformation and resolve their divergence explicitly using --amend.
> Novices can just use the defaults and things will probably work.
> 
> It can get more complex, though. If there are two or more child
> changes containing merge commits that resolve divergence, this
> transformation would happen separately for each one and the resulting
> merges would themselves become divergent (since they are two
> conflicting solutions to the same problem). This may happen if the
> user unnecessarily resolved the same divergence multiple times with
> different merge commits. At that point, one of several things would
> happen. If after rebasing the merge, the result automerges to exactly
> the same thing (which would happen if both merges were the result of
> running the automerger on incremental versions of the same two
> changes), the divergence would instantly resolve itself because the
> two changes are aliases. Otherwise, this new divergence would be
> treated like any other and evolve would eventually try to apply the
> same algorithm recursively on the new divergent changes.
> 
> I'll elaborate more on the supported transformations in the doc for
> the evolve command.

Thanks for the explanation, as you say it can get quite complicated so I
think good user documentation would be important. I'm conflicted about
having merge create non-merge commits as I think users are used to it
creating a commit with more than one parent. One of the things I found
difficult to understand when I first started using git was the
difference between a merge commit and performing a three-way merge. The
documentation tends just to use 'merge' when the two concepts are
somewhat orthogonal as rebase and cherry-pick use the same three-way
merge algorithm as 'git merge' but create commits with a single parent.

Best Wishes

Phillip


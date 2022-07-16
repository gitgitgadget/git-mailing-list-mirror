Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E23FC43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 20:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGPU4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 16:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPU4r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 16:56:47 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597061BE94
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 13:56:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p14so6134277qvo.9
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qq3qwoYEYTvhVOw3qOpVefzdxcp5PP0iT0mcoicJNJc=;
        b=JXUrqk5qt3TwvQM6SIdvE4bkP2kbGdZEDMZ0YIv9FQQrZRqfmZTdbLrbfPocSqeOCT
         t1t4APi68S7TdmWE0fPTK6CoCvVPqWC/6KkL283s+1a+D/Iql/xUJBmgpu2GGAJ6E13T
         6KTfS6d2TkgVGRIT5cxGsr7SJG02XcMQdeBBjpwBvy5DBhY9WhBVatUSMZ0QtELiqU1+
         uNEEBomfHjmEvw6EklRLaXwF9tBUhfFRpjWwc8FAi0cRAVrhX0byEgWtNXQ4oF+qNQET
         2gSG2+KSf2lq5FRKPRHOjsffDOAfizZaTbDFeeuut6dKLE5NK7wojmkB1bprcYNUTfgM
         4cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qq3qwoYEYTvhVOw3qOpVefzdxcp5PP0iT0mcoicJNJc=;
        b=Fuk+I6tJMhxlLbxPTwnkiKk6Q+Ns5+zLgBT5OzGYaTLP1h1HwhZdXXV1dE+0BZqxLq
         LcDOQK6LXxL5XyzcLQuYDLrK+j1/Ljk19r6tqaQgOjsCKzZPfNneIRIt95prTVRJrzsQ
         4QIxQoqbNrTOiyH126o6QK2p8cLbXoxj3PGDETLKyGql77bedrpFy4m6qkb1E5Th4fJy
         t8ilDVzeROoxz37BrO7QBFWNSNgGxBHs+ZZaQ8U1V9TTRcZNE2csWLCsZG5Cn8PUBFme
         JwkKGpPGN1mAC8y12aqMXHvFhvs/MMdITcnomnsEJQvtjLMP/qvAk6hZPuD6eLMGoI1Z
         cycg==
X-Gm-Message-State: AJIora992SLj5kgCsDmQilyJDzDTtB6RanK/POATAEz0rTzfQGAU0zmg
        017mVMjoz/6JiaZomJOjBnPNBmjzKT3cJuIzNSM=
X-Google-Smtp-Source: AGRyM1suYwmppMGndco19nlzTkr2U3Gl6RwPUVQ9LEYOSkvQ4g5dEId1ZSH3hlddJIyoAT+w4oU59gLnHCXZBgGPnCo=
X-Received: by 2002:ad4:5ae9:0:b0:473:62ef:601a with SMTP id
 c9-20020ad45ae9000000b0047362ef601amr16068686qvh.69.1658005005481; Sat, 16
 Jul 2022 13:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> <xmqq8royibor.fsf@gitster.g>
 <73311eba-244b-3c88-d0b9-f97f426f1de6@github.com>
In-Reply-To: <73311eba-244b-3c88-d0b9-f97f426f1de6@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 13:56:34 -0700
Message-ID: <CABPp-BFe7tWVe2v2y_QXJ_yDD8DDqApkvFAyVx-ACXkb-CcNsw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] rebase: update branches in multi-part topic
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 14, 2022 at 7:50 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 7/12/22 11:37 AM, Junio C Hamano wrote:> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This is a tangent, but may serve as some food for thought.
> >
> > When I queue (or develop myself) a topic that depends on another
> > topic, I often do
> >
> >     $ git checkout --detach vX.Y.Z ;# choose an appropriate base
> >     $ git merge --into derived-topic base-topic
> >     $ develop develop (or "git am")
> >
> > which would end up in
> >
> >     vX.Y.Z -----M---A---B---C derived-topic
> >                /
> >      base-topic
> >
> > so that "git log --first-parent --oneline master.." would show the
> > commits in the topic plus the fact that it depends on which other
> > topic recorded in a single merge commit.  A topic that depends on
> > two or more topics can be handled the same way.
> >
> > One good thing about this arrangement, unlike the "totally linear"
> > one depicted at the top of your cover letter, is that it is easier
> > to rebuild each topic independently and the first-parent view is
> > still useful.  If you futz with the base topic in a totally linear
> > history, "log --decorate" of the derived topic would no longer tell
> > you where the old iteration of the base topic ended.
> >
> > It would be very nice to see the update-ref feature (or something
> > like that) makes it easy to deal with such a topology, too.
>
> Your topology is an interesting one, but --update-refs isn't limited to
> linear history.
>
> (Begin aside)
>
> One goal of this feature is to make it easier to manage the topics that
> are being juggled in friendly forks. For example, git-for-windows/git and
> microsoft/git have some topics that evolve version-to-version but might be
> cleaned up and sent upstream. Both of these forks use 'git rebase
> --rebase-merges=rebase-cousins' when consuming new upstream versions to
> keep the merge structure of these new topics. However, we lose the branch
> names and need to reconstruct them from the context of the merge commits.
>
> With --update-refs, we can automatically rewrite the branches that are
> included in these individual topics. That might make it simpler to extract
> a series to send upstream.
>
> One test in this series does test such a case with the --rebase-merges
> option.
>
> (End aside)
>
> Back to your topology, I wonder what your rebase command looks like when
> tracking those topics.
>
> The goal of --update-refs is to help rebase multiple branches at the same
> time, and with your example here, it would imply you want to rebase both
> dependent topics.
>
>  Before:
>
>   A---B----C---M---Q1---Q2---Q3 <-- refs/heads/Q
>    \          /
>     P1--P2--P3 <-- refs/heads/P
>
>  After rebasing both topics simultaneously (with 'git rebase --update-refs
>  C' while Q is checked out):
>
>   A---B---C---D---P1---P2---P3---Q1---Q2---Q3
>                             ^              ^
>                         refs/heads/P  refs/heads/Q
>
> But it seems what you mean to say is to update the merge commit M, which
> means that the 'P' branch above has been updated independently of the 'Q'
> branch, so we need to update 'Q' after-the-fact. I'm not sure what that
> rebase would look like, indepdendent of updating refs.

Since this is an aside, I'll take a chance to talk about stuff I'm
working on.  After

  git replay --onto main --contained main..Q

(where "--contained" seems to be similar to rebase's --update-refs
option, in that it assumes all refs pointing to history being
rewritten should also be updated), or the more explicit

  git replay --onto main ^main P Q

and assuming 'main' has one additional commit 'D' on top of 'C', you'd see

   A---B---C---D-----------M---Q1---Q2---Q3 <-- refs/heads/Q
               \          /
                P1--P2--P3 <-- refs/heads/P

In other words, both P and Q would be replayed but with relative
topology preserved.  Also, important changes in M (conflict fixups or
semantic fixes, etc.) would be preserved -- at least that's the plan.

> Do you have an example rebase command that manipulates the commits the
> way you want? Then I can better understand how the --update-refs could fit
> in with that. (Or maybe the point of your tangent is that there isn't an
> option.)

This would be nice.

> If instead we thought about an example like re-rolling the 'next' branch
> entirely on top of the 'master' branch, then we have an example that is
> closer to the friendly fork example. (I know this isn't a realistic
> scenario since we don't rewrite the commits already merged to 'next', but
> it's an interesting stress test.)
>
> While having 'next' checked out, I ran
>
>   git rebase -i --update-refs --rebase-merges=rebase-cousins master

Re-rolling 'next' might not be realistic, but re-rolling 'seen' isn't
quite as far fetched.  I think it'd be more likely to use
no-rebase-cousins, so:

    git checkout seen && git rebase -i --update-refs
[--rebase-merges=no-rebase-cousins] next

or

    git replay -i --contained --keep-base next..seen

> and it updated all of the branches currently in the region master..next.
> I've attached the output of
>
>   git -c log.excludeDecoration="refs/remotes/*" \
>         log --oneline --graph --boundary master..next
>
> just to show what this looks like.

One example that I thought might be useful, is tweaking a single topic
in 'seen', and updating 'seen' to reflect those updates.  This would
be something like

    git replay --keep-base --first-parent ^next seen topic_branch

Which would show you all the commits in the first-line history of
next..topic_branch plus the first-line history of next..seen, and let
you tweak that todo list.

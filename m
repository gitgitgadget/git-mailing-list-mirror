Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6839BC07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 00:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4810D6143F
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 00:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGIAsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 20:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGIAsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 20:48:22 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FBC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 17:45:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so6938508otf.9
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KZKlts7TyLs2RNUkRpDjyrTnx/GhCj0kZyaFXsS095o=;
        b=tp9UOaUaANnZEulmOsJFlsGhripEUKksakBPpSB/v9Jckwx0PMTQOgduzlDA6026SZ
         OZiNNWljZRI4MGHj1KpB1Yxwm/V3ddY1YdBWeC7uG+OweAyyJ+Tw0m/ZX33uyq9A6FjC
         QANKJNOLuSXRNwhHLwWCVBW/uy2iFC+BhQUh8Q+GOd3UJoK+v9KBffo6aiU2TooOcSaP
         SSizK318ZqHIxTSfV5/Q+oXDo67lWE4m6s31rBf3flndqBX84eDdlHqsvMILklW75a56
         pLSSHL6DVoLgxlK3QC/kaJEmC6xI042JOURNMCZDs0qrfSRLyJL7uOjxkZaqiUV70EZG
         RS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KZKlts7TyLs2RNUkRpDjyrTnx/GhCj0kZyaFXsS095o=;
        b=hrHlszfhXIEdrP0XanMG+IsxXsTYVhZ8HbDKT/L5g8akm9j+GOh7qzxuzdYSb+P6KP
         3xaDAGIx4Iw2KVLi5OBLVaUmB6xAZpha2KCnosw8ENj0+vS31/YS+ktuJTmxACtSeqBd
         8lFzG99SmfBve595IvQDA658Pc+YPBYX2M2ea21cotlG+Ti4OtlwQp7cYn05Kk8VgcM2
         562nRV1v3NiNYNYgKIjKdV7NO6l8P4DHDyh38ZkSTqJpsPZs179zqUmVOmT8lTNPQzrC
         tI2XjIIlOnrNmEMJxBSWYjtrHiPWHPQqvyOXymSB2SqPsWNquuILCtjqCwU1SrIx3vYf
         Ldpg==
X-Gm-Message-State: AOAM5312GP/3kZkvfrsNz+OQWPkoD7m2AX04WdJU80x7UVmzQBQd0XFI
        3zzrJk14R2Uistj6zAmhb3c=
X-Google-Smtp-Source: ABdhPJzY9zfdaTEDczLxrJcrV2oiVw6dgzkgBnnoYwK2ZQiCFh7i2x8s5IFrT0RvcpuPUivga8jWgQ==
X-Received: by 2002:a9d:6e06:: with SMTP id e6mr12769039otr.350.1625791539560;
        Thu, 08 Jul 2021 17:45:39 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id d3sm777582otf.61.2021.07.08.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 17:45:38 -0700 (PDT)
Date:   Thu, 08 Jul 2021 19:45:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e79c31aaa72_30b8a4208c1@natae.notmuch>
In-Reply-To: <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
Subject: Re: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 08/07/2021 22:37, Felipe Contreras wrote:
> > Technically a branch is a file with an object id in it. That doesn't
> > give the user any useful information.
> > 
> > What is important is the *meaning* of that file.
> > 
> >> People indeed tend to thing, I branched at X, so anything before is not
> >> part of the branch.
> >> "--contains" says otherwise.
> > 
> > Yes, that is the status quo, but the fact that X is the case doesn't
> > mean it *should* be the case.
> 
> Well yes. So lets start over.
> 
> A branch is a container for commits. Those commits have a start (root or 
> base / not sure), and an end (head).
> The commits are continuous, in that they have no gaps.
> 
> The big question is the start point of the branch.
> 
> And there is a further consequence:
> If a branch "starts" at "base" then
>   --contains  needs to be changed
>   --reachable needs to be added (for what contains does now)

Indeed, but as of this moment @{base} is not being considered, it's just
a mental model tool.

> This also complicates it, because now there are 3 types of relation 
> between commits and a branch
> - unrelated (outside / not reachable)
> - inside (base..head)
> - reachable (base and all its parents) // better word needed

I think that has always been the case. The fact that the git
documentation doesn't talk about that doesn't mean the concept doesn't
exist.

> The last is important:
> 
> A => B => C master
>       \ => D  foo
> 
> If I delete master, without the concept of reachable, I would expect 
> commit A to be dropped. Technically B should drop too, but it takes some 
> insight to expect that.
> So then with only the branch foo left, I would also have only the commit 
> D (well maybe B too, if the system is lenient)

Commits don't need a branch to exist. B could have a tag 0.3.7 and no
branch pointing to it. There could be other refs pointing to that
commit.

> One might even go an say if master is deleted, then the base of foo is 
> deleted. since foo must have a base, and it no longer has, foo can not 
> exist any longer.

Of course it can. The base of a branch doesn't necessarily need to be
part of any other branch.

Or another way to think of it is that B is part of an unnamed branch.

> > A branch that you hold, or point to, is a concete concept easy to
> > underand. When I say: "me, my sister, and my father are one tiny branch
> > of the Contreras family", people understand what that means inuitively.
> > 
> > On the other hand saying "Felipe contains his great-great-grandfather"
> > would stop anyone on their tracks.
> 
> The Chicago branch of your family contains Al Capone.
> That works.

Sure, if you start from a certain grandparent, not if you start from my
grandfather.

Most humans have issue with more than 7 items. A branch containing
millions of members reaching as far back as a fish is a notion an
evolutionary biologist might not have any problem with, but most people
would struggle.

For most people a branch must start from somewhere.

> > But if you do `git reset --hard origin/master`, you are saying: drop
> > everything about this branch, and make it the same 'origin/master'.
> > *Now* we have a reason to distinguish `git merge --ff-only` from `git
> > reset --hard`.
> 
> No you don't. IMHO not.
> "reset --hard" resets the branch to a commit. You can specify that 
> commit by giving a branch-name (that then will be resolved). But it 
> could be any commit, even a detached one.

OK. Sure. It could be repurposed to say what I explained, but we might
be overloading that command in that case.

How about `gt branch --reset <otherbranch>`?

> So "reset --hard" has to set the base and the head to the same commit. 
> Effectively creating an empty branch based at that commit.

Maybe. Or maybe the base remains the same. Fortunately that's not
something we need concern ourselves with at this moment.

> But local tracking branches still are counter intuitive.
> 
> IMHO local tracking branches should follow one of the following 
> scenarios. (And ideally that should be the same for all local tracking 
> branches, for any user.)
> 
> 1) Always have the same base as their remote branch.
> Therefore always have the same content as the remote branch, up to where 
> they diverge, if they diverge.
> 
> 2) Not include the remote branches content. Just hold my local commits, 
> until they will be pushed to the remote.
> 
> But neither works:
> 
> Say I have a local commit, and you pushed new changes to the remote.
>     git pull --rebase
> My branch is rebased.
> So my local tracking branch has its base at the head of the remote. It 
> has only local commits => case 1.
> 
> Say I have no local commits, and you pushed new changes to the remote.
>     git pull --ff-only
> If I understand correct the --ff-only move the head of my local branch, 
> but leaves the base where it is.
> Now I have some shared commits with the remote branch.
> => either case 2, or worse none of the 2 cases.

There's no need for --ff-only, do `git pull --rebase` on both cases, and
the base will constantly be reset to the remote head.

However, at least I never do this. My 'master' branch doesn't contain
any commits and I always do the equivalent of `git pull --ff-only`, so
the base would never change.

> > If you send a pull request for your 'master' branch, which then gets
> > merged to 'origin/master', then you can do `git merge --ff-only` to
> > advance the head pointer of the 'master' branch to the remote branch so
> > both are in sync... Except the base won't be the same.
> 
> There may be something I missed. ff should not touch the base?
> So the 2 base will still be the same or not the same, depending on if 
> they were equal before the ff?

That's right. Before the fast-forward the base was different (because of
the rebase), so after the fast-forward the base remains different.

> >> So yes, what is a branch? More exactly what does it contain.
> >> Two examples, that to me suggest two answers.
> > 
> > Not necessarily. See above.
> 
> I feel we must have some understandingly on the part how base and local 
> branches would interact.
> 
> You agree: rebase changes the base (it creates a new branch on to --onto)
> 
> You pointed out there also is fast-forward. But see my above example.
> I am not even doing a pull request. I simply go for you and I both can 
> push to the same remote. So we both commit to master and pull/push it.

It doesn't matter who does the merge:

  git merge origin/master
  git push

It would be the same as a pull request followed by a fast-forward
(except with the parents reversed).

The base remains unmoved.

> >> Also if branch@{base}..branch  then there is a problem.
> >> - branch@{base} is then correctly not part of the branch
> >> - So immediately after "git switch -c branch" the branch is empty => ok
> >> But if so, then what is the branch head at that time?
> >> The Pointer would point the @{base}, but @base is outside the branch. So
> >> the pointer of the branch points outside the branch?
> > 
> > Yes, the base pointer doesn't include the branch. When you do
> > `branch@{base}..branch` that's the same as `^branch@{base} branch` so that
> > excludes all the commits rechable from branch@{base} *including* that
> > commit iself.
> 
> My question is, where you see the branch head pointing to?
> If the branch is empty, i.e. if it has no commit at all, then to what 
> commit does the branch head point?

To the same commit as the base: master..master contains zero commits.

> >> The only problem is:
> >> branch is too often used for "the commits contained in the branch". That
> >> is way to common to even try to stop it.
> > 
> > We don't need to stop it, we can sidestep it.
> > 
> > Instead of talking about the branch, talk about the branch head:
> > "the brach head is moved to X".
> 
> Yes well, we need to be very concise, if we speak about anything that is 
> not the "commits in the branch".
> 
> 
> >>> When you change the branch head you are effectively changing the branch.
> >> Well if branch is the pointer, then you change the branch, and head is
> >> being changed.
> >> If branch is the content, then you change the head, and yes the content
> >> changes.
> > 
> > Exactly, so regardless of which semantics you choose, everyone
> > understands that the branch is not the same anymore.
> > 
> 
> Your original text was
> > When you change the branch head you are effectively changing the branch.
> > If @{base} existed, then changing the base would also change the branch
> > (although that would be a much less dangerous operation).
> > 
> > Does that make sense?
> 
> And yes, if either boundary changes, the branch changed.

But our immediate concern is to improve the documentation of
`git switch -C`, and perhaps improve the interface while we are at it.

I believe we have all the semantic tools needed to write something that
is understandable by most people regardless of their conception of what a
branch is.

No?

-- 
Felipe Contreras

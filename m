Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C4FC07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7CD616EA
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 20:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhGHUkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhGHUkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 16:40:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7039C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 13:37:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w74so9397583oiw.8
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hoYUJKA8rLeDQK69FV2G2ZhFU+RgC/jXDd8Xl+I4ybg=;
        b=ffgNd7mK7yN8TE0SPm7o+YyWnmhTa9zg2JGAF6Mkp+8ilpkFOu3NOibvEKW8CvUy2z
         64sBWBao+7xGkt8F7c44Y5S0o7cM4TFQek7heyDQnzo/UjZj8yipPWeAtOTPGDQCkctq
         2Da8B7PF8hWz6ulFiOFIQrE6xXKVu6aalxrlCNx3D/yP7+EgBOINiaz6PjFeVo8fGX9S
         HwIa4S0sq3Uoo1ri+O/A6ePce8DAG4eMDc484/QZ1wVNY5N2f72/Q1VPX9cDJZeRGdYs
         ARxFKG0g8KEmZyqkYGNHBeYARRDIPjgldQghIH/WH4qnJswFovnToFTqcBegRLfZrlqR
         wd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hoYUJKA8rLeDQK69FV2G2ZhFU+RgC/jXDd8Xl+I4ybg=;
        b=ERpxD/w9IdOZOo2z5gZLP3Fp0wkU87UbINPYNg5A2v/nZVj9rY1rUGW9Hv5rsoF3PJ
         gtltUGiXn/WFtZMXpDBY9pXK2FOsWdUwS+EBo7qKKu+rYI/fAefHUg88jlFPyN6sEmUJ
         L5RLUtW2tfTMZrZBQzJnbu1oCpPCxtmGB2F7XtRCymeN5v4i53p4mtxtMocTiqd/9wa/
         PgdRpm/0dmdQFnQ1PFi6tXJKJv/LrI8RS0nx9yLjvAOJZkEW7zIrzNmXWtkjROLz3Gn6
         l3o3zQsctQykOXIG73h5meLwl/3IdiJhrX+iJlBIcWJYbqndULwvbkNW5i0Y94shpFYt
         td2w==
X-Gm-Message-State: AOAM5333MeB+Jq2gp5wSJdT+/Egixe5RvIbxSNAAKMtaUzAZntaQ8hIj
        qbh1gzQCK105QefJzvpR9f4=
X-Google-Smtp-Source: ABdhPJzHXbNky0/HVvyfcrlByDMEZrtbmeveMdloYYXKU7jXLaYiyq/gdrgcRScABvQ1JP3lvt5dOA==
X-Received: by 2002:a05:6808:208a:: with SMTP id s10mr5217535oiw.97.1625776678055;
        Thu, 08 Jul 2021 13:37:58 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id y18sm695339oiv.46.2021.07.08.13.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 13:37:57 -0700 (PDT)
Date:   Thu, 08 Jul 2021 15:37:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e762243aab1_30a7b02089@natae.notmuch>
In-Reply-To: <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
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
Subject: Re: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 08/07/2021 19:33, Felipe Contreras wrote:
> > The only reason I mentioned @{tail} (or @{base}) is to have a better
> > mental model of what a branch is.
> > 
> >   1. A branch is whatever is inside `branch@{base}..branch`
> 
> For this part "branch" = some series of commits.
> 
> Then this is what I would say is a common misunderstanding.
> 
> Yet that may be the difference between what people want the branch to 
> be, and what it (afaik) technically is.

I'm not talking about what a branch technically is, I'm talking about
what it is semantically.

Technically a branch is a file with an object id in it. That doesn't
give the user any useful information.

What is important is the *meaning* of that file.

> People indeed tend to thing, I branched at X, so anything before is not 
> part of the branch.
> "--contains" says otherwise.

Yes, that is the status quo, but the fact that X is the case doesn't
mean it *should* be the case.

The ideal user interface doesn't need to be explained. The more you need
to explain a concept the less intuitive it is, and the more you should
look for another concept that is perhaps more intuitive.

A branch that you hold, or point to, is a concete concept easy to
underand. When I say: "me, my sister, and my father are one tiny branch
of the Contreras family", people understand what that means inuitively.

On the other hand saying "Felipe contains his great-great-grandfather"
would stop anyone on their tracks.

> Thinking of it.
> 
> If I look at a feature branch, then my feature starts where I created 
> the branch. I want my feature branch to represent this.
> 
> But if I look at my local master branch (or any tracking branch), I like 
> to believe that it contains the same as the remote branch.
> And well, if we just set the base for the local tracking branch to be 
> the same as the base for the remote branch that would be fine.
> But if (after diverging, due to changes pulled from remote) then, I run
>     git rebase @{base} @{remote}
> then rebase has to skip all the shared commits.
> 
> And since rebase also repoints the "base", my local branch then no 
> longer contains the same as the remote.

That is a *very* interesting case that exemplifies the lack of our
current semantic arsenal.

Every time you do a rebase you are in effect creating a new branch with
new commits, a new head, and a new base. The only thing that remains
the same is the name.

It is no longer the same as the remote branch, or an outgrowth; it's
a new branch.

If you send a pull request for your 'master' branch, which then gets
merged to 'origin/master', then you can do `git merge --ff-only` to
advance the head pointer of the 'master' branch to the remote branch so
both are in sync... Except the base won't be the same.

With the current semantics this recreated 'master' is now exactly the
same as the remote 'origin/master'. But not with the @{base} semantics;
since both branches have a different base, they are strictly speaking
different branchs.

But if you do `git reset --hard origin/master`, you are saying: drop
everything about this branch, and make it the same 'origin/master'.
*Now* we have a reason to distinguish `git merge --ff-only` from `git
reset --hard`.

> So limiting the branch to branch@{base}..branch only works for feature 
> branches.
> 
> 
> So yes, what is a branch? More exactly what does it contain.
> Two examples, that to me suggest two answers.

Not necessarily. See above.

> Also if branch@{base}..branch  then there is a problem.
> - branch@{base} is then correctly not part of the branch
> - So immediately after "git switch -c branch" the branch is empty => ok
> But if so, then what is the branch head at that time?
> The Pointer would point the @{base}, but @base is outside the branch. So 
> the pointer of the branch points outside the branch?

Yes, the base pointer doesn't include the branch. When you do
`branch@{base}..branch` that's the same as `^branch@{base} branch` so that
excludes all the commits rechable from branch@{base} *including* that
commit iself.

> >   2. `branch` is the branch head (`branch@{head}`), but it's not the
> >      branch itself
> Well technically "branch" is the "pointer" to the head.
> Assuming we want "head" to be a commit?

No, the branch head is a reference: 'refs/heads/master'. The reference
points to a commit, but it's not the commit itself.

So it's a pointer to a pointer.

> The only problem is:
> branch is too often used for "the commits contained in the branch". That 
> is way to common to even try to stop it.

We don't need to stop it, we can sidestep it.

Instead of talking about the branch, talk about the branch head:
"the brach head is moved to X".

Or if you want to use the branch, don't assume any specifics:
"the branch is recreated to be the same as X".

> > When you change the branch head you are effectively changing the branch.
> Well if branch is the pointer, then you change the branch, and head is 
> being changed.
> If branch is the content, then you change the head, and yes the content 
> changes.

Exactly, so regardless of which semantics you choose, everyone
understands that the branch is not the same anymore.

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5207C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355227AbiELOw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351927AbiELOwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 10:52:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9B6161D
        for <git@vger.kernel.org>; Thu, 12 May 2022 07:52:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w24so6576220edx.3
        for <git@vger.kernel.org>; Thu, 12 May 2022 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvswCWawMMZeZJqGwiZH2aEXh+hBvtM5qjt3Fzs/v1s=;
        b=SBqMZvGHRznLuM6EOt1OIHX1QlPZoTHB7m4yAzAaSUIHjOsxYXwX22nnnWkoMT51cG
         Q2py75zum9/d2mQoQWPnkhYFivqZh3hEXTYcVerEy02vMzQLINNtrS9SzeVbaSo+h4r9
         bZPiFnIFL9ecNtFnaA4LzPuTBonB6V+pDmzIUMF+WjlQmmMzU1ZqLqHOVkiq6ChneVqv
         JgA9B4J5uZo9vssXa+w3dnfrroclTRUqEymKFSHHpq8iuwQpKR5Y4HbkcZ7yM2UfWYo6
         pHuEnZ3a68XLQJWYYwrG6r+7pE+B4isWPSDHQK+vc4fJ9c59RWbwFuM6Q0ZP4HA++8ZI
         X1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvswCWawMMZeZJqGwiZH2aEXh+hBvtM5qjt3Fzs/v1s=;
        b=i0Dprg061tSL4GLu1elWWFzkDmeKPP7TPKit7UpbDxYRDRk9hgXb41YKElgWmTru8n
         nhkACBzqpN4U3Dgxse+fu8lpaUInKbkrkVUplPGPjHliNymHXENpZBimrIIIHZfs4/5i
         L1DXZXHTcpt9Ve0+oXhyys4JRsKDTimfxPKCDMAYlqNvFi0LnO2nadBeBZ3wjeWtv5tU
         vNcX3+lHPxlNTGvsjCNWw5kEBfQ6c/42uwmfLqogwNKJbj+kb71iB4T0tGnaUxHJfNay
         dYQwDSyAHE1zOwb8PfgA+FoCMPJer6UgYmxejzS7y76pzaofT9VqSJBG180ogXAaERRb
         Hayw==
X-Gm-Message-State: AOAM531/MfgAMi4ne6lb1L4FrOD/cGfeDaC3JsdNnwuqfk5SRx5y7gV3
        0BaFvBDOQJBqpxPj3hAdJoz1XttoF9FK3vw2upI=
X-Google-Smtp-Source: ABdhPJzya915kHWA/cLCWW8A5nCOpOPc7elB85TQ3c61wUc8PyWp67TfId+B+8wfQDWwo2/SS4UMuwDnP/0j/JTjdDQ=
X-Received: by 2002:a05:6402:268e:b0:427:bb19:f889 with SMTP id
 w14-20020a056402268e00b00427bb19f889mr36412645edd.33.1652367141247; Thu, 12
 May 2022 07:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <e733c2fd9f497a8d80555126ec2e166e182ab8db.1652225552.git.gitgitgadget@gmail.com>
 <20220512010124.1800540-1-jonathantanmy@google.com>
In-Reply-To: <20220512010124.1800540-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 May 2022 07:52:09 -0700
Message-ID: <CABPp-BFjPtzYcysjkr+q-FYJm3AJTti-YniVYnx6E8aQAkkWAw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] stash: apply stash using 'merge_ort_nonrecursive()'
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2022 at 6:01 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > @@ -551,10 +553,26 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
> >       if (o.verbosity >= 3)
> >               printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
> >
> > -     bases[0] = &info->b_tree;
> > +     head = lookup_tree(o.repo, &c_tree);
> > +     merge = lookup_tree(o.repo, &info->w_tree);
> > +     merge_base = lookup_tree(o.repo, &info->b_tree);
> > +
> > +     repo_hold_locked_index(o.repo, &lock, LOCK_DIE_ON_ERROR);
>
> What's the reason for locking the index? I would think that
> merge_ort_nonrecursive() does not modify the index (in any case, I
> removed the locking code and the tests still pass). And as for changes
> in the worktree, I ran "strace" on the "stash apply" in the test and I
> didn't see any changes in the worktree from here until the lock is
> released.

merge_incore_nonrecursive() doesn't modify the index or working tree,
but merge_ort_nonrecursive() certainly modifies both in general (via
its call to merge_switch_to_result()).  I'm surprised you didn't see
working tree changes in a strace; was the stash being applied on top
of some commit that had equivalent changes already in its history, so
that the stash application involved a merge where the working tree was
already up-to-date?

More generally, I think it'd be nice if stash locked the index early
in the beginning of its process, did all the modifications, and then
released the lock.  But that's somewhat orthogonal to these changes,
and it'd require getting rid of the forking-subprocesses design of
git-stash.  Since stash is just a transliteration of a shell script,
it locks and unlocks after each individual subcomponent instead.

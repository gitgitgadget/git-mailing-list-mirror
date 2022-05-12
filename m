Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5862C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 16:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356767AbiELQ4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356745AbiELQz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 12:55:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AE2BCE
        for <git@vger.kernel.org>; Thu, 12 May 2022 09:55:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id t15-20020a17090ae50f00b001d925488489so2674760pjy.3
        for <git@vger.kernel.org>; Thu, 12 May 2022 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=4X1e0jPmdeDZdEccHg9AtCRgEilD3kpCHPyPPqfkGHE=;
        b=bdpPp7wZgbTPtFURNHPnz/ZXY4WKbbod/fnFlvI1/7UXSVYN7/KrUnPmK2k0/AbxCW
         Hk3RTvhxtNgIjjCWoKeX6lEIlBWKmByTSEgKnWSHKmc8UXpi2QEhMa4Sp9kOGAakVO0/
         1hVUYQqrB0JcvBIvr6LOeiDHqRW85Fw+isuCuxOFsIG1UF9AiwcSE/GEYeYOhAOScN6f
         bNqICN9z8pwHX9aMD9vvwX23z3m9YuvH2ddxdDEsR3Dk5wbstztxkWdhDCwb8O4SVsQA
         zGl79voQxTQgEuQ2oIKgTq9ilIVTQnPktxa1sq3E1UfP1GteIiRqR6IJ5OhSyY7pDgKo
         13zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=4X1e0jPmdeDZdEccHg9AtCRgEilD3kpCHPyPPqfkGHE=;
        b=gCXGW8uEJxpoZo3miccifG+wZxWuBK/HKZA7SzlT5WlFhuREMeyAiV13N+wtDDXvOX
         o4+0Aifx6Wlfq83eUuKJTRmuoc+BMbHWLjiHhqUEc6/M26i8APNNNQv7UZnRw8gBtTLC
         pq5lmJdWT8zbt0VCE1RjO3hsaU9ajHKjwP66Y3ENr/n+6dO9mT+3MRmAMayxTYyiEsUk
         3Px3EjUsoD9JPqn0GTxOQFYoVMqI+0MQJxNOQpCrNPZWqSM+fbucFjYcTZsBGzDpEJiD
         0ZL5OrO+WYJQIEq+HpS8z5aWakAbNY/G/EuKnEH/cJqYGnhUr3t/W1eXov/2xwNHsGI5
         20+g==
X-Gm-Message-State: AOAM531cO8+XhV0Gl7E9QEHnfHvbrOmOAEja7N1oVSCUT+krC6GI4KOk
        8r4NHSWXaX1OeV4Ao5iG4sdiko2YG2fZkNujBk16
X-Google-Smtp-Source: ABdhPJz/Hoc9/pf6ajW5o5/UcwhBmjDFK8sPLaLrTMRu0dRgP+zVk2ZPi2zEoRCN5PKZcuTX+ffdOWonGMzK9hx8pnSr
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1bc4:b0:1dc:2133:2e01 with
 SMTP id oa4-20020a17090b1bc400b001dc21332e01mr465317pjb.221.1652374551930;
 Thu, 12 May 2022 09:55:51 -0700 (PDT)
Date:   Thu, 12 May 2022 09:55:46 -0700
In-Reply-To: <CABPp-BFjPtzYcysjkr+q-FYJm3AJTti-YniVYnx6E8aQAkkWAw@mail.gmail.com>
Message-Id: <20220512165547.116747-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: Re: [PATCH v3 5/6] stash: apply stash using 'merge_ort_nonrecursive()'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> On Wed, May 11, 2022 at 6:01 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > > @@ -551,10 +553,26 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
> > >       if (o.verbosity >= 3)
> > >               printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
> > >
> > > -     bases[0] = &info->b_tree;
> > > +     head = lookup_tree(o.repo, &c_tree);
> > > +     merge = lookup_tree(o.repo, &info->w_tree);
> > > +     merge_base = lookup_tree(o.repo, &info->b_tree);
> > > +
> > > +     repo_hold_locked_index(o.repo, &lock, LOCK_DIE_ON_ERROR);
> >
> > What's the reason for locking the index? I would think that
> > merge_ort_nonrecursive() does not modify the index (in any case, I
> > removed the locking code and the tests still pass). And as for changes
> > in the worktree, I ran "strace" on the "stash apply" in the test and I
> > didn't see any changes in the worktree from here until the lock is
> > released.
> 
> merge_incore_nonrecursive() doesn't modify the index or working tree,
> but merge_ort_nonrecursive() certainly modifies both in general (via
> its call to merge_switch_to_result()).  I'm surprised you didn't see
> working tree changes in a strace; was the stash being applied on top
> of some commit that had equivalent changes already in its history, so
> that the stash application involved a merge where the working tree was
> already up-to-date?
> 
> More generally, I think it'd be nice if stash locked the index early
> in the beginning of its process, did all the modifications, and then
> released the lock.  But that's somewhat orthogonal to these changes,
> and it'd require getting rid of the forking-subprocesses design of
> git-stash.  Since stash is just a transliteration of a shell script,
> it locks and unlocks after each individual subcomponent instead.

Thanks for the note. Yeah..I'm not sure what happened.

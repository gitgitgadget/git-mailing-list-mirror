Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD1FC6FA99
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 00:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCKAEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCKAEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 19:04:04 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4512C730
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 16:04:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id bd34so4678106pfb.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 16:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678493043;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Px6KcYiRcduYXF05Ae43AECh0MszfVu1ngek8o2C4ik=;
        b=qWdxxN8rNuhTge8yPbrQDhfWo4+HOnvZqlyAs+qcxBBAuk3Ny64YhfuE2Uvw9MEiYV
         bk/MTgKKmQ3i0J2SkoicGrCOJelhAabyB+j/1kxU/NYBNDZ9cealv8OgrpKWvU8YLZdd
         aIxaPnPJV8Tm8qqnfe2oRI2hOfaJs89OfJH3blqS3/jCwig8ea4oK5NcZM4h0V6NxcFT
         AF28iNeOVQC6b4czweC1KC0JlWqbMDOi9xnmIawxuhe6LHWx+3DRNdhz/2Or8/GQ3l3j
         C2DqNyBurzqZ07TJwerov+hiOC5zbEIPT2Lghf2vg72MfgCpRjkOXF0viflX4tjQnc83
         JnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678493043;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px6KcYiRcduYXF05Ae43AECh0MszfVu1ngek8o2C4ik=;
        b=lXb7pCfO4GdQdTl498OvgSDB3v18pMTW3pRHg56HsTwYoZO8LfsQ+rQ5J+Ae0r6jhT
         qunacIqWju0nM7NXzAoMwTl+piW+jHBIqCi8xs8+RYK8CCDOdQkpS+h1B4yO5XhQ9LaI
         Io4bxU1pgqi0Q0H0hg05sDGW8SvcqVAokl/HNTOD8a65WB/aDflAw1XbFHfxIVux2CPE
         BQKgypwmeYRml+Ple++po6BCgjo762snq4c4TcodjVM53Yor2/V7SWbY9/5dPseRz+pL
         H+Nn8E+KsY/kAamNkm8/QYYC+OVKn3ugl1cvs5C+NH6l68bTiGuGeOFi42KQGhvPk1MU
         pAcw==
X-Gm-Message-State: AO0yUKXtktWt5co4ZdG+KJqSJWYuh8m6W6++EcPkXKWlhW27R4NEGkDM
        oGakZba6xGMVtYMYJF3EACg=
X-Google-Smtp-Source: AK7set8vszrQSA13rhN5A/ZOHAeivnDQzcVsPSiksCqH/IcOVNLCxgzdXTXb0TmDlqCJcAdaHnX6zQ==
X-Received: by 2002:a62:1785:0:b0:5a8:e3dc:4337 with SMTP id 127-20020a621785000000b005a8e3dc4337mr3940785pfx.16.1678493042804;
        Fri, 10 Mar 2023 16:04:02 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79219000000b005825b8e0540sm313559pfo.204.2023.03.10.16.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:04:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/3] Support for tail (branch point) experiment
References: <20230310214515.39154-1-felipe.contreras@gmail.com>
Date:   Fri, 10 Mar 2023 16:04:02 -0800
Message-ID: <xmqq7cvoywzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is *not* meant a serious proposal, it's just an exploration of an
> idea.

It is easy to explain and understand the benefit of keeping a
separate pointer to the bottom [*] of the branch on top of which the
history leading to the commit at the tip of the branch has been
built, but the devil is in the details of how such a bottom pointer
will be maintained.

    side note: below, I use "bottom" because for me it is the most
    natural term to refer to the starting end of the range of
    commits.  In the context of this topic, readers can replace any
    "bottom" they see with "tail", if they prefer.

In a sense, this is very similar to the idea of "notes".  It is easy
to explain and understand that a bag of objects, in which additional
data can be associated with an object name, can be used to keep
track of extra data on commits (and other objects) after they are
created without invalidating their object name.  As long as they are
copied/moved when a commit is used to create another copy of it.
The "notes" are automatically copied across "rebasing", which is one
of the many details that makes the "notes" usable, but cherry-pick
that does not honor notes.rewriteRef sometimes leads to frustration.

Creation of a new branch with "git branch" would be an obvious point
to add such a bottom pointer, and "git rebase" is a good point to
update such a bottom pointer.  But there are many other ways that
people update their branches, depending on the workflow, and
guessing when to update the bottom pointer and trying to be complete
with the heuristics will lead to the same "no, we do not know all
users' workflows" that made approaches based on reflog parsing
etc. fail to solve the "where did the branch start?" puzzle.

And I think what is sketched in these RFC patches can be a good
starting point for a solution that strikes a good balance.  "git
rebase", which is the most common way to mangle branches, is taught
to update the bottom pointer automatically.

Giving users an explicit way to set the bottom when manipulating
branches would help those who mangle their branches with something
other than "git rebase" in the most trivial form.  I suspect that is
still missing in this RFC?  Of course other things on the consuming
side may be missing, like send-email or format-patch, but they are a
lot more trivial to add and will be useful.  As long as the bottom
pointer is properly maintained, that is.

A few of the things that I often do to mangle my branches are
listed.  Some of them are not application of "git rebase" in the
trivial form:

 * I have a patch series (single strand of pearls).  I update on
   top of the updated upstream:

    $ git rebase -i --onto master @{bottom}
    $ git range-diff @{bottom}@{1}..@{1} @{bottom}..HEAD

   No, this is not what "I often do" yet, but I hope to see become
   doable.  Rebase the current branch from its bottom on top of the
   master, and then take the range diff between the old branch
   (i.e. @{bottom} refers to the bottom pointer, but because it is
   implemented as a ref, its reflog knows what the previous value of
   it was---@{bottom}@{1}..@{1} would be the range of commits on the
   branch before I did the above rebase) and the new one.

 * I have 7 patch series (single strand of pearls).  I only need to
   touch the top 3.

    $ git rebase -i HEAD~3
    $ git range-diff @{1}...

   In this case, I am not updating the bottom to HEAD~3 and reducing
   the branch into 3-patch series.  I am keeping the bottom of the
   branch, and the commits that happen to be updated are only the
   topmost 3.

 * In the same situation, but the top 3 in the original are so bad
   that I am better off redoing them from scratch, taking advantage
   of new features in 'master'.

    $ git checkout --detach master
    ... work on detached HEAD ...
    ... first pick the bottom commits ...
    $ git cherry-pick master..@{-1}~3
    ... still working on detached HEAD ...
    ... redo the topmost commits from scratch ...
    $ git range-diff master..@{-1} master..
    $ git checkout -B @{-1}

   I do not mind "checkout -B" *not* learning any trick to
   automatically update the bottom pointer for the branch to
   'master' in this case, but I should be able to manually update
   the bottom of the branch easily.  Something like "git checkout -B
   @{-1} --set-bottom=master" might be acceptable here.

 * I have an existing series, and want to replace it.  To keep the
   reflog of these branches useful, I apply patches, fix author's
   mistakes, etc., on detached HEAD and update the original branch
   after everything is done.

    $ git checkout --detach master... 
    # This could  be "git checkout --detach @{bottom}"
    $ git am -s mbox
    $ git range-diff @{-1}...
    $ git checkout -B @{-1}

   In this case, the bottom of the branch should stay the same.

 * I tried to do the above, but failed at "git am" step, because new
   iteration requires to be on updated master.

    $ git checkout --detach master... 
    # This could  be "git checkout --detach @{bottom}"
    $ git am -s mbox
    $ git am --abort
    $ git reset --hard master
    $ git am -s mbox
    $ git range-diff master..@{-1} master..
    $ git checkout -B @{-1}
    # or "git branch -f @{-1}"

   In this case, I should be able to manually update the bottom of
   the branch, and making it easy (e.g. "git checkout -B @{-1}
   --set-bottom=master") is much easier and more robust than
   teaching "checkout -B" to guess my intention.

IOW, I do not mind if maintenance of the bottom of the branch is not
always automatic (and prone to heuristic making an incorrect guess).
But I think we should make sure it is easy for the user to assist
the tool to maintain it correctly [*].

    Side note: and that is what I find "frustrating" in the "notes"
    world.  "notes" can be copied after cherry-pick manually, but
    that is a very tedious process, and at some point, being "merely
    possible" stops to have much value, unless it is "easily
    doable".

There are of course other things people do to their branches, and I
do not think we need to teach all the tools used in these workflows
to update the bottom pointer automatically (even though the more we
can do automatically would make it easier for users, as long as the
automation never makes any mistakes).  Again, I think the key to the
success for this "we record the fork point of a branch" idea is to
make it easy and simple for users to help the tools to maintain it
correctly.

Thanks.

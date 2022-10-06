Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F6C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 04:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJFEUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 00:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFEUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 00:20:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35222B07
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 21:20:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s10so858603ljp.5
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i27s61RMXD6LqsIuErJAOc0RcoQpu5KRmZlMlPtZjbQ=;
        b=LTSti/3gI//dCiylcFtpjm7FMxnAjMbI8SPpfpqUn4Ivr8DIVXSY455Y5jmf/rl6J3
         FS+sTyzGirmGqSrcYTC+mM2PB1MYacWhc8CLZt/z0Of01AuIc4120nogl/0e9iMsHmiH
         iPIIvemfg/N/0qxLKIGGuBzzWmvWHQcDPv6ZHFLv94FWpSJLy8nvFLXA2nQy+jcQu4ay
         3BJN2qVJm5aDpEh1UtxY25JOySCifBxDNcCw1ek0MI/IMiS7PJK2D7yQKNZKbwLsV96E
         HoG+kkHPcXWe7NZE5HYtO0hzH8KOxITcEAoTe21oMv3jvkQcuzxtcC+HCGauJoxiMwOM
         vM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i27s61RMXD6LqsIuErJAOc0RcoQpu5KRmZlMlPtZjbQ=;
        b=vxBtoZD0KH92mePML5z2bTfrxvRf0Lsyj5Tjk9QsmW+k+EEA7Ls8qHO7fRL9gOWVKx
         woNoOFkaM4qEAQhzpAmJV93hKpZGQSrEJV3b3aNRGkxhiq8T98O3EkiZvYC9mvoxi4Vq
         WehWM6ChyyV8YAj6MClaLofJ9nU5itJXXnnUMJxin4OAR8p09pWOrJdrCYiXVrr0od5o
         ZNYitPbdVOs2e4mtIcOXGrLF6cOjzDuOaUdeuQlpiZVgr+9HI6zdit4bYzkaMtRahimY
         +rGKogrlduMqZLTxbxMS9zIb4aSQh/3V8WDDqIPxyp0d38wkk3DP4wY455QYQUnrv6wx
         Vo/w==
X-Gm-Message-State: ACrzQf0si3qL09RDYoi6ZWvqNg4kSG72sEjQBjMdw00+486wKrySNIJR
        V/wip7fE4IQaalfnv9+pZ8kPxDYjOIcV8nSNtJo=
X-Google-Smtp-Source: AMsMyM6je+fiRRAZneZZgt2LL8Nxf8KeTE5Ztx5owWdERNFAavEr+YMX71B8ATh6pzihebLqqX5i7IteX+uB8Cwe9c4=
X-Received: by 2002:a2e:7804:0:b0:26c:463c:493c with SMTP id
 t4-20020a2e7804000000b0026c463c493cmr1037538ljc.521.1665030045794; Wed, 05
 Oct 2022 21:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com> <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
 <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com> <CAESOdVByucFm=yJn2yL1mwKGqey7tHXH4A-JM-yP125Ok+_Q+g@mail.gmail.com>
 <CABPp-BH5_=Tq9DM6iAfG3+DuzEE7dR-H8rhP34x-A5FQhLO+bg@mail.gmail.com> <CAESOdVDt7SU=OJhF0mgyZ=B3sncB49aML8oOzKTKAnmGO5BaVQ@mail.gmail.com>
In-Reply-To: <CAESOdVDt7SU=OJhF0mgyZ=B3sncB49aML8oOzKTKAnmGO5BaVQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Oct 2022 21:20:33 -0700
Message-ID: <CABPp-BE12gaeWEWnqc589N+kJwqq796K5KJOHDiGduvOmQ36Gw@mail.gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with sparse-checkout
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     Victoria Dye <vdye@github.com>, Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2022 at 1:00 PM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 12:51 AM Elijah Newren <newren@gmail.com> wrote:
> >
[...]
> I agree with you and Stolee that there are two different cases: some
> people use sparse checkouts to restrict what they see (behavior A), and
> some people use it just as a performance optimization (behavior B). So I
> suspect we roughly agree about what should happen if you pass
> `--restrict` (or if that becomes the default so you don't actually need to
> pass it). My arguments were about the `--no-restrict` case. Sorry, I
> should have made that clear.
>
> I also agree that having a way to make commands restrict to certain paths
> by default is useful, and I agree that tying that set of paths to the current
> worktree's sparse spec makes sense.
>
> I'll answer the questions below for the `--no-restrict` case
> (behavior B).

I don't think your usecase matches behavior B.  I think we should
label your VFS usecase as behavior C and define it separately.  More
on that below...

[...]
> > What about merge/rebase/cherry-pick/revert?  Should those write
> > additional files to the working tree or avoid it?  What about if there
> > are conflicts outside the sparse specification?
>
> I think they should avoid it, but since the user will need to resolve
> that conflict anyway, I can see it makes sense to write them to disk
> if there are conflicts.
>
> >
> > And if extra files get written outside the sparse specification, are
> > there ways for this to get "cleaned up" where after resolving
> > conflicts or changes we can again remove the file from the working
> > tree?
>
> I've never really used `git sparse-checkout` (until I read your doc),
> but isn't that what `git sparse-checkout reapply` is for?

While that command is available for users that want to manually clean
things up proactively, my suspicion is that it is used very rarely --
especially now that we have the present-despite-skipped class of
issues fixed.  I suspect nearly all cleaning up is actually done as an
implicit side-effect of calls to unpack_trees(), which would affect
commands such `switch`, the switch-like portion of `checkout`, `reset
--hard`, `merge`, `rebase`, and many others.

All of these commands have two types of implicit clean-up they do as
part of their operation (which could be thought of as a
post-processing step): (1) marking *unmodified* files outside the
sparsity patterns as SKIP_WORKTREE in the index and removing them from
the working tree, and (2) taking files which match the sparsity
patterns which were previously SKIP_WORKTREE and flip them to
!SKIP_WORKTREE and restore them to the working tree.  I've got a few
examples of what this clean up looks like over at:
https://lore.kernel.org/git/CABPp-BHGrxLPu_S3y2zG-U6uo0rM5TYYEREZa2A=e=d9VZb2PA@mail.gmail.com/

I have no idea how this cleanup affects the VFS usecase; it's very
focused towards "sparse checkout means many files should NOT be
present in the working tree" which may be at odds with how the VFS
stuff is intended to behave.  But it's also been part of
sparse-checkout behavior the longest; for well over a decade now.

> > What about `git grep PATTERN`?  That's documented to search the
> > tracked files in the working tree.  But should that include the files
> > that would have been there were it not for the "performance
> > optimization" of not checking them out?  (Similarly, what about `git
> > grep --cached PATTERN` or `git grep PATTERN REVISION`?)  I mean, if
> > these commands should behave the same regardless of sparse
> > specification, then you should search those other files, right?  But
> > isn't that a nasty performance penalty if the user has a
> > sparse/partial clone since Git will have to do many network operations
> > to get additional blobs in order to search them?  Is that really
> > wanted?
>
> I think it's consistent to search them with `--no-restrict` (but not
> with `--restrict`, of course).
>
> > What about `git rm '*.png'` to remove all the tracked png files from
> > my working tree.  Should that also remove all the files that would
> > have been there were it not for the "performance optimization"?  Will
> > that result in very negative surprises for those with a "I want to
> > concentrate on just this subset of files" mental model?
>
> Same here.
>
> >
> > What about `git worktree add`?  Should the sparse specification be the
> > same for all worktrees?  Be per-worktree?  Should it default to dense?
> >  To just top-level sparse?  To the same sparsity as the worktree you
> > were in when you created a new one?
>
> That's an interesting case. If someone does `git worktree add` and expects
> all files to be available in the working copy, they might be surprised, yes.
> I think that's a much smaller risk than
> `git restore --source HEAD^ --staged && git commit -m 'undo changes'` being
> partial, however.

After you described the VFS usecase, I was guessing you'd answer how
you did for most of these commands.  Most of your answers do not match
the answers I'd expect for behavior B, which seems to me to support my
suspicion that you've got a third usecase.

In particular, I think the difference between Behavior B and your
usecase hinges on the expectation for the working tree:
   Behavior B: Files outside the sparse specification are NOT present
in the working tree.
   Behavior C (your usecase): Files outside the sparse specification
ARE "present" in the working tree, but Git doesn't have to put them
there (they'll be lazily put into place by something else, and the VFS
will ensure that users don't ever notice them actually missing, so far
all intents and purposes, the files are present).

In particular, that difference is perhaps most notable with `git grep`
(without --cached or REVISION flags); such a command is supposed to
search the worktree.  For Behavior B, files outside the sparse
specification are NOT present in the working tree, and hence those
files should NOT be searched.  For your usecase, as you highlight
above, you view all files as present in the working tree (even if Git
isn't the thing writing those files to the working tree and even if
they aren't technically present until you query whether they are
there), so all those files SHOULD be searched.

This difference about the "presence" of files has other knock-on
effects too.  Under Behavior B, users get used to working on just a
subset of files.  Thus `git rm '*.jpg'` or `git restore --source HEAD^
-- '*.md'` should NOT overwrite files outside the sparse specification
(but an error should be shown if the pathspec doesn't match anything,
and that error should point out how users can affect other files
outside the sparse specification).  Under your usecase, users are
always working on the full set of files and all of them can be viewed
in their working copy (as enforced by the filesystem intercepting any
attempts to view or edit files and suddenly magically materializing
them when users look) -- so users in your usecase are not expecting to
be working on a subset of files, and thus those commands would operate
tree-wide.

Similarly, under Behavior B, `git add outside/of/cone/path` should
throw an error.  If it doesn't, some future command will silently
remove the file from the working copy, which may confuse the user;
they are getting themselves into an erroneous state.  Users are
pointed to an override flag they can use if they want to accept the
consequences.  Under your usecase, since ALL files are always
"present" (but not materialized until an attempt to access is made),
that same command would be expected to run without an override and
with no error or warning.

Related to the above, under Behavior B, `git status` should probably
report the existence of any untracked files that do not match the
sparsity patterns as an erroneous condition (because why wait until
git-add to throw an error; let the user know early).  Under your
usecase, we wouldn't.


You might think I'm describing Behavior A above, but only because
Behavior A and Behavior B overlap on worktree-related operations.  The
primary difference between Behavior A and Behavior B is with behavior
of history-related operations.  Behavior B says "the working tree is
sparse, but history is dense; if I do a query on older revisions of
history (grep/diff/log/etc.) then give me results across all paths",
whereas Behavior A says "I only care about this subset of files, both
for the working tree and for history.  Unless I override,
grep/diff/etc. on history should restrict all output to files within
the sparse specification.

One potential way to (over)simplify this would be:
    Behavior A: `--scope=sparse` for both worktree and history operations
    Behavior B: `--scope=sparse` for worktree operations,
`--scope=all` for history operations
    Behavior C: `--scope=all` for both worktree and history operations

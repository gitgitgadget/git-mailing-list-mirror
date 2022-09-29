Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9D2C433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiI2T5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiI2T5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:57:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3C1ED6C1
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:57:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r62-20020a252b41000000b006af00577c42so2029956ybr.10
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv3e6bZrqeTmkYwdAIin4HLSpTbN9T77Oz/B4YS/kIc=;
        b=XnKqb7A13awwFHAS0HN7iqNW5im7OY+IwPGpukRl097i1EU6+lk4S55T8+cvLNMbF2
         UhrCaCh7B7Jz+GYC0irNljkHkKATXURdl+svh6cw5r9p+YjfynjXiQQ2Mfeol6vgIBTU
         F5ot7WsCyft7y2pdIN32casGgCxdWHSABbV1ttw+dTlo6dkqtwkKQCLPJcxs7yzoa8WT
         U2msxLyclNOtPyjSRT/fgkYBovvGvmGVw1mLFRcpt4gZx5cAofuY9nB1hx9rE88Y3UoK
         lE4YnZHs/bgdYhKrzT5mylKkb9TDQyV+2I6hnLo0X3NU1fxFcHx6KBynmz5hVMX5S0MF
         Hkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cv3e6bZrqeTmkYwdAIin4HLSpTbN9T77Oz/B4YS/kIc=;
        b=PjzXj3hrNEUEk8PPg+grk5W+oLMOAZQKox1WcaulF9EOFLHqKoAx/zu6fWQzoJCk5V
         cngvPjpDHWF2eeG3QqREYac+agBSt1kuM7AGPpR9WcGuJa6rkIVjRWNUiNazsT24FDnp
         K9kK8sFh4fuj88BkkQ4cNklOAiZXgWkmXc+TNQd7rOOmifS8MrVO+hOJ6wUz6kr39vUM
         acXiOgjiuqQSW5r78AbI7xIExpo1LRqzZxiCJ3qwnky+NUdt+tfjqvcxsmixcbMZ6Uaf
         M2cKNWRP5mzFPk2HO4FuhrkR2or6/94aFdhjtVcaAkPJfBsY8gUk/8fGmOuH2zwJGci3
         x8IA==
X-Gm-Message-State: ACrzQf3RKmaSEpH/qGsh3dOPAOYCcucU6EChvSeYyLwIJy1mKf11/1Wn
        UGksXHJX+4jb4+pIK12H1T3wpcP36aqm74atlAwA
X-Google-Smtp-Source: AMsMyM7/cythaskGAogBtwJrDlpRqFOzwpv8DkyLUqeCIK7CXjdjSM6Qbm10klzgu0cDaq86NelRhE/C+V/5pijDRHKN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:d806:0:b0:355:ea3e:cf69 with
 SMTP id a6-20020a0dd806000000b00355ea3ecf69mr1225098ywe.127.1664481448823;
 Thu, 29 Sep 2022 12:57:28 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:57:24 -0700
In-Reply-To: <a0cf68f8ba2adefae4fceeab0d438d05e355e695.1663959324.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220929195725.1420647-1-jonathantanmy@google.com>
Subject: Re: [PATCH 01/10] technical doc: add a design doc for the evolve command
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +Background
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Imagine you have three sequential changes up for review and you receive =
feedback
> +that requires editing all three changes. We'll define the word "change"
> +formally later, but for the moment let's say that a change is a work-in-=
progress
> +whose final version will be submitted as a commit in the future.
[snip]
> +Part of making the "evolve" command work involves tracking the edits to =
a commit
> +over time, which is why we need an change graph.=20

Reading later, I thought that a "change" is a connected subset of
elements in the set of metacommits, so a "change" is already a graph.
I'll mentally substitute "the concept of a change" for "an [sic] change
graph" for now - hopefully that's correct.

> +- It can be used as part of other high-level commands that combine or sp=
lit
> +  changes.

Is the current concept of a change suitable for combining and splitting?
There is divergence, but that seems like a commit being modified in 2
different ways, not a commit being split into 2.

> +Goals
> +-----
[snip]
> +P0. A commit can be obsoleted by more than one replacement (called diver=
gence).
> +P0. Users must be able to resolve divergence (convergence).

Is divergence important? It seems to me that both the internals and the
UX could be simplified if we don't allow divergence, and systems like
Gerrit don't have it either (as far as I know, in Gerrit, all commits
bearing the same Change-Id just form a sequence in the order that they
were pushed to the server, with no branching).

> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +We introduce the notion of =E2=80=9Cmeta-commits=E2=80=9D which describe=
 how one commit was
> +created from other commits. A branch of meta-commits is known as a chang=
e.

"Branch" here is confusing. Do you mean a connected set of meta-commits?

("Branch" has a specific meaning in Git - a ref of the form
refs/heads/??. If you mean that refs of the form refs/metas/?? point to
changes in a 1:1 manner, then the term "ref" is appropriate.)

> +Example usage
> +-------------
> +# First create three dependent changes
> +$ echo foo>bar.txt && git add .
> +$ git commit -m "This is a test"
> +created change metas/this_is_a_test
> +$ echo foo2>bar2.txt && git add .
> +$ git commit -m "This is also a test"
> +created change metas/this_is_also_a_test
> +$ echo foo3>bar3.txt && git add .
> +$ git commit -m "More testing"
> +created change metas/more_testing
> +
> +# List all our changes in progress
> +$ git change list
> +metas/this_is_a_test
> +metas/this_is_also_a_test
> +* metas/more_testing
> +metas/some_change_already_merged_upstream
> +
> +# Now modify the earliest change, using its stable name
> +$ git reset --hard metas/this_is_a_test
> +$ echo morefoo>>bar.txt && git add . && git commit --amend --no-edit

So up to here, I thought that we would have 2 refs metas/this_is_a_test2
and metas/this_is_a_test, with the latter's commit being one of the
parents of the former's commit. (This is because we presumably need to
be able to represent the situation in which the user checks out the
original "This is a test" commit and modifies it, so we still need to
hang on to the metas/this_is_a_test.)

> +# Use git-evolve to fix up any dependent changes
> +$ git evolve
> +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> +rebasing metas/more_testing onto metas/this_is_also_a_test
> +Done

So I'm surprised that there's no mention of this_is_a_test2 here. In
addition, linearizing a change like this doesn't seem to be described in
this document.

Having said that, I don't think that linearizing changes is important to
the goals of this "evolve" concept, so maybe one thing we can do is to
not support it at all.

Fast-forward...

> +# Fetch the latest code from origin/master and use git-evolve
> +# to rebase all dependent changes.
> +$ git fetch origin master
> +$ git evolve origin/master
> +deleting metas/some_change_already_merged_upstream
> +rebasing metas/this_is_a_test onto origin/master
> +rebasing metas/this_is_also_a_test onto metas/this_is_a_test
> +rebasing metas/more_testing onto metas/this_is_also_a_test
> +rebasing metas/unrelated_change onto origin/master
> +Conflict detected! Resolve it and then use git evolve --continue to resu=
me.
> +
> +# Sort out the conflict
> +$ git mergetool
> +$ git evolve origin/master
> +Done

This is what I expected from the evolve mechanism, so that's great :-)

The conflict resolution needs to be discussed further, though. It is
superficially similar to rebase, but with rebase, the ref being rebased
is only rewritten at the end of the process, so it is always possible to
abort halfway. Here, multiple refs are written during the process, so it
is not as easy to abort.

> +Parent-type
> +-----------
> +The =E2=80=9Cparent-type=E2=80=9D field in the commit header identifies =
a commit as a
> +meta-commit and indicates the meaning for each of its parents. It is nev=
er
> +present for normal commits. It contains a space-deliminated list of enum=
 values
> +whose order matches the order of the parents. Possible parent types are:
> +
> +- c: (content) the content parent identifies the commit that this meta-c=
ommit is
> +  describing.
> +- r: (replaced) indicates that this parent is made obsolete by the conte=
nt
> +  parent.
> +- o: (origin) indicates that the content parent was generated by cherry-=
picking
> +  this parent.
> +- a: (abandoned) used in place of a content parent for abandoned changes=
. Points
> +  to the final content commit for the change at the time it was abandone=
d.

How would the "o" parent be useful to the user?

> +Changes
> +-------
[snip]
> +Changes are also stored in the refs/hiddenmetas namespace. Hiddenmetas h=
olds
> +metadata for historical changes that are not currently in progress by th=
e user.
> +Commands like filter-branch and other bulk import commands create metada=
ta in
> +this namespace.
> +
> +Note that the changes in hiddenmetas get special treatment in several wa=
ys:
> +
> +- They are not cleaned up automatically once merged, since it is expecte=
d that
> +  they refer to historical changes.
> +- User commands that modify changes don't append to these changes as the=
y would
> +  to a change in refs/metas.
> +- They are not displayed when the user lists their local changes.

The presence of refs/hiddenmetas further muddies the already unclear
lifecycle of meta-commits and their refs. Non-hidden meta-commits get
cleaned up when their latest commit appears upstream, so they may get
deleted when the user doesn't expect it (especially if the user is
using, say, a prefetch mechanism that downloads refs at night). We're
adding to this a class of refs that don't get cleaned up at all.

Besides the disk space taken by the meta-commits, having more refs
typically reduces performance e.g. because all refs generally take part
in packfile negotiation during fetching. (And they probably should
continue with this behavior because sharing meta-commits is one of the
features we want.) So I think that having a clear cleanup strategy is a
good idea, and permanent archiving probably shouldn't be it.

> +Change creation
> +---------------
> +Changes are created automatically whenever the user runs a command like =
=E2=80=9Ccommit=E2=80=9D
> +that has the semantics of creating a new change. They also move forward
> +automatically even if they=E2=80=99re not checked out. For example, when=
ever the user
> +runs a command like =E2=80=9Ccommit --amend=E2=80=9D that modifies a com=
mit, all branches in
> +refs/metas that pointed to the old commit move forward to point to its
> +replacement instead.

What happens in the following?

  $ echo "hello" >hello.txt
  $ git add hello.txt
  $ git commit -m "hello"
  $ git tag hello
  $ echo "one" >hello.txt
  $ git commit -a --amend # this updates refs/metas/hello
  $ git checkout hello
  $ echo "one" >hello.txt
  $ git commit -a --amend # does this update refs/metas/hello too?

> +Sharing changes
> +---------------
> +Change histories are shared by pushing or fetching meta-commits and chan=
ge
> +branches. This provides users with a lot of control of what to share and
> +repository implementations with control over what to retain.
> +
> +Users that only want to share the content of a commit can do so by pushi=
ng the
> +commit itself as they currently would. Users that want to share an edit =
history
> +for the commit can push its change, which would point to a meta-commit r=
ather
> +than the commit itself if there is any history to share. Note that multi=
ple
> +changes can refer to the same commits, so it=E2=80=99s possible to const=
ruct and push a
> +different history for the same commit in order to remove sensitive or ir=
relevant
> +intermediate states.

It looks difficult to remove such intermediate states, but maybe that
doesn't have to be dealt with in the initial design.

> +Checkout
> +--------
> +Running checkout on a change by name has the same effect as checking out=
 a
> +detached head pointing to the latest commit on that change-branch. There=
 is no
> +need to ever have HEAD point to a change since changes always move forwa=
rd when
> +necessary, no matter what branch the user has checked out
> +
> +Meta-commits themselves cannot be checked out by their hash.

This is the same behavior as for annotated tags, but I guess we can't
use them because those can only have one referent.

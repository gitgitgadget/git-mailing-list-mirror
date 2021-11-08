Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF8C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6524F61994
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhKHWg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 17:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbhKHWg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 17:36:27 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4534C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 14:33:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l7-20020a622507000000b00494608c84a4so9413439pfl.6
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 14:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=bgaDmYn0PKgBLLvWzS2vBL+Sj8IDfCM/RCQ6SplC8nA=;
        b=UFxycx5rhhoWjCajXl9/lS+Q7CLgMGUIM9FZVudCIHWrGre6qJirfhwlobvLZTxe7T
         YhEHGQypObdpvY4HezE7sNIfKGI+Ha3Ej+OZCSIkiTFkZ59lisGpfSTuX9/jNcuP4g0s
         bee3dN7sPapJYnW7rwu1uF+Cse0pVoZYDYRl5S+6n2eYWxnT7s2sOj0y+M4+pzYC7SJ6
         npY1kp3+DH1CEC17/95JhEhxoZT/mLp767qw3bJPrkS5QGES9KqjA8aZ0NVA6wMkhC9X
         ytRHMOkUbBvj/U/4AK3PSPJUrtro8nxLnB0v1tCEuABPYKIirHedyrpFVoQyPKds+oHc
         90Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=bgaDmYn0PKgBLLvWzS2vBL+Sj8IDfCM/RCQ6SplC8nA=;
        b=eK0XAZ9HwhF4fYYt0lyqdBU3EBj7nreSjdGk8VH8IdrhvPOVmoacridlGZqi6QuvPj
         OY4fwpSElII0P1XugEHrTpTvC0i6XWKvMp2INw6uDQaqWWWFJhpYDMrjdPQpyniqUM15
         AWIH6UDI6FvBpfEz+YdaH/btAd6+KDc2erTVi4C8ffvDwRZ9L/f4bgV9jK/EOishceuH
         0VxvJZwRMMNsHHNQaxExFm1a+BEwUkivYLhJKD3DqAgMD7yzeF8If47q3PnxNurxcvL9
         LSR0AN1TPgSL2U2QwWxvkD9wMTgrkH4xpnrCoN4QTlbrcPSWZ+P9vkUlbSZ9x5qRtMbz
         gE5w==
X-Gm-Message-State: AOAM533y8tUZa+hrApE+/N+EF7KkEFEgxkOXloqdqGOTCJQ91mA+LjAc
        3+2HwF2/MxHRb8Azdwr3ackrzKmz+hC4YfFRaNrFxMLVhBR+F615ZdRBo446DSldizhyxmqRAmh
        H8rjF4Oo3TZelN3XSoAH+M1117IU89t/KNU6dP4uD1WbdafnoWxlD0/F1E9hJSEA=
X-Google-Smtp-Source: ABdhPJzNz1ZnEw/QDedZvi28WqbKDMNsYqkpktli59Za8XrT1WUhiLZeok/rl3B7mgo5Hn7sODspHhD2wgFcOg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7d96:b0:142:87dc:7dd3 with SMTP
 id a22-20020a1709027d9600b0014287dc7dd3mr2284265plm.11.1636410822305; Mon, 08
 Nov 2021 14:33:42 -0800 (PST)
Date:   Mon, 08 Nov 2021 14:33:40 -0800
Message-Id: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: [RFC] Branches with --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Original Submodule UX RFC/Discussion:
https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

Contributor Summit submodules Notes:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbj=
f.bet/

Submodule UX overhaul updates:
https://lore.kernel.org/git/?q=3DSubmodule+UX+overhaul+update

Hi all! Building on Emily=E2=80=99s original RFC, here is a more fleshed ou=
t
vision of how `git {switch,checkout,branch}` will work with
submodule-native branches.

The "Background" section reframes the justification and mental model
behind our proposed workflow in more explicit terms (see "Submodule UX
RFC:Overview"). The "Design" section presents the rules we are using to
implement "Submodule UX RFC:Detailed Design", and how certain corner
cases should be handled.

I=E2=80=99d appreciate any and all feedback :) In particular, readers may b=
e
interested in the "dirty worktree" approach behind `git switch`. If
anything stands out as good, bad or missing, do let us know. Thanks!

=3D=3D Background

The purpose of this effort is to bring the benefits of branches to
superprojects. In Git, branches are used to name and track progress;
submodules are used to incorporate other repos. However, because of how
submodules are tracked by superprojects, submodules usually operate in
detached HEAD and the benefits of branches are lost. For users
uncomfortable with detached HEAD, this workflow seems risky and
unintuitive. Other users may still prefer branches because they can have
branch reflog and they can be confident that submodule work is being
tracked by some branch and won=E2=80=99t be gc-ed.

The main ideas are:

* there is a single set of branch names that are used throughout the
  repo tree
* progress can be made on submodules and/or the superproject without
  requiring a gitlink update on the superproject
* the user can switch between branches like they would for a
  non-submodule-using repo.

We do not require the branches to move in lockstep, thus this UX may be
suboptimal for logical monorepos that are implemented as submodules.

=3D=3D Design

This design uses the same branch name in the superproject and
submodules; a user who sees the branch `topic` in the superproject and
submodules knows that they are the same logical thing. Commands with
--recurse-submodules maintain the invariant that branches in the
superproject and submodules are {read,created,modified,deleted}
together.

e.g.

* `git branch --recurse-submodules topic` should create the branch
  `topic` in each of the repositories.
* `git switch --recurse-submodules topic` should checkout the branch
  `topic` in each of the repositories

In a superproject-submodule relationship there is some ambiguity in what
=E2=80=98checkout the branch `topic`=E2=80=99 should mean (does the submodu=
le use its
topic branch, or the version recorded in the superproject=E2=80=99s gitlink=
?).
Our approach is to preserve existing semantics where reasonable - the
ref name refers to the superproject=E2=80=99s ref, just as it does without
--recurse-submodules.

One wrinkle is that a user can act on submodules _without_ going through
the superproject (e.g. by cd-ing into the submodule), thus the branch
tips may not match the expected commits in the superproject or the set
of submodules branches may not match the set of superproject branches.
As such, submodule branch names are resolved on a best-effort basis:

* If the submodule branch commit matches the one in the superproject, we
  can safely use the submodule branch.
* If the branch is in an unexpected state, we either:
** Fallback to the version that the user would expect (if it is safe to
    do so).
** Reject the operation (if it is not safe).

As we expand submodule branches to other commands (merge, rebase,
reset), the notions of =E2=80=98unexpected state=E2=80=99 and =E2=80=98safe=
ty=E2=80=99 become
increasingly nebulous and difficult to define because they depend on the
command being run. To manage this, we will start by supporting submodule
branching under a limited set of circumstances and try to loosen them in
the future. We will manage the user=E2=80=99s expectations by warning them =
if
Git detects an unexpected state.

The proposed rules for submodule branching are as follows:

=3D=3D=3D Switching _from_ a branch `topic`, i.e. `git {switch,checkout}`

Check `topic` if each submodule=E2=80=99s worktree is clean (except for
gitlinks), and has one of the following checked out:

* `topic`
* the commit id in the superproject gitlink

This allows the user to switch with a dirty worktree (with respect to
the superproject). We consider this acceptable because the submodule
commits are tracked by the submodule branch. This is helpful when a user
needs to switch branches before they are ready to commit to the
superproject.

=3D=3D=3D Switching _to_ a branch `topic`, i.e. `git {switch,checkout} topi=
c`

Switch to `topic` in the superproject. Then in each submodule, switch to:

* `topic`, if it exists
* Otherwise, the commit id in the superproject gitlink (and warn the
  user that HEAD is detached)

If the submodule `topic` points to a different commit from the
superproject gitlink, this will leave the superproject with a dirty
worktree with respect to the gitlinks. This allows a user to recover
work if they had previously switched _away from_ "topic".

If a dirty worktree is unacceptable, we may need an option that is
guaranteed to check out the superproject=E2=80=99s `topic`.

=3D=3D=3D Creating a branch `topic`, i.e. `git branch topic start-point`

Check each submodule at the superproject=E2=80=99s `start-point` (not the
submodule=E2=80=99s `start-point`) for the following:

* The submodule is initialized (in .git/modules)
* `topic` is a valid branch name

If so, create `topic` in the superproject and submodules based on the
superproject=E2=80=99s `start-point`. Else, do not create any `topic` branc=
hes
and guide the user towards a possible fix:

* A --force option that will move the branch tip to the commit in the
  superproject. This will let the user overwrite the history of `topic`.
* An --ignore option that ignores the existing `topic` branch. If used,
  `git switch topic` would result in a dirty worktree.
* (If needed) An --adopt option that creates a new superproject commit
  that points to the existing submodule `topic` branch. This will let
  the user checkout `topic` without ending up with a dirty worktree.
* For uninitialized submodules, prompt them to initialize it via git
  checkout start-point && git submodule update (we are working to
  eliminate manual initialization in the long run, so this will become
  obsolete eventually).

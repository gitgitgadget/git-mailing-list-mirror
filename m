Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2ABEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 08:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGKIZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGKIY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 04:24:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC0E6B
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 01:24:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977e0fbd742so682812566b.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-net.20221208.gappssmtp.com; s=20221208; t=1689063895; x=1691655895;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4Nc/xS4u3ocXm2/gZbZZRnlYWGvvhLbgAupbE3QKnM=;
        b=JICWIvE8wUkmulc2w2lwXwUu2Fd0cexxXmp6XmQ2OKDB6QKbpzJ/HovAaQ0h6/YJI4
         aKsAXeM5mtt2JjzxKFOZ1dmccqGf3r9NaFu81g5PTetvxs1NYRfO/ZHbSSWTzUEFZ254
         Vu4t9EImyWZaQzaZtvsVXnjgWnOMt27OWBxpVdq15pdsEilbHOXlAw4kthuSKaH/a73L
         ysY4lhl83LyueiQDrk1lfc+xFHBc32IQav7U+pJYoDjbJXSLDylJEqeHarjThB0HQeiS
         1lyKPTJo2ztm3XFBECU60OmhN5ECEDccpTV9jQdMhpASJi0NTKmaE0fzxi8vQeqPWmkZ
         9GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689063895; x=1691655895;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4Nc/xS4u3ocXm2/gZbZZRnlYWGvvhLbgAupbE3QKnM=;
        b=jVMg7FDryVKrJcAAPal9vTJV3Q1y47kkqRHkyoD/3HvEpDmO3Mgr7isp22fM5i8r1z
         bjqx1aMZjrH1IGheqXLgpzpn+dcX8mwgEUnfijiwWUvBRzxZIbxlkg5hNq4YuTGlzB6w
         i59QxskFbwqOJKS89N4AsCKJ0zsKvwzFbxKpUKO9LPrmVaPLPw8RKLQHXLCp4qmQaPV0
         bLN0SPnURJCyi58ZK/xFnAJj/p/khTtNbNy0D2K9ZonjGOWgzOMyLWmboGDnrL0hi0+F
         SB8/gMsZjKG38HbBXreouaa58jLGb0HHvqBfgmAt+dq0bfSY4NmaqDacv2MVCqqlz7uI
         +VQw==
X-Gm-Message-State: ABy/qLbLW8/tft9BU8F+OP1Hgt6oWPynXS8vVLrL8TSC/aeqni9CLbYv
        rgIA5FsYdhOWaF55pGPtpMyiRS2/w+TrEcilKzfx9Q==
X-Google-Smtp-Source: APBJJlGWJlKkxZc89Gm/y0Brq5Dus/EATH6lmOF0rGfT0FY8aP1AofZG0MuLMApXLZ7L6eJFO7qKcw==
X-Received: by 2002:a17:906:1096:b0:993:f8b2:d6fa with SMTP id u22-20020a170906109600b00993f8b2d6famr9707605eju.21.1689063895020;
        Tue, 11 Jul 2023 01:24:55 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id o16-20020a1709062e9000b00992ea405a79sm809830eji.166.2023.07.11.01.24.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 01:24:54 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-991fe70f21bso682333066b.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 01:24:54 -0700 (PDT)
X-Received: by 2002:a17:906:1859:b0:98e:2c13:c44d with SMTP id
 w25-20020a170906185900b0098e2c13c44dmr11671021eje.68.1689063893865; Tue, 11
 Jul 2023 01:24:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ak@akorzy.net
From:   =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
Date:   Tue, 11 Jul 2023 10:24:42 +0200
X-Gmail-Original-Message-ID: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
Message-ID: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
Subject: Beyond Merge and Rebase: The Upstream Import Approach in Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git users often have to make a choice: to merge or rebase. I'm going
to describe a third way that has the characteristics of both and is
very well suited for tracking an open-source project or any other
upstream branch. I'm looking for feedback on the approach.

MERGE OR REBASE?

Let's assume that you have forked an upstream open-source repository
and keep the fork in your own repo. The default branch of the upstream
repository is called "main" and is called the same in your own fork.
You have made a few changes to the source code and committed them to
the "main" branch of your fork. In the meantime, new changes have been
committed to the upstream "main" branch of the project. How do you
import the upstream changes to your fork?

Let's assume that your local fork also contains a branch called
"upstream/main", which reflects the state of the upstream's "main"
branch. So the "main" branch contains your own changes and the
"upstream/main" branch contains the community's changes:

  time -->

  o---o---o---o---o  upstream/main
       \
        o---o---o  main

So a different way to ask the question is: how do you bring
upstream/main's changes into main?

One solution is to merge "upstream/main" into "main":

  o---o---o---o---o  upstream/main
       \           \
        o---o---o---M  main

The merge above would certainly work, but it becomes problematic as
time passes and you get a lot of these merges in your "main" branch.
You then no longer have visibility into the differences between
"upstream/main" and "main", because your commits get lost deep in the
history of the branch, as illustrated below:

  o---o---o---o---o---o---o---o---o---o---o  upstream/main
       \           \       \       \       \
        o---o---o---M---o---M---o---M---o---M  main

So the alternative solution is to rebase your "main" branch on top of
"upstream/main":

  o---o---o---o---o  upstream/main
                   \
                    o'---o'---o'  main

You now have the advantage of having greater visibility into the
differences between "upstream/main" and "main". However, a rebase
comes with a different problem: if any user of your fork had the
"main" branch checked out in their local repository and they run "git
pull", they are going to get an error stating that the local and
upstream branches have diverged. They will have to take special steps
to recover from the rebase of the "main" branch.

So how to solve that problem?

THE THIRD WAY - UPSTREAM IMPORT

The proposed third way is a special operation that (in the described
use case) has the advantages of both a merge and a rebase, without the
disadvantages. The approach is illustrated below:

  o---o---o---o---o  upstream/main
       \           \
        \           o'---o'---o'
         \                     \
          o---o---o-------------S  main

First, the divergent commits from "main" are rebased on top of
"upstream/main", but then they are combined back with "main" using a
special merge commit, which has a custom strategy: it replaces the old
content of "main" with the new rebased content. This last commit is
the secret sauce of this solution: the commit has two parents, like an
ordinary merge, but has the semantics of a rebase.

The structure above has the advantages of both a merge and a rebase.
On the one hand, just like with an ordinary merge, a user who runs
"git pull" on their local copy of "main" is not going to see the error
about divergent branches. On the other hand, just like with an
ordinary rebase, there is visibility into the last imported commit
from "upstream/main" and the differences between that commit and the
tip of "main".

DROPPING PATCHES

What is supposed to happen if one of the commits from "main" is ported
to "upstream/main", as illustrated below?

  o---o---o---A'---o  upstream/main
       \
        \
         \
          A---B---C  main

In that case, the upstream importing operation should drop that patch,
as illustrated below:

  o---o---o---A'---o  upstream/main
       \            \
        \            B'---C'
         \                 \
          A---B---C---------S  main


But how would the upstream importing operation know which patches to
drop? There are one of two ways.

Firstly, it can look at the git's patch-id, which is the SHA of the
file changes with line numbers ignored. This is the same strategy that
rebase uses to drop duplicate commits.

Secondly, it can use an arbitrary change-id associated with a commit
(for example, for projects that use Gerrit, it can be the Gerrit's
Change-Id, which is saved in the commit message). This is useful when
a given patch lands upstream in a slightly changed form, but is meant
to replace the version in "main".

IMPLEMENTATION

The solution above has already been implemented in an open-source
Python script called git-upstream[1], published 10 years ago. It was
originally implemented for the OpenStack project, but the solution is
generic and applicable to any open-source project. It is going to be
easier for users to benefit from the ideas behind git-upstream if the
functionality is integrated directly into git.

Would you like to see the above functionality integrated directly into git?

Best regards,
Aleksander Korzynski

www.linkedin.com/in/akorzy
www.devopsera.com/blog

P.S.

For completeness, I'm providing links to alternative solutions for
tracking patches:

* git-upstream[1] uses the strategy described above
* quilt[2] uses patch files saved in a source code repository
* StGit[3] is inspired by quilt and uses git commits to store patches
* MQ[4] is also inspired by quilt and implements a patch queue in Mercurial

[1] https://opendev.org/x/git-upstream
[2] https://savannah.nongnu.org/projects/quilt
[3] https://stacked-git.github.io
[4] https://wiki.mercurial-scm.org/MqExtension

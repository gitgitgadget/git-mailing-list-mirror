Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B2A1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 01:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfJIBho (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 21:37:44 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:46535 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfJIBho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 21:37:44 -0400
Received: by mail-io1-f45.google.com with SMTP id c6so1240403ioo.13
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 18:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/+E/IlpKuYddPk0vHbnRxNZuwhgce8P88YR7UekGkKM=;
        b=NUmQZV42qi1+JuYkQy9cQn2DkKWx3ODRAHldF/w7Bmo5RHiDubHCFxw7oi2EVqUGZi
         FXmH7zgE0Ux66sN8bkEKsQ8pg8fB/YkFGF4h0DJcgFpXMgguBtd1LkVPArQp5nAl3gqi
         DCIwKyqSPlq37JavaXuGCIaSUXJG5mJ89ywXCBguZVY/cIo/g2Djv2trDU4cBuRoUOhN
         2LQ+GD4Fj6ezUnNGS3tHQcYWWa7sZ0/wySLRlHWtJly/hg8s7WA7HmYJROzV8lzX6XrR
         h5eQO5MCXUJb17tsGuJ08ixJp6k6OJJdC3YIVxiuQ7pfSub6ot8PaOdrZ0JlPVl4RQLm
         Y2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/+E/IlpKuYddPk0vHbnRxNZuwhgce8P88YR7UekGkKM=;
        b=d4yRcMHNmll07sGFgvKT/qKcS+A0BIoR4Y8LkUkNsO1W63eb2LOcD7GnhEuv21eEEa
         igroW5v/t2G8J116CBDYm284LuFmjfiXUUCkYWVQZ1qqHuI8bGDw6Im9ShqWcxoi3ilu
         kcoPR+VrcN6gqLeRP/eYD+mvRqbXMvBp/EPhL0NqZhJk+nmYaxHN6oLmB0diCQhYqJSz
         wycQU1Ygq2LHckJ0Ha0Rj1yu6ulGw0b/6cSLCgQYW5sCZKkIQz6DBfyzoDMTk2P6Rv1w
         PSwiJT565/HUMJsoA5tjmmUYMx2jjeNXcUC5JNFHCDg384o3ze6lGFhNv5P6tjgaxY19
         rQ1Q==
X-Gm-Message-State: APjAAAVjCRj1RbFaXrso1vpImVLl0dd05QUVQiiun+VZ03Oc19OHWayF
        zyFuQZHdQjFQd3k2VgFg3ghjZPS0kNs2z4zZR2eZUVgE
X-Google-Smtp-Source: APXvYqxqXxfoTM6bK2BZ7zV8gJmQcCE+2MxjJL3mlnn/sVXNAWqloBKos9pix5ed32Z5IDoHwp2P4WVPHnM2Ybe0PYU=
X-Received: by 2002:a92:6a04:: with SMTP id f4mr824417ilc.252.1570585063161;
 Tue, 08 Oct 2019 18:37:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dominik Salvet <dominik.salvet@gmail.com>
Date:   Wed, 9 Oct 2019 03:37:27 +0200
Message-ID: <CAEXP2g8-reK+u2FaO=mMP-nsvuDDWGpwV_tyKG5L5XpU=1LQeg@mail.gmail.com>
Subject: Fetch origin/HEAD during git fetch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git community!
Imagine a repository initialised using git init. Then, a remote (e.g.,
origin) is added. Now, I want to fetch all branches, tags and commits
from the prepared remote to fill the local repository up for the first
time and do it as quick as possible. I want the origin/HEAD reference
to be fetched as well, and this is where the problem is - I don't know
how to do it optimally.

To summarise it, I want the following:

* Prepare a repository as quick as possible
* No local branches in the repository
* No files in working tree after downloading
* Working tree must be available (for further checkouts)
* Keep the information about its default branch (origin/HEAD)
* Updates can be fetched using a git fetch (ideally a plain one)
* The repository will not be ever used for pushing (it does not have
to be disabled)

Three sub-optimal solutions I have considered:

1) `git fetch origin && git remote set-head origin -a`
2) `git fetch origin +refs/heads/*:refs/remotes/origin/*
HEAD:refs/remotes/origin/HEAD`
3) instead of git init and remote, use directly `git clone --no-checkout`

The first solution is not suitable due its delay caused by remote
access (2 separate invocations). For smaller repositories, delays of
these individual commands are almost comparable. However, this
solution is semantically exactly what I want.

The problem with the second solution is that it will create
origin/HEAD as a commit hash, not as a symbolic reference to a branch
(e.g., master). When master branch gets updated, it may cause problems
with further update fetching using a plain git fetch. Also, this
solution doesn't look very familiar and stable.

The third solution has several problems. The first one is the created
default local branch. So delete it. However, to delete it, I need to
checkout another commit and that modifies working tree, which can
cause unnecessary delay (namely for bigger repositories) as it may
(and will in most cases) be checked out to another commit later. Then
I can finally remove the local branch (after getting its name,
though).

If you wonder which applications I need such restrictions for - I am a
developer of GitPack, a very simple Git-based package manager, and I
would like to solve the mentioned problem to improve storing
downloaded repositories in GitPack cache. It would allow GitPack
projects to use a different default branch than master branch, which
is currently hard-coded in GitPack.

I hope everything is clear. If not, do not hesitate and ask me. I
would really appreciate your help.

Thank you for all your effort
-- 
Dominik Salvet

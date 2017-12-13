Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058EF1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 17:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbdLMRcb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 12:32:31 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:33144 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753409AbdLMRca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 12:32:30 -0500
Received: by mail-it0-f45.google.com with SMTP id o130so21497616itg.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ov3N67ye3df82MKo8dFxhI39dvhFfJi1dyu/XtEaRu4=;
        b=kHoK1RLI+HmeGAsQQdA5QVLJxjQnSI6dpJa872E5UVkcKT20nUrXUchVJUGQpZ0FvN
         bvskL6CQi849WU6m9nTh8Q+aunNEHN95Z1/KyeKW/EgnidVBNqXZJ1KHYyNrcIyeoVvs
         9qBHjToaFq4RTa7LWHswsfId2tduaEem9GdQOURaynGK95aKyy6e9DOBhQEMOPApO/w0
         D6i6FQHxQGwece8rhrRcRweuN8g7B2KEqYOkvHGxBk/HweLNkYkM/Qy8gCMuPUDZTUpu
         kgy/GSefTfc9ozeVPhckUyrKAZJ6CqUwr94BxzxP/sQVz/8pSgMxD7TvzumSpZinRKLP
         kGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ov3N67ye3df82MKo8dFxhI39dvhFfJi1dyu/XtEaRu4=;
        b=jBt8/jTSEc5QfJnQO/NI3yTyfT8aQWueYfEPUIhm283Dm2/487YAuUURLAW+ljR1yw
         egy0qosKJOTd5+BTn3QprnA48KpvnpDyfhIL5MPuD3ztOhv5G8dT+Xqgv//xfJEbIaxm
         yCbl0drZN3EJyvOBKixqL2V5hfnSqLJzXUuw+DVL18QIaaZDxq69HW7fAKEP+dvJ0wi9
         MHDTlTXEstoN5E4x4boVqFtGr7YGCSLSVdG9JGGpZNWL+wr30seKNnpP9pkTh68JKDV0
         EdHlsEDpjyNeqwauYi7rJLHb8zrntJl+oLkOdKzuZrGwYQqFEaywgab4buSqjqQU8KFk
         mRBg==
X-Gm-Message-State: AKGB3mLSH3lBY3XG5rGOs/ELrF9HocAPJDlDUTEcQ5T91WDNOopLzbrf
        trGHnhdRBn3UYuWySnTnkHo/KFiCeZl65jQHg+a/I7ma
X-Google-Smtp-Source: ACJfBovYKOjCnc7epg3wHiv9mPfLphIPp60GfSam4SGwPDEYgqUvx+iJbXY6kiFK3ByLdjk4wJJB9ZUoGPrWdSgkkBY=
X-Received: by 10.36.53.20 with SMTP id k20mr3626452ita.21.1513186349920; Wed,
 13 Dec 2017 09:32:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.89.24 with HTTP; Wed, 13 Dec 2017 09:32:09 -0800 (PST)
From:   Reid Price <reid.price@gmail.com>
Date:   Wed, 13 Dec 2017 09:32:09 -0800
Message-ID: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
Subject: Apparent bug in 'git stash push <subdir>' loses untracked files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git stash push <subdir>' if there are both tracked and
untracked files in this subdirectory, the tracked files are stashed
but the untracked files are discarded.

I can reproduce this on my system (OSX, git 2.14.1) by running the
below script as

    bash -x ./stashbug.sh &> output.txt

I could not find this indicated anywhere as an existing issue by
performing generic searches, apologies if this is known.

  -Reid

Contents of stashbug.sh
------------------------
    #!/bin/sh

    uname -a
    git --version
    mkdir -p stashbug
    cd stashbug
    git init
    mkdir dir
    touch dir/tracked
    git add dir/tracked
    git commit -m 'initial'
    tree; git status
    mkdir dir/untracked_dir
    touch dir/untracked_dir/casualty1
    touch dir/casualty2
    echo 'contents' > dir/tracked
    tree; git status
    git stash push dir/
    git stash show -v
    tree; git status
    git stash pop
    tree; git status
------------------------

Resulting output.txt
---------------------
    + uname -a
    Darwin Reids-MacBook-Pro.local 15.6.0 Darwin Kernel Version
15.6.0: Tue Apr 11 16:00:51 PDT 2017;
root:xnu-3248.60.11.5.3~1/RELEASE_X86_64 x86_64
    + git --version
    git version 2.14.1
    + mkdir -p stashbug
    + cd stashbug
    + git init
    Initialized empty Git repository in /Users/reid/git/stashbug/.git/
    + mkdir dir
    + touch dir/tracked
    + git add dir/tracked
    + git commit -m initial
    [master (root-commit) 895197e] initial
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 dir/tracked
    + tree
    .
    =E2=94=94=E2=94=80=E2=94=80 dir
        =E2=94=94=E2=94=80=E2=94=80 tracked

    1 directory, 1 file
    + git status
    On branch master
    nothing to commit, working tree clean
    + mkdir dir/untracked_dir
    + touch dir/untracked_dir/casualty1
    + touch dir/casualty2
    + echo contents
    + tree
    .
    =E2=94=94=E2=94=80=E2=94=80 dir
        =E2=94=9C=E2=94=80=E2=94=80 casualty2
        =E2=94=9C=E2=94=80=E2=94=80 tracked
        =E2=94=94=E2=94=80=E2=94=80 untracked_dir
            =E2=94=94=E2=94=80=E2=94=80 casualty1

    2 directories, 3 files
    + git status
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working direct=
ory)

        modified:   dir/tracked

    Untracked files:
      (use "git add <file>..." to include in what will be committed)

        dir/casualty2
        dir/untracked_dir/

    no changes added to commit (use "git add" and/or "git commit -a")
    + git stash push dir/
    Saved working directory and index state WIP on master: 895197e initial
    + git stash show -v
    diff --git a/dir/tracked b/dir/tracked
    index e69de29..12f00e9 100644
    --- a/dir/tracked
    +++ b/dir/tracked
    @@ -0,0 +1 @@
    +contents
    + tree
    .
    =E2=94=94=E2=94=80=E2=94=80 dir
        =E2=94=94=E2=94=80=E2=94=80 tracked

    1 directory, 1 file
    + git status
    On branch master
    nothing to commit, working tree clean
    + git stash pop
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working direct=
ory)

        modified:   dir/tracked

    no changes added to commit (use "git add" and/or "git commit -a")
    Dropped refs/stash@{0} (93ceee344b947ecd8a27a672e3aedd2b2e1acc99)
    + tree
    .
    =E2=94=94=E2=94=80=E2=94=80 dir
        =E2=94=94=E2=94=80=E2=94=80 tracked

    1 directory, 1 file
    + git status
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working direct=
ory)

        modified:   dir/tracked

    no changes added to commit (use "git add" and/or "git commit -a")
---------------------

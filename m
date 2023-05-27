Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E355C77B7E
	for <git@archiver.kernel.org>; Sat, 27 May 2023 17:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjE0R5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 13:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE0R5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 13:57:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CEDF
        for <git@vger.kernel.org>; Sat, 27 May 2023 10:57:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so3143818a12.2
        for <git@vger.kernel.org>; Sat, 27 May 2023 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685210267; x=1687802267;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mGyPV0h+HIlJ25CyjvCwA/2/o7pUJ4vTloHXZYe2xXs=;
        b=XyOJUpB5cDMdkL+Y0UyWsn9u1x9MlG5eiDqEdcW7Bksf9Af6wI24KAz32R52bOd63c
         2O9RhUFvUepb5BuWrVMduzTXryhIWut/hQ3/RhMCdrA6ahTL+bAAL/mTu2/uhf+eCp3H
         DsxhYIjXNByHbBMeP9NNKPFeGwLgSjlEUuZJtyHCKvcq9l3FbUR+SJufeB7CD9vUzGtn
         p9G8jUSLhadywMryBxhHms68cLcriPwMvoL/sMWjoeCtXtd6ekg3lWmbg2v4zTN+pUjB
         79MVCAjucIzGw4dkp1hbPBhAyl6vdd9Z/KJIgQgG+VUQwRyw5cbfG1iOXCK/DPEPQNvA
         dyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685210267; x=1687802267;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGyPV0h+HIlJ25CyjvCwA/2/o7pUJ4vTloHXZYe2xXs=;
        b=W9F8aN9aT5dCcN2zIKSAhRrBEXW0qnrBYYFx8alBNlTLTYvkOY/aB50V/ImjpJEMO5
         10KvOxELPtcKsb820cvkyuVZ7GChXkUNmKCfaxH7R4NL6J5WtJaDDLnR0rxhvknUT2Zp
         k0Lyb3kBMKjUXzsOYbyr3yGu3wdPBQGGGmM9mq1HQIVpdwYY7XI5uMVNckf+ABY8MM8Y
         bFptHkUVBazS8rkaWONwL8olPSifrQHaMtZqNBdGs2N7E21t/Cbn76BiKwYdvdqlxA62
         y3i5lx7PPRuoaCXBduc7YNrZEZ+bOLmnQlXrRzdiLYRO7TXV/DiJ0oWEyrexNI/UwaLv
         1tDA==
X-Gm-Message-State: AC+VfDzeXfTyp6lTAnOR35QHzGX7xJJ4JsLgbogV1KuVRzczhua0xtvp
        DodhrpD/wL1fi+CojPVy4CaHnlRVtgUNdrT8+2m2CA8zWrw=
X-Google-Smtp-Source: ACHHUZ57FsdJln8nDIEIyPZIrlE/ENPq2eN/Vy7HDLaEbO4NFIWFRkacCGz6vHowuonNNMVYEsuayj0pr6Mifh6iAt8=
X-Received: by 2002:a17:907:3f93:b0:96f:ddaa:c30f with SMTP id
 hr19-20020a1709073f9300b0096fddaac30fmr6299691ejc.13.1685210266591; Sat, 27
 May 2023 10:57:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:971b:b0:96f:b49e:ff3d with HTTP; Sat, 27 May 2023
 10:57:45 -0700 (PDT)
From:   Fraser Hanson <fraser.hanson@gmail.com>
Date:   Sat, 27 May 2023 10:57:45 -0700
Message-ID: <CA+3o5aPQ3BkbAn3u6qSMCkAfNgTcpjT+_ikdqAkkc69NBGybpw@mail.gmail.com>
Subject: git fetch recursion problem
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some git repositories in a state where `git fetch` recursively
spawns subprocesses until all system resources are used up and the OS
locks up.
This has been reproduced on debian with git 2.39.2, and on macos with
git 2.40.1.

The repositories being tracked are mirrors of github repos, within a
secure corporate environment.

During the problem, the `ps aux` output looks like this:
    fhanson     3187  0.0  0.0  11400  5092 ?        S    12:58   0:00
             \_ git fetch --recurse-submodules --tags --force
--progress
    fhanson     3195  0.0  0.0   9932  3372 ?        S    12:58   0:00
             |   \_ /usr/lib/git-core/git remote-https origin
https://repomirror.eng.corporate.com/github-neovim/lewis6991/gitsigns.nvim.git
    fhanson     3207  0.3  0.0 101608 16004 ?        S    12:58   0:00
             |       \_ /usr/lib/git-core/git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/lewis6991/gitsigns.nvim.git
    fhanson     3555  0.0  0.0  10292  4788 ?        S    12:58   0:00
             |           \_ /usr/lib/git-core/git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    fhanson     3583  0.0  0.0   9932  3956 ?        S    12:58   0:00
             |               \_ /usr/lib/git-core/git remote-https
origin https://repomirror.eng.corporate.com/github-neovim/lewis6991/gitsigns.nvim.git
    fhanson     3592  0.3  0.0 101600 16156 ?        S    12:58   0:00
             |                   \_ /usr/lib/git-core/git-remote-https
origin https://repomirror.eng.corporate.com/github-neovim/lewis6991/gitsigns.nvim.git
    ... repeating forever!

The git config for these repositories looks like this:

    $ cat .git/config
    [core]
        repositoryformatversion = 1
        filemode = true
        bare = false
        logallrefupdates = true
    [submodule]
        active = .
    [remote "origin"]
        url = https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        promisor = true
        partialclonefilter = blob:none
    [branch "master"]
        remote = origin
        merge = refs/heads/master

The git trace output looks like this (some server names redacted):
    $ export GIT_TRACE=1
    $ git fetch
    07:41:19.325652 git.c:439               trace: built-in: git fetch
    07:41:19.330118 run-command.c:655       trace: run_command:
GIT_DIR=.git git remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:19.337765 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:19.338220 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:20.664527 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:20.679814 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:20.681735 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:20.692494 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:20.693132 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:21.695677 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:21.715621 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:21.717230 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:21.727616 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:21.728337 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:22.801117 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:22.816026 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:22.817972 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:22.828436 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:22.829219 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:24.242220 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:24.257211 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:24.259264 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:24.269718 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:24.270612 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:25.306129 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:25.320842 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:25.322801 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:25.332775 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:25.333522 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:26.332580 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:26.348349 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:26.350225 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:26.361171 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:26.361969 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:27.585641 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:27.600316 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:27.602370 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:27.611823 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:27.612607 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:28.666477 run-command.c:655       trace: run_command: git -c
fetch.negotiationAlgorithm=noop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=no --filter=blob:none
--stdin
    07:41:28.678956 git.c:439               trace: built-in: git fetch
origin --no-tags --no-write-fetch-head --recurse-submodules=no
--filter=blob:none --stdin
    07:41:28.680665 run-command.c:655       trace: run_command: git
remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:28.690534 git.c:725               trace: exec:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    07:41:28.691277 run-command.c:655       trace: run_command:
git-remote-https origin
https://repomirror.eng.corporate.com/github-neovim/nvim-treesitter/nvim-treesitter-textobjects.git
    ^C


Random clues and experiments:

A `git clone` from our corporate mirrors always succeeds.  Immediately
after a `git clone`, I am always able to `git fetch`, so far.
Something else must cause the repository to enter a broken state,
possibly the addition of upstream commits.  I can't verify that since
I can't complete `git fetch.`

I can fix a broken repository by deleting these settings from `.git/config`:
        promisor = true
        partialclonefilter = blob:none
After this, `git fetch` succeeds.
Deleting just one of these settings is not sufficient, it must be both.

I copied one such broken repository out of our secure environment onto
a mac laptop that has access to both our mirror sites and to the
internet.
I verified that `git fetch` from our mirror is still broken on the mac.
Then I modified .git/config to point to the https://github.com/ url
instead of our mirror site, leaving the 'promisor' and
'partialclonefilter' settings in place.
Running `git fetch` in this state succeeded.

This suggests that our internal mirror site is returning something
different from github itself.


Here is the trace from successfully fetching from github.com:
    $ git fetch
    07:43:30.901275 git.c:439               trace: built-in: git fetch
    07:43:30.904188 run-command.c:655       trace: run_command:
GIT_DIR=.git git remote-https origin
https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
    07:43:30.917345 git.c:725               trace: exec:
git-remote-https origin
https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
    07:43:30.918560 run-command.c:655       trace: run_command:
git-remote-https origin
https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
    remote: Enumerating objects: 8, done.
    remote: Counting objects: 100% (8/8), done.
    remote: Compressing objects: 100% (5/5), done.
    07:43:31.714337 run-command.c:655       trace: run_command: git
index-pack --stdin -v --fix-thin --promisor --pack_header=2,8
    remote: Total 8 (delta 2), reused 5 (delta 1), pack-reused 0
    07:43:31.729793 git.c:439               trace: built-in: git
index-pack --stdin -v --fix-thin --promisor --pack_header=2,8
    Receiving objects: 100% (8/8), 3.36 KiB | 3.36 MiB/s, done.
    Resolving deltas: 100% (2/2), completed with 1 local object.
    07:43:31.738815 run-command.c:655       trace: run_command: git
rev-list --objects --stdin --exclude-promisor-objects --not --all
--quiet --alternate-refs
    07:43:31.748286 git.c:439               trace: built-in: git
rev-list --objects --stdin --exclude-promisor-objects --not --all
--quiet --alternate-refs
    From https://github.com/nvim-treesitter/nvim-treesitter-textobjects
       9c5237b..95b76b9  master        -> origin/master
       9c5237b..11ae4c7  update-readme -> origin/update-readme
    07:43:31.757504 run-command.c:1524      run_processes_parallel:
preparing to run up to 1 tasks
    07:43:31.757515 run-command.c:1551      run_processes_parallel: done
    07:43:31.757522 run-command.c:655       trace: run_command: git
maintenance run --auto --no-quiet
    07:43:31.765282 git.c:439               trace: built-in: git
maintenance run --auto --no-quiet

The difference starts just a few lines in, my failed fetches never see this:
    remote: Counting objects: 100% (8/8), done.
    remote: Compressing objects: 100% (5/

Next I enabled both GIT_TRACE and GIT_CURL_VERBOSE to identify
differences in the HTTP conversation between a failed fetch versus a
successful one.
The successful run was made by deleting the `promisor` and
`partialclonefilter` settings from .git/config.
I'm having some some trouble attaching these to this email, I'll have
to include them in a follow up.

Nothing jumped out at me here but I'm no expert.


Is this a git bug, or a server misconfiguration, or both?

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F3BC001B2
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 23:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLHXAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLHXAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 18:00:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99748F73A
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 15:00:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c66so881379edf.5
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snowflake.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SsDKWa4Bu84a5GzEhFstGteGtetLq7bD6CrACl7i6c8=;
        b=Wc50pPiGXQ5gRQbLF5D+x+EvlyyGS1a2vRkEEiCx9F6cZkD4P9ZIsJDbHpud5ZL+nJ
         HY0g42tJWyV3kBTHhYDLsS3sBv5I0HgZzLiqiLX6K78kxCgCzMzoC9bnsGS38TGq3j+F
         V7FK9HfsTkDk5TCXCF3T+Aun40QzbXIIyNqnqNRsZaYH7eTMH8Yf//6FfVwHlFiBck28
         foBk9t249FC5I8qnoM47P4uqHah0AQT+vWocYcKtNyXWcUd2SstNAu2ruWiu66j0IpcX
         y+HZlw+9ihEHjuPPETPsUvx9AE8T5vFIQEcR9beTROF3Vj1aLJ/MJLj3Eh/vEelrG9ya
         jlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsDKWa4Bu84a5GzEhFstGteGtetLq7bD6CrACl7i6c8=;
        b=phy4MMFX/0VTaxPZkiVHoMS1UVKSf2ik/AQUXcNZW79FyqGzPqh1VMxYXJiTwC0isL
         MG3OZVSPVyD5kp/StG0H4ULTxwc6pKTWxOqO0jkEMU+GP1yAVgio6kwjQK05ZO1hfR6C
         qTY0mFHXcC+g4AqBjXZaCyQBZ8253T7yXY9TgTVIKhVA7oIJEa8i4j/aIdnvizWOK0Af
         5wv/3NRyyhDTpYjpVuVGThW9i+a3/8CzfPevDjzgJp71JptAvhLpaRTq6ad2my/MKpDw
         XQpKT+2U+PmC8yf3VkAhHUBzCc6PbP3h5XZ8WSJrB451Y3oQfksaNdYbNwVUFwxwD4hZ
         Svng==
X-Gm-Message-State: ANoB5pkf1lo2B5uXxerxZvoLsVoRrD3xTwZK6CyP0iZAtbV2+D+xGlQn
        C/9Qycilqn2mXSlOXzmIRc21RlO9x4Ajb1/X6ZUI5gKeOWnC9LAw
X-Google-Smtp-Source: AA0mqf7oBSjMywzz38VKNmflVDZfBxhfwtlsGq052Zwg0uTDjd6puCy4K2YMBfkW8ydEKMyst9/HwP2aOONzfm+Awk4=
X-Received: by 2002:aa7:c415:0:b0:46c:4b56:8c06 with SMTP id
 j21-20020aa7c415000000b0046c4b568c06mr20941937edq.230.1670540429836; Thu, 08
 Dec 2022 15:00:29 -0800 (PST)
MIME-Version: 1.0
From:   Eric Musser <eric.musser@snowflake.com>
Date:   Thu, 8 Dec 2022 15:00:18 -0800
Message-ID: <CAGW=zr_BD=7d5dZi+yO4cpufFi=jEjH=wQoTndDLfTi14UresQ@mail.gmail.com>
Subject: rebase update-refs can delete ref branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
$ git init
Initialized empty Git repository in /home/emusser/git/test/.git/
$ git checkout -b working-branch
Switched to a new branch 'working-branch'
$ git commit -m "commit 1" --allow-empty
[working-branch (root-commit) 1238cf8] commit 1
$ git commit -m "commit 2" --allow-empty
[working-branch 2dd4408] commit 2
$ git branch other-branch
$ git commit -m "commit 3" --allow-empty
[working-branch 39f626e] commit 3
$ git rebase -i --update-refs HEAD~2
[I am presented]:
pick 2dd4408 commit 2 # empty
update-ref other-branch

pick 39f626e commit 3 # empty

[I deleted first two lines and submitted]:
pick 39f626e commit 3 # empty

Successfully rebased and updated refs/heads/working-branch.
Updated the following refs with --update-refs:
refs/heads/other-branch
$ git rev-parse other-branch
other-branch
fatal: ambiguous argument 'other-branch': unknown revision or path not
in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

What did you expect to happen? (Expected behavior)
The branch I interactively removed from the rebase to not actually be
deleted. It is common
to remove unrelated changes (and refs) from your working branch before pushing.
I'd hope in this case I would not have to use `git rebase
--no-update-refs' (if I'm set
in my config UpdateRefs=true) to avoid branches from being deleted.

What happened instead? (Actual behavior)
The branch was deleted.

What's different between what you expected and what actually happened?
The branch was deleted when I would expect branches that are no longer listed
to not be updated or deleted.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.0
cpu: aarch64
built from commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.16.13-generic #2 SMP Fri Mar 11 12:48:38 UTC 2022 aarch64
compiler info: gnuc: 10.2
libc info: glibc: 2.17
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
pre-commit

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4690C56201
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D49522202
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 16:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2MBk1lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgKSQfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgKSQfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 11:35:42 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77714C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 08:35:40 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id x9so6912917ljc.7
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9BfvQcwzClYZuLXxCrhMosQen1Vn5tJZEG2d7rJloFo=;
        b=t2MBk1lbMz0s5RvTNY0GL34bQlUq1ouJpt6smrQcbrGgT4n3eHH2QI6mszuMlRYoOs
         JPdfaboVAhRjErorqvt0HPYwcRPMCtIFREZNS+MfCzGPOQAonSRb/L6DlXHr6qFRVVPU
         gqjwk03MtxIcLrwwY1ap+rYuIxBSh5YlpfW+adjoYuEXue5EJmzJF1H9/VuM6VYDKoSg
         1kPaL18Y2PoZGpTjmuW7czG0SChhFqm+vfWXmfFpneUtMxtnBw89/bq51Tqv+VZsUWTd
         /i2q71mhUYf9TclI88sNxd9cuzQa3qXJYFj2MLR2K1FFoe3JUzfxRA7bEpeKH/Aud+xo
         ufIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9BfvQcwzClYZuLXxCrhMosQen1Vn5tJZEG2d7rJloFo=;
        b=euj2eCrlanmED6cpjSOhUc9vSBNbWo1AdwbCcEL+xpAECZ0iqRi+/hrfrJcv3NQ9ty
         rajH5326Ty6qmbbvTzI4ZsReXQBVYFkNdXlTivFZQr8lFb0GeNIlHrYDVcx1fTUiuFKO
         c//R22UTsJwSUP1rWr8ubc9hN4tLt9r4tReQ02PjAaHxclcJDD6m8kSnM7o5Q1x/dklP
         PIu1eOnAy7wK7GP9wt1aDi5KZO6ZgkPx6pj3+YFwF/9lpLI1dOB7xjrmk5z9GI1ble9+
         4dDWuPr5FSqyIsdMa2R0V1SR0/C6F6FWdxJK9KBu2zqLodTqQAmUkYOC+K9kfUdSfcqh
         M1+g==
X-Gm-Message-State: AOAM532wavgF7Z0lsGPji1j7eAiKeyXZbDo36pWGaLaCyaWHhS47gbhl
        dyIlHKelxRlU7GSgCZ9IZmSk4QzVXXg8ad6EdX59Cf6avG4=
X-Google-Smtp-Source: ABdhPJygMRUWxtbLIdobNr1CHzitWYMPVDoaS7jDL6pFTpwBBP7Vp7AnV8UKdbovGQIwjI6sm6jGG/Fx4vnQEwcAchw=
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr6725725ljc.447.1605803738076;
 Thu, 19 Nov 2020 08:35:38 -0800 (PST)
MIME-Version: 1.0
From:   Tom Piercy <personalnadir@gmail.com>
Date:   Thu, 19 Nov 2020 16:35:26 +0000
Message-ID: <CAAMZeNMAwKcpwLaCL-6rgN5EQh65GcqfOaw32qXB+PU6BwDEhQ@mail.gmail.com>
Subject: git add fails silently when adding files in subfolders which contain
 their own repositories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Create a new repository in a new folder:
    a. mkdir gittest
    b. cd gittest
    c. git init
2. Create a subfolder and a new repository inside the subfolder (all
inside the gittest directory)
    a. mkdir dir
    b. cd dir
    c. git init
3. Create a file in the subdirectory and try to add it to the first
repository (starting inside gittest/dir)
    a. touch file
    b. cd ..
    c. git add dir/file
4. Observe status of file
    git status

What did you expect to happen? (Expected behavior)
    The files to be added to the main repository or an error message

What happened instead? (Actual behavior)
    git add dir/file runs and completes. However the file is not
staged. There is no output.

    Running the command git add dir/ (where dir is a folder containing
the second git repository) produces the warning:

        error: 'dir/' does not have a commit checked out
        fatal: adding files failed

    If the repository in the subfolder has at least 1 commit the
following warning will be printed:
        warning: adding embedded git repository: dir
        hint: You've added another git repository inside your current
repository.
        hint: Clones of the outer repository will not contain the contents of
        hint: the embedded repository and will not know how to obtain it.
        hint: If you meant to add a submodule, use:
        hint:
        hint: git submodule add <url> dir
        hint:
        hint: If you added this path by mistake, you can remove it from the
        hint: index with:
        hint:
        hint: git rm --cached dir
        hint:
        hint: See "git help submodule" for more information.

    After the warning git status displays:
    gittest % git status
        On branch master

        No commits yet

        Changes to be committed:
          (use "git rm --cached <file>..." to unstage)
        new file: dir

        Changes not staged for commit:
          (use "git add <file>..." to update what will be committed)
          (use "git restore <file>..." to discard changes in working directory)
          (commit or discard the untracked or modified content in submodules)
        modified: dir (untracked content)

    Deleting the .git folder in the subdirectory allows the git add
command to complete correctly

What's different between what you expected and what actually happened?
    The files are not added and there is no explanation why they are not.

Anything else you want to add:
    Deleting the .git folder in the subdirectory allows the git add
command to complete correctly

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Thu Oct 29 22:56:45
PDT 2020; root:xnu-6153.141.2.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.27)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

[Enabled Hooks]
post-commit
post-checkout
post-merge
pre-push

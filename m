Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC22EC388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BAD22240
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOF2Dblf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgKUN60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 08:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgKUN6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 08:58:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A7C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 05:58:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gj5so16866494ejb.8
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 05:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HBOxsUtbAeevSwngGDoOQ2lVZ6p6JezItsSVmLxq174=;
        b=tOF2DblfHKeXws8/QZwVcbj502LEYHShKMN2GP+Lc3dVMTyTNIHyk1wCuPKzqDxkn1
         MdNahvAmz7h8Sg7uI6YwJDjlTwPmH/PkVC4SaJHVgH+KiuQxXYB//60EKyf7iO3iLq8R
         9T1q6agAyAs2w28tU9CFhGjLBUWgowIE6gj7N889IXdAcfwoEDG4/MfYmzWzOq0N/67m
         4cpOopwNk7T84ToEwsw3joFm0Lo5nSu4XDsCaW3wLE4hut03RuFnioQZf3gIeZf79jsM
         2T4s0owynY60h37Lf7Fm18es3FuulYQLd4t5h2yVIoaUjD8dAO781UMFG56Sr5wOrGuA
         JiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HBOxsUtbAeevSwngGDoOQ2lVZ6p6JezItsSVmLxq174=;
        b=My635x6fH5JB1uGc86GSU+dZGMZHK5AJsFHTW/ffDX3x98oNpbotgW4TRcdAU3kF4R
         X8onuRfP+tfvuHvWxe/JgHPj31geY8SOJJlPOQvR+KCoIOhvkgQtL3qXKVwEbzVS63tx
         /jVWV4ZSjI2GlISpBZXiySl6v0T5BFkBvonfAIfNZkBQ78BBX2H5epLD+c4xgXg6u4Hj
         NerxKZKcfFTPH9gtoVz6dNwonjQD6Qw1iVDuIxDdmRSF0dYr4PShRD5mmWnloOjXS4AT
         25ZGzn6sPzbFa+7Yzl6z2lyoE+Xsu17UNs0fj7VQMdwrBgNSH9/YJkE7C3O3pDT2MZ95
         z4Cg==
X-Gm-Message-State: AOAM531wrPyufbPuJ0uVvH278ambchvoLOzKHMx+GzqqDofCR18CmHig
        VAdxXyJHSgsig7/DK1DtlJ4WeaX5yVYTAKmyuPb83y+jUFD/3w==
X-Google-Smtp-Source: ABdhPJwkdqafOEc8FL7CkUKo0olKkAEK86TRS5hYKVOyXVBnjzXcXmdcTZiUvjYRqj2iSXPIHTfN2CAOvkGLwdh170A=
X-Received: by 2002:a17:906:4a02:: with SMTP id w2mr19110369eju.267.1605967103690;
 Sat, 21 Nov 2020 05:58:23 -0800 (PST)
MIME-Version: 1.0
From:   David Alberto <dalbertom@gmail.com>
Date:   Sat, 21 Nov 2020 08:58:12 -0500
Message-ID: <CALUYcvvcBrgbu=OjgHSygKL+ibj3AA1oi7a6FWZEmWoiRdcAqQ@mail.gmail.com>
Subject: receive.denyCurrentBranch updateInstead issues when using separate
 git dir
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there, I think I found a bug, it's a bit of an edge case when the
repository has a separate git dir. Here's the filled-in output of git
bugreport:

What did you do before the bug happened? (Steps to reproduce your issue)
The `receive.denyCurrentBranch updateInstead` configuration behaves
differently when cloning using a --separate-git-dir flag.

What did you expect to happen? (Expected behavior)
The documentation for `receive.denyCurrentBranch updateInstead` indicates
that the `push-to-checkout` hook should be configured to run
`git read-tree -u -m HEAD "$1"`, however, the tree still contains files
from the original commit. This only happens when the receiving repository
uses a separate git dir. When the .git dir is inside the repository it
updates the work tree correctly.

What happened instead? (Actual behavior)
The work tree still had files from the original commit when they should
have gotten deleted.

What's different between what you expected and what actually happened?
I was expecting the work tree to be updated after the push-to-checkout
hook ran git read-tree

Anything else you want to add:
I wrote this script to reproduce the issue. I tested it on 2.29.0,
v2.29.2-334-gfaefdd61ec, and v2.29.2-505-g04529851e5
```
#!/usr/bin/env bash

function create {
        git init --quiet one
        cd one
        touch file1
        git add file1
        git commit --quiet -am 'added file1'
        cd ..
}

function allow-updateInstead {
        cd two
        git config receive.denyCurrentBranch updateInstead
        echo 'git read-tree -u -m HEAD "$1"' > $(git rev-parse
--git-dir)/hooks/push-to-checkout
        chmod 755 $(git rev-parse --git-dir)/hooks/push-to-checkout
        cd ..
}

function push-changes {
        cd one
        touch file2
        git rm --quiet file1
        git add file2
        git commit --quiet -am 'removed file1, add file 2'
        git push --quiet ../two HEAD
}

function check-status {
        cd ../two
        git status
}

pushd $(mktemp -d)
create
git clone --quiet one two
allow-updateInstead
push-changes
echo
echo WITH REGULAR CLONE
check-status
echo GIT STATUS WAS EMPTY
echo
popd

pushd $(mktemp -d)
create
git clone --quiet --separate-git-dir two.git one two
allow-updateInstead
push-changes
echo
echo WITH SEPARATE GIT DIR CLONE
check-status
echo GIT STATUS WAS NOT EMPTY
echo
popd
```

[System Info]
git version:
git version 2.29.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.4.0-1117-aws #131-Ubuntu SMP Tue Oct 6 20:45:33 UTC 2020 x86_64
compiler info: gnuc: 5.4
libc info: glibc: 2.23
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
push-to-checkout

-- 
==============
David Montemayor

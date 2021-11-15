Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E83C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B115761BF5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhKOIpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 03:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbhKOIp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 03:45:26 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053FAC0613B9
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 00:42:28 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id y5so15312897ual.7
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 00:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=U4LijYnzbD0enhU5yNakm9aW34KBqfBXJCn+S83VBFo=;
        b=YUHUFqdZ2eIKR3zepFqALZxFz8nmi2V/ymGRpym1KiXxAbehayK6UKluJFEDnPZYhE
         lZNTtl4kquin4LbqDkyeTSqJ6sT8Fpmgn14U9B9PXIMqe2AEWZHPZUAp3FLUgEjvOS8Q
         2oPtkKSbfofPwZn68prqmx5UAY02vaNPy5kAj4GEMzlFK3boMOkrpiWzeytefex+sjN0
         oAfoCXWNy/JfMTVRvWwwLirwoRBky9VTNEw9XxXA7LNXYFKxQ8PXIWDly7bVvdXT3Hmk
         Sz/fWX/LGHKjDFxETMOh1yxbgCIqMk8BqEYfP57IvXmgTO46envT9qrktWAfrnJIugMK
         I7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U4LijYnzbD0enhU5yNakm9aW34KBqfBXJCn+S83VBFo=;
        b=kuOWcZvHqXPh9Q6JHtI6R6XZM40QX7KQPwuFCk5+j8XwTBcOxZFBUxxwD7+ipZh90Q
         8c1ihAaU4to55sZHTxwv15K8+z9EELA8XMoFQfOtBb3cAxi7Djf0QIfaae9G78+Gl4uj
         5pHtsh3jv9ttJAqHB4Akl132KhPxZX/1rdLUaWQOZirtCcWaCUqIpkNtuO+MCQ6AwZ/E
         0S/RQnZ3zIM+YzHWumkzRw+2zDE5hWui54k2C32oVbxVr2dhkQ63bj50kkzRAbwolhKC
         XlPXUcA7sWDfuHO152TyfKu1mQZXvFvkRYBC0p2PkiLC0T12KFo/aJ8PxbYcS1dlk+Iw
         6YZQ==
X-Gm-Message-State: AOAM53225mehyHTI1dI+MmprPwC4pmYase7xNtc2K8iK70U5ikiQ1YV6
        sc29B+An+gYpwxlPv3HwC4VZ1TDDsdtX5N2F9lSXwCp43UE=
X-Google-Smtp-Source: ABdhPJwmb/jP5d+n0tAwQR3i8sr8pkmJlcJ0l6jJ7k2dNP1avhEgEMxNg34uzXRtx1MKUUcy9Exf08nBeKdIb0vtCi0=
X-Received: by 2002:a67:d28b:: with SMTP id z11mr40930163vsi.49.1636965746932;
 Mon, 15 Nov 2021 00:42:26 -0800 (PST)
MIME-Version: 1.0
From:   Erwin Villejo <erwinvillejo@gmail.com>
Date:   Mon, 15 Nov 2021 15:42:15 +0700
Message-ID: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
Subject: git pull bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What did you do before the bug happened? (Steps to reproduce your issue)
* make local changes, stage, and commit
* local is ahead of upstream. confirmed by `git status`:

```
$ git status
On branch main
Your branch is ahead of 'github/main' by 1 commit.
  (use "git push" to publish your local commits)
```

* try to pull upstream to local

> What did you expect to happen? (Expected behavior)
No-op (and NO failure) since local is ahead of upstream.

> What happened instead? (Actual behavior)
`git pull` fails with error:

```
$ git pull
hint: You have divergent branches and need to specify how to reconcile them.
hint: You can do so by running one of the following commands sometime before
hint: your next pull:
hint:
hint:   git config pull.rebase false  # merge (the default strategy)
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint:
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.
fatal: Need to specify how to reconcile divergent branches.
```

> What's different between what you expected and what actually happened?
I expected no failure and no-op since local is ahead of upstream.
Instead, `git pull`
fails because it thinks the branches have diverged.

> Anything else you want to add:
I found this bug in VSCode. VSCode runs `git pull` first before `git
push` when pushing to upstream.
This bug causes pushing via VSCode to always fail, although it can be
worked around by simply opening
a terminal and running `git push` manually.

[System Info]
git version:
git version 2.33.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.2-arch1-1 #1 SMP PREEMPT Fri, 12 Nov 2021 19:22:10
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Best regards,
Erwin

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4DDC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB006109F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhGUIqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbhGUIhW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 04:37:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B09C0613E5
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 02:17:47 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso1456738ota.6
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4pc/RM5T+9LlRY0t0528dYS+z829BHtTgigdNhw7oaA=;
        b=GPmzgcP+5gGyYWqUnk4MTmG2nskNLxHqiK7CUvq1xquaendRyjwz6TsxC4w3qgONrA
         xsBJT/X83g1NCKj3q0mLY493+QRbp3Rkdwe9n3m6t8deXDBrlGRx7bPWvgtjniFJ1Toq
         0sIBqsBym+Co/rRm3gWdvk1VqT7WSB28o+u0GYqePBmg1qWZ3k/jJ8ATISeoW5M3B/so
         YlMWnVoOGSNEuRpgo1Y32bU5/1KZdhFj5AZV0jMOaxsp1gjWEX/Pt5Q05srH6oleX0Hv
         6Wu11hMGS7rwkEMWklLusckwjph9i72GDe3u7DHcJ1EAYU9FQtaKSxIlYq5aJYdRJ0h6
         zclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4pc/RM5T+9LlRY0t0528dYS+z829BHtTgigdNhw7oaA=;
        b=TBywoGDwMUf9N+srUCtUhKca+9OtjxcOJJSO/NWFfJFDN5aF2Gi0YWsKd6HbAYxbvE
         BMsSt+RFy7eRtOIXIW24J1qeY+BaSHqpZspRdrUntzNqJOKHo051EwEXPaGcEV/8VoqE
         j1B1IuP4oL97AKiOWhoS9sgvI2okXxahtESIQl0ISff+yDjGByp2Axp/0V5SRnTifCJy
         iVvINw542QZNWy1Q0dIk5Vy/2eE+Kb6HRrsPkBa8+LKTv7DrQuxlxeNygOIyNohfby5e
         77MPheNF7rJYBBUTRc0vxEjxuIaVQ01ffUQiqJPg70UgCRtchku218D7aHivBizxC7YO
         Pcsw==
X-Gm-Message-State: AOAM5329Cy0M6SXENpogpFddGrFKQexmy5E74SqgjMvkR9NIBugIK1Qw
        9lRNrsPX/Fmf4ISxnykNzASZ/EQELMTvYMMAe/L2GC4ZHIEukg==
X-Google-Smtp-Source: ABdhPJwedoL7FjdVZXKHRQFQGAFwToeRcG8aRNmU3OD+2rB47Zl7ltfS2Um/ZWJw7YDKzw1lJlJRYCAun3A51UsqXLA=
X-Received: by 2002:a9d:3bc3:: with SMTP id k61mr15843845otc.355.1626859067260;
 Wed, 21 Jul 2021 02:17:47 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Wed, 21 Jul 2021 10:17:36 +0100
Message-ID: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
Subject: Bug: All git operations fail when .git contains a non-existent gitdir
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

Add a git submodule to a git repository.
Overlay-mount that submodule to another place in the filesystem.
Attempt any git operation in the overlay-mounted path.

What did you expect to happen? (Expected behaviour)

git operations that don't depend on a repository should succeed.

What happened instead? (Actual behaviour)

All git operations fail.  Even `git bugreport` fails.  More importantly,
`git ls-remote` on an unrelated repository fails.

```
$ git bugreport
fatal: not a git repository:
/home/tkcook/git/Veea/demo.git/VHP-3375-veeadb-on-vhe09/build/iesv10/programs/veeadb/../../../../../../.git/worktree>
```

What's different between what you expected and what actually happened?

Commands that should succeed actually fail with the above message.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.13.0 #1 SMP Mon Jun 28 11:38:29 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34AE1F461
	for <e@80x24.org>; Sun, 12 May 2019 10:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfELKNC (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 06:13:02 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45168 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfELKNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 06:13:02 -0400
Received: by mail-ot1-f46.google.com with SMTP id t24so546795otl.12
        for <git@vger.kernel.org>; Sun, 12 May 2019 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5SKFNJ6ZLlO+s7JpCWQnCyauVTR9u6YgQNAmTMmUfSk=;
        b=DIzNA8Yiw+ROWoKguQN2rEkpljVSgKc2TAGIdN2rGsAWHT3HVe76l6UiPQGIdYOehw
         KmQmgFC3LBMjVYejX+n21JdoOSVbldv9L2FtIAp+BVNWz3i8PyFwQ7N0hl8oD/HPE8yj
         4rqhDp0okU8vKggC5LVUfLmvAUc/u7MMz3jxRJT39ItMsyoDYhqaTTMDQKRFhdjisNle
         jiNPD236LV6rAuH0bPPBw4fvZ549pkmqlJcfbidtXFuYzg9/SKukHqH9KiwMmwAm+10H
         nv2CbbAkyMpU/5xtYmBetlKFYrGTGKAwpjTmZlv+pxTvjdAE3w6XnkI8rTfg7ULgYUAI
         UUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5SKFNJ6ZLlO+s7JpCWQnCyauVTR9u6YgQNAmTMmUfSk=;
        b=hrxBEJ7D9lUuz8fksIT2NNGHjJjsrltvrLoWFgaMhzEKa4FSiWt0291CmjOZhk2pib
         YLYlwYa26Z45u4jlmIu+xO54cX4s4/FyNvRDuCsoe5/MpXDmJa54m9qb1d1rDFEo1qWi
         uG+oOKlZbmTofQ+q0mNU29B2VdYaMO6AJ5a72c5jjX9cMV+6xtoUTdH3B+AcafIW/4KZ
         GlnNn4YcS2gi5AO6iiuyL9MYakI4AaEm5BkZIZmv1ni8gJgLwZ5occ1Ln3ZeO2az63hi
         qEKDXyguePJtH5gM683WbPJ66L1/8HI/e5qbvytbbpDC3FO97AbNvb5+NrnogVLe8/Dw
         VJNQ==
X-Gm-Message-State: APjAAAWBJXG1GH37MzgGQLz8p+SHkK09C5ij/9/N5V2Ah2SaOvd97Tk4
        +M2orGpxBqpQrU7q5FH/MkYU4GzxEhJIMcfyxONMl0sp2No=
X-Google-Smtp-Source: APXvYqxFtisR4TUa+G6fL2xUc7uJb3srELImpM7gjUFAm50U6DWddoi3O62axpgY6ZmWFu2399cf6lQUA4hF/fd7TYw=
X-Received: by 2002:a9d:638f:: with SMTP id w15mr782247otk.16.1557655981647;
 Sun, 12 May 2019 03:13:01 -0700 (PDT)
MIME-Version: 1.0
From:   Shaheed Haque <shaheedhaque@gmail.com>
Date:   Sun, 12 May 2019 11:12:50 +0100
Message-ID: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
Subject: "add worktree" fails with "fatal: Invalid path" error
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm running git v.2.20.1 on Ubuntu from a program which follows the pattern:

============
1. create a temporary directory /tmp/tmpabc
2. in a loop:
    2a. create a second level of temporary directory /tmp/tmpabc/tmpworktree123
    2b. use "git worktree add" on the second level directory
    2c. do something
3. cleanup
    3b. "git branch -D" on each basename(second level directory)
    3a. "git worktree prune"
============

The loop size is of the order of 8-20. In step 2b, I often get errors
like this (from a Bash reproducer):

============
$ git worktree add /tmp/tmpgtxug4y9/git_worktree.gBGqnfnU
Preparing worktree (new branch 'git_worktree.gBGqnfnU')
fatal: Invalid path '/tmp/tmp1q9ysvyl': No such file or directory
============

I can see that the problematic path exists in the "gitdir" file of
what must be an earlier worktree from an older run (the branch is
gone, but the tree is still there). The path appear to relate to the
older run's first level directory:

============
$ grep -r /tmp/tmp1q9ysvyl ../.git/worktrees/
../.git/worktrees/git_worktree.frcwtjt_/gitdir:/tmp/tmp1q9ysvyl/git_worktree.frcwtjt_/.git
$ git worktree list
...
/tmp/tmp1q9ysvyl/git_worktree.frcwtjt_  edde3f25 (detached HEAD)
...
$ git branch | grep frcwtjt_
<no matches>
============

NOTE: I've not yet had to try deleting the worktree, since "add
worktree" does appear to work some of the time, so I am able to limp
along.

I have these questions:

1. There is no branch or first level directory, but "git prune" has
not deleted the worktree, is this expected?
2. Is there something wrong with the sequence of steps I am following?

Thanks, Shaheed

P.S. I have an strace of a failing worktree add if needed.

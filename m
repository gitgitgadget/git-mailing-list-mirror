Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0F51F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeH2BOS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34089 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH2BOR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:17 -0400
Received: by mail-io0-f196.google.com with SMTP id c22-v6so2733182iob.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpekV5ERgk676wI5cquPLlAKUONQHMRZL1dKvdVdytU=;
        b=VM3xWYJEmFiTx5LbyVs0sb5ELrkjQmM95rBTZyCftzk8AFbCL9JSHFew4mEw5tj1/3
         zgL+92mhoSY6FggJRoJogyiSsOcfXpG9ajm5Jd2muU2KvoTgFXvijqK6XkCwCrdHqVfD
         7vT7HqwqCinaHIbSoeakCdFk09vffA+o9VG/onXZ45RdVe71dRJEl4grjYHtHIu55EXQ
         QqdwFfnBkL9PDTdGGJzfL+6gZ6yCzv9NK3odU1V/Z8mBtCwFqCKuIflqrx3U8i2A1Qii
         /ZOyA79vzgmlA435ao/kk+m7rWPX58U2VKJ3rNf7OnEqYK0BzZk+6xDjDJmb16l5eb8M
         QbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vpekV5ERgk676wI5cquPLlAKUONQHMRZL1dKvdVdytU=;
        b=NYFw/ehTyBLxdgCDIamThTr2KJ086qki+pAbg4+JGSmI+iyma64usitCJCR7dDmIG8
         1O/7gSYMnh2XAWzzA1svD31GVmOhEHJw0HMazxJfGv86pim42cpclbsfNy6CRARXGoLh
         BrjkYtAzualzVJktOWjcvqicJcPn0C3wZzoAS6qC4y4sUAqOvCHUBIejXWbcKzSF3wrj
         jCotphNg0e0ykCaJryhQPOc91ZwKHKaQ6EfqzI0TYYGbGMa+prwdXGzpmIPvWnh7IlAk
         Frq7yxqfYM+0dt66/Kp6mR1tUcvYsDSK95/4FcAVfMtfZGjWQe78xlTIdMqKdItSejby
         Tjhw==
X-Gm-Message-State: APzg51AbrtgLBxR/7IR2HoealUh1UirV4Y32EwnbWlHSj+RHOlrMwlE6
        uLlZCJsTCUloxwdbkNZuSxD3SrVN
X-Google-Smtp-Source: ANB0VdZw464zCkpI1Ov4jk9WLoOVIrbLI1IVVcQdncNLJIP9/13gaC5sI/N2EAoRTvaiOCfv4o1P8g==
X-Received: by 2002:a5e:cb48:: with SMTP id h8-v6mr3059202iok.178.1535491247133;
        Tue, 28 Aug 2018 14:20:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:46 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
Date:   Tue, 28 Aug 2018 17:20:17 -0400
Message-Id: <20180828212026.21989-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series started as a fix for a bug reported by Peff[1] in which the
"database" of worktrees could be corrupted (or at least become
internally inconsistent) by having multiple worktree entries associated
with the same path.

Peff's particular use-case for git-worktree is Documentation/doc-diff
which wants to re-use a worktree if it exists or create it anew if it
doesn't. Unfortunately, this is a bit more difficult than it should be
if the worktree directory is deleted manually (without pruning the
worktree entry) between script invocations. To simplify this use-case
for tools, it was suggested[2] that "git worktree add --force" could
deal with the problem of a registered-but-missing worktree (much as a
tool might rely upon "mkdir -p" to create or re-use an existing
directory). This series implements that proposal, as well.

Fixing the original bug revealed another existing bug, and after several
additional "while we're here" changes, the series ended up a bit longer
than expected.

[1]: https://public-inbox.org/git/20180821193556.GA859@sigill.intra.peff.net/
[2]: https://public-inbox.org/git/CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com/

Eric Sunshine (9):
  worktree: don't die() in library function find_worktree()
  worktree: move delete_git_dir() earlier in file for upcoming new
    callers
  worktree: generalize delete_git_dir() to reduce code duplication
  worktree: prepare for more checks of whether path can become worktree
  worktree: disallow adding same path multiple times
  worktree: teach 'add' to respect --force for registered but missing
    path
  worktree: teach 'move' to override lock when --force given twice
  worktree: teach 'remove' to override lock when --force given twice
  worktree: delete .git/worktrees if empty after 'remove'

 Documentation/git-worktree.txt |  12 +++-
 builtin/worktree.c             | 113 ++++++++++++++++++++++-----------
 t/t2025-worktree-add.sh        |  18 ++++++
 t/t2028-worktree-move.sh       |  44 +++++++++++++
 worktree.c                     |   6 +-
 5 files changed, 154 insertions(+), 39 deletions(-)

-- 
2.19.0.rc1.350.ge57e33dbd1


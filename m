Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2DDC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiG2KM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiG2KMz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F66747AB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z19so4201886plb.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEgrw7g6Q94tTfF0MxDdOzZwkNdSnl4sIwQ9vUQxaNE=;
        b=IHT1C22OLn8eibmhTNwS3Po56ocZnHD5uMmBPoebY1wHNLfaV8A+JjEKVTJFeDwuBR
         OEY25ao5w3Rm4igPUsKgGC7RDbb5M9G2DhwOTExO7/F+J90mIGhNHHeINGodqt4tV7Tz
         sxa7j5tDkhOt/9vSUP34panaQUYv3FQ+oY4Yw33QRQUsMjb6TrskmC6957/KQLxojJeg
         tazdi25gybhtP6oMCu/P9v9tFPprctNKRuDAd1XhS1DLGi+5qu2Y5Z4sHCLOufs61Tjr
         N910t5LT5etuNk3JMbCWvGTKwLMfkK4rw6aZMVFlrST2MMbvyPfc68rH+xRC/h4Sb8dt
         fEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEgrw7g6Q94tTfF0MxDdOzZwkNdSnl4sIwQ9vUQxaNE=;
        b=nIZdPny/7KencBrt7iuYhvu8GX9uXnwfNNTUn4liI62Cg5tIZLFapaweN/ewwkBcmD
         XJOkacO+GO59/VBrtoswFh4D6Bywqlads+PIvT80SrDSj+iZwT0hcSrUHVqc9bioUVIp
         9jAk8i3exBL4U0G3H644tE9w3wG7JOVkj4uElbv1Q+UtOa4ZhCWlshBMlX/baHEVYJu3
         AyB16SsvGYEQeWFuZazMgW5WdGEJ1ssTJTRIBITfAI91FHbV1rGhJvNAZ5b4yew/1yRk
         5Y2etqiu5gYfR1hUHYBvKkAX5AQKKacWCtoiTq0aeWWrsTBKEYVX3OgrWtWJOHUmH5qZ
         iyiQ==
X-Gm-Message-State: ACgBeo2ZPi2HDYNDiMfiaW5g0cdvaGsxUNsqhup0Dusl7VS/SB9A2Jgv
        jbsFpQ/T5FqNoHqXvLj1Qs4=
X-Google-Smtp-Source: AA6agR45EX08MzOnHmradybQqVNi8199XPC1o5f/snAYhgZ7fisUPn2p/uyZ1gM0XhSxudTY/L0cpQ==
X-Received: by 2002:a17:902:f54e:b0:16c:5119:d4a8 with SMTP id h14-20020a170902f54e00b0016c5119d4a8mr3063478plf.22.1659089573920;
        Fri, 29 Jul 2022 03:12:53 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:53 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 0/9] Fix issues of reference-transaction hook for various git commands
Date:   Fri, 29 Jul 2022 18:12:36 +0800
Message-Id: <20220729101245.6469-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Before Patrick introduced the reference-transaction hook in git 2.28,
We had implemented some internal transaction hooks "pre-txn" and
"post-txn" for our internal git infrastructure. The "pre-txn" hook is
used to check our site-wide lockfile to disable write services for
the repository. The "post-txn" hook is used to update the timestamp
and checksum of the repository. Recently I wanted to migrate our
internal implementation to use ref-txn hooks, but I ran into the same
issues reported by Michael and Bryan:

 * https://lore.kernel.org/git/CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com/
 * https://lore.kernel.org/git/pull.1228.git.1651676435634.gitgitgadget@gmail.com/

This patch series try to fix the issues I encountered.

Patch 1/9 adds more testcases in t1416:
 * Some commands failed because the expected "<old-oid>" was
 * "<zero-oid>".
   Such as: "git update-ref -d <ref>".
 * Some commands failed because the "reference-transaction committed"
   command was repeated multiple times for the same changes. Such as:
   "git update-ref -d <ref>" and "git tag -d <tag>".
 * Some commands should not trigger the "reference-transaction" hook
   because no real changes have occurred to the repository. Such as:
   "git pack-refs --all" and "git gc".
 * Some commands did not execute the "reference-transaction" hook at
 * all.
   Such as: "git branch -c <src> <dest>", "git branch -m <old> <new>"

Patch 2/9 propagates real old-oid found in lockfile to the update entry
for txn, so we can get proper old-oid in "prepared" and "committed"
stage
for ref-txn hook.

Patch 3/9 adds a new flag in transaction, and we can turn off running
the
entire hook for git-pack-refs in patch 4/9. We can also turn off the
"committed" and "aborted" stages of the ref-txn hook for
"packed-ref-store",
but we can still run "prepared" stage of the hook. See patch 5/9.

Patch 6/9 and 7/9 create an extended function
"ref_transaction_update_extended()"
to be used in patch 8/9 to reimplement branch copy and rename.

Patch 9/9 reimplents "files_delete_refs()" to fix failed testcases for
"git branch -d" and "git tag -d".

--

Jiang Xin (9):
  t1416: more testcases for reference-transaction hook
  refs: update missing old-oid in transaction from lockfile
  refs: add new field in transaction for running transaction hook
  refs: do not run transaction hook for git-pack-refs
  refs: avoid duplicate running of the reference-transaction hook
  refs: add reflog_info to hold more fields for reflog entry
  refs: get error message via refs_update_ref_extended()
  refs: reimplement files_copy_or_rename_ref() to run hook
  refs: reimplement refs_delete_refs() and run hook once

 refs.c                           |   99 ++-
 refs.h                           |   23 +
 refs/debug.c                     |    2 +-
 refs/files-backend.c             |  158 ++---
 refs/packed-backend.c            |   51 +-
 refs/refs-internal.h             |   25 +-
 t/t1416-ref-transaction-hooks.sh | 1072 +++++++++++++++++++++++++++++-
 t/t5510-fetch.sh                 |   17 +
 8 files changed, 1264 insertions(+), 183 deletions(-)

-- 
2.36.1.25.gc87d5ad63a.dirty


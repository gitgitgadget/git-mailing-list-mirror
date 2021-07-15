Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44850C12002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245A861396
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhGOCf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGOCf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:35:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A5C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:32:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v5so5640448wrt.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UvACiXf7UqgbQLNEQIflzfUdEG54lLyale/jBvH475Y=;
        b=qwUy/FPL8Fyx2TO7BN6M6FMSI/vuP4HoxeXOj8RlxIsAggPzlKhRGZNwuL/1hcLRNp
         YKKqhnSK3/jcF/4BiUmbljP7+V6d6Tw0z1YV+lWTxY68xX9eA+4K3r0LSmdsxXwHG/ad
         knEj/IfciXsBKHDIy4fXDQ00jL5tsHlDKm/rMpOhlHHSNENWYskIpC5qNtD2fuvkYZh4
         uSl2o8JGjGVXWsCVoLFBp0eeM6YayP/U8AWaGUWUWefLHO5esT9fgyOcyoydLNTqIwjb
         YSFsfVug2r7TGL7OZ8z83AYgXYJ93tys5+fy+OsD8A/L/jVkzEv9T2qa8Q3YeOAyK2yu
         Fyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UvACiXf7UqgbQLNEQIflzfUdEG54lLyale/jBvH475Y=;
        b=bIPDKaywYsEuPYj0ZXiXFZX3QTrDg9VsQdJHpFbHIwVDvCKvYT3PS89KXKiCVsNuDD
         2NihAZozagob4EYNgCXawt6E0mW8i2daMxGB0/E3Ij9X2amWKfUzYjokkUmu/gZ+Djpc
         6HdmBCvFnhlB/YfxwHlaShNB3vd5H4Y4Widju3dqQIgk27KDS/uAYt4PvUXXlMqL/BKl
         IaWq8s6CrvZB4k2sK21aI+11fNGVihcaN+8D0xafWsZw5aWR4w8y96ML5r5P24Zmyn9o
         6Pcn3HmEuU6pFWRj9tLdj2rVSW2XrtneuiSSnkO23WBIq6I60WZQ64nJDHkrnLPHTJWF
         +Ukg==
X-Gm-Message-State: AOAM531v8jAZTnvFHrx8Ycq/Drdna7JC0OzL3V8XQu4Beu0ihC/f0rdn
        7rF2OdVJueII+lKhIYfTBpE8Qyff96U=
X-Google-Smtp-Source: ABdhPJzRKY8dSOZqsNDjQTVJcLY8RKFfkgfWh1RttSi8PqwNQ5FshCO/wHgpSDOXHTCHDIOMgWVl2Q==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr1720828wrt.295.1626316352460;
        Wed, 14 Jul 2021 19:32:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm3324131wmq.1.2021.07.14.19.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:32:31 -0700 (PDT)
Message-Id: <pull.992.v4.git.1626316350.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
References: <pull.992.v3.git.1625963240.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:32:27 +0000
Subject: [PATCH v4 0/3] worktree: teach add to accept --reason with --lock
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default reason stored in the lock file, "added with --lock", is unlikely
to be what the user would have given in a separate git worktree lock
command. Allowing --reason to be specified along with --lock when adding a
working tree gives the user control over the reason for locking without
needing a second command.

Changes since v3:

 * Updated test to define a shell variable, lock_reason, set to "why not".
   Expand the variable to use with --reason and to echo to file, expected.
   This avoids the spacing comment made by Eric Sunshine.

Changes since v2:

 * Updated first of the 3 commits to include a step in the test to unlock
   the worktree when test completes and modified commit message accordingly.
 * Updated second commit to wrap "initializing" string with _() to mark it
   for translation, as requested. I had originally opted not to mark it,
   since, when --lock is not given, file locked gets removed after the
   working tree is populated. Thus, it's not really user-facing. Modified
   the commit message accordingly.
 * Updated the third commit to have no new lock_reason member of struct
   add_opts and changed type of member keep_locked from int to const char *,
   as suggested.

The file, .git/worktrees/name-of-worktree/locked, is created even if --lock
isn't given, although only temporarily. In this instance, "initializing" is
written to the file, but the file is removed at the end of the add-worktree
operation. My goal was to maintain this behavior and is the reason my
post-parsing code doesn't quite match the suggested patch.

Changes since v1:

 * Split changes into 3 commits. The first commit is removal of git
   rev-parse in the test above the ones I'm adding. The second is wrapping
   the "added with --lock" string with _() to mark it for translation. The
   third commit is the main change.
 * Reworked the if-else-if-else to if-else if-else
 * Added test_when_finished ... command to unlock the working tree
 * Changed test_expect_failure to test_expect_success and embedded
   test_must_fail and test_path_is_missing commands

Note: I don't see how to disambiguate --lock with no --reason from no --lock
at all. I still think that the original keep_locked boolean is needed along
with the new lock_reason char array. If I don't add lock_reason and change
keep_locked to a char array, it will start as NULL. But it will remain NULL
if --lock alone is given or if --lock isn't given at all.

cc: Eric Sunshine sunshine@sunshineco.com

Stephen Manz (3):
  t2400: clean up '"add" worktree with lock' test
  worktree: mark lock strings with `_()` for translation
  worktree: teach `add` to accept --reason <string> with --lock

 Documentation/git-worktree.txt |  4 ++--
 builtin/worktree.c             | 21 ++++++++++++++++-----
 t/t2400-worktree-add.sh        | 16 +++++++++++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-992%2FSRManz%2Flock_reason-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-992/SRManz/lock_reason-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/992

Range-diff vs v3:

 1:  5618933279d = 1:  5618933279d t2400: clean up '"add" worktree with lock' test
 2:  ceb7a58b004 = 2:  ceb7a58b004 worktree: mark lock strings with `_()` for translation
 3:  9a414a3078b ! 3:  4b6bb50d3d6 worktree: teach `add` to accept --reason <string> with --lock
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with lock' '
       '
       
      +test_expect_success '"add" worktree with lock and reason' '
     -+	git worktree add --detach --lock --reason "why not" here-with-lock-reason main &&
     ++	lock_reason="why not" &&
     ++	git worktree add --detach --lock --reason "$lock_reason" here-with-lock-reason main &&
      +	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
      +	test -f .git/worktrees/here-with-lock-reason/locked &&
     -+	echo why not >expect &&
     ++	echo "$lock_reason" >expect &&
      +	test_cmp expect .git/worktrees/here-with-lock-reason/locked
      +'
      +

-- 
gitgitgadget

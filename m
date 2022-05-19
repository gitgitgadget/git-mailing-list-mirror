Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CDC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 16:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbiESQ0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 12:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiESQ03 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 12:26:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5F5F8EC
        for <git@vger.kernel.org>; Thu, 19 May 2022 09:26:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so5340555wmj.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W9Lcb/8aoyOfOE5AerAneohoNficPFd41J8EuEzXE7M=;
        b=dFa61zenp7SJVuGHwICpHoe9/06sf3wg4c0dwf1yBu2pQrLwB5R5Zu1T2o+kVMnsWB
         BrsqWf1/ieSFz0pdFJS4keM/+KG4vv8fXqo/WrfGkJWwvkyLii6OIjEfVH28gVFq8xyz
         3bVEcDnExMltpayBkXheS4AYELJVBOekG0SiECLC2xLrEf5Jr7PpXl5a36MZEuDWMCNY
         h/mPW4C4eVl/MxOxNQTEnny0EjZwNCD5PdXSfG15PKJM0DrVSotjaHSxA8NS67TKSEsM
         mDgd0fHAqfvC7SOmyoDUUJ7JM1I9qMxxefLmrYMlPIkyKzAp0n4Z7VRWejRmhGGhv3uk
         8fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W9Lcb/8aoyOfOE5AerAneohoNficPFd41J8EuEzXE7M=;
        b=ZoCcLSAQ3c699yHky/+ZMkdBzV+EK3KwreGvwdSlquFl0ZfeEuVbDA++LNqhn1643s
         BeKhSAbC5yFglN8I85bULYv/yTZMrHL9Xfa4NmTrYf4c5x1zd1i+tShVMNaBNgKJGtFK
         pOcIR/09DevuTF0TGbFbL28yveA9r8nKI/VuEwuBZhT1OrbFUjvF2avAc2c50EM3aTE8
         iKhHslObzd+0D9sVAk4hBtS1ke6mI/3JcIWGRLOT/20Mk885Oh2USFncBHwtaWUy/YHm
         j3g9MEVFkLzm7mmwXrPq7XUFp2ImJOGjlbAQo+Cy+lJeopfAoNzMgck9zg7VkrpxcOYO
         kdfw==
X-Gm-Message-State: AOAM5305EDyAfX38BxhXYpZ4GKFe10/x2SDak5lhAFse310TbSm6+w+s
        QcRSYaxc+Kl4B7rFuyoldjCqkRQZ6p4=
X-Google-Smtp-Source: ABdhPJzu9HnlvXGdTIhtCISUmsEd60mdPxXD5Tv8lOyzANNbTH2NpFscVGjwH8VxW16gBHJ1C/cQXw==
X-Received: by 2002:a05:600c:2102:b0:394:2765:580c with SMTP id u2-20020a05600c210200b003942765580cmr4525520wml.150.1652977585972;
        Thu, 19 May 2022 09:26:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm48608wrr.32.2022.05.19.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:26:25 -0700 (PDT)
Message-Id: <88bdca72a780d70e156e22e1ab96dedd368c761b.1652977582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 16:26:22 +0000
Subject: [PATCH 2/2] merge: make restore_state() do as its name says
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, if the user:

* Had no local changes before starting the merge
* A merge strategy makes changes to the working tree/index but returns
  with exit status 2

Then we'd call restore_state() to clean up the changes and either let
the next merge strategy run (if there is one), or exit telling the user
that no merge strategy could handle the merge.  Unfortunately,
restore_state() did not clean up the changes as expected; that function
was a no-op if the stash was a null, and the stash would be null if
there were no local changes before starting the merge.  So, instead of
"Rewinding the tree to pristine..." as the code claimed, restore_state()
would leave garbage around in the index and working tree (possibly
including conflicts) for either the next merge strategy or for the user
after aborting the merge.  And in the case of aborting the merge, the
user would be unable to run "git merge --abort" to get rid of the
unintended leftover conflicts, because the merge control files were not
written as it was presumed that we had restored to a clean state
already.

Fix the main problem by making sure that restore_state() only skips the
stash application if the stash is null rather than skipping the whole
function.

However, there is a secondary problem -- since merge.c forks
subprocesses to do the cleanup, the in-memory index is left out-of-sync.
While there was a refresh_cache(REFRESH_QUIET) call that attempted to
correct that, that function would not handle cases where the previous
merge strategy added conflicted entries.  We need to drop the index and
re-read it to handle such cases.

(Alternatively, we could stop forking subprocesses and instead call some
appropriate function to do the work which would update the in-memory
index automatically.  For now, just do the simple fix.)

Reported-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c        | 10 ++++++----
 t/t7607-merge-state.sh | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100755 t/t7607-merge-state.sh

diff --git a/builtin/merge.c b/builtin/merge.c
index 00de224a2da..ae3ee3a996b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -377,11 +377,11 @@ static void restore_state(const struct object_id *head,
 {
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
-	if (is_null_oid(stash))
-		return;
-
 	reset_hard(head, 1);
 
+	if (is_null_oid(stash))
+		goto refresh_cache;
+
 	args[2] = oid_to_hex(stash);
 
 	/*
@@ -390,7 +390,9 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	refresh_cache(REFRESH_QUIET);
+refresh_cache:
+	if (discard_cache() < 0 || read_cache() < 0)
+		die(_("could not read index"));
 }
 
 /* This is called when no merge was necessary. */
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
new file mode 100755
index 00000000000..655478cd0b3
--- /dev/null
+++ b/t/t7607-merge-state.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description="Test that merge state is as expected after failed merge"
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+. ./test-lib.sh
+
+test_expect_success 'set up custom strategy' '
+	test_commit --no-tag "Initial" base base &&
+git show-ref &&
+
+	for b in branch1 branch2 branch3
+	do
+		git checkout -b $b main &&
+		test_commit --no-tag "Change on $b" base $b
+	done &&
+
+	git checkout branch1 &&
+	test_must_fail git merge branch2 branch3 &&
+	git diff --exit-code --name-status &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
+test_done
-- 
gitgitgadget

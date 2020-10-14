Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE44C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B255C22257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2jN9zXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgJOByt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbgJOByi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:38 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288CCC08EADD
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:22 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m23so861344qkh.10
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Pjn7CZtn5A4vJ1nojmkcd3nLpwhUey7lEEA3HcBRwfU=;
        b=K2jN9zXcFWyS5ssDc9ze1PUhiatYZRnI2pb/M2TnMoY0zCxBjHqZi10NQpexxy7wZD
         xByHdaWz2LY8cOjnU9RESbNLBWfTM4QStQ9ekGYMK216aKrvioP13cLsh+j0HbcdgP8F
         LV48hoH1lf4YijmBs2023RGSfjV7ajleMj9wt5eKBwsXYS3sQMuJG/MqA4uzVrJXUvCr
         ZKCweBKzRURmK1FKDL/LLMIsbguUtQuKHt0Ui2DpVy9/cFTEKq/E6ZJbk5yCbc+Kggkx
         0hP/Ae0HKVqObaNFUHg5dZ9yV7t8lzxCbPDxJl4pNw4OLbvIA0iSPxuT5C2KYLinQC5+
         T6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Pjn7CZtn5A4vJ1nojmkcd3nLpwhUey7lEEA3HcBRwfU=;
        b=byL0vrLli6DMyfuQZ8teqW0/frl1ddVYTPg9OHzvtWCEqCosNoflfKWvR7qOHcPteP
         eUFeGYUyPjNvuCVF1QsTO0sw+qrbJiHB/cBk3TTVM349lsplsfexQcph3WcYQgUA/uyZ
         PnEbJCYkaY5oGwvOAyxaz8C12QlXJFqZoCmd7SD4DJ4Jdpi1rKLvhXJvqrLm6DTC/dvk
         CB0uEmtyRitT1irOm5MXwbOzlYdYGx1XdOODqtqVezBkJVLmpVTvgvsewOJ+KFCkYsnw
         VlIFT/qKY+j7LDIxRxvgFR5MB6nG2TCLvuDsQM86jyRc5zN1Xc58JZq4Y22pzVF6ZXln
         I8cw==
X-Gm-Message-State: AOAM531MhN5YEtaJwiDFKhwGCuyKkOZMnYiLfh9bVhYp7cDvcTkh6KFl
        Ef/2AAVePXaUjDonayz0stKKLxaiuoG5M4yzTOeziaJNbkPcLW4fRBqUXNBUNDezcYt9v2pDTl8
        uxgbv0B3+LRZn4OH0Gs7NpWT8u14J7CNCzOKLv4mtZpaf9ShhkUAkOcSIKECzbZmKtwDk3WzuOg
        ==
X-Google-Smtp-Source: ABdhPJzxsLtvVQF69Qc/F5Z9FeVpjh0X5o38zO8ak/GSF6nGCInOxLxVE9o/xlW2LUSehCUqQNhHIBmO5LCp6hJCVLc=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:b902:: with SMTP id
 u2mr1663488qvf.7.1602717921249; Wed, 14 Oct 2020 16:25:21 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:25:17 -0700
Message-Id: <20201014232517.3068298-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH] commit: use config-based hooks (config-based hooks part II)
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the adoption of config-based hooks, teach run_commit_hook()
to call hook.h instead of run-command.h. This covers 'pre-commit',
'commit-msg', and 'prepare-commit-msg'. Additionally, ask the hook
library - not run-command - whether any hooks will be run, as it's
possible hooks may exist in the config but not the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

This is based on es/config-based-hooks (v5).

Since config-based hooks v4, I split a new branch for the conversions of
existing hook callers. I'm hoping this will make it easier for me to
work on the architecture without needing to juggle these
hopefully-slow-moving patches as frequently, and will reduce the load on
reviewers.

Since v4 also I removed the second patch changing the run_commit_hook()
API. I had figured it might not be well received when I sent it, and it
wasn't, so no worries.

I'm hoping to have updates to this series pretty soon too with new
conversions... so I guess this one may just be noise. Ah well.

 - Emily

 builtin/commit.c                                |  3 ++-
 builtin/merge.c                                 |  3 ++-
 commit.c                                        | 10 +++++++++-
 ...503-pre-commit-and-pre-merge-commit-hooks.sh | 17 +++++++++++++++--
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1dfd799ec5..a337ecd4c2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -36,6 +36,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -983,7 +984,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit", configured_hookdir_opt())) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..36ba138f4e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -829,7 +830,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit", configured_hookdir_opt()))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
diff --git a/commit.c b/commit.c
index f53429c0ac..b338f50103 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1635,8 +1636,11 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 {
 	struct strvec hook_env = STRVEC_INIT;
 	va_list args;
+	const char *arg;
+	struct strvec hook_args = STRVEC_INIT;
 	int ret;
 
+
 	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
@@ -1646,9 +1650,13 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&hook_args, arg);
 	va_end(args);
+
+	ret = run_hooks(hook_env.v, name, &hook_args, configured_hookdir_opt());
 	strvec_clear(&hook_env);
+	strvec_clear(&hook_args);
 
 	return ret;
 }
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..fc93bc3d23 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -5,8 +5,8 @@ test_description='pre-commit and pre-merge-commit hooks'
 . ./test-lib.sh
 
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
-PRECOMMIT="$HOOKDIR/pre-commit"
-PREMERGE="$HOOKDIR/pre-merge-commit"
+PRECOMMIT="$(pwd)/$HOOKDIR/pre-commit"
+PREMERGE="$(pwd)/$HOOKDIR/pre-merge-commit"
 
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -103,6 +103,19 @@ test_expect_success 'with succeeding hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+# NEEDSWORK: when 'git hook add' and 'git hook remove' have been added, use that
+# instead
+test_expect_success 'with succeeding hook (config-based)' '
+	test_when_finished "git config --unset hook.pre-commit.command success.sample" &&
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	git config hook.pre-commit.command "$HOOKDIR/success.sample" &&
+	echo "$HOOKDIR/success.sample" >expected_hooks &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success 'with succeeding hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
-- 
2.28.0.rc0.142.g3c755180ce-goog


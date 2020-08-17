Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770D4C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5343C20738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uG3BAjPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgHQRlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbgHQRkS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:40:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C83C061343
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a14so15818314wra.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=cKo0/VMRtvJyblJ4c0yERNd4jXZ3OokpaAL/HM/CGTk=;
        b=uG3BAjPlVhIBMTRWii55f8R2TGTfOb/tcfa7k7LfTVg/BA4sCxer7OsN8P2f44UHcW
         m5E70U0mjWARN5IcNhzHBTEqNA6vVqXMVnjLVXiMF2lk2SNXxYec8dlXzGbEMuua5m56
         vYgyI+r1C6IJFAeYeTjuyBx0zAxdKDvgMcvF22Fyixha8Y5jyeACGPoI55gvbiLccnZQ
         /JqZz4vKinz3sOpYPkE4SQponcAqGYbfKWbkYI9cdgpnuPfSMUtAfCzopMPIHATPB28b
         3iYtDl7MBipwc24rVuqPaNT61C8OjXwugJO6gLhQrZa8WxfmdDvjeK0dPEyx5HoWUgcV
         l4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=cKo0/VMRtvJyblJ4c0yERNd4jXZ3OokpaAL/HM/CGTk=;
        b=EaacRmUqHOhRJlcDm18GEkrNNPj5BWRbEdIvPN2hzB1W3GfhYKl9KCHwWyren16LDV
         Jw9hhy8VZ6Ot+Pt0610nwYqKeCPIBrW54I+fv/MNYLp1MGrQ5l/1sil/D7A7D53nBf0y
         vk1QoB9DDjexzs1Ut1BlDvokTBTSVSVxpL5pZMGBSHr4JLkcosiC1xgMo7JpQsbCK5Zg
         ntUxVyWJOoXauxDRyBwh5x71EDFXCI1juW0Co47KxQuJQFuhpnOzZtI6hSRfp43kyPaV
         nI5PKvCwZRIAG7Rjdt/k4x+y87JCzAXfv9RphHMKt4njB4YwarHW7oBrdgVRoW5c5Ms6
         ED5g==
X-Gm-Message-State: AOAM531OmgjA36/MKiYYN87jd0vFg5uEQ07SB8tWXqFNHnixQfdX1Sy+
        CnGtxvTe3gPIMN5vbmg8bhA=
X-Google-Smtp-Source: ABdhPJztip9K02UTpOjI/VBG+sRm5+P+08lalYpgDvD+jag16sVwI/+BQmXnTJdu6e32M8E4FJiDNw==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr17005785wrt.191.1597686014398;
        Mon, 17 Aug 2020 10:40:14 -0700 (PDT)
Received: from localhost.localdomain (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id l10sm31252058wru.3.2020.08.17.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:40:13 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 1/5] rebase -i: add --ignore-whitespace flag
Date:   Mon, 17 Aug 2020 18:40:00 +0100
Message-Id: <20200817174004.92455-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817174004.92455-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

Rebase is implemented with two different backends - 'apply' and
'merge' each of which support a different set of options. In
particular the apply backend supports a number of options implemented
by 'git am' that are not implemented in the merge backend. This means
that the available options are different depending on which backend is
used which is confusing. This patch adds support for the
--ignore-whitespace option to the merge backend. This option treats
lines with only whitespace changes as unchanged and is implemented in
the merge backend by translating it to -Xignore-space-change.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt           | 19 +++++++-
 builtin/rebase.c                       | 19 ++++++--
 t/t3422-rebase-incompatible-options.sh |  1 -
 t/t3436-rebase-more-options.sh         | 60 ++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 6 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..b003784f01 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -422,8 +422,23 @@ your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
+	Ignore whitespace differences when trying to reconcile
+differences. Currently, each backend implements an approximation of
+this behavior:
++
+apply backend: When applying a patch, ignore changes in whitespace in
+context lines. Unfortunately, this means that if the "old" lines being
+replaced by the patch differ only in whitespace from the existing
+file, you will get a merge conflict instead of a successful patch
+application.
++
+merge backend: Treat lines with only whitespace changes as unchanged
+when merging. Unfortunately, this means that any patch hunks that were
+intended to modify whitespace and nothing else will be dropped, even
+if the other side had no changes that conflicted.
+
 --whitespace=<option>::
-	These flags are passed to the 'git apply' program
+	This flag is passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Implies --apply.
 +
@@ -572,7 +587,6 @@ The following options:
  * --apply
  * --committer-date-is-author-date
  * --ignore-date
- * --ignore-whitespace
  * --whitespace
  * -C
 
@@ -598,6 +612,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --empty=
+ * --preserve-merges and --ignore-whitespace
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27a07d4e78..bd93e9742c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -126,6 +126,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
+
 	if (opts->strategy_opts)
 		parse_strategy_opts(&replay, opts->strategy_opts);
 
@@ -1466,6 +1467,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct strbuf revisions = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
+	int ignore_whitespace = 0;
 	enum action action = ACTION_NONE;
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
@@ -1495,16 +1497,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
-				  NULL, N_("passed to 'git am'"),
-				  PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
 				  &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
+		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
@@ -1850,6 +1851,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		imply_merge(&options, "--rebase-merges");
 	}
 
+	if (options.type == REBASE_APPLY) {
+		if (ignore_whitespace)
+			argv_array_push(&options.git_am_opts,
+					"--ignore-whitespace");
+	} else {
+		/* REBASE_MERGE and PRESERVE_MERGES */
+		if (ignore_whitespace) {
+			string_list_append(&strategy_options,
+					   "ignore-space-change");
+		}
+	}
+
 	if (strategy_options.nr) {
 		int i;
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 50e7960702..55ca46786d 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --ignore-whitespace
 test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
new file mode 100755
index 0000000000..4f8a6e51c9
--- /dev/null
+++ b/t/t3436-rebase-more-options.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Rohit Ashiwal
+#
+
+test_description='tests to ensure compatibility between am and interactive backends'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+# This is a special case in which both am and interactive backends
+# provide the same output. It was done intentionally because
+# both the backends fall short of optimal behaviour.
+test_expect_success 'setup' '
+	git checkout -b topic &&
+	test_write_lines "line 1" "	line 2" "line 3" >file &&
+	git add file &&
+	git commit -m "add file" &&
+
+	test_write_lines "line 1" "new line 2" "line 3" >file &&
+	git commit -am "update file" &&
+	git tag side &&
+
+	git checkout --orphan master &&
+	test_write_lines "line 1" "        line 2" "line 3" >file &&
+	git commit -am "add file" &&
+	git tag main
+'
+
+test_expect_success '--ignore-whitespace works with apply backend' '
+	test_must_fail git rebase --apply main side &&
+	git rebase --abort &&
+	git rebase --apply --ignore-whitespace main side &&
+	git diff --exit-code side
+'
+
+test_expect_success '--ignore-whitespace works with merge backend' '
+	test_must_fail git rebase --merge main side &&
+	git rebase --abort &&
+	git rebase --merge --ignore-whitespace main side &&
+	git diff --exit-code side
+'
+
+test_expect_success '--ignore-whitespace is remembered when continuing' '
+	(
+		set_fake_editor &&
+		FAKE_LINES="break 1" git rebase -i --ignore-whitespace \
+			main side &&
+		git rebase --continue
+	) &&
+	git diff --exit-code side
+'
+
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
+test_done
-- 
2.28.0


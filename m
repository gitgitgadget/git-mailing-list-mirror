Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A2C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773942072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0xchTTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEUKPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgEUKPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 06:15:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C96C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so4904921wrw.1
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=NJmFAE8A9rgEGyh7Pifl8cs2YJ1/clxENMtMNq/R85k=;
        b=N0xchTTpZuGoj5CNYMesXVaiHP6iN2cvcKuNE6Hpq866cuWabuVpWLie2iT5EmGxrc
         XxmUJMJP2zytqNqc7o7hRVKp/TTJKrIperVXX2IaabzN7r7AePFGcIVe/HWLn8v6BFE1
         c6l9mRv0cOBFnj2X0azLB9VNA7BG5hwvfC1YU37/2O51YwmEc6lbZZ9PJoF3djBgcxkb
         tCNdi913rxf5us4khamQUrVR/5h48r7h+SibP/7N+rntU8Krih2cpdW0azD3nCA60FTq
         NFL+CCNE1/SI47LlEgA3f40SRgWCvzJbmPSuOzvsrvInyzsRQPiqMel9g/p4eRV9a9ei
         7CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=NJmFAE8A9rgEGyh7Pifl8cs2YJ1/clxENMtMNq/R85k=;
        b=sksSZ9I3V9MG6M8kqwDCeiSJ6pfUTZTX/StQS3TSX5HSggpirUb9ENXXLmkrYumlwf
         paT7sLxupg91e0/JLHESYWXHHN8vOTNm5dPc5Zzs6LM12goj599ekEhrjejPsWrf7oAX
         jHh1R2knhzrtwCQRjn6tIq7ZQylpPNGxKzfC1hqKwovUmfviGDqbNwAn64bXiJhjMCTi
         E8TlMJVpvFggJ411rTKbb/g+a9uO4xVvVtXijYTLUJj72OEIe6dde1qZmsM2O3+PQCN1
         M9G5j6BordgkdAKsw5DRB9HtQy0vJbqmuEicDW6wRXL1pa0U+BZeuJm9Ag6kDE2oSzGF
         iJvg==
X-Gm-Message-State: AOAM532pqXO8hpHkE8nq9aA2pHr9446lIjtbmWe+tkgxDzVAq5u31h3T
        EvtA4ldMWpBYd480KY9RP9c=
X-Google-Smtp-Source: ABdhPJzyV3YS6SZyY1vRA2KjcPSI3pZ5kQ9hJMysrfKp6se9mXXkfPZGVajScYQ+fTluYsR4CI/zSg==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr8472777wru.12.1590056116219;
        Thu, 21 May 2020 03:15:16 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id y5sm656219wrs.63.2020.05.21.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:15:15 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 1/5] rebase -i: add --ignore-whitespace flag
Date:   Thu, 21 May 2020 11:14:51 +0100
Message-Id: <20200521101455.63484-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521101455.63484-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

Rebase is implemented with two different backends - 'apply' and 'merge'
each of which support a different set of options. In particuar the apply
backend supports a number of options implemented by 'git am' that are
not available to the merge backend. As part of an on going effort to
remove the apply backend this patch adds support for the
--ignore-whitespace option to the merge backend. This option treats
lines with only whitespace changes as unchanged and is implemented in
the merge backend by translating it to -Xignore-space-change.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt           | 19 +++++-
 builtin/rebase.c                       | 19 ++++--
 t/t3422-rebase-incompatible-options.sh |  1 -
 t/t3436-rebase-more-options.sh         | 86 ++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 7 deletions(-)
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
index 27a07d4e78..5d8e117276 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -86,6 +86,7 @@ struct rebase_options {
 	int signoff;
 	int allow_rerere_autoupdate;
 	int autosquash;
+	int ignore_whitespace;
 	char *gpg_sign_opt;
 	int autostash;
 	char *cmd;
@@ -108,6 +109,7 @@ struct rebase_options {
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 {
+	struct strbuf strategy_buf = STRBUF_INIT;
 	struct replay_opts replay = REPLAY_OPTS_INIT;
 
 	replay.action = REPLAY_INTERACTIVE_REBASE;
@@ -126,14 +128,20 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
+
 	if (opts->strategy_opts)
-		parse_strategy_opts(&replay, opts->strategy_opts);
+		strbuf_addstr(&strategy_buf, opts->strategy_opts);
+	if (opts->ignore_whitespace)
+		strbuf_addstr(&strategy_buf, " --ignore-space-change");
+	if (strategy_buf.len)
+		parse_strategy_opts(&replay, strategy_buf.buf);
 
 	if (opts->squash_onto) {
 		oidcpy(&replay.squash_onto, opts->squash_onto);
 		replay.have_squash_onto = 1;
 	}
 
+	strbuf_release(&strategy_buf);
 	return replay;
 }
 
@@ -539,6 +547,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
+	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
+
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
@@ -991,6 +1001,8 @@ static int run_am(struct rebase_options *opts)
 	am.git_cmd = 1;
 	argv_array_push(&am.args, "am");
 
+	if (opts->ignore_whitespace)
+		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1495,16 +1507,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
+		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
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
index 0000000000..fb5e747e86
--- /dev/null
+++ b/t/t3436-rebase-more-options.sh
@@ -0,0 +1,86 @@
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
+	q_to_tab >file <<-\EOF &&
+	line 1
+	Qline 2
+	line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	cat >file <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	git commit -am "update file" &&
+	git tag side &&
+
+	git checkout --orphan master &&
+	sed -e "s/^|//" >file <<-\EOF &&
+	|line 1
+	|        line 2
+	|line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	git tag main
+'
+
+test_expect_success '--ignore-whitespace works with apply backend' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	test_must_fail git rebase --apply main side &&
+	git rebase --abort &&
+	git rebase --apply --ignore-whitespace main side &&
+	test_cmp expect file
+'
+
+test_expect_success '--ignore-whitespace works with merge backend' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	test_must_fail git rebase --merge main side &&
+	git rebase --abort &&
+	git rebase --merge --ignore-whitespace main side &&
+	test_cmp expect file
+'
+
+test_expect_success '--ignore-whitespace is remembered when continuing' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="break 1" git rebase -i --ignore-whitespace main side
+	) &&
+	git rebase --continue &&
+	test_cmp expect file
+'
+
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
+test_done
-- 
2.26.2


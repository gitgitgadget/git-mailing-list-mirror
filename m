Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9D020248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfBYXRY (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXRX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id n19so598396wmi.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=su2L3jRnma+x1Bj9zF4Twv7P3n6xzrqejiOkljswUdg=;
        b=jQwW1dT7Nw2Vfqyfu39VAqUneyRyllJtjxXs878LpkXwSkoRNFuYuOS1YCIEPNnVgm
         EUoSSZDr9XXEKiVC0zRwbKZgWrLPPByCjgSmGLblHJi9ILghHCqQWfzT54sKuhDgbDzr
         puk2tCxztF8zkVRGo02cbk4oa7jtRLa2RoxgAjiyc/w6CUxcl8FvK+/P0d1Y+0GrJ6xd
         gvLOXelCnNZ6aBR3/1ZTBEl3uRH8MwUphicGpzK2s+jAwVRaRnVSkGRqVvzF4jLi7dat
         /keYEchzwwxpw68MuZPi+JN9eRFViOJvHxEgwl1J5rmV06rsWOfQZhY4t1aMgDILH0Dk
         NuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=su2L3jRnma+x1Bj9zF4Twv7P3n6xzrqejiOkljswUdg=;
        b=fi7lkFo6RmR1pvnpQnHKryhk/3dzyr90lElh2IDneQTMDImz3P/bo3NrX/uC+wN1MQ
         2JVurK1Ce7mhDIftjgYiRwID8yMO333e/O7fvmmNRuwhmHVl7OdO9338j23s5y5O/2zR
         TGna6WjCYGwx38FSbVVcJ8NBmygZfGlR+dtlapWz6mbOwezo5auI+gVvf64YxqKupo2J
         8+uzzOcR7yKaUprlLRbK382d4xMz8RogML5DXMsSqC+pxk03GxZ7BYLT8MM/au6L8efr
         Epfb1HxXMcNpaHP7FZCY093mH5Q0MtKKAZJInYgHWVVHa8me9/Fce1zbdvWm8PY8mNJ8
         FITQ==
X-Gm-Message-State: AHQUAuYYsfAEX5RrRHdMUm2RB/Lc8pHQtPnuXzVEgs3E/nCj02qKdHMF
        ZLjKzYcflsQvNlfu5C6dZ+54Z8XY
X-Google-Smtp-Source: AHgI3IbbA5Q67JFaq9eRYdrnaKDMAjovIX4O9LzwzrRbQcO5SsOK19PokD+Fkc4Afy+anbrevQ6MgQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr686946wme.93.1551136640615;
        Mon, 25 Feb 2019 15:17:20 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id i12sm17746588wrq.21.2019.02.25.15.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:19 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 20/27] stash: make push -q quiet
Date:   Mon, 25 Feb 2019 23:16:24 +0000
Message-Id: <20190225231631.30507-21-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

There is a change in behaviour with this commit. When there was
no initial commit, the shell version of stash would still display
a message. This commit makes `push` to not display any message if
`--quiet` or `-q` is specified. Add tests for `--quiet`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 56 ++++++++++++++++++++++++++---------------
 t/t3903-stash.sh        | 23 +++++++++++++++++
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 30c7aad76a..1c61352093 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -966,7 +966,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 }
 
 static int stash_patch(struct stash_info *info, struct pathspec ps,
-		       struct strbuf *out_patch)
+		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
 	struct strbuf out = STRBUF_INIT;
@@ -1019,7 +1019,8 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 	if (!out_patch->len) {
-		fprintf_ln(stderr, _("No changes selected"));
+		if (!quiet)
+			fprintf_ln(stderr, _("No changes selected"));
 		ret = 1;
 	}
 
@@ -1098,7 +1099,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info, struct strbuf *patch)
+			   struct stash_info *info, struct strbuf *patch,
+			   int quiet)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1118,7 +1120,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	refresh_cache(REFRESH_QUIET);
 
 	if (get_oid("HEAD", &info->b_commit)) {
-		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		if (!quiet)
+			fprintf_ln(stderr, _("You do not have "
+					     "the initial commit yet"));
 		ret = -1;
 		goto done;
 	} else {
@@ -1143,7 +1147,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot save the current index state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current "
+					     "index state"));
 		ret = -1;
 		goto done;
 	}
@@ -1151,26 +1157,29 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	if (include_untracked && get_untracked_files(ps, include_untracked,
 						     &untracked_files)) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
-			fprintf_ln(stderr, _("Cannot save "
-					     "the untracked files"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save "
+						     "the untracked files"));
 			ret = -1;
 			goto done;
 		}
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch);
+		ret = stash_patch(info, ps, patch, quiet);
 		if (ret < 0) {
-			fprintf_ln(stderr, _("Cannot save the current "
-					     "worktree state"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the current "
+						     "worktree state"));
 			goto done;
 		} else if (ret > 0) {
 			goto done;
 		}
 	} else {
 		if (stash_working_tree(info, ps)) {
-			fprintf_ln(stderr, _("Cannot save the current "
-					     "worktree state"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot save the current "
+						     "worktree state"));
 			ret = -1;
 			goto done;
 		}
@@ -1196,7 +1205,9 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 
 	if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
-		fprintf_ln(stderr, _("Cannot record working tree state"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot record "
+					     "working tree state"));
 		ret = -1;
 		goto done;
 	}
@@ -1231,7 +1242,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	memset(&ps, 0, sizeof(ps));
 	strbuf_addstr(&stash_msg_buf, stash_msg);
 	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
-			      NULL);
+			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
@@ -1293,26 +1304,29 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 
 	if (!reflog_exists(ref_stash) && do_clear_stash()) {
 		ret = -1;
-		fprintf_ln(stderr, _("Cannot initialize stash"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot initialize stash"));
 		goto done;
 	}
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
 	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    &info, &patch)) {
+			    &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
 	}
 
 	if (do_store_stash(&info.w_commit, stash_msg_buf.buf, 1)) {
 		ret = -1;
-		fprintf_ln(stderr, _("Cannot save the current status"));
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot save the current status"));
 		goto done;
 	}
 
-	printf_ln(_("Saved working directory and index state %s"),
-		  stash_msg_buf.buf);
+	if (!quiet)
+		printf_ln(_("Saved working directory and index state %s"),
+			  stash_msg_buf.buf);
 
 	if (!patch_mode) {
 		if (include_untracked && !ps.nr) {
@@ -1414,7 +1428,9 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 		argv_array_pushl(&cp.args, "apply", "-R", NULL);
 
 		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
-			fprintf_ln(stderr, _("Cannot remove worktree changes"));
+			if (!quiet)
+				fprintf_ln(stderr, _("Cannot remove "
+						     "worktree changes"));
 			ret = -1;
 			goto done;
 		}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 023421a36c..7dfa3a8038 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1072,6 +1072,29 @@ test_expect_success 'push: <pathspec> not in the repository errors out' '
 	test_path_is_file untracked
 '
 
+test_expect_success 'push: -q is quiet with changes' '
+	>foo &&
+	git add foo &&
+	git stash push -q >output 2>&1 &&
+	test_must_be_empty output
+'
+
+test_expect_success 'push: -q is quiet with no changes' '
+	git stash push -q >output 2>&1 &&
+	test_must_be_empty output
+'
+
+test_expect_success 'push: -q is quiet even if there is no initial commit' '
+	git init foo_dir &&
+	test_when_finished rm -rf foo_dir &&
+	(
+		cd foo_dir &&
+		>bar &&
+		test_must_fail git stash push -q >output 2>&1 &&
+		test_must_be_empty output
+	)
+'
+
 test_expect_success 'untracked files are left in place when -u is not given' '
 	>file &&
 	git add file &&
-- 
2.21.0.rc2.291.g17236886c5


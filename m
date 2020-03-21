Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF0FC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACBE2070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHP8K+Bx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgCUJWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:36 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35942 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgCUJWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:36 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so4473524qvw.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzbZ3ys4Y1U3aFmYFRHczPO7oubpzxQSsBh9CTMSZcI=;
        b=OHP8K+Bx4GinS4FNJT/RNpQybw64h2I44XXWNFUUAQcv8Rf3Prf++PIsF9X3lJ0Zb2
         5qhn4UhIW9CcNwRAj+uqkQfXDwDdpQ/0LhvezBCUyWVNUBaXi5mxYKmpv2xvBmtv2BYB
         OoxR51Wm0zrZnu37ewUY5p4RXM9V9hojdQs/pAZmT6H8MZw5wLXoI7P+Xxrgs7heaEY2
         SWp3UECPGT3O+6jBBxfTI/CwJUabzwosdzJLBkXxHWiX+ag2RAVkR5Rrcy+JL8ZkJc0+
         DZPFk8to7qULANfNX4H48CeMZe5WdHW86tYChby6/kpYvu7XeqrB86T5td39en/zhUw8
         wG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzbZ3ys4Y1U3aFmYFRHczPO7oubpzxQSsBh9CTMSZcI=;
        b=VBDceso8qBApDwynYH/QqeSmFCtROGNCQAtHu9uP+BnaxKRzuJIck9RXF2idUURNZ6
         qox8pVgq+dSsNDE87NzcTbriJnzLLHucr2PcL1rRlluMb5tQ1LdybQIueu2eEQbpLIdL
         7mleoPtdtae8Zj6Mca58ygcOGM/c6aJe1r9xJDrc2N3NMm7qXUNCCut6aw/p9LScj/d2
         BbNPtdaIF6fCeM3FZYxMmWQz6roqmufq2rSeVG4q0/Nj+oX571dY+ZMyk3p1AsiGf0k9
         oj9MjO6fb5D3CAGPnvUnvEpgOWVCyHMN+nklP29CkKFnCKH735kfFAGzks/n5NvET9i5
         ANbA==
X-Gm-Message-State: ANhLgQ3ugjTfGF8IIhRp9g3Xt3msSyo4t/dTVBTO2Lxhx83M/qAoR5lQ
        ysx76QnMY7VeBKXmdiQaZo9jTAMI
X-Google-Smtp-Source: ADFU+vtTUJDaXlhhVdM6NVWmdWXT4HXfWOuJDBL/uLFj5+RpL9FD2HmBtWGWK4d1BEl7jEAHNyki9Q==
X-Received: by 2002:a0c:aee5:: with SMTP id n37mr11679367qvd.173.1584782555219;
        Sat, 21 Mar 2020 02:22:35 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 14/19] sequencer: extract perform_autostash() from rebase
Date:   Sat, 21 Mar 2020 05:21:33 -0400
Message-Id: <bf55b86e2bd64d995ef559611558e885bf63bc38.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lib-ify the autostash code by extracting perform_autostash() from rebase
into sequencer. In a future commit, this will be used to implement
`--autostash` in other builtins.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 49 -----------------------------------------------
 sequencer.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |  2 ++
 3 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3370c8f2c4..b6821be62b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1274,55 +1274,6 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
-static void create_autostash(struct repository *r, const char *path,
-			     const char *default_reflog_action)
-{
-	struct strbuf buf = STRBUF_INIT;
-	struct lock_file lock_file = LOCK_INIT;
-	int fd;
-
-	fd = repo_hold_locked_index(r, &lock_file, 0);
-	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
-	if (0 <= fd)
-		repo_update_index_if_able(r, &lock_file);
-	rollback_lock_file(&lock_file);
-
-	if (has_unstaged_changes(r, 1) ||
-	    has_uncommitted_changes(r, 1)) {
-		struct child_process stash = CHILD_PROCESS_INIT;
-		struct object_id oid;
-
-		argv_array_pushl(&stash.args,
-				 "stash", "create", "autostash", NULL);
-		stash.git_cmd = 1;
-		stash.no_stdin = 1;
-		strbuf_reset(&buf);
-		if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
-			die(_("Cannot autostash"));
-		strbuf_trim_trailing_newline(&buf);
-		if (get_oid(buf.buf, &oid))
-			die(_("Unexpected stash response: '%s'"),
-			    buf.buf);
-		strbuf_reset(&buf);
-		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
-
-		if (safe_create_leading_directories_const(path))
-			die(_("Could not create directory for '%s'"),
-			    path);
-		write_file(path, "%s", oid_to_hex(&oid));
-		printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, NULL, "reset --hard",
-			       NULL, RESET_HEAD_HARD, NULL, NULL,
-			       default_reflog_action) < 0)
-			die(_("could not reset --hard"));
-
-		if (discard_index(r->index) < 0 ||
-			repo_read_index(r) < 0)
-			die(_("could not read index"));
-	}
-	strbuf_release(&buf);
-}
-
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = REBASE_OPTIONS_INIT;
diff --git a/sequencer.c b/sequencer.c
index b52668f8de..b2951843a1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,7 @@
 #include "alias.h"
 #include "commit-reach.h"
 #include "rebase-interactive.h"
+#include "reset.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3655,6 +3656,55 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
+void create_autostash(struct repository *r, const char *path,
+		      const char *default_reflog_action)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
+
+	fd = repo_hold_locked_index(r, &lock_file, 0);
+	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
+	if (0 <= fd)
+		repo_update_index_if_able(r, &lock_file);
+	rollback_lock_file(&lock_file);
+
+	if (has_unstaged_changes(r, 1) ||
+	    has_uncommitted_changes(r, 1)) {
+		struct child_process stash = CHILD_PROCESS_INIT;
+		struct object_id oid;
+
+		argv_array_pushl(&stash.args,
+				 "stash", "create", "autostash", NULL);
+		stash.git_cmd = 1;
+		stash.no_stdin = 1;
+		strbuf_reset(&buf);
+		if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
+			die(_("Cannot autostash"));
+		strbuf_trim_trailing_newline(&buf);
+		if (get_oid(buf.buf, &oid))
+			die(_("Unexpected stash response: '%s'"),
+			    buf.buf);
+		strbuf_reset(&buf);
+		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
+
+		if (safe_create_leading_directories_const(path))
+			die(_("Could not create directory for '%s'"),
+			    path);
+		write_file(path, "%s", oid_to_hex(&oid));
+		printf(_("Created autostash: %s\n"), buf.buf);
+		if (reset_head(r, NULL, "reset --hard",
+			       NULL, RESET_HEAD_HARD, NULL, NULL,
+			       default_reflog_action) < 0)
+			die(_("could not reset --hard"));
+
+		if (discard_index(r->index) < 0 ||
+			repo_read_index(r) < 0)
+			die(_("could not read index"));
+	}
+	strbuf_release(&buf);
+}
+
 int apply_autostash(const char *path)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
diff --git a/sequencer.h b/sequencer.h
index bab910f012..44ecfee7f3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -191,6 +191,8 @@ void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
+void create_autostash(struct repository *r, const char *path,
+		      const char *default_reflog_action);
 int apply_autostash(const char *path);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
-- 
2.25.0.114.g5b0ca878e0


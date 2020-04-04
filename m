Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF9C2BA19
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BEE20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usB5BWYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDDBMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33990 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDDBMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so7904599qtp.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zk9ObUzTQltqhzu6e9Ir2MbkOrMxwNbJFFPR40SA9yw=;
        b=usB5BWYIfKgWBBilRELcQ65/OuqCXgrsPF9zsD8Ybn1WzFcDjLV5ZaGev0m1JV41Lr
         m6vOF3kYmJCsLu824lsProue/EVl14BZjE5lNWmRYjzBKTt+lgnpX7E4JfjnwmlRLETO
         QqsIzXEpXcMVsOK9JuyXjxbRP+08T9BkgN+HcbCeKXkZzJ50sXY1Z5e+FaIi4VrRbmSP
         NvlYNEhd50Uz5nYGi6/idU1iURSV8JTEX+BL20D0R+aH1zKJWLQecHCV0GHN6Kl5ULHi
         cze7VGrWaKaKEBMNSOAnUUJtBkEY+K9W8QP78KpNxADZV4pfuG/4imaTm54hxUy+1m3S
         13JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zk9ObUzTQltqhzu6e9Ir2MbkOrMxwNbJFFPR40SA9yw=;
        b=nokO5KDZDcAS8KIjm98v/i6xNYAXbDzqnVJGj46/FcpItsTfZM0N+3HJKvjHMiwcgu
         xx/fWzqrklxezHROS4j3LC2LVEbxKmYeYZ6GQtpPyPjzYQTs+DUhQr/+mFe56lyym2Yt
         OjwJgo+AtHjuJR0siQc+cSssEXcptkNQhJWimEioAEJXExqkbklfpEn7YV68s+84xAi8
         T0datuergnkLbNYonsc8O8nJHSz7xXfPYYS7VHcAjoq+cYD05gV2vMY/iDaWg3hnYFL0
         nnd+GY8g7XnOUUxvoBLvPXqoz3qz97vnEk78608+vq9Aa52hzfHQ5uojX8rbx1m0MU1q
         QIRw==
X-Gm-Message-State: AGi0PuYcuEYMUrOwEuHuSfdt0zLzEXxVjd6W6RCoK2iLVLpNhPbXEQjc
        AGC1fWqNC2FRqhPIAoCTWh+1spJG
X-Google-Smtp-Source: APiQypJA3LB1piLFEUVvYH9xPosrvGL7Yz+IUbN4DxRGyybIcMejOB3xGTTrZKwnT0UiFa4K9LOzNg==
X-Received: by 2002:aed:2f01:: with SMTP id l1mr11122523qtd.37.1585962737380;
        Fri, 03 Apr 2020 18:12:17 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:16 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 17/23] sequencer: extract perform_autostash() from rebase
Date:   Fri,  3 Apr 2020 21:11:30 -0400
Message-Id: <26cca49be6908083382b2209e405e7462cd077a7.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
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
index e9b05a6cd8..b800c8bfca 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1269,55 +1269,6 @@ static int check_exec_cmd(const char *cmd)
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
index dde1f6b30f..8efe0976fd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,7 @@
 #include "alias.h"
 #include "commit-reach.h"
 #include "rebase-interactive.h"
+#include "reset.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3649,6 +3650,55 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
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
 	struct strbuf stash_oid = STRBUF_INIT;
diff --git a/sequencer.h b/sequencer.h
index d6ba62a089..cf1284f9ed 100644
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
2.26.0.159.g23e2136ad0


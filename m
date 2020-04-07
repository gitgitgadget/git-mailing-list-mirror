Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D060C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336F22078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbxeQo+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgDGO2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40183 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgDGO2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id y25so2765930qtv.7
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEzgRKezWZjx4ccNWcDOD2Fu4xo8RPkVpircpq0w+6Q=;
        b=kbxeQo+xa4jGdMap5KE0NImCgu7QBkwE0THcNxaethH+YozPDm10FAf58nvn7HuLPf
         dlRlkjVT7PDLBvZFpMxI2lZfBHYomC7RRVY7UHGGT/WTHS3nkPVCIgMAsnUAI3VFzNKx
         JAq/xqCy6yZxDeC+vjFBfp0V0zZIeySBNc+iT8qJlU6dB/6zAI5/ZafbEISSwjMZYhPy
         NGKs2WRifCd3QJpgZ7NcQwgpm5UFrKZy7k6bG9ITNcYOOIXmgQo9BstEKIkugyyJsiv4
         HTG0bzj0FPOa9CqcV8rgv4o+vD9GriR+XjWsWS7FZqa1fRl5JS934BwznH3+zUFAuAcU
         lsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEzgRKezWZjx4ccNWcDOD2Fu4xo8RPkVpircpq0w+6Q=;
        b=JkOu5m3J5N0XR95QkbRheOumY/7yoPsHmZPr4ow/GNrv8xhPVNKfj8S9z0HaNFThpB
         yYsQhfWacSqVeIfo0wmz5H1lNlcM9LtJiVWKX/AFRcnQeMgoGfSQwCBSaL8tlaN2yfEp
         gMqvuX7Y4E0vGS8gr7LaCTMCBY+Ieodooo2xxlzFW+OJRsKty7DTwbO5/Y9YuB11Bjbf
         AYM7jGB4FIH7VSllUJjI79e0othLfxOwXseCxpAoeAdGMvKBagaeTAarT/Tthw1bc3r6
         UocCCnbxU3HDwe5aXCDFqQ7sKpVxWc59ziCY6BVl/lteUo6UlHL0v05OIPnUQ1KGmnYt
         tjBg==
X-Gm-Message-State: AGi0PuZUjSdvRcKLl5N+N4eh/MDfgtiQ1JLCgJ5reqTIZA3LeCSQO3My
        xVlyzvwNj3nDLXKf5BpMtehWlot6
X-Google-Smtp-Source: APiQypI/zI+N+Y5KLUpkgFVLyTpzvrV2DPTyScmRf68vnKxhT3gto+xRfN9z9CCF6Wzy+Q97Psxm2A==
X-Received: by 2002:ac8:424e:: with SMTP id r14mr1320253qtm.324.1586269718818;
        Tue, 07 Apr 2020 07:28:38 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:38 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 16/22] sequencer: extract perform_autostash() from rebase
Date:   Tue,  7 Apr 2020 10:28:03 -0400
Message-Id: <3be4a27dfe0f91c6f0730d0b3a5d1883e4b0eac4.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
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
index ae345c9e57..08b89869b3 100644
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
index f5bb1cc1fb..e0b8262521 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,7 @@
 #include "alias.h"
 #include "commit-reach.h"
 #include "rebase-interactive.h"
+#include "reset.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3657,6 +3658,55 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
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
index ab686146d1..9d1fe0ccfb 100644
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


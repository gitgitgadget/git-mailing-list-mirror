Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE1EC2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5F120643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg8CWZ0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLXLGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:06:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44387 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfLXLGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:06:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id t3so17850271qtr.11
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdNn547eEV48EQGchFj3dbcbQnZ0aMFqfkJbKWNoe48=;
        b=Wg8CWZ0iUEuD9gXrKq8GuC5qBjp4U4ZX8dIWeVowh1NPtzfEINDoAE1dm1o5/XoUAH
         xfaRmdM9gFvVeEKdxQ6MR/HGoKiiCXUAQRjlF1Fr1Dknn9SWTgnX7z43IG6GCDlz37n6
         LbE1rwkYxsQ2BmZ1hO8wRKQ4OWGDxluDqhECWEWPNF3pyrRsYAVNKsZlxXB/WfLc/+mC
         VTbTwH8SQVgcNnrqgzxTlS28gvsEXLRlFA7PuLswF0Acy8YPV5td8V5glS4zgagJTjb+
         rLfYvJkzQDNmZHykiL4qKT0fr6NFdn1ZOUQi82m0tTVscq32EdalFLeXPDTtP+mUWPQm
         ftFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdNn547eEV48EQGchFj3dbcbQnZ0aMFqfkJbKWNoe48=;
        b=I7aX2xIGjyN89ioZeCQvsKX+bDg4TZTJ+pW4mlhgvdCejTlSkFIxa6GvhsEA12QqL1
         hC4EVMvIyrEvqY5oNp2bTVnvFKDmkSF6z+8SvnZWYw8ngK4RTHoY2Kqr9rhTSw3EML1g
         ZwjsR9BJFExE8gqAPnBkHgJW+lM2/LxgsvbqUeoIvsK+VzVrBT0R7T0H/NxBN9utt3xF
         CpkKPIPGWVyLEtDHeCq2pQWLqGzQaxED4w4h8nvfgXr60ySABmP6gEvZNYw2TR98ig2R
         zlgUPvc/p4hUFAUSpVaXyGPcEVXge8OnhmbVTOlNYxX0QAfiUWViWRuBe4/RknezH7Ef
         Mvrw==
X-Gm-Message-State: APjAAAVHGfj7rXTnnA8TAaHtW2OTq5ghOLD4NO5HnCcBZpN5Z30z2JSH
        x43m8Of1nbYAeYW1UNCGr1AYkKE/
X-Google-Smtp-Source: APXvYqy3AmHrEhVLJM55FXzZS7kDgIdBnZmI6tiQdD/5RT70RtzBSGYid1M0QflpOycRkRJe9PkSMA==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr26781769qtj.104.1577185558810;
        Tue, 24 Dec 2019 03:05:58 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:58 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 13/17] sequencer: extract perform_autostash() from rebase
Date:   Tue, 24 Dec 2019 06:05:10 -0500
Message-Id: <2ff189692f82dc34391715ce68e85938190b06c5.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
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
index fea4ae754d..666d3f0181 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1232,55 +1232,6 @@ static int check_exec_cmd(const char *cmd)
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
index 98e08dbbe0..ba04ee2de8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,7 @@
 #include "alias.h"
 #include "commit-reach.h"
 #include "rebase-interactive.h"
+#include "reset.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -3744,6 +3745,55 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
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
index ecef2c144c..8beb1472f7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -195,6 +195,8 @@ void commit_post_rewrite(struct repository *r,
 int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
 				 const char *commit);
 
+void create_autostash(struct repository *r, const char *path,
+		      const char *default_reflog_action);
 int apply_autostash(const char *path);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
-- 
2.24.1.810.g65a2f617f4


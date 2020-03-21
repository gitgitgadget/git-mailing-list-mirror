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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5966C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D9D2070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKtzisJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgCUJWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37316 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCUJWc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id z25so9826346qkj.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQzYfZfGitMPy9DZUivn5OQoLOpLrKzCQmzmrSedqUA=;
        b=cKtzisJo6zMVqgC7jCQlrridayfBo0lWDpbFZ5NXE+ABGjex9xp+bF0sidsJETJYgr
         zpR705pooU9DvSsO8UTgw8VsBwJkT39TLhDuzcfMKZxSXin0gm9N7JBKRgjn44WyngcN
         WmLoUPAaGQNmhujKq6vA5mPkIH6uxBoM62C0LtQ0YQtPYuE5ZcZzWFU85aVV0BV7lzTv
         cF97xLIrIexWlzI0PHGkL5hhQbRQYoUUDoN+UaPh/v1Rmp3/B/k/LP/Zz1dzuqO5pJ9v
         NgLXFrdFu+xRof1nHl+yVZ4I6hHGCEQZeYJjaBfJK45tET6vOiiu3QyKl5lJFA8CwaUw
         RF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQzYfZfGitMPy9DZUivn5OQoLOpLrKzCQmzmrSedqUA=;
        b=prXhh9sVKZc4pt5NCg5ghq+ceLlwiR7ZqySDipBnJBC4Vz4K/NcPErfQLkAgk+GMS6
         DIpF1CuL6zF+8qqzQGxe/Z6uTLg+LFUSGp9irBWL97UWa+d3ju7/5IGnZplGiFVCGeja
         Mkkch2LFerdDFVfpW+PbEejLhsiIl0Dd1vosTeXD+y62b1a5NC/9hBvY2O2dFKFl8Tdf
         NDcnSmE2SEjNLrSEcIK7lB6+4S9gVCxFuEeL9LlhHg8oiNB3eM4A7anjeLXO23LRT1mh
         YvqXPR6pgsBmFZYwB7drpG81Can5l5Zk7bMGWY7CtVLq2KjSSWlPhQf7TRlPu9++jdUq
         9IhQ==
X-Gm-Message-State: ANhLgQ0oHSh/euXz8CO4ZDWDAb4WcMfuZfJSGK+IN9ImE4xrnejht4tw
        TOyFPIxG3CzAhta+fUA1yiYxyGnT
X-Google-Smtp-Source: ADFU+vsnwsxpWtwJamdkVohMguqeiJmqYCYNlj+EW1JbWlsS166iJ1RxcjV58owLIbkHYGNg9+EILQ==
X-Received: by 2002:a05:620a:1279:: with SMTP id b25mr1640871qkl.481.1584782550322;
        Sat, 21 Mar 2020 02:22:30 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 12/19] rebase: extract create_autostash()
Date:   Sat, 21 Mar 2020 05:21:31 -0400
Message-Id: <1dbae3dfbf0a9dbd0ef68d8788771b7dd04e7d0c.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will lib-ify this code. In preparation for
this, extract the code into the create_autostash() function so that it
can be cleaned up before it is finally lib-ified.

This patch is best viewed with `--color-moved` and
`--color-moved-ws=allow-indentation-change`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 94 +++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index caff67b00d..037effc510 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1274,6 +1274,55 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
+static void create_autostash(struct rebase_options *options)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
+
+	fd = hold_locked_index(&lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	if (0 <= fd)
+		repo_update_index_if_able(the_repository, &lock_file);
+	rollback_lock_file(&lock_file);
+
+	if (has_unstaged_changes(the_repository, 1) ||
+	    has_uncommitted_changes(the_repository, 1)) {
+		const char *autostash =
+			state_dir_path("autostash", options);
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
+		if (safe_create_leading_directories_const(autostash))
+			die(_("Could not create directory for '%s'"),
+			    options->state_dir);
+		write_file(autostash, "%s", oid_to_hex(&oid));
+		printf(_("Created autostash: %s\n"), buf.buf);
+		if (reset_head(the_repository, NULL, "reset --hard",
+			       NULL, RESET_HEAD_HARD, NULL, NULL,
+			       DEFAULT_REFLOG_ACTION) < 0)
+			die(_("could not reset --hard"));
+
+		if (discard_index(the_repository->index) < 0 ||
+			repo_read_index(the_repository) < 0)
+			die(_("could not read index"));
+	}
+	strbuf_release(&buf);
+}
 
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
@@ -1907,50 +1956,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("could not read index"));
 
 	if (options.autostash) {
-		struct lock_file lock_file = LOCK_INIT;
-		int fd;
-
-		fd = hold_locked_index(&lock_file, 0);
-		refresh_cache(REFRESH_QUIET);
-		if (0 <= fd)
-			repo_update_index_if_able(the_repository, &lock_file);
-		rollback_lock_file(&lock_file);
-
-		if (has_unstaged_changes(the_repository, 1) ||
-		    has_uncommitted_changes(the_repository, 1)) {
-			const char *autostash =
-				state_dir_path("autostash", &options);
-			struct child_process stash = CHILD_PROCESS_INIT;
-			struct object_id oid;
-
-			argv_array_pushl(&stash.args,
-					 "stash", "create", "autostash", NULL);
-			stash.git_cmd = 1;
-			stash.no_stdin = 1;
-			strbuf_reset(&buf);
-			if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
-				die(_("Cannot autostash"));
-			strbuf_trim_trailing_newline(&buf);
-			if (get_oid(buf.buf, &oid))
-				die(_("Unexpected stash response: '%s'"),
-				    buf.buf);
-			strbuf_reset(&buf);
-			strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
-
-			if (safe_create_leading_directories_const(autostash))
-				die(_("Could not create directory for '%s'"),
-				    options.state_dir);
-			write_file(autostash, "%s", oid_to_hex(&oid));
-			printf(_("Created autostash: %s\n"), buf.buf);
-			if (reset_head(the_repository, NULL, "reset --hard",
-				       NULL, RESET_HEAD_HARD, NULL, NULL,
-				       DEFAULT_REFLOG_ACTION) < 0)
-				die(_("could not reset --hard"));
-
-			if (discard_index(the_repository->index) < 0 ||
-				repo_read_index(the_repository) < 0)
-				die(_("could not read index"));
-		}
+		create_autostash(&options);
 	}
 
 	if (require_clean_work_tree(the_repository, "rebase",
-- 
2.25.0.114.g5b0ca878e0


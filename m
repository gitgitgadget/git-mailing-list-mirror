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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE153C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8436320731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI6P2iVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDDBMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:17 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46334 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgDDBMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:16 -0400
Received: by mail-qv1-f66.google.com with SMTP id bu9so4574640qvb.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnSIFpWzrZIhL4coIee8OMYgHWQfDde9r+RYhxzpxa0=;
        b=DI6P2iVoEzTZSTWPI+53jFO2k3Xk8jVyT3jmr6vbXEsUla/7dTQdD0XpTGgBSQ4qz0
         nBGAQ+IZdrBgTk1rVFuiTf0fsEPXgUHI9c33GHRByt1U9zSxaBO85kOURLdwlkT6AxFR
         5vKD7Rl7b1T1VCnxiuGWUxHIYjZx84NoNjawVG9YGXEDLlAJuuqdJAm+XoZGNU2QrPqA
         bwpD5e0XTUCek+BO0I4NMmIGhIOTgxQaaq6x9Xevv+Uq/FGj2L3LVXo/BzcQewnDyWhu
         fHcwEuZeUlKho8cSDcVRT7zQRJsShU3G5cxJyH5b2Dow5Oh043jU8Ty9phgPpFZYRovd
         lxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnSIFpWzrZIhL4coIee8OMYgHWQfDde9r+RYhxzpxa0=;
        b=ItlgDgnmFp04djvsB3wT6l35I7Eujcw6HqaWs+ZFSUhIMlpWnXfF2bvtotmmXKIoc8
         q2iJIKPi7Nun9qJhLqaHcNGjxAasVbyY6NCMf6TwRj/IH8vLcGcIHqz9XFi5YLUqQ+ga
         oqMw5DmApPayWuH8e6PjWe7lnp+IFs6CK2Slr2kV3lGDzNzD39sFzhQzCcDd13Z8kRxe
         LNrypeXr7ya//opHube03wevfNeJnitigc52vh55hpPM0ASWblg0EF95NDHuw5531UPo
         oHsBClahZdvn0vJkUHAOQgbLskKSlMwGsR3f0ERqXZ7LGcXN57sNG6rGEA2PSN/Ij0Qp
         v1CQ==
X-Gm-Message-State: AGi0PuZ1vAYGmqo/gFGhh4GAOTusyK3WLkvWq2WXlX5iw91AA8WUO8Tg
        RAQzeQsw+miSYu/34sS42yAkRg46
X-Google-Smtp-Source: APiQypIvFttcAg7f8e8rPu8qP8IH9x52J8LBNq24DaGapLwH9SM8x5M8tD4Wwc5KoLrycNMxgWM5VQ==
X-Received: by 2002:ad4:4581:: with SMTP id x1mr10638221qvu.152.1585962734828;
        Fri, 03 Apr 2020 18:12:14 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:14 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 15/23] rebase: extract create_autostash()
Date:   Fri,  3 Apr 2020 21:11:28 -0400
Message-Id: <d5f51cd80e8bc85146ac8ea0cb95f89afbd7324d.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
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
index 55730f6360..8349f3a03a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1269,6 +1269,55 @@ static int check_exec_cmd(const char *cmd)
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
@@ -1902,50 +1951,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
2.26.0.159.g23e2136ad0


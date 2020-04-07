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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED6C2BB85
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EF62078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEowklLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgDGO2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38405 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgDGO2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so1797626qke.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNOyiS3Y7o7KMBjDf4zmPCsz3aXDud+4hBeyGRElu4I=;
        b=JEowklLl05gHk4QLMo2JivhJx0t4j/23hBrSmnwPqwODc/r4INEc7efmeQZs+BaQiX
         i0NMB/4fTGZNxWdR7o/lEPO5eT9DRzAcO8y16BOkp+Ijf6MiKi+efa/eikpSi0uiSDx4
         9P19fx+JgKuL6NNlHx5rOYjAuTijwHbmVYCZNjkbKnsu+vc6JllFmANsEOdOdFzcdB2M
         Kl1v/LdlCb3o0zhOBxhkt2TJh0J5niD7Tbg5nbTa6FUBFEFvZ+eacqzX1RMQ8DkMskdc
         ddeBeFJRpZVny7AqW+khCLjKeoRXCo5yWuYzVsB6ptWhS1YhnWrBfqc2bjEbvq0by7jG
         VM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNOyiS3Y7o7KMBjDf4zmPCsz3aXDud+4hBeyGRElu4I=;
        b=o5rCjfx9qd1/kdKdSuGGOXZbfIlq7IndNWR1OlPvRC954jAXYbKhsbsEKGMxZhccPd
         vgYwoLpeaGVlnpv5AuPrBSfuS6fquSoWAV37VOYnLVwr+FC8sgy0DoAluvnY0p9dCZ1K
         OqTMIsezEC2oJx7zyvefN4lKWC6nDrSHGb83Hg9Acx19XvKxo9nOM0I+PrCwppx0qAmE
         k9YeoKqLvYyHbfDLsdPoKshBNGTjmNQhyaQu8yhn0Z44epgUYIWrqQ4VHiG79jg68uR4
         w/Y7k3KQNtR669KZgDWa3czoJf9cbYD8+x8KFFcpswWKfy/2ZrEwqga7EaEY+hneng52
         4a1w==
X-Gm-Message-State: AGi0PubKLRrM4UPh8flt4FkVsHmZULq6k/LGmwcWf3s0RX/3OKlUyE3v
        VbuszOD/xZYATftrN6YDijFj8i8A
X-Google-Smtp-Source: APiQypLQ4RlW1NQdHw34r6NNSmey4/AUyLqbjjxGqpybXtp9ds1yDNaGfvi/5xdHMwfrUV4Dww1Ssg==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr2384379qkk.313.1586269716302;
        Tue, 07 Apr 2020 07:28:36 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 14/22] rebase: extract create_autostash()
Date:   Tue,  7 Apr 2020 10:28:01 -0400
Message-Id: <114d9a765531d2e232dbc94484f5ef544bda8170.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
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
index 48ef36bd10..581ad3af7b 100644
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
2.26.0.159.g23e2136ad0


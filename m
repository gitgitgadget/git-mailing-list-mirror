Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7CB1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439069AbeKWJsQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36270 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439043AbeKWJsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so10647839wrr.3
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRM/kF8CkCawV5nN7RH6PjozXtvDmWt+KGBM55K3ci0=;
        b=GJ/Ztn/rkh2hyoh1qSHSOpY5JCD1Kk689IHItC6bX2SfZaQ41I74Hz4h6piA3EoaI1
         +OSLAW8U5uzRPX1QEIf5PW0JhBv1ALobi+mq+r0HqUxVotqOux6UxHkK4AGMpHdQCsU8
         4qcMF7EakLO7HUCFVkfKXXHiYBbS4AyT46SMMUBKXRrnavxPsttX1+EHVSU/4QWKgqH1
         F3FhxyGDnXuiPSnS3JSZMfmoGcYcQ/40tfesXzBwYiGX0hLQpkeKlOVRkPM45D1cY0Py
         eogX7PgcKGJ2RHz2iuElnI3zOYImytK1GzhRU/SZu6eJQkcnwsrS3RnntUrfCZn1xcjA
         a2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRM/kF8CkCawV5nN7RH6PjozXtvDmWt+KGBM55K3ci0=;
        b=AcaKTUoRCJ4DbpUDZ9vNJCBI5eSDbYr5ehgsiTpSla/CjtvHL2Jvylbi8ddBoIqOGW
         cZb7JmFaO3UqItCIgYA46lBm9RsJxVuZoT7ocRUGlZRfrBBmrkHnp31EbjXH4bBNwrj0
         wUdApbBRAgP7jx7Ydd1Y1JdRU4hAXsz8tMxow0DcR4G0nD8KVcnmzjo4FFnlTFU6LBDg
         +00PMJxS7Igrld3sHAavkK44h7evP4jXjyiOATqFy93qoKdE9sVHPwyNXGTyaQgxo/83
         1OMt1997c+odBxfP/smtS0OTUj1764fxM1ZGh8Z4PAcQXbMZPwGZjh7qvZB0+pWcpZcW
         ieUg==
X-Gm-Message-State: AA+aEWYDBeoV/Sy50+T4B+F4rdPqV80400pof5jihQnHchb41pl2FD+J
        0J91Y3hJitcmmpfQu+f676n52MGz
X-Google-Smtp-Source: AFSGD/Vx4Cu6S46O7WPVEzhQGJzdA4DOx/32lhYqgPl9515a4kWHJMh4PxAlQ4re3wrjL1EehbuX7A==
X-Received: by 2002:adf:b253:: with SMTP id y19mr10395689wra.184.1542927993889;
        Thu, 22 Nov 2018 15:06:33 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:33 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 22/22] stash: replace all `write-tree` child processes with API calls
Date:   Fri, 23 Nov 2018 01:05:42 +0200
Message-Id: <0482332a22d527333b1b62a2ed293e6d92acd64e.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit replaces spawning `git write-tree` with API calls.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 5ad0f443ca..029e209176 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -945,9 +945,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -962,15 +961,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 		goto done;
 	}
 
-	cp_write_tree.git_cmd = 1;
-	argv_array_push(&cp_write_tree.args, "write-tree");
-	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+	if (write_index_as_tree(&info->u_tree, &istate, stash_index_path.buf, 0,
+				NULL)) {
 		ret = -1;
 		goto done;
 	}
-	get_oid_hex(out.buf, &info->u_tree);
 
 	if (commit_tree(untracked_msg.buf, untracked_msg.len,
 			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
@@ -979,8 +974,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	}
 
 done:
+	discard_index(&istate);
 	strbuf_release(&untracked_msg);
-	strbuf_release(&out);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -989,11 +984,10 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_add_i = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	remove_path(stash_index_path.buf);
 
@@ -1019,17 +1013,12 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 	/* State of the working tree. */
-	cp_write_tree.git_cmd = 1;
-	argv_array_push(&cp_write_tree.args, "write-tree");
-	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
+				NULL)) {
 		ret = -1;
 		goto done;
 	}
 
-	get_oid_hex(out.buf, &info->w_tree);
-
 	cp_diff_tree.git_cmd = 1;
 	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
 			 oid_to_hex(&info->w_tree), "--", NULL);
@@ -1045,7 +1034,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 done:
-	strbuf_release(&out);
+	discard_index(&istate);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1055,9 +1044,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	int ret = 0;
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
+	struct index_state istate = { NULL };
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -1096,20 +1084,15 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 		goto done;
 	}
 
-	cp_write_tree.git_cmd = 1;
-	argv_array_push(&cp_write_tree.args, "write-tree");
-	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
+				NULL)) {
 		ret = -1;
 		goto done;
 	}
 
-	get_oid_hex(out.buf, &info->w_tree);
-
 done:
+	discard_index(&istate);
 	UNLEAK(rev);
-	strbuf_release(&out);
 	object_array_clear(&rev.pending);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
-- 
2.19.1.878.g0482332a22


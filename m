Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366921F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeJOFz7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39331 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeJOFz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id d15-v6so16068278edq.6
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hEi+Qr6ZqKEH2PWNky8phuNgEODLWv9ILBsjiq9Pek=;
        b=g1k6kPvqdOf0iv/h01zIgvqmmjWkqYhx0PkQSPyiexQUMekyT/BR9izeKbXxeAzkN0
         ncXQBtoDfwUL5dM35FWDUQQwESOu/I6Hm7CoPuCOUQFuQU+mrwxr5QY0cB/fRojC3Q+4
         J/0ehHsuUiUT56H2qZLTRgATd8+i3NugIc9r1stwTChyX5vtIgUfclq2oZtn31zarl41
         nLCzBfJyxSPi2lBVn9oqfuKKI/Xebj8G9/kXhpf4doBIhGE2S7NdFnWpqWqrskaOZ8+Q
         /u/jGCnIXKxQXyCLBUGbXvZsVQfmSyE/dxdddjQX5iBIZocuwuIwI+oydMypAHeZIE9/
         cJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hEi+Qr6ZqKEH2PWNky8phuNgEODLWv9ILBsjiq9Pek=;
        b=pIhLLx1izd3CoHCZ1Ej1bGQVgUDy74qjo/sURGkHAaTD2noAL5srh9UwJn9+Qag9lU
         ksyY5IfdVAp9lYBV95209zmobBZQaDf2FnEnstf13IQ4Q2xKlZo7TMzMzhTMENuQ6UPN
         HcUg1u/XJkM+/fTe24KoV83F1Xwln76OIbfvTNuBQZAqeCldzOZ5R07QGeyUZIumO75p
         yFsEmMCLezDmZOpN1s/IN0lmiQGnZhHbefn2KAF8WwIS9i4x/sjACes2tY+YcT5lbo2v
         UGz9Eb/VBuq6kdDksB9YKVauu2X0pEbppolZ8l5u8cxUF2xHxwZSgD1iI8sELZTIVHO7
         SJQA==
X-Gm-Message-State: ABuFfoh0lkTDw42Lp8gGMHEE+KDVlMvAxO+gpatL7bwB4ktI8a48EHzm
        4yoIQxl5yofKT0SLk8umYR5i5VxS
X-Google-Smtp-Source: ACcGV60cS4KApgyfq/RqqDBqHI0cJJd9V7TciYMOYf597gUFixFE/FH9Jxv9ukYJ+QhPx/IheakF3Q==
X-Received: by 2002:a17:906:7fc4:: with SMTP id r4-v6mr16282090ejs.200.1539555210636;
        Sun, 14 Oct 2018 15:13:30 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:30 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 21/21] stash: replace all `write-tree` child processes with API calls
Date:   Mon, 15 Oct 2018 01:11:27 +0300
Message-Id: <10a62394e78991259425832e9af0656bbada4c45.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
index d2365ada2e..651d05c820 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -947,9 +947,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -964,15 +963,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
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
@@ -981,8 +976,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	}
 
 done:
+	discard_index(&istate);
 	strbuf_release(&untracked_msg);
-	strbuf_release(&out);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -991,11 +986,10 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
 
@@ -1021,17 +1015,12 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
@@ -1047,7 +1036,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 done:
-	strbuf_release(&out);
+	discard_index(&istate);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1057,9 +1046,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	int ret = 0;
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
+	struct index_state istate = { NULL };
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -1099,20 +1087,15 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
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
2.19.0.rc0.23.g10a62394e7


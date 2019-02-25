Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9070C20248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfBYXR2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33611 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfBYXR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id c13so877360wmb.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyr17qTqtIW8G8GjKWYMRyA8LHCMzeDUC3fnojEeItE=;
        b=MATnxR3Rq3lNxppFhDqlC6rHFDIw2hUNNU1tPvgaSX21yJrN2p7KqTXp//gNV++e0i
         jhKvGcyzh5imR/9vDxQUzFwTxRvI/F01IkTO46ljxcHIfSPNdVvlA8O37b9FjOMSN3tS
         lCRBVEWQiWWHWAXpg81H5WkG6zlldtuDu4kWcKsnFepc0PdedDYMXKIPbHtZUiKPNb4D
         UmSqgmLXXF8oC8jgcLyqfnYMsMXWy7geh0oT0AknLDjvV8Wy7PCPVDGqPHEL1p9fXyKN
         9qbal9udeLBCF9EYtV+uThvm08/pF6oYN+7in4oxg0LH+actTRu2s8BrTe7DCSd2aG01
         b8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyr17qTqtIW8G8GjKWYMRyA8LHCMzeDUC3fnojEeItE=;
        b=E5Oi+PZC7LQqcyfn7KsN2T65pDmjzzBfpQQvrenFrBCfpFKFnKjtboNELgrfEJDOkP
         rhUCOMKLtaxJoqhtOZ8fsHAzNZhBY1PAURye49aEuUnLkydSBTUNa98nMviWGKPiiZr6
         LevtKRXSn4JdiQsR9EGACWStXIiDul3uZwBYsqotL6BB1i0w13Ak4HSuzELbOz4f3VwR
         IOpvcT3JIqJN+RrMx/iFyybx8wnEHh+MKjAq7KArfwIb2syShCz0DJ4u7KWI+afaAhYH
         ZGjNCfOYqIYb5LFCcJETXqsmMTEd9mJx+ccxQKXLIt2fVno6MCyq4CKEM//Zk4ygm32A
         En8w==
X-Gm-Message-State: AHQUAubJIc+tJVzxFV/s7yzVtO/4PSKvAbJuAHDzof4dWQJXtnTfTCjy
        aYSU8yQxg73ATNHGSKb28KFxBRzF
X-Google-Smtp-Source: AHgI3IbEaBxdkGd0JFYb7HeQ7M51kjaXDOdVAxuuXDHHqPcxtXZo2ZU46MtbeHQ2SSvy+fFETpmwAQ==
X-Received: by 2002:a1c:6c0c:: with SMTP id h12mr681404wmc.35.1551136646022;
        Mon, 25 Feb 2019 15:17:26 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id s5sm7678363wra.77.2019.02.25.15.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:25 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 23/27] stash: replace all `write-tree` child processes with API calls
Date:   Mon, 25 Feb 2019 23:16:27 +0000
Message-Id: <20190225231631.30507-24-t.gummerer@gmail.com>
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

Avoid spawning write-tree child processes by replacing the calls with
in-core API calls.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 4c51b58206..5f8c99c12f 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -943,9 +943,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -960,15 +959,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
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
@@ -977,8 +972,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	}
 
 done:
+	discard_index(&istate);
 	strbuf_release(&untracked_msg);
-	strbuf_release(&out);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -987,11 +982,10 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
 
@@ -1017,17 +1011,12 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
@@ -1043,7 +1032,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 done:
-	strbuf_release(&out);
+	discard_index(&istate);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1053,9 +1042,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	int ret = 0;
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
+	struct index_state istate = { NULL };
 
 	init_revisions(&rev, NULL);
 
@@ -1095,20 +1083,15 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
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
2.21.0.rc2.291.g17236886c5


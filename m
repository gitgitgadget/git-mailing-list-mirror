Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A201F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbeLTTpR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38573 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389475AbeLTTpM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so3516507wml.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6WRbwssI+OW/a9OvjLI98BDK/OlW2q3PXyQdSqCD7M=;
        b=rpBaNRS+xSUx8jGb6cu6g4L3vs6w78SbVj0RqlEylkqrh6UG41onZ+wzSyGzK//nBU
         mmsE0EwH6XSGsABANcQ3FDkQJqqaFCoZVeu39sNGA/SReS53kIWQi11mmdZwXF/H7JcR
         2QrLNPo0v+GCPoJx+xSlKRK4H/4pdg1aFOexNoYrtRnPUVXupeD6i2rj0z3fQ4hX43iJ
         aMyUCuxL9zNEttmEoATSpLfqdRUUjpESLT4JS11BdbuaxVLt5zaXr/66jqCLEqWK91fF
         xDkqDZZJcUgFq56/ORcRQRy+WbQgm5DSJHw9sZ0WKEDB8Tt2woIKt3hrLVOnTYgS3npN
         X+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6WRbwssI+OW/a9OvjLI98BDK/OlW2q3PXyQdSqCD7M=;
        b=uMWDYF+FBQw20ezdlfpsnmsV6Qvc2YBpAbhYth0x0rEStCMgZfQD8lDCw4v0zWy5oK
         6Lhu0d1SZxw+BcBi/St9vUStPqS+EQ+U/kyKrA9HrziHkujiSBI+1INwVKLPKuj51lDb
         7KyJVH8HDZM3JgstIVnYAKkchsIieFbMRKYVLMPXt8wy90JgjvLmO+lmStVNOj07cP8i
         8uZXmTjO8rStvW4QjxZt/+pPUvgGLx90iR3ywdCOAqrylbH967SkbugPCzlq8FIMa/jy
         IPUykYMUXTaTweuvx2PqDAoJ0ZJBCLU7WjaebScWFtebSIJwqx6J8LavAOcPy5mN1+IT
         8clQ==
X-Gm-Message-State: AA+aEWbi4als2XZshXUabsE6m8ztSBYzAfLKtHHmuWcBKnHGn4ZkBMbb
        p6/RjzTCMIqTLHl+TCvul2MDZVIYaQo=
X-Google-Smtp-Source: AFSGD/VWJBMcWTlhjmJyHzNtxjZ6Rk8m8Ya7A96Vbp+sWAOlO2fTLH8MyQa5jfUEsgNAEaYPtBXMOg==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr2535wmk.152.1545335109510;
        Thu, 20 Dec 2018 11:45:09 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:09 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 22/26] stash: replace all `write-tree` child processes with API calls
Date:   Thu, 20 Dec 2018 21:44:38 +0200
Message-Id: <73eac729193a64fe6ce5f2e38b73362263631b5b.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit replaces spawning `git write-tree` with API calls.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 4b63352927..39fcff32b7 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -950,9 +950,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -967,15 +966,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
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
@@ -984,8 +979,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	}
 
 done:
+	discard_index(&istate);
 	strbuf_release(&untracked_msg);
-	strbuf_release(&out);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -994,11 +989,10 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
 
@@ -1024,17 +1018,12 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
@@ -1050,7 +1039,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 done:
-	strbuf_release(&out);
+	discard_index(&istate);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1060,9 +1049,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	int ret = 0;
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
+	struct index_state istate = { NULL };
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -1101,20 +1089,15 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
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
2.20.1.441.g764a526393


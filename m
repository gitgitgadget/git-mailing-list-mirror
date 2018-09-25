Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3601F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeIZEoc (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43924 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id u23so170678edx.10
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xxW8Q0t94ubg6LLGzT2Nu7sA56MKD4lWd0asvksHVd8=;
        b=K8F0/tnUGdDXToLTZbGmpQR7epnYF1aktlcuUnE2GclHjasiAyhZgK84U8XqLzsnhY
         aiYTUCb1fHECZXxcCWEi8I19oSrDuyWbksNAiW2Ads/ldDVvcnGxO+ch8VqSvtJXrufe
         3ni7zs+xJ3CBj4AVNrprp7yTJ7RNwlOu9kpzretY1LS9id8d9qVg1cdMaP91RA/edS3L
         ToIRI7WJ50aYJgLfXjq2OZhr6iIe41SSgd44DdhciaUwICXXu6DU15+4irIGv/MZxVPj
         KNVDkr5xDPSayxjeDJr8hJ2GxBcnyJDR/ZAGHuGHazvhTb824rQI5XKD/6wiqx6+GB8s
         S0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xxW8Q0t94ubg6LLGzT2Nu7sA56MKD4lWd0asvksHVd8=;
        b=g2pLTrbKZwo+OR07y+nW08nbHYSshbVxMahXuOjZWqwQ1jMEjR3PSkHWkItgGeOvkV
         1SGS6mEuL2vhuZYYjjjhxg8LQc7AEPTtLJzLJdlBTgUuUDAeSfr7FPcAYXk0k/bI4r1z
         NaLHIlvAvgOmVRmrFZ2pDmxVISSq39VRjP4PHLoeggHVSqBZzxwF2aElx0RCJZPhscYq
         yfRog/JJlIlhzo4O/4J4iGeUt0Mdna/ued7hv14KQz8NXHklgzU9r2tfPbrrKcx/08z4
         u6DuTp58QVT3pk4DsLeT0nrf86ycoa5npUa2vMCNiW5BarNXh2WjNqDdsXxXb9NVI9C5
         10lw==
X-Gm-Message-State: ABuFfogt0Ew5aIhvpfwPKecrfHF3ts1Q5RPpMQDeH1rW+USDQtzXaQzU
        2A1x/MbnwnPAx+pqoz20tfF3Yncl
X-Google-Smtp-Source: ACcGV63w5Pd59DsIdXCXxmloMpeKU6Ru4hMVINO6DkrJNJVYG290/0/Z1e1X1ftOCapxTGpftzmObg==
X-Received: by 2002:a50:c345:: with SMTP id q5-v6mr1056070edb.130.1537914884394;
        Tue, 25 Sep 2018 15:34:44 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:43 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 21/21] stash: replace all `write-tree` child processes with API calls
Date:   Wed, 26 Sep 2018 01:33:37 +0300
Message-Id: <1fb9f40d88a813af81e3ddc9e143215571bc53f3.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
index 43d0de1f13..86a7e0a5a5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -941,9 +941,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -957,15 +956,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
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
@@ -974,8 +969,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	}
 
 done:
+	discard_index(&istate);
 	strbuf_release(&untracked_msg);
-	strbuf_release(&out);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -984,11 +979,10 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
 
@@ -1014,17 +1008,12 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
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
@@ -1040,7 +1029,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	}
 
 done:
-	strbuf_release(&out);
+	discard_index(&istate);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1050,9 +1039,8 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	int ret = 0;
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
+	struct index_state istate = { NULL };
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -1091,20 +1079,15 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
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
2.19.0.rc0.23.g1fb9f40d88


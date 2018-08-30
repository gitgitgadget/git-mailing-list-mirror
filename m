Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538CA1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeHaBqK (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40593 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeHaBqK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so9358491wrw.7
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JJ1fuLivYCFMyuT+mWJjcrDO8R+3Hmg/D3o9eoaUXxk=;
        b=eFw5OMq2efbEERHbXZfVck1N0zOPQkJstERw9DbkAjpI43PByAzm4eQzyQfRfMjh37
         1tFHOq6mkYRa18Aere4/xBdT4hUvfqhWIrRPchYTPXU52w46ncQblTBSJpUdNEL6Ruri
         P5/SAT0e5Pic9ue8poh69FL4NhGmI8FBfBpK4RzZPP8BmHx7L3SyNmKqpCEmq+oQCaRs
         X9nuJMExCJb5mwHiCIVUG995g5GKF3EehHLUBiS2y2KbnudZ3PbQjiWzsWBF+fpg87H5
         AZW1FN68qtZKlL595Ya4Tfw7WUtOeZe2Kf6iAV++Ap8GQc5PLPqn5fhxNVgHMSnEzy9q
         O4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJ1fuLivYCFMyuT+mWJjcrDO8R+3Hmg/D3o9eoaUXxk=;
        b=Oz9WrMHQwY5btKfUnSepZk6zBE1YhMdOXOegmSbgCyKcnND3Y00sIhMKGsGa/45Bh+
         3ubUKHISYSkBX9iw+VzRGY5I+hLGqZXvMiW2z/v6hMhFSlUdjLdXCU6GQ5qDJK8qW9ir
         8sv/m47G8PQC4SuDQWkI5/IdyrbWByllCKCJvYx57lvfPRKiXNP06beretxoHyEObLdC
         5TpJgaY74Eb5PvI9s4XiE4tClqdfB32zdAaI6Glm+tLrnakSWashhVxgO6fEocA88vT3
         JDrW7obmyHw/26aCemN4P8WUb7JydazjUBWeJVUJj0RB9yyFGLBua5SULX8/CGAnzAmK
         C8Vw==
X-Gm-Message-State: APzg51DM8pYdlOUn6p+tRgmd/f4zmP+eka3CrqA36gkI8g1v8kZ5m1Md
        eOfve3poAT9ZLChy3ly0r62C/W2U
X-Google-Smtp-Source: ANB0VdaH6NcJDio9zrVlJZavsWOnSNU/7dyxVqnBYm86bFq6nQdCV0XHsXT7+T+PanpMhSUTuqMYew==
X-Received: by 2002:a5d:4605:: with SMTP id t5-v6mr8365579wrq.200.1535665316651;
        Thu, 30 Aug 2018 14:41:56 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:56 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 20/20] stash: replace all `write-tree` child processes with API calls
Date:   Fri, 31 Aug 2018 00:40:50 +0300
Message-Id: <c26283d74e3f761a554940e3e0db13cef1b613d5.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
index ba5818e24e..dd1084afd4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -910,9 +910,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	cp_upd_index.git_cmd = 1;
 	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -927,15 +926,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
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
@@ -944,8 +939,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
 	}
 
 done:
+	discard_index(&istate);
 	strbuf_release(&untracked_msg);
-	strbuf_release(&out);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -956,11 +951,10 @@ static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
 {
 	int i;
 	int ret = 0;
-	struct strbuf out = STRBUF_INIT;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_add_i = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
+	struct index_state istate = { NULL };
 
 	remove_path(stash_index_path.buf);
 
@@ -985,17 +979,12 @@ static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
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
 	cp_diff_tree.git_cmd = 1;
 	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
 			 oid_to_hex(&info->w_tree), "--", NULL);
@@ -1011,7 +1000,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps, int quiet)
 	}
 
 done:
-	strbuf_release(&out);
+	discard_index(&istate);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1020,10 +1009,9 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 {
 	int ret = 0;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
 	struct rev_info rev;
+	struct index_state istate = { NULL };
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -1062,20 +1050,15 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
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
2.19.0.rc0.22.gc26283d74e


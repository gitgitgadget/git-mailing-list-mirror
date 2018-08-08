Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021B21F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbeHHVUn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:43 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:56111 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbeHHVUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:42 -0400
Received: by mail-wm0-f42.google.com with SMTP id f21-v6so3794483wmc.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gT9k3Oj+S5Mcdk4DxEOwk2ZA5VUbOgkkVweVP52o02I=;
        b=CPK8049qZ3wf6BQ3u8KH3YzzjqXZSgMPNLdbOPaU/fjyKgr9BrqpSJ5InxYCyhi0K3
         F030vkIFLcNbpQlamjEKA5PScJed2G4RnL8cs5BtFTkkGFZ0OJ0Hzcq+7fyiHpAW7GPF
         +PJT0zNOQTwm636KcvHQyAmtM6cNIEe1m8nN9RAlynIFquz8B1EumwrDGpERcsiOL5SN
         2nrhZgc2jmWqhuO/vxAdJcaXUlPlSZOvMA+zhf/qAv0o8Er1RxILMNfdAH5eFrJPwd0R
         w1P0kZo3VxX0uQkIWRHpSVQjudAVezA22yfqzUXgxsbotlCOoFvyWzyE1A3dNk+Q14BG
         AilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gT9k3Oj+S5Mcdk4DxEOwk2ZA5VUbOgkkVweVP52o02I=;
        b=M4rZtnQQzctK/OxKI71zm+r6FoAjhjLPd8/VSouF7+GaKnvPAXLFz7NNIY4I00uMnR
         a5FDbEgmbgonPUdNfCWk5Z625GF0h6Gl1hI8ItBDrRgiMbE/SCD5YteNOvJ//Sf2Ie1W
         2ARCbPZya3fbeQCjMu6eCTbI5L61gPZcj01rbYaor8p/PeQniXf2DwsOw+VCk8LikxKF
         1YQL9aXcARoHV1bxADGvqZLsAWlCU3mCnfB5v66Rlxl9hNzGDtHL2ZFoaJmx0SZ0kY0Y
         3BrKAZ0/jESMPTS0RKRmnXdCARoSnXmoYgHK3cTSdSrOkEZu1LqgkWr6VLFmFmdkTHjW
         lfdw==
X-Gm-Message-State: AOUpUlHjFhK4OdcZXKSZiaOXfnRI0knzzGqWRWvQEWxIb+awj2vhxISh
        yUWedwXesxkK9IkqTiAjZOabBVRq
X-Google-Smtp-Source: AA+uWPxq9qxZbR4KmWMGPXYcyNNRnzd1/Jbtl2mjb+k2/yoDgoVmRF7KMnVJLRW47ekXQU/RCIfPvA==
X-Received: by 2002:a1c:ea9c:: with SMTP id g28-v6mr2682073wmi.65.1533754780221;
        Wed, 08 Aug 2018 11:59:40 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:39 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 25/26] stash: replace all `write-tree` child processes with API calls
Date:   Wed,  8 Aug 2018 21:59:04 +0300
Message-Id: <3b4a3b766598589df30e16cddf175f039eb4e290.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit replaces spawning `git write-tree` with API calls.
---
 builtin/stash.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 4d5c0d16e..46e76a34e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -949,9 +949,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
-	struct strbuf out2 = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	struct child_process cp2 = CHILD_PROCESS_INIT;
+	struct index_state state = { NULL };
 
 	cp.git_cmd = 1;
 	argv_array_pushl(&cp.args, "update-index", "--add",
@@ -966,15 +965,11 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
 		goto done;
 	}
 
-	cp2.git_cmd = 1;
-	argv_array_push(&cp2.args, "write-tree");
-	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (pipe_command(&cp2, NULL, 0, &out2, 0,NULL, 0)) {
+	if (write_index_as_tree(&info->u_tree, &state, stash_index_path.buf, 0,
+				NULL)) {
 		ret = -1;
 		goto done;
 	}
-	get_oid_hex(out2.buf, &info->u_tree);
 
 	if (commit_tree(untracked_msg.buf, untracked_msg.len,
 			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
@@ -984,7 +979,6 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
 
 done:
 	strbuf_release(&untracked_msg);
-	strbuf_release(&out2);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -994,11 +988,10 @@ static struct strbuf patch = STRBUF_INIT;
 static int stash_patch(struct stash_info *info, const char **argv)
 {
 	int ret = 0;
-	struct strbuf out2 = STRBUF_INIT;
 	struct child_process cp0 = CHILD_PROCESS_INIT;
 	struct child_process cp1 = CHILD_PROCESS_INIT;
-	struct child_process cp2 = CHILD_PROCESS_INIT;
 	struct child_process cp3 = CHILD_PROCESS_INIT;
+	struct index_state state = { NULL };
 
 	remove_path(stash_index_path.buf);
 
@@ -1023,17 +1016,12 @@ static int stash_patch(struct stash_info *info, const char **argv)
 		goto done;
 	}
 
-	cp2.git_cmd = 1;
-	argv_array_push(&cp2.args, "write-tree");
-	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (pipe_command(&cp2, NULL, 0, &out2, 0,NULL, 0)) {
+	if (write_index_as_tree(&info->w_tree, &state, stash_index_path.buf, 0,
+				NULL)) {
 		ret = -1;
 		goto done;
 	}
 
-	get_oid_hex(out2.buf, &info->w_tree);
-
 	cp3.git_cmd = 1;
 	argv_array_pushl(&cp3.args, "diff-tree", "-p", "HEAD",
 			 oid_to_hex(&info->w_tree), "--", NULL);
@@ -1046,7 +1034,6 @@ static int stash_patch(struct stash_info *info, const char **argv)
 	}
 
 done:
-	strbuf_release(&out2);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1056,11 +1043,10 @@ static int stash_working_tree(struct stash_info *info,
 {
 	int ret = 0;
 	struct child_process cp2 = CHILD_PROCESS_INIT;
-	struct child_process cp3 = CHILD_PROCESS_INIT;
-	struct strbuf out3 = STRBUF_INIT;
 	struct argv_array args = ARGV_ARRAY_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
 	struct rev_info rev;
+	struct index_state state = { NULL };
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -1103,20 +1089,18 @@ static int stash_working_tree(struct stash_info *info,
 		goto done;
 	}
 
-	cp3.git_cmd = 1;
-	argv_array_push(&cp3.args, "write-tree");
-	argv_array_pushf(&cp3.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (pipe_command(&cp3, NULL, 0, &out3, 0,NULL, 0)) {
+	if (write_index_as_tree(&info->w_tree, &state, stash_index_path.buf, 0,
+				NULL)) {
+
 		ret = -1;
 		goto done;
 	}
 
-	get_oid_hex(out3.buf, &info->w_tree);
+	discard_cache();
+	read_cache();
 
 done:
 	UNLEAK(rev);
-	strbuf_release(&out3);
 	argv_array_clear(&args);
 	object_array_clear(&rev.pending);
 	strbuf_release(&diff_output);
-- 
2.18.0.573.g56500d98f


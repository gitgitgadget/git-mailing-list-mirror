Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62311F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeHaBqJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39949 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHaBqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so3411134wme.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ykZtNkfRXTGGBSXTRlt7fPj4xRepls86g5jymvecj14=;
        b=kza7XUfwLjJv8zyukXOuLvNF7PjUebatvMncytssuigwiE7X6cM7GgW/6H1aDeqwij
         vtHQyImrMTEWnuRK5wAJ1Pw1LEB1Us7swq+0VOWWOXKL5FLfRHm1o2p814ST/7YXhJG8
         5pAQ0Z7LMLMmWgXYB3gGX8dMlaZs97rXYEp5Gv3rnfnsSOF7GspHR66supatNGjd70H6
         pL0Zt3XUg8g06V82KTjX04Hq/wMuaaE1QATiSwCtc4MRguivzoMAQ327pLtqbnL84GGS
         3X+GnsAmlwiANMDbKA/tWVbFV+stJo+ki2MPDXmBRYhr6xRc3a/bFDY7rXiX8cinBGZF
         vg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykZtNkfRXTGGBSXTRlt7fPj4xRepls86g5jymvecj14=;
        b=E4DBkbaO/SBn6Feu56Q/aFMWGBcMUzJDDRR9oa8CRMyCVT2m5fx3NLPBomvmuFJsbk
         Z3K0b+CWRro9TE/H+LHY/VrDHSMgQZ6WlaI5buuOwbzlOwv2dHPTEF6y9qBpkAywmRET
         md4mUvYdSsjoLGAA5cMNFrXQQWhpegU9IKmhol7wKciRtSCMRC7xwVhQK+tl1WnQE2rR
         Zz4MxZJtsVerIe7ERh3pupq7Cp8SJ3kpgqBqIbcDSAxxQycmhOyp7DtwQjBjOvPIqpLh
         vFJWSLuERmi0cqL9JH8YRmIKMx19cZtahEjHlB6tTAB0ZLXj7jQ9+pcN3yYgp0RrMZAK
         PElA==
X-Gm-Message-State: APzg51D1bR09pghH0RT9HWHih4Fd7Kv7shyESNr5k2pcK9yqL7MY2n+o
        AGGTgylSS4EibdoYE/RM6K7MDd8p
X-Google-Smtp-Source: ANB0VdYwVzhS9WcQYJVRgpuUkNzzbLkZQ1CUyidHBCsc2SLgyKYBpmqO0qhPo1hcZ8evZH+GA8c+rg==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr3027002wmh.112.1535665315742;
        Thu, 30 Aug 2018 14:41:55 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:55 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 19/20] stash: optimize `get_untracked_files()` and `check_changes()`
Date:   Fri, 31 Aug 2018 00:40:49 +0300
Message-Id: <e4c17b20b0204386be06270e4a7f7283e6641f5a.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commits introduces a optimization by avoiding calling the
same functions again. For example, `git stash push -u`
would call at some points the following functions:

 * `check_changes()` (inside `do_push_stash()`)
 * `do_create_stash()`, which calls: `check_changes()` and
`get_untracked_files()`

Note that `check_changes()` also calls `get_untracked_files()`.
So, `check_changes()` is called 2 times and `get_untracked_files()`
3 times.

`get_untracked_files()` has now only two parameters and it will
fill a global strbuf called `untracked_files`.

The old function `check_changes()` now consists of two functions:
`get_untracked_files()` and `check_changes_tracked_files()`.

These are the call chains for `push` and `create`:

 * `push_stash()` -> `do_push_stash()` -> `do_create_stash()`

 * `create_stash()` -> `do_create_stash()`

To prevent calling the same functions over and over again,
`check_changes()` inside `do_create_stash()` is now placed
in the caller functions (`create_stash()` and `do_push_stash()`).
This way `check_changes()` and `get_untracked files()` are called
only one time.

https://public-inbox.org/git/20180818223329.GJ11326@hank.intra.tgummerer.com/

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash.c | 73 ++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3d2316e3f7..ba5818e24e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -813,13 +813,15 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 }
 
 /*
- * `out` will be filled with the names of untracked files. The return value is:
+ * `untracked_files` will be filled with the names of untracked files.
+ * The return value is:
  *
  * = 0 if there are not any untracked files
  * > 0 if there are untracked files
  */
-static int get_untracked_files(struct pathspec ps, int include_untracked,
-			       struct strbuf *out)
+static struct strbuf untracked_files = STRBUF_INIT;
+
+static int get_untracked_files(struct pathspec ps, int include_untracked)
 {
 	int max_len;
 	int i;
@@ -839,7 +841,7 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
 			free(ent);
 			continue;
 		}
-		strbuf_addf(out, "%s%c", ent->name, '\0');
+		strbuf_addf(&untracked_files, "%s%c", ent->name, '\0');
 		free(ent);
 	}
 
@@ -847,23 +849,22 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
 	free(dir.ignored);
 	clear_directory(&dir);
 	free(seen);
-	return out->len;
+	return untracked_files.len;
 }
 
 /*
- * The return value of `check_changes()` can be:
+ * The return value of `check_changes_tracked_files()` can be:
  *
  * < 0 if there was an error
  * = 0 if there are no changes.
  * > 0 if there are changes.
  */
-static int check_changes(struct pathspec ps, int include_untracked)
+
+static int check_changes_tracked_files(struct pathspec ps)
 {
 	int result;
-	int ret = 0;
 	struct rev_info rev;
 	struct object_id dummy;
-	struct strbuf out = STRBUF_INIT;
 
 	init_revisions(&rev, NULL);
 	rev.prune_data = ps;
@@ -890,18 +891,22 @@ static int check_changes(struct pathspec ps, int include_untracked)
 	if (diff_result_code(&rev.diffopt, result))
 		return 1;
 
-	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &out)) {
-		strbuf_release(&out);
-		return 1;
-	}
-
-	strbuf_release(&out);
 	return 0;
 }
 
-static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
-				struct strbuf *in)
+static int check_changes(struct pathspec ps, int include_untracked)
+{
+	int ret = 0;
+	if (check_changes_tracked_files(ps))
+		ret = 1;
+
+	if (include_untracked && get_untracked_files(ps, include_untracked))
+		ret = 1;
+
+	return ret;
+}
+
+static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
 {
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
@@ -916,7 +921,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 			 stash_index_path.buf);
 
 	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
-	if (pipe_command(&cp_upd_index, in->buf, in->len, NULL, 0, NULL, 0)) {
+	if (pipe_command(&cp_upd_index, untracked_files.buf, untracked_files.len,
+			 NULL, 0, NULL, 0)) {
 		ret = -1;
 		goto done;
 	}
@@ -1090,18 +1096,11 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 	struct commit_list *parents = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf commit_tree_label = STRBUF_INIT;
-	struct strbuf out = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 
 	read_cache_preload(NULL);
 	refresh_cache(REFRESH_QUIET);
 
-	if (!check_changes(ps, include_untracked)) {
-		ret = 1;
-		*stash_msg = NULL;
-		goto done;
-	}
-
 	if (get_oid("HEAD", &info->b_commit)) {
 		if (!quiet)
 			fprintf_ln(stderr, _("You do not have the initial commit yet"));
@@ -1132,9 +1131,8 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &out)) {
-		if (save_untracked_files(info, &msg, &out)) {
+	if (include_untracked) {
+		if (save_untracked_files(info, &msg)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the untracked files"));
 			ret = -1;
@@ -1191,7 +1189,6 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
 done:
 	strbuf_release(&commit_tree_label);
 	strbuf_release(&msg);
-	strbuf_release(&out);
 	strbuf_release(&stash_msg_buf);
 	return ret;
 }
@@ -1213,25 +1210,21 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 			     git_stash_create_usage,
 			     0);
 
+	memset(&ps, 0, sizeof(ps));
+	if (!check_changes_tracked_files(ps))
+		return 0;
+
 	for (i = 0; i < argc; ++i)
 		strbuf_addf(&stash_msg_buf, "%s ", argv[i]);
 	stash_msg = strbuf_detach(&stash_msg_buf, NULL);
 	to_free = (char *) stash_msg;
 
-	memset(&ps, 0, sizeof(ps));
-	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, 0);
-
-	if (!ret)
+	if (!(ret = do_create_stash(ps, &stash_msg, 0, 0, &info, 0)))
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	free(to_free);
 	free((char *) stash_msg);
-
-	/*
-	 * ret can be 1 if there were no changes. In this case, we should
-	 * not error out.
-	 */
-	return ret < 0;
+	return ret;
 }
 
 static void add_ps_items_to_argv_array(struct argv_array *args,
-- 
2.19.0.rc0.22.gc26283d74e


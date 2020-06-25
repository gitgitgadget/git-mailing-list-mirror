Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1DAC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3328206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMzHyVCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404825AbgFYMtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404803AbgFYMtF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A7C061796
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so5714144wrm.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN6fUU7/hu7NvBTxy4af5w0M00mlHTF4zQlGrg0jgpc=;
        b=hMzHyVCQTGzYhs8K3ajhiV2vA8czEfwfX2MR5Xp912JVnm1xco7z6gLumZKb0Gdwnz
         bNSv5Pu+enlIW56uPS3jIfl6LokyEI+YPoauNQ4twRqfxnXXTzDIOkUcg/Cuk5UjpqFb
         oj48InpWuVli9rGPzfMczdL48HHJYETZ36K8Ytql/ocPip7HMMc6ahUWN7g/XXGp7m7w
         H1J0qRVA+QzRPYam+ELVTKrjZ37wt65FUIv94oTp4LR4Gux9QVQZBn37LV09b6xGRgJz
         2A2zxsESe0PtC0vRv+ycLJBKIPMDKyOV3aPX683ItDByJZdO1Vpk4uVEJ26ChkThTwrT
         TgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN6fUU7/hu7NvBTxy4af5w0M00mlHTF4zQlGrg0jgpc=;
        b=mF76GFpfbQnKcVSM+Y0SAgRYnFmax9Gk3POv4UctDgO1DiLg5eslxp3V+AcF5oPNBC
         Gq+HWCDY97jlHkqaJ/zxAphZd3b0Cvc5lpVCqwSJV48CZD/iap7B1UTpkc0iYRLqK+BC
         +goyBIDE1ryRPbF+PtnFzLVD2AvWxtg06MvnqUhO9EvzEbyoLinc0RSdCFJC289pV7Do
         FEpVRY4mkKp2oI7XitHM2h4w2jR2Uy4meWhIgOMY+R+hDs+Dw/ouvIkkPs1hKDo0A7ew
         1e4o2VBULKqwKyn6IeLxabfY6tZiNED1hPQOMSESp75AAzJjpWh0Se6RYef02bNWWwuc
         GEgw==
X-Gm-Message-State: AOAM531fPDJ+54mobQ5MnTCDsgCfgB+8YGqJFm9eH0wLcj6H3nvBHnDJ
        QeNdlRnoGR4ae1Q4Qm+13wFsoFJ4
X-Google-Smtp-Source: ABdhPJwUKSnstKH9aMrEPWenj7B+3xaseQwKicmVZE5jAl4je2ZXY1+AmPnXQ8kI1yjCsSYeC0q2+Q==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr34699910wrn.281.1593089343732;
        Thu, 25 Jun 2020 05:49:03 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:03 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 08/17] merge-resolve: remove calls to external processes
Date:   Thu, 25 Jun 2020 14:19:44 +0200
Message-Id: <20200625121953.16991-9-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes calls to external processes to avoid reading and writing
the index over and over again.

 - The call to `update-index -q --refresh' is replaced by a call to
   refresh_index().

 - The call to `read-tree' is replaced by a call to unpack_trees() (and
   all the setup needed).

 - The call to `write-tree' is replaced by a call to
   write_index_as_tree().

 - The call to `merge-index', needed to invoke `git merge-one-file', is
   replaced by a call to the new merge_all() function.  A callback
   function, merge_one_file_cb(), is added to allow it to call
   merge_one_file() without forking.

Here too, the index is read in cmd_merge_resolve(), but merge_resolve()
takes care of writing it back to the disk.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-resolve.c | 103 ++++++++++++++++++++++++++++------------
 merge-strategies.c      |  11 +++++
 merge-strategies.h      |   6 +++
 3 files changed, 89 insertions(+), 31 deletions(-)

diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
index c66fef7b7f..2c364fcdb0 100644
--- a/builtin/merge-resolve.c
+++ b/builtin/merge-resolve.c
@@ -10,54 +10,91 @@
  */
 
 #include "cache.h"
+#include "cache-tree.h"
 #include "builtin.h"
-#include "run-command.h"
+#include "lockfile.h"
+#include "merge-strategies.h"
+#include "unpack-trees.h"
+
+static int add_tree(const struct object_id *oid, struct tree_desc *t)
+{
+	struct tree *tree;
+
+	tree = parse_tree_indirect(oid);
+	if (parse_tree(tree))
+		return -1;
+
+	init_tree_desc(t, tree->buffer, tree->size);
+	return 0;
+}
 
 static int merge_resolve(struct commit_list *bases, const char *head_arg,
 			 struct commit_list *remote)
 {
+	int i = 0;
+	struct lock_file lock = LOCK_INIT;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+	struct object_id head, oid;
 	struct commit_list *j;
-	struct child_process cp_update = CHILD_PROCESS_INIT,
-		cp_read = CHILD_PROCESS_INIT,
-		cp_write = CHILD_PROCESS_INIT;
-
-	cp_update.git_cmd = 1;
-	argv_array_pushl(&cp_update.args, "update-index", "-q", "--refresh", NULL);
-	run_command(&cp_update);
-
-	cp_read.git_cmd = 1;
-	argv_array_pushl(&cp_read.args, "read-tree", "-u", "-m", "--aggressive", NULL);
-
-	for (j = bases; j && j->item; j = j->next)
-		argv_array_push(&cp_read.args, oid_to_hex(&j->item->object.oid));
 
 	if (head_arg)
-		argv_array_push(&cp_read.args, head_arg);
-	if (remote && remote->item)
-		argv_array_push(&cp_read.args, oid_to_hex(&remote->item->object.oid));
+		get_oid(head_arg, &head);
 
-	if (run_command(&cp_read))
-		return 2;
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+	refresh_index(the_repository->index, 0, NULL, NULL, NULL);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = the_repository->index;
+	opts.dst_index = the_repository->index;
+	opts.update = 1;
+	opts.merge = 1;
+	opts.aggressive = 1;
+
+	for (j = bases; j; j = j->next) {
+		if (add_tree(&j->item->object.oid, t + (i++)))
+			goto out;
+	}
+
+	if (head_arg && add_tree(&head, t + (i++)))
+		goto out;
+	if (remote && add_tree(&remote->item->object.oid, t + (i++)))
+		goto out;
+
+	if (i == 1)
+		opts.fn = oneway_merge;
+	else if (i == 2) {
+		opts.fn = twoway_merge;
+		opts.initial_checkout = is_index_unborn(the_repository->index);
+	} else if (i >= 3) {
+		opts.fn = threeway_merge;
+		opts.head_idx = i - 1;
+	}
+
+	if (unpack_trees(i, t, &opts))
+		goto out;
 
 	puts("Trying simple merge.");
+	write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
 
-	cp_write.git_cmd = 1;
-	cp_write.no_stdout = 1;
-	cp_write.no_stderr = 1;
-	argv_array_push(&cp_write.args, "write-tree");
-	if (run_command(&cp_write)) {
-		struct child_process cp_merge = CHILD_PROCESS_INIT;
+	if (write_index_as_tree(&oid, the_repository->index,
+				the_repository->index_file, 0, NULL)) {
+		int ret;
 
-		puts("Simple merge failed, trying Automatic merge.");
+		repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+		ret = merge_all(the_repository->index, 0, 0,
+				merge_one_file_cb, the_repository);
 
-		cp_merge.git_cmd = 1;
-		argv_array_pushl(&cp_merge.args, "merge-index", "-o",
-				 "git-merge-one-file", "-a", NULL);
-		if (run_command(&cp_merge))
-			return 1;
+		write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
+		return !!ret;
 	}
 
 	return 0;
+
+ out:
+	rollback_lock_file(&lock);
+	return 2;
 }
 
 static const char builtin_merge_resolve_usage[] =
@@ -73,6 +110,10 @@ int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
 	if (argc < 5)
 		usage(builtin_merge_resolve_usage);
 
+	setup_work_tree();
+	if (repo_read_index(the_repository) < 0)
+		die("invalid index");
+
 	/* The first parameters up to -- are merge bases; the rest are
 	 * heads. */
 	for (i = 1; i < argc; i++) {
diff --git a/merge-strategies.c b/merge-strategies.c
index f4c0b4acd6..39bfa1af7b 100644
--- a/merge-strategies.c
+++ b/merge-strategies.c
@@ -191,6 +191,17 @@ int merge_strategies_one_file(struct repository *r,
 	return 0;
 }
 
+int merge_one_file_cb(const struct object_id *orig_blob,
+		      const struct object_id *our_blob,
+		      const struct object_id *their_blob, const char *path,
+		      unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+		      void *data)
+{
+	return merge_strategies_one_file((struct repository *)data,
+					 orig_blob, our_blob, their_blob, path,
+					 orig_mode, our_mode, their_mode);
+}
+
 int merge_program_cb(const struct object_id *orig_blob,
 		     const struct object_id *our_blob,
 		     const struct object_id *their_blob, const char *path,
diff --git a/merge-strategies.h b/merge-strategies.h
index cf78d7eaf4..40e175ca39 100644
--- a/merge-strategies.h
+++ b/merge-strategies.h
@@ -16,6 +16,12 @@ typedef int (*merge_cb)(const struct object_id *orig_blob,
 			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
 			void *data);
 
+int merge_one_file_cb(const struct object_id *orig_blob,
+		      const struct object_id *our_blob,
+		      const struct object_id *their_blob, const char *path,
+		      unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
+		      void *data);
+
 int merge_program_cb(const struct object_id *orig_blob,
 		     const struct object_id *our_blob,
 		     const struct object_id *their_blob, const char *path,
-- 
2.27.0.139.gc9c318d6bf


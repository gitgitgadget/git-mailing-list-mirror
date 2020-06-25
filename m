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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2AC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4922072E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DySU+eav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404861AbgFYMtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404821AbgFYMtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FFC061795
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so5707226wrc.7
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZna7OhEKhzpo1wAeUZXoNM3XN2M7ox9MYwbTh4qYC4=;
        b=DySU+eav+Gx+KG64tM8im28yheR0BiT8bfWn6W6iZdf5KR8eMuaycdN1TL4H6lHQ5C
         ilTGomw0H4rDsofuONRQzw4A1eDPU+OCZ/7ixqjw6aML6Tjm3okUtMVnpKurP6EbpgYu
         VLNHbngeWJfKMdc/XzSLNoaeYsRWeefoajqzKSvtteNlguAz84IeZANlAgPegs25JdZA
         ws9EJl1daX2SqUtRN7OFyNIIB2CDGPqkXy0jUc5M8xIr76JKO04owkYobHXlmvNDAcZo
         u4/TYBPLGKJm654pz/iNeZb+lfKQy3UVsQrHn1SeC03PJR8QhSPLGvEbRDA1yx4sB5T0
         327w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZna7OhEKhzpo1wAeUZXoNM3XN2M7ox9MYwbTh4qYC4=;
        b=fMoR1OBJGV/7Xx0N03XcyHzocfAWy5LiMJwbXDJASbj0LtM4YXuGuu4Uc4Xwl28Q8a
         xzEg7eyhv/gXXvX2L5sRxFu38tfQDlqRoV/3iklkDrLTh54dPZ8lJk3kB/F/E4p3XtiG
         IkLQIyI9otaAGjLV8nRIW8c5c2fHhcbsxbMilUurYzdKXjk8uEqQJrmHMIg42aRQmo2U
         WU2MpLh7RCz/8arAWhFN8+pQScxt/KUeUg+bjYOoahugZKVexpewx+K6dpLw4W9ecUR3
         CvAIxndsipJK8AdX9iMIbbCScntFB1oCdZ2Xxcuce2OCWn6je2EescggtYhT8RJ56oZc
         ZBCg==
X-Gm-Message-State: AOAM531flRLxjxTMnauIdfojm3ll6cYWpnDs605I32StlXVps/M9fXcv
        Nw7jWUjKrsRP7tXL2Q1bvNq3lmV1
X-Google-Smtp-Source: ABdhPJx+ZLeHxG7we1qsQE2BhkqZevaCp1fddZ8k1jDpP+0NRG5CTwiQp3GEdAgtvHsa7XwPvTFVEw==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr2519504wrw.355.1593089348900;
        Thu, 25 Jun 2020 05:49:08 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 12/17] merge-octopus: remove calls to external processes
Date:   Thu, 25 Jun 2020 14:19:48 +0200
Message-Id: <20200625121953.16991-13-alban.gruin@gmail.com>
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

 - Calls to `read-tree -u -m (--aggressive)?' are replaced by calls to
   unpack_trees().

 - The call to `write-tree' is replaced by a call to
   write_index_as_tree().

 - The call to `diff-index ...' is replaced by a call to
   repo_index_has_changes(), and is moved from cmd_merge_octopus() to
   merge_octopus().

 - The call to `merge-index', needed to invoke `git merge-one-file', is
   replaced by a call to merge_all().

The index is read in cmd_merge_octopus(), and is wrote back by
merge_octopus().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-octopus.c | 155 ++++++++++++++++++++++------------------
 1 file changed, 86 insertions(+), 69 deletions(-)

diff --git a/builtin/merge-octopus.c b/builtin/merge-octopus.c
index 6216beaa2b..14310a4eb1 100644
--- a/builtin/merge-octopus.c
+++ b/builtin/merge-octopus.c
@@ -9,33 +9,70 @@
  */
 
 #include "cache.h"
+#include "cache-tree.h"
 #include "builtin.h"
 #include "commit-reach.h"
 #include "lockfile.h"
-#include "run-command.h"
+#include "merge-strategies.h"
 #include "unpack-trees.h"
 
+static int fast_forward(const struct object_id *oids, int nr, int aggressive)
+{
+	int i;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+	struct lock_file lock = LOCK_INIT;
+
+	repo_read_index_preload(the_repository, NULL, 0);
+	if (refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL))
+		return -1;
+
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = the_repository->index;
+	opts.dst_index = the_repository->index;
+	opts.merge = 1;
+	opts.update = 1;
+	opts.aggressive = aggressive;
+
+	for (i = 0; i < nr; i++) {
+		struct tree *tree;
+		tree = parse_tree_indirect(oids + i);
+		if (parse_tree(tree))
+			return -1;
+		init_tree_desc(t + i, tree->buffer, tree->size);
+	}
+
+	if (nr == 1)
+		opts.fn = oneway_merge;
+	else if (nr == 2) {
+		opts.fn = twoway_merge;
+		opts.initial_checkout = is_index_unborn(the_repository->index);
+	} else if (nr >= 3) {
+		opts.fn = threeway_merge;
+		opts.head_idx = nr - 1;
+	}
+
+	if (unpack_trees(nr, t, &opts))
+		return -1;
+
+	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK))
+		return error(_("unable to write new index file"));
+
+	return 0;
+}
+
 static int write_tree(struct tree **reference_tree)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf read_tree = STRBUF_INIT, err = STRBUF_INIT;
 	struct object_id oid;
 	int ret;
 
-	cp.git_cmd = 1;
-	argv_array_push(&cp.args, "write-tree");
-	ret = pipe_command(&cp, NULL, 0, &read_tree, 0, &err, 0);
-	if (err.len > 0)
-		fputs(err.buf, stderr);
-
-	strbuf_trim_trailing_newline(&read_tree);
-	get_oid(read_tree.buf, &oid);
-
-	*reference_tree = lookup_tree(the_repository, &oid);
-
-	strbuf_release(&read_tree);
-	strbuf_release(&err);
-	child_process_clear(&cp);
+	ret = write_index_as_tree(&oid, the_repository->index,
+				  the_repository->index_file, 0, NULL);
+	if (!ret)
+		*reference_tree = lookup_tree(the_repository, &oid);
 
 	return ret;
 }
@@ -48,12 +85,23 @@ static int merge_octopus(struct commit_list *bases, const char *head_arg,
 	struct tree *reference_tree;
 	struct commit_list *j;
 	struct object_id head;
+	struct strbuf sb = STRBUF_INIT;
 
 	get_oid(head_arg, &head);
+
 	reference_commit = xcalloc(commit_list_count(remotes) + 1, sizeof(struct commit *));
 	reference_commit[0] = lookup_commit_reference(the_repository, &head);
 	reference_tree = get_commit_tree(reference_commit[0]);
 
+	if (repo_index_has_changes(the_repository, reference_tree, &sb)) {
+		error(_("Your local changes to the following files "
+			"would be overwritten by merge:\n  %s"),
+		      sb.buf);
+		strbuf_release(&sb);
+		ret = 2;
+		goto out;
+	}
+
 	for (j = remotes; j; j = j->next) {
 		struct commit *c = j->item;
 		struct object_id *oid = &c->object.oid;
@@ -94,43 +142,36 @@ static int merge_octopus(struct commit_list *bases, const char *head_arg,
 		}
 
 		if (!non_ff_merge && can_ff) {
-			struct child_process cp = CHILD_PROCESS_INIT;
-
+			struct object_id oids[2];
 			printf(_("Fast-forwarding to: %s\n"), branch_name);
 
-			cp.git_cmd = 1;
-			argv_array_pushl(&cp.args, "read-tree", "-u", "-m", NULL);
-			argv_array_push(&cp.args, oid_to_hex(&head));
-			argv_array_push(&cp.args, oid_to_hex(oid));
+			oidcpy(oids, &head);
+			oidcpy(oids + 1, oid);
 
-			ret = run_command(&cp);
+			ret = fast_forward(oids, 2, 0);
 			if (ret) {
 				free(branch_name);
 				free_commit_list(common);
 				goto out;
 			}
 
-			child_process_clear(&cp);
 			references = 0;
 			write_tree(&reference_tree);
 		} else {
-			struct commit_list *l;
+			int i = 0;
 			struct tree *next = NULL;
-			struct child_process cp = CHILD_PROCESS_INIT;
+			struct object_id oids[MAX_UNPACK_TREES];
 
 			non_ff_merge = 1;
 			printf(_("Trying simple merge with %s\n"), branch_name);
 
-			cp.git_cmd = 1;
-			argv_array_pushl(&cp.args, "read-tree", "-u", "-m", "--aggressive", NULL);
+			for (k = common; k; k = k->next)
+				oidcpy(oids + (i++), &k->item->object.oid);
 
-			for (l = common; l; l = l->next)
-				argv_array_push(&cp.args, oid_to_hex(&l->item->object.oid));
+			oidcpy(oids + (i++), &reference_tree->object.oid);
+			oidcpy(oids + (i++), oid);
 
-			argv_array_push(&cp.args, oid_to_hex(&reference_tree->object.oid));
-			argv_array_push(&cp.args, oid_to_hex(oid));
-
-			if (run_command(&cp)) {
+			if (fast_forward(oids, i, 1)) {
 				ret = 2;
 
 				free(branch_name);
@@ -139,19 +180,15 @@ static int merge_octopus(struct commit_list *bases, const char *head_arg,
 				goto out;
 			}
 
-			child_process_clear(&cp);
-
 			if (write_tree(&next)) {
-				struct child_process cp = CHILD_PROCESS_INIT;
+				struct lock_file lock = LOCK_INIT;
+
 				puts(_("Simple merge did not work, trying automatic merge."));
+				repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+				ret = !!merge_all(the_repository->index, 0, 0,
+						  merge_one_file_cb, the_repository);
+				write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
 
-				cp.git_cmd = 1;
-				argv_array_pushl(&cp.args, "merge-index", "-o",
-						 "git-merge-one-file", "-a", NULL);
-				if (run_command(&cp))
-					ret = 1;
-
-				child_process_clear(&cp);
 				write_tree(&next);
 			}
 
@@ -178,12 +215,14 @@ int cmd_merge_octopus(int argc, const char **argv, const char *prefix)
 	struct commit_list *bases = NULL, *remotes = NULL;
 	struct commit_list **next_base = &bases, **next_remote = &remotes;
 	const char *head_arg = NULL;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf files = STRBUF_INIT;
 
 	if (argc < 5)
 		usage(builtin_merge_octopus_usage);
 
+	setup_work_tree();
+	if (repo_read_index(the_repository) < 0)
+		die("corrupted cache");
+
 	/* The first parameters up to -- are merge bases; the rest are
 	 * heads. */
 	for (i = 1; i < argc; i++) {
@@ -215,27 +254,5 @@ int cmd_merge_octopus(int argc, const char **argv, const char *prefix)
 	if (commit_list_count(remotes) < 2)
 		return 2;
 
-	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "diff-index", "--cached",
-			 "--name-only", "HEAD", "--", NULL);
-	pipe_command(&cp, NULL, 0, &files, 0, NULL, 0);
-	child_process_clear(&cp);
-
-	if (files.len > 0) {
-		struct strbuf **s, **b;
-
-		s = strbuf_split(&files, '\n');
-
-		fprintf(stderr, _("Error: Your local changes to the following "
-				  "files would be overwritten by merge\n"));
-
-		for (b = s; *b; b++)
-			fprintf(stderr, "    %.*s", (int)(*b)->len, (*b)->buf);
-
-		strbuf_list_free(s);
-		strbuf_release(&files);
-		return 2;
-	}
-
 	return merge_octopus(bases, head_arg, remotes);
 }
-- 
2.27.0.139.gc9c318d6bf


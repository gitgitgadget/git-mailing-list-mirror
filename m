Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD22C64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 14:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCCOzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCCOzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 09:55:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18401041C
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 06:55:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so11357722eda.7
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmU0CfIWmBoeWn73iOA+E4iHsortvQx/UyHj2KplNK4=;
        b=q5oPOdig98hGo+PnHHim5wbrZFsNh4INMqMk1cXxcTj5RX+LopFfrxzwEa1Ac0CDQ3
         MfTOoClgdX+f1ILnzmHFDoiFMSohgxGlDG9PXuxfaxYJ7MWHouUKVJYiNH5mmw1FNkod
         2rB1oJzTvHoLlXViQQt44K0Tamq14igzWpi/HmyAq0yzpri4VVAY2lCXuXrLKpzAN2yy
         KhTQ5RhnM+LJxt+/pNJ44He/JDq7lyH/GTL/F1M34TEBv3jOZd2RFz4vKznkF36ACaNV
         8GggKyn4Uvapu5Pnl8MULbVdy+I8+CVJnUCWc9qXyC84k6e2uAl8jKD3H+fnguYmUPUl
         GE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmU0CfIWmBoeWn73iOA+E4iHsortvQx/UyHj2KplNK4=;
        b=nJ6dTpezAC/DreRgS/8/HzNsk+lZFUD4+Llt/2mX+4ZTmfL/8kTl+KAzaSMjXfaUMA
         rGDif2VbXMBuIawQGmuWD61s+a26QdUnFubiv0XvHaFCwOpw5z/G043LFpSVme9tvTEZ
         jkvm2LGgoZ5YE0ZjOB/hC2JTFDeEIrRLlHXzbiuUv9kQLxVF1rGJJ9wuIQDTNM3KMXwA
         BS55m3UPjcv7HSvIjWNS6TI6ulMOFMQH5oKlvtMv2oqBr6U41U06H1KTfozrQN6uWQra
         i6tWbJeDOE0XLyoiRwkPRNdDntkq1qZNdA8nbR732ac7QLSOmeqBOpEitL+YiOb3IQYq
         PkWg==
X-Gm-Message-State: AO0yUKV0atTkcmr1ud/SjBO17jjyB8bj5JohAxW0ecoVVT+MhKxnkCR4
        VAmV08zV+PsK+lDvBdM5sfCdxbfOfck=
X-Google-Smtp-Source: AK7set9HyDp7/30f4jWRLEiCg3/+J9QHdKkVh26+FHHZYeqwa9ppy5OCSuZhwwAiH6URKl0AXe9+Jw==
X-Received: by 2002:a05:6402:88b:b0:4ad:5220:79f6 with SMTP id e11-20020a056402088b00b004ad522079f6mr2073682edy.18.1677855303864;
        Fri, 03 Mar 2023 06:55:03 -0800 (PST)
Received: from linuxerio.localdomain (j149130.upc-j.chello.nl. [24.132.149.130])
        by smtp.gmail.com with ESMTPSA id u9-20020a50d509000000b004af70dcce7esm1244054edi.40.2023.03.03.06.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:55:03 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [RFC PATCH] sequencer - tipped merge strategy
Date:   Fri,  3 Mar 2023 15:53:11 +0100
Message-Id: <20230303145311.513960-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing merge commits and dealing with conflicts, having the
original merge commit as a reference can help us avoid some of
them.

With this patch, we leverage the original merge commit to handle the most
obvious case:
- HEAD tree has to match the tree of the first parent of the original merge
  commit.
- MERGE_HEAD tree has to match the tree of the second parent of the original
  merge commit.
- At least one tree in the merge bases of HEAD/MERGE_HEAD has to match
  a tree in the merge bases of the parent commits of the original merge
  commit.

If all of those conditions are met, we can safely use the tree of the
original merge commit as the resulting tree of this merge that is being
attempted at the time.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 .gitignore          |   1 +
 Makefile            |   1 +
 builtin.h           |   1 +
 builtin/merge-tms.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
 git.c               |   1 +
 sequencer.c         |  36 ++++++++++-
 6 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 builtin/merge-tms.c

diff --git a/.gitignore b/.gitignore
index e875c59054..8b534f98e6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,6 +103,7 @@
 /git-merge-recursive
 /git-merge-resolve
 /git-merge-subtree
+/git-merge-tms
 /git-mergetool
 /git-mergetool--lib
 /git-mktag
diff --git a/Makefile b/Makefile
index 50ee51fde3..10a3167c50 100644
--- a/Makefile
+++ b/Makefile
@@ -1264,6 +1264,7 @@ BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
+BUILTIN_OBJS += builtin/merge-tms.o
 BUILTIN_OBJS += builtin/merge-tree.o
 BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
diff --git a/builtin.h b/builtin.h
index 46cc789789..94dcb73f85 100644
--- a/builtin.h
+++ b/builtin.h
@@ -180,6 +180,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix);
 int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+int cmd_merge_tms(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
 int cmd_mktree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-tms.c b/builtin/merge-tms.c
new file mode 100644
index 0000000000..37a2427757
--- /dev/null
+++ b/builtin/merge-tms.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright (c) 2023 Edmundo Carmona Antoranz
+ * Released under the terms of GPL2
+ *
+ * Tipped merge strategy.... a.k.a. fortune-teller merge strategy
+ *
+ * In cases like rebases, merge commits offer us the advantage of knowing
+ * _before hand_ what the previous result of the _original_ branches
+ * involved was.
+ *
+ * This merge strategy tries to leverage this knowledge so that we can
+ * avoid at least the most obvious conflicts that have been solved in the
+ * original merge commit.
+ *
+ * In the current state, the strategy works based on exact matches of the trees
+ * involved:
+ * - HEAD tree has to match the tree of the first parent of the original merge
+ *   commit.
+ * - MERGE_HEAD tree has to match the tree of the second parent of the original
+ *   merge commit.
+ * - At least one tree in the merge bases of HEAD/MERGE_HEAD has to match
+ *   a tree in the merge bases of the parent commits of the original merge
+ *   commit.
+ * If all of those conditions are met, we can safely use the tree of the
+ * original merge commit as the resulting tree of this merge that is being
+ * attempted at the time.
+ */
+
+#include "builtin.h"
+#include "commit-reach.h"
+#include "oid-array.h"
+#include "parse-options.h"
+#include "run-command.h"
+
+
+struct tms_options {
+	const char *tip;
+	const char *merge_head;
+} tms_options;
+
+static int restore(struct commit *commit)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	strvec_push(&cmd.args, "restore");
+	strvec_push(&cmd.args, "--worktree");
+	strvec_push(&cmd.args, "--stage");
+	strvec_pushf(&cmd.args, "--source=%s",
+		     oid_to_hex(&commit->object.oid));
+	strvec_push(&cmd.args, "--");
+	strvec_push(&cmd.args, ".");
+	cmd.git_cmd = 1;
+	return run_command(&cmd);
+}
+
+static void load_tree_oids(struct oid_array *oids, struct commit_list *bases)
+{
+	struct commit_list *i;
+
+	for (i = bases; i; i = i->next)
+		oid_array_append(oids, get_commit_tree_oid(i->item));
+}
+
+static int find_oid(const struct object_id *oid,
+		void *data)
+{
+	struct oid_array *other_list = (struct oid_array *) data;
+	int pos = oid_array_lookup(other_list, oid);
+	return pos >= 0 ? 1 : 0;
+}
+
+static int base_match(struct commit *rebase_head,
+		struct commit *head,
+		struct commit *merge_head)
+{
+	struct commit_list *bases_current, *bases_tip;
+	struct oid_array trees_current = OID_ARRAY_INIT;
+	struct oid_array trees_tip = OID_ARRAY_INIT;
+	int oid_match;
+
+	bases_current = get_merge_bases(head, merge_head);
+	bases_tip = get_merge_bases(rebase_head->parents->item,
+				    rebase_head->parents->next->item);
+	load_tree_oids(&trees_current, bases_current);
+	load_tree_oids(&trees_tip, bases_tip);
+
+	oid_match = oid_array_for_each(&trees_current, find_oid, &trees_tip);
+
+	oid_array_clear(&trees_current);
+	oid_array_clear(&trees_tip);
+
+	return oid_match;
+}
+
+static int run_tms_merge(struct tms_options *options)
+{
+	struct commit *head, *merge_head, *tip;
+	struct commit_list *i;
+
+	head = lookup_commit_reference_by_name("HEAD");
+	merge_head = lookup_commit_reference_by_name(options->merge_head);
+	tip = lookup_commit_reference_by_name(options->tip);
+
+	if (!(head && merge_head && tip)) {
+		return 2;
+	}
+	if (commit_list_count(tip->parents) != 2)
+		return 2;
+
+	for (i = tip->parents; i; i = i->next)
+		parse_commit(i->item);
+	if (!oideq(get_commit_tree_oid(head),
+		   get_commit_tree_oid(tip->parents->item)))
+		return 2;
+	if (!oideq(get_commit_tree_oid(merge_head),
+		   get_commit_tree_oid(tip->parents->next->item)))
+		return 2;
+
+	if (!base_match(tip, head, merge_head))
+		return 2;
+
+	if (restore(tip))
+		return 2;
+
+	return 0;
+}
+
+int cmd_merge_tms(int argc, const char **argv, const char *prefix)
+{
+
+	struct option mt_options[] = {
+		OPT_STRING(0, "tip", &tms_options.tip,
+			    N_("tip-merge-commit"),
+			    N_("merge commit being rebased used as a tip for conflict resolution.")),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, NULL, mt_options,
+			     NULL, 0);
+
+	if (argc != 1)
+		return 2;
+	tms_options.merge_head = argv[0];
+
+	if (!tms_options.tip)
+		return 2;
+
+	return run_tms_merge(&tms_options);
+}
diff --git a/git.c b/git.c
index 96b0a2837d..2e843731f1 100644
--- a/git.c
+++ b/git.c
@@ -544,6 +544,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-tms", cmd_merge_tms, RUN_SETUP },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP },
 	{ "mktree", cmd_mktree, RUN_SETUP },
diff --git a/sequencer.c b/sequencer.c
index 65a34f9676..559169814b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3833,6 +3833,21 @@ static int do_reset(struct repository *r,
 	return ret;
 }
 
+static int try_tms_merge(struct replay_opts *opts,
+			 struct commit *rebase_head,
+			 struct commit *merge_commit)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	strvec_push(&cmd.args, "merge-tms");
+	strvec_push(&cmd.args, "--tip");
+	strvec_pushf(&cmd.args, "%s", oid_to_hex(&rebase_head->object.oid));
+	strvec_pushf(&cmd.args, "%s", oid_to_hex(&merge_commit->object.oid));
+
+	cmd.git_cmd = 1;
+	return run_command(&cmd) ? 0 : 1;
+}
+
 static int do_merge(struct repository *r,
 		    struct commit *commit,
 		    const char *arg, int arg_len,
@@ -3846,7 +3861,8 @@ static int do_merge(struct repository *r,
 	const char *strategy = !opts->xopts_nr &&
 		(!opts->strategy ||
 		 !strcmp(opts->strategy, "recursive") ||
-		 !strcmp(opts->strategy, "ort")) ?
+		 !strcmp(opts->strategy, "ort") ||
+		 !strcmp(opts->strategy, "tms")) ?
 		NULL : opts->strategy;
 	struct merge_options o;
 	int merge_arg_len, oneline_offset, can_fast_forward, ret, k;
@@ -4086,6 +4102,23 @@ static int do_merge(struct repository *r,
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
 
+	if (!opts->strategy || !strcmp(opts->strategy, "tms")) {
+		rollback_lock_file(&lock);
+		ret = try_tms_merge(opts, commit, to_merge->item);
+		if (ret) {
+			discard_index(r->index);
+			if (repo_read_index(r) < 0) {
+				ret = error(_("could not read index"));
+				goto leave_merge;
+			}
+			goto ran_merge;
+		}
+		// regain lock to go into recursive
+		if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
+			ret = -1;
+			goto leave_merge;
+		}
+	}
 	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
 		/*
 		 * TODO: Should use merge_incore_recursive() and
@@ -4100,6 +4133,7 @@ static int do_merge(struct repository *r,
 		ret = merge_recursive(&o, head_commit, merge_commit, bases,
 				      &i);
 	}
+ran_merge:
 	if (ret <= 0)
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
-- 
2.39.1
I think it is ok to write things over here, right?

I would like a little bit of coaching in terms of releasing/regaining
lock before/after calling the merge strategy built-in. I am not so sure
current implementation is correct in that front but at least it is
working in my tests so I think it is a good starting point for an RFC.

Thanks in advance for any feedback you might provide.

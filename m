Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49387C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiAEQd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241938AbiAEQdt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:33:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A857C061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 08:33:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so2268231wmk.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BK/oS73SUetZOI2Q/Wjfe2+okRB/7aUZYCJyoh5Pk9Y=;
        b=iZVEWTxBHTutGTItEkz88dhxSq7hxkXZ0jQFHm+C66CDR1bUMRCE3rcj/H6y6FdTXs
         9LVTrkANhKTyfVNBckZvXjQ/+9EPtjwxYp8CsD6wzJPJL1XWSgNsxLIigem3kn/3HDrT
         GgZHaCKQ7d3abWBtnZijYavsI4KDdAc8e804EraRNuf9HP+GPHyYDi7CgWPlAC603CEJ
         RkC/jTzCIbGfhVsrKXnerKJpTZEDQTxCJZETgg6jzinxqZIPfJJ74TYH/8PPcZOUy/nH
         rJYcWxqC0E1w9xkOG1P6r/+IY8t6mjI2BEBla0UDuHg4/hmiFvhv5fD7NG98wVGa7BWj
         Prhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BK/oS73SUetZOI2Q/Wjfe2+okRB/7aUZYCJyoh5Pk9Y=;
        b=khlTKsyxV1+fBgMdAtM4LfEztnEm/7wKEqPjELttbMbXeHXyHeSZ6ehVqTZ0apYmty
         2mx4MpS2GS28ZrS1wIC9065EzObpHxN7wjtV0zHbha4O6ZmcSElFxSpfj+Ote10Ci7wJ
         RmNLtqKBGwptOKF8ffTssOtosuJKQ+ED+n4qK7jvYt0mswZ8SSlTupBVvMWFnXPSYnPq
         MeMns7oNCRFP3G4i2sVvmqrsUf+fD8eh0hGfZCF1wpKY2y/GP3br+CoT7qpwIYSHO/pR
         zeBD4FcTsWU5Zz9RKxA1fhdHqWU8RRpQ9bQtafU1mPdbaozzMknrS0TBs1gPFCgjsSEA
         +nmg==
X-Gm-Message-State: AOAM532rJyZSO9b+NcX6A3KDUlCKjV5xR8lBZty/ch1zdXC9ceTSJRhm
        mX77E9jax7crzK2hcD7acZTbWY08y9A=
X-Google-Smtp-Source: ABdhPJxQ+PV+2RDoOzI2YvP3+hIoNHGuoAYYVb12X+FNvSOVTEpN0F6vyotKpXxKuXk+rcHziDSLSQ==
X-Received: by 2002:a05:600c:3caa:: with SMTP id bg42mr3581492wmb.106.1641400427426;
        Wed, 05 Jan 2022 08:33:47 -0800 (PST)
Received: from localhost.localdomain ([185.228.230.189])
        by smtp.gmail.com with ESMTPSA id u20sm3417515wml.45.2022.01.05.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 08:33:47 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/2] merge-ort: add new merge-tree-ort command
Date:   Wed,  5 Jan 2022 17:33:23 +0100
Message-Id: <20220105163324.73369-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.34.1.433.g7bc349372a.dirty
In-Reply-To: <20220105163324.73369-1-chriscool@tuxfamily.org>
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new command is similar as merge-tree, but uses
merge-ort code and features, especially
merge_incore_nonrecursive(), instead of those from
resursive merge, to perform the merge.

The output from this new command is very different from
merge-tree's custom output, as we are only using code and
features from diff.{h,c}, especially diff_tree_oid(). This
should make it easy to customize and standardize the output
using regular diff options in the future.

This command will be extended to support new features
with the long-term goal of enabling merges and rebases
without a worktree.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore               |  1 +
 Makefile                 |  1 +
 builtin.h                |  1 +
 builtin/merge-tree-ort.c | 93 ++++++++++++++++++++++++++++++++++++++++
 git.c                    |  1 +
 5 files changed, 97 insertions(+)
 create mode 100644 builtin/merge-tree-ort.c

diff --git a/.gitignore b/.gitignore
index 054249b20a..2dfcb1a589 100644
--- a/.gitignore
+++ b/.gitignore
@@ -98,6 +98,7 @@
 /git-merge-index
 /git-merge-file
 /git-merge-tree
+/git-merge-tree-ort
 /git-merge-octopus
 /git-merge-one-file
 /git-merge-ours
diff --git a/Makefile b/Makefile
index 75ed168adb..915e500b06 100644
--- a/Makefile
+++ b/Makefile
@@ -1124,6 +1124,7 @@ BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
 BUILTIN_OBJS += builtin/merge-tree.o
+BUILTIN_OBJS += builtin/merge-tree-ort.o
 BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
 BUILTIN_OBJS += builtin/mktree.o
diff --git a/builtin.h b/builtin.h
index 8a58743ed6..c68f46b118 100644
--- a/builtin.h
+++ b/builtin.h
@@ -182,6 +182,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 int cmd_merge_file(int argc, const char **argv, const char *prefix);
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 int cmd_merge_tree(int argc, const char **argv, const char *prefix);
+int cmd_merge_tree_ort(int argc, const char **argv, const char *prefix);
 int cmd_mktag(int argc, const char **argv, const char *prefix);
 int cmd_mktree(int argc, const char **argv, const char *prefix);
 int cmd_multi_pack_index(int argc, const char **argv, const char *prefix);
diff --git a/builtin/merge-tree-ort.c b/builtin/merge-tree-ort.c
new file mode 100644
index 0000000000..1c8ecd16ec
--- /dev/null
+++ b/builtin/merge-tree-ort.c
@@ -0,0 +1,93 @@
+#include "builtin.h"
+#include "merge-ort.h"
+#include "diff.h"
+
+static const char merge_tree_ort_usage[] = "git merge-tree-ort <base-tree> <branch1> <branch2>";
+
+static void show_result(struct tree *base_tree,
+			struct tree *head_tree,
+			struct tree *merge_tree,
+			struct merge_result *result)
+{
+	const struct object_id *base_oid = &(base_tree->object.oid);
+	const struct object_id *head_oid = &(head_tree->object.oid);
+	const struct object_id *merge_oid = &(merge_tree->object.oid);
+	const struct object_id *result_oid = &(result->tree->object.oid);
+	struct diff_options opts;
+
+	repo_diff_setup(the_repository, &opts);
+	opts.stat_width = -1; /* use full terminal width */
+	opts.output_format |= DIFF_FORMAT_RAW | DIFF_FORMAT_PATCH;
+	opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_setup_done(&opts);
+
+	printf("result tree: %s\n", oid_to_hex(result_oid));
+	printf("clean: %d\n", result->clean);
+
+	printf("diff with branch1:\n");
+	diff_tree_oid(head_oid, result_oid, "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+
+	printf("diff with branch2:\n");
+	diff_tree_oid(merge_oid, result_oid, "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+
+	printf("diff with base:\n");
+	diff_tree_oid(base_oid, result_oid, "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+}
+
+static struct commit *get_commit_by_name_or_die(const char *name)
+{
+	struct commit *c = lookup_commit_reference_by_name(name);
+	if (!c)
+		die(_("not a valid commit name '%s'"), name);
+	return c;
+}
+
+static void merge_trees_ort(const char *base_name,
+			    const char *branch1,
+			    const char *branch2)
+{
+	struct merge_result result;
+	struct merge_options merge_opt;
+
+	struct commit *base = get_commit_by_name_or_die(base_name);
+	struct commit *head = get_commit_by_name_or_die(branch1);
+	struct commit *merge = get_commit_by_name_or_die(branch2);
+
+	struct tree *base_tree = get_commit_tree(base);
+	struct tree *head_tree = get_commit_tree(head);
+	struct tree *merge_tree = get_commit_tree(merge);
+
+	memset(&result, 0, sizeof(result));
+	init_merge_options(&merge_opt, the_repository);
+
+	merge_opt.show_rename_progress = 1;
+	merge_opt.branch1 = branch1;
+	merge_opt.branch2 = branch2;
+	merge_opt.ancestor = base_name;
+
+	result.tree = head_tree;
+
+	merge_incore_nonrecursive(&merge_opt,
+				  base_tree,
+				  result.tree,
+				  merge_tree,
+				  &result);
+
+	show_result(base_tree, head_tree, merge_tree, &result);
+}
+
+int cmd_merge_tree_ort(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_ort_usage);
+
+	merge_trees_ort(argv[1], argv[2], argv[3]);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 7edafd8ecf..90b8a4984c 100644
--- a/git.c
+++ b/git.c
@@ -562,6 +562,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-tree-ort", cmd_merge_tree_ort, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
-- 
2.34.1.433.g7bc349372a.dirty


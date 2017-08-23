Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B744D20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbdHWMi2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33058 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id t12so203988pfk.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0SBMTb/1HM1VK/096XBvWFKuF15fLNiIJvEpzrsERQ=;
        b=N3VdOVIHfTp4DSdos5F3QCFdqU8f20vxvwotS/Uu2ycqoeb4ZkEdAO75aG9r+q4HO/
         /Q+x+M6IgOKrKdREnwCPvK5NUFbH7TcNj3qE08oDdZs7FfK9DGjsFXPhD4yWKIUzTlF5
         OUA4qWkLOTsbuib7t4QSk+TqFcXBdMnGecXVSPZccsJvPSeL1IcPPCATpxgf2QCQJX6p
         nof1glI6pNE3+NHNpP3fW7Pb3zEVPgw2seMIqATLBaqKRUjZEC0d4Cypfdir0DLKHbOp
         M6SqGuZhpp6rZZH6BDRQSUEdxHSORZ7JordRQR6+G7OjnERpHD0D9TiRMcbtNlvait4k
         O8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0SBMTb/1HM1VK/096XBvWFKuF15fLNiIJvEpzrsERQ=;
        b=gZXbP2iSfUKaukOTKsOKLVQi/4SWWFErHeBRAjf80RbZR6npP8C5xpANx6evPWfe3m
         K9SG9QZBEPLo3tTYfLm7zwRRPqwRHw0yD29otXOCrP64IwK+2OV7y0gg0L8ncoslVfko
         VBI62naPf9hYDjvyFIkOEZGH+zbk3iY21lGbYjIsw8a6aqHyOTblhD1phOQZRWq2F6BY
         FMJKS9SfmjsTSOtWpupdFb4DSmsIzcwFQu+O5UXl0GCD4zeOpieszLiFh79+jB/rmVht
         1eZO0yiYDAYhKcqit4uEAjSCtrF5AKrnGqPQ8a6pbNq1Q6Ft3BesYtkMIImWPL6PQIQd
         NUXw==
X-Gm-Message-State: AHYfb5jZGxBFTACI8W+eCf282I/5+HKg1Yzl8uR1dYr/V+/oqehR3jH5
        uukq0UkMIty4cr8I
X-Received: by 10.99.117.87 with SMTP id f23mr2511801pgn.231.1503491907119;
        Wed, 23 Aug 2017 05:38:27 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id e5sm3309358pgn.55.2017.08.23.05.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 11/16] revision.c: --all adds HEAD from all worktrees
Date:   Wed, 23 Aug 2017 19:36:59 +0700
Message-Id: <20170823123704.16518-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless single_worktree is set, --all now adds HEAD from all worktrees.

Since reachable.c code does not use setup_revisions(), we need to call
other_head_refs_submodule() explicitly there to have the same effect on
"git prune", so that we won't accidentally delete objects needed by some
other HEADs.

A new FIXME is added because we would need something like

    int refs_other_head_refs(struct ref_store *, each_ref_fn, cb_data);

in addition to other_head_refs() to handle it, which might require

    int get_submodule_worktrees(const char *submodule, int flags);

It could be a separate topic to reduce the scope of this one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 reachable.c      |  2 ++
 revision.c       | 14 ++++++++++++++
 submodule.c      |  2 ++
 t/t5304-prune.sh | 12 ++++++++++++
 worktree.c       | 22 ++++++++++++++++++++++
 worktree.h       |  8 ++++++++
 6 files changed, 60 insertions(+)

diff --git a/reachable.c b/reachable.c
index c62efbfd43..492e87b9fa 100644
--- a/reachable.c
+++ b/reachable.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "progress.h"
 #include "list-objects.h"
+#include "worktree.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -176,6 +177,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	/* detached HEAD is not included in the list above */
 	head_ref(add_one_ref, revs);
+	other_head_refs(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/revision.c b/revision.c
index 8d04516266..0e98444857 100644
--- a/revision.c
+++ b/revision.c
@@ -2133,6 +2133,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	int argcount;
 
 	if (submodule) {
+		/*
+		 * We need some something like get_submodule_worktrees()
+		 * before we can go through all worktrees of a submodule,
+		 * .e.g with adding all HEADs from --all, which is not
+		 * supported right now, so stick to single worktree.
+		 */
+		if (!revs->single_worktree)
+			die("BUG: --single-worktree cannot be used together with submodule");
 		refs = get_submodule_ref_store(submodule);
 	} else
 		refs = get_main_ref_store();
@@ -2150,6 +2158,12 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(refs, revs, *flags, refs_for_each_ref);
 		handle_refs(refs, revs, *flags, refs_head_ref);
+		if (!revs->single_worktree) {
+			struct all_refs_cb cb;
+
+			init_all_refs_cb(&cb, revs, *flags);
+			other_head_refs(handle_one_ref, &cb);
+		}
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
diff --git a/submodule.c b/submodule.c
index 98e1f9d3c7..61a38adcd4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1685,6 +1685,8 @@ static int find_first_merges(struct object_array *result, const char *path,
 			oid_to_hex(&a->object.oid));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
+	/* FIXME: can't handle linked worktrees in submodules yet */
+	revs.single_worktree = path != NULL;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
 
 	/* save all revisions from the above list that contain b */
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index cba45c7be9..683bdb031c 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -292,4 +292,16 @@ test_expect_success 'prune: handle index in multiple worktrees' '
 	test_cmp second-worktree/blob actual
 '
 
+test_expect_success 'prune: handle HEAD in multiple worktrees' '
+	git worktree add --detach third-worktree &&
+	echo "new blob for third-worktree" >third-worktree/blob &&
+	git -C third-worktree add blob &&
+	git -C third-worktree commit -m "third" &&
+	rm .git/worktrees/third-worktree/index &&
+	test_must_fail git -C third-worktree show :blob &&
+	git prune --expire=now &&
+	git -C third-worktree show HEAD:blob >actual &&
+	test_cmp third-worktree/blob actual
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index e28ffbeb09..389e2e952c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -386,3 +386,25 @@ int submodule_uses_worktrees(const char *path)
 	closedir(dir);
 	return ret;
 }
+
+int other_head_refs(each_ref_fn fn, void *cb_data)
+{
+	struct worktree **worktrees, **p;
+	int ret = 0;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct ref_store *refs;
+
+		if (wt->is_current)
+			continue;
+
+		refs = get_worktree_ref_store(wt);
+		ret = refs_head_ref(refs, fn, cb_data);
+		if (ret)
+			break;
+	}
+	free_worktrees(worktrees);
+	return ret;
+}
diff --git a/worktree.h b/worktree.h
index 5ea5e503fb..9276c81ae7 100644
--- a/worktree.h
+++ b/worktree.h
@@ -1,6 +1,8 @@
 #ifndef WORKTREE_H
 #define WORKTREE_H
 
+#include "refs.h"
+
 struct worktree {
 	char *path;
 	char *id;
@@ -70,6 +72,12 @@ extern void free_worktrees(struct worktree **);
 extern const struct worktree *find_shared_symref(const char *symref,
 						 const char *target);
 
+/*
+ * Similar to head_ref() for all HEADs _except_ one from the current
+ * worktree, which is covered by head_ref().
+ */
+int other_head_refs(each_ref_fn fn, void *cb_data);
+
 int is_worktree_being_rebased(const struct worktree *wt, const char *target);
 int is_worktree_being_bisected(const struct worktree *wt, const char *target);
 
-- 
2.11.0.157.gd943d85


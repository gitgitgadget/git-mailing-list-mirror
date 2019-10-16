Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003A61F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbfJPR0c (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbfJPR0b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so6674924pgu.13
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NrMwuioCgAntf6Od7acxRqFhhr/dVfgY7jxGTrX0LEQ=;
        b=Wi9RS0NDJfXYl7Rx4tcd/9mTLBYaEwN+kz9pdccg6pUspgFEFSjT5SgIopv9enilSV
         Xh6HbPjaho8rdZX741mgPBZNWL/gBeuFj2eOf/PWBPzvlc8IYBlxxQ5EMyLxtaiadOce
         dfcRDY2j5bWQPma6ne4duI39Kp+vL8GMt1EPwdovy2hHwBHIJxxrpbfdoRGuUrzJkVRj
         Ldjsz3Sa5S8rQmtJh5LaPJXfQcqQW5cTeng6+iZXwkXLPuMw8qD5YWQaq/UBH16wGDMt
         sxa8sVDvgsJ6vsy4dunLxMI56x70Mu7MKTUzKlI1WqyLai5itERRZcgsYxvsc6zDwzTu
         oXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NrMwuioCgAntf6Od7acxRqFhhr/dVfgY7jxGTrX0LEQ=;
        b=tkJCZ/mwuZnfKddFc6zVS5sz2RlLQIdG2xBgLDY9KuhA9rhXiv+OukSs7EBRY9UzvR
         ckv6HzBhr/UkxUQB99c7xh3wPGxD0qJY/n+OjcacVyk7l7unZb9PU+RBWX/1rhYPd+Dy
         xXuNBvog599xfT9m8k2SzwYc51ABBCA9zMt0fg4z1wr959rlPCKYs6D/6BbHiQIh7Gsi
         xfcFyMNpBQxJAU5mHYvxM1y8rvgRZlPTviOtHVgrpr/oZ7rHdmnPoh1IjgcAChE5AFFg
         Fc0NpMiBTS1oniBx3HS6DnJV10kQqfiWNU1aTjCxHehiaCIScwBFQQ+YHWZ8o3x8UCcG
         RE/g==
X-Gm-Message-State: APjAAAWXOW8kp9mKCM2F7IlrReoRBBxmyH4BIbmpaBQ4oRv4IAXJt4U+
        /pMH3vG25jF9sOh9h4UjdLMSMZL5
X-Google-Smtp-Source: APXvYqz12OlVTt/3GtvnJDaNs4s3GnzIZqeQwtBBRLR9oTknsyJY4epz/6JE5Q8rEwIrdkgXRf3lqw==
X-Received: by 2002:a63:734a:: with SMTP id d10mr26576254pgn.334.1571246790044;
        Wed, 16 Oct 2019 10:26:30 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id u13sm22006882pgk.88.2019.10.16.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:29 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:27 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 4/7] autostash: extract reset_head() from rebase
Message-ID: <5e0dcd7cbeb3481beef04f1d145474739f8bdea3.1571246693.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571246693.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Begin the process of lib-ifying the autostash code. In a future commit,

This patch is best viewed with `--color-moved` and
`--color-moved-ws=allow-indentation-change`.
this will be used to implement `--autostash` in other builtins.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 autostash.c      | 137 +++++++++++++++++++++++++++++++++++++++++++++++
 autostash.h      |  12 +++++
 builtin/rebase.c | 137 -----------------------------------------------
 3 files changed, 149 insertions(+), 137 deletions(-)

diff --git a/autostash.c b/autostash.c
index 62ec7a7c80..eb58e0c8a4 100644
--- a/autostash.c
+++ b/autostash.c
@@ -1,9 +1,17 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
+
 #include "git-compat-util.h"
 #include "autostash.h"
+#include "cache-tree.h"
 #include "dir.h"
 #include "gettext.h"
+#include "lockfile.h"
+#include "refs.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "tree-walk.h"
+#include "tree.h"
+#include "unpack-trees.h"
 
 int read_one(const char *path, struct strbuf *buf)
 {
@@ -13,6 +21,135 @@ int read_one(const char *path, struct strbuf *buf)
 	return 0;
 }
 
+int reset_head(struct object_id *oid, const char *action,
+	       const char *switch_to_branch, unsigned flags,
+	       const char *reflog_orig_head, const char *reflog_head)
+{
+	unsigned detach_head = flags & RESET_HEAD_DETACH;
+	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	struct object_id head_oid;
+	struct tree_desc desc[2] = { { NULL }, { NULL } };
+	struct lock_file lock = LOCK_INIT;
+	struct unpack_trees_options unpack_tree_opts;
+	struct tree *tree;
+	const char *reflog_action;
+	struct strbuf msg = STRBUF_INIT;
+	size_t prefix_len;
+	struct object_id *orig = NULL, oid_orig,
+		*old_orig = NULL, oid_old_orig;
+	int ret = 0, nr = 0;
+
+	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
+		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
+
+	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
+		ret = error(_("could not determine HEAD revision"));
+		goto leave_reset_head;
+	}
+
+	if (!oid)
+		oid = &head_oid;
+
+	if (refs_only)
+		goto reset_head_refs;
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = the_repository->index;
+	unpack_tree_opts.dst_index = the_repository->index;
+	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
+	unpack_tree_opts.update = 1;
+	unpack_tree_opts.merge = 1;
+	if (!detach_head)
+		unpack_tree_opts.reset = 1;
+
+	if (repo_read_index_unmerged(the_repository) < 0) {
+		ret = error(_("could not read index"));
+		goto leave_reset_head;
+	}
+
+	if (!reset_hard && !fill_tree_descriptor(the_repository, &desc[nr++], &head_oid)) {
+		ret = error(_("failed to find tree of %s"),
+			    oid_to_hex(&head_oid));
+		goto leave_reset_head;
+	}
+
+	if (!fill_tree_descriptor(the_repository, &desc[nr++], oid)) {
+		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		goto leave_reset_head;
+	}
+
+	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	tree = parse_tree_indirect(oid);
+	prime_cache_tree(the_repository, the_repository->index, tree);
+
+	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
+		ret = error(_("could not write index"));
+		goto leave_reset_head;
+	}
+
+reset_head_refs:
+	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
+	prefix_len = msg.len;
+
+	if (update_orig_head) {
+		if (!get_oid("ORIG_HEAD", &oid_old_orig))
+			old_orig = &oid_old_orig;
+		if (!get_oid("HEAD", &oid_orig)) {
+			orig = &oid_orig;
+			if (!reflog_orig_head) {
+				strbuf_addstr(&msg, "updating ORIG_HEAD");
+				reflog_orig_head = msg.buf;
+			}
+			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
+		} else if (old_orig)
+			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	}
+
+	if (!reflog_head) {
+		strbuf_setlen(&msg, prefix_len);
+		strbuf_addstr(&msg, "updating HEAD");
+		reflog_head = msg.buf;
+	}
+	if (!switch_to_branch)
+		ret = update_ref(reflog_head, "HEAD", oid, orig,
+				 detach_head ? REF_NO_DEREF : 0,
+				 UPDATE_REFS_MSG_ON_ERR);
+	else {
+		ret = update_ref(reflog_head, switch_to_branch, oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		if (!ret)
+			ret = create_symref("HEAD", switch_to_branch,
+					    reflog_head);
+	}
+	if (run_hook)
+		run_hook_le(NULL, "post-checkout",
+			    oid_to_hex(orig ? orig : &null_oid),
+			    oid_to_hex(oid), "1", NULL);
+
+leave_reset_head:
+	strbuf_release(&msg);
+	rollback_lock_file(&lock);
+	while (nr)
+		free((void *)desc[--nr].buffer);
+	return ret;
+}
+
 int apply_autostash(const char *path)
 {
 	struct strbuf autostash = STRBUF_INIT;
diff --git a/autostash.h b/autostash.h
index 5f4e4bd22c..1406638166 100644
--- a/autostash.h
+++ b/autostash.h
@@ -6,6 +6,18 @@
 /* Read one file, then strip line endings */
 int read_one(const char *path, struct strbuf *buf);
 
+#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
+
+#define RESET_HEAD_DETACH (1<<0)
+#define RESET_HEAD_HARD (1<<1)
+#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
+#define RESET_HEAD_REFS_ONLY (1<<3)
+#define RESET_ORIG_HEAD (1<<4)
+
+int reset_head(struct object_id *oid, const char *action,
+	       const char *switch_to_branch, unsigned flags,
+	       const char *reflog_orig_head, const char *reflog_head);
+
 int apply_autostash(const char *path);
 
 #endif
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 661928d427..c3165896cc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -734,143 +734,6 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 	}
 }
 
-#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
-
-#define RESET_HEAD_DETACH (1<<0)
-#define RESET_HEAD_HARD (1<<1)
-#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
-#define RESET_HEAD_REFS_ONLY (1<<3)
-#define RESET_ORIG_HEAD (1<<4)
-
-static int reset_head(struct object_id *oid, const char *action,
-		      const char *switch_to_branch, unsigned flags,
-		      const char *reflog_orig_head, const char *reflog_head)
-{
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
-	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
-	struct object_id head_oid;
-	struct tree_desc desc[2] = { { NULL }, { NULL } };
-	struct lock_file lock = LOCK_INIT;
-	struct unpack_trees_options unpack_tree_opts;
-	struct tree *tree;
-	const char *reflog_action;
-	struct strbuf msg = STRBUF_INIT;
-	size_t prefix_len;
-	struct object_id *orig = NULL, oid_orig,
-		*old_orig = NULL, oid_old_orig;
-	int ret = 0, nr = 0;
-
-	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
-		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
-
-	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
-		ret = error(_("could not determine HEAD revision"));
-		goto leave_reset_head;
-	}
-
-	if (!oid)
-		oid = &head_oid;
-
-	if (refs_only)
-		goto reset_head_refs;
-
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
-	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
-	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = the_repository->index;
-	unpack_tree_opts.dst_index = the_repository->index;
-	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
-	unpack_tree_opts.update = 1;
-	unpack_tree_opts.merge = 1;
-	if (!detach_head)
-		unpack_tree_opts.reset = 1;
-
-	if (repo_read_index_unmerged(the_repository) < 0) {
-		ret = error(_("could not read index"));
-		goto leave_reset_head;
-	}
-
-	if (!reset_hard && !fill_tree_descriptor(the_repository, &desc[nr++], &head_oid)) {
-		ret = error(_("failed to find tree of %s"),
-			    oid_to_hex(&head_oid));
-		goto leave_reset_head;
-	}
-
-	if (!fill_tree_descriptor(the_repository, &desc[nr++], oid)) {
-		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
-		goto leave_reset_head;
-	}
-
-	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	tree = parse_tree_indirect(oid);
-	prime_cache_tree(the_repository, the_repository->index, tree);
-
-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
-		ret = error(_("could not write index"));
-		goto leave_reset_head;
-	}
-
-reset_head_refs:
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
-	prefix_len = msg.len;
-
-	if (update_orig_head) {
-		if (!get_oid("ORIG_HEAD", &oid_old_orig))
-			old_orig = &oid_old_orig;
-		if (!get_oid("HEAD", &oid_orig)) {
-			orig = &oid_orig;
-			if (!reflog_orig_head) {
-				strbuf_addstr(&msg, "updating ORIG_HEAD");
-				reflog_orig_head = msg.buf;
-			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
-				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
-		} else if (old_orig)
-			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
-	}
-
-	if (!reflog_head) {
-		strbuf_setlen(&msg, prefix_len);
-		strbuf_addstr(&msg, "updating HEAD");
-		reflog_head = msg.buf;
-	}
-	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, orig,
-				 detach_head ? REF_NO_DEREF : 0,
-				 UPDATE_REFS_MSG_ON_ERR);
-	else {
-		ret = update_ref(reflog_head, switch_to_branch, oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
-		if (!ret)
-			ret = create_symref("HEAD", switch_to_branch,
-					    reflog_head);
-	}
-	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : &null_oid),
-			    oid_to_hex(oid), "1", NULL);
-
-leave_reset_head:
-	strbuf_release(&msg);
-	rollback_lock_file(&lock);
-	while (nr)
-		free((void *)desc[--nr].buffer);
-	return ret;
-}
-
 static int move_to_original_branch(struct rebase_options *opts)
 {
 	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
-- 
2.23.0.897.g0a19638b1e


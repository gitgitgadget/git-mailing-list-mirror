Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A659E20951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbdCNVrW (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:22 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36079 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbdCNVrU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:20 -0400
Received: by mail-pg0-f45.google.com with SMTP id g2so79010659pge.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M6g3E2rDLIsl89HHumSL7mqQyyAEl18XxSklWYHQPPk=;
        b=t98lDTag4ctm3Gd3KOueAGZa2uIj+/sOb8rjflRRCL7l01JgphGySiAiqwm82x0eqa
         2XmHjd68hUIg0E774of2lBibbu3+NM66JxwoQvxczYY9Hp824KxIDwflDqWfEdDh7sod
         NWLLb6QRxojP1aTruKHPGUamKtdHGyALjwMmmyqJoz2JAVGtq8DEEDHF9M/SnflncuBj
         92Wwo4QK31ianWzwP2Jw2NdB1tfdfBJDpuUOBGeP3R7eBQA3jIWuKy33FSDMKuI/FvhO
         kyar0AizmIWzdYrancCasLwDWHVDRE5cCBd60LqUC54NenM5rUekIiV4E8tU5ruf/kp7
         uOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M6g3E2rDLIsl89HHumSL7mqQyyAEl18XxSklWYHQPPk=;
        b=kSG5NaruZmlHZXpKeaYrWvkAcPrRBrYlMI6oObie+Cy1hfLXQA2qoVSIYKO336xKhN
         GRIXWOBkS7kz5iTdxd6zaB2QMkKiy464tkxQfHW5GXfKHzDurk3eabGG8YBbV4cHZjfc
         plruyuNT9xXUNAStibQ7UuwDuIgDUSzwg+1eOl4hW+Z9U/7/ugRpBdsd3vE03AYLDKTx
         4wVaY6Mn3g/foKhhC69lBVc8+mnSnMU0yaprVDrcqJQl476KOGsU6C8qD6HVOWrGsiSQ
         Sd5U/54sx1n3quI6Xl7INbayIzOyMnPG/fC6dZFDcWVb1KMyh3XmE6FrzvSjwi9Mpv5W
         LkgA==
X-Gm-Message-State: AMke39kXbf6dj/LjGx0BTZsgGffhnQoADva6S/5YmxCEDOuM5yyN2lZmLMn4qMvoGCBALjok
X-Received: by 10.84.174.4 with SMTP id q4mr58659171plb.35.1489528028743;
        Tue, 14 Mar 2017 14:47:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id b11sm40325116pfj.27.2017.03.14.14.47.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 16/19] unpack-trees: check if we can perform the operation for submodules
Date:   Tue, 14 Mar 2017 14:46:39 -0700
Message-Id: <20170314214642.7701-17-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll support submodule entries to be
in sync with the tree in working tree changing commands,
such as checkout or read-tree.

When a new submodule entry changes in the tree, we need to
check if there are conflicts (directory/file conflicts)
for the tree. Add this check for submodules to be
performed before the working tree is touched.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 unpack-trees.h |   1 +
 2 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 616a0ae4b2..8333da2cc9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -10,6 +10,8 @@
 #include "attr.h"
 #include "split-index.h"
 #include "dir.h"
+#include "submodule.h"
+#include "submodule-config.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -45,6 +47,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 
 	/* ERROR_WOULD_LOSE_ORPHANED_REMOVED */
 	"Working tree file '%s' would be removed by sparse checkout update.",
+
+	/* ERROR_WOULD_LOSE_SUBMODULE */
+	"Submodule '%s' cannot checkout new HEAD.",
 };
 
 #define ERRORMSG(o,type) \
@@ -161,6 +166,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
 		_("The following working tree files would be removed by sparse checkout update:\n%s");
+	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
+		_("Submodule '%s' cannot checkout new HEAD");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
@@ -240,12 +247,75 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		fprintf(stderr, _("Aborting\n"));
 }
 
+static int check_submodule_move_head(const struct cache_entry *ce,
+				     const char *old_id,
+				     const char *new_id,
+				     struct unpack_trees_options *o)
+{
+	const struct submodule *sub = submodule_from_ce(ce);
+	if (!sub)
+		return 0;
+
+	switch (sub->update_strategy.type) {
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_CHECKOUT:
+		if (submodule_move_head(ce->name, old_id, new_id, SUBMODULE_MOVE_HEAD_DRY_RUN))
+			return o->gently ? -1 :
+				add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
+		return 0;
+	case SM_UPDATE_NONE:
+		return 0;
+	case SM_UPDATE_REBASE:
+	case SM_UPDATE_MERGE:
+	case SM_UPDATE_COMMAND:
+	default:
+		warning(_("submodule update strategy not supported for submodule '%s'"), ce->name);
+		return -1;
+	}
+}
+
+static void reload_gitmodules_file(struct index_state *index,
+				   struct checkout *state)
+{
+	int i;
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
+		if (ce->ce_flags & CE_UPDATE) {
+			int r = strcmp(ce->name, ".gitmodules");
+			if (r < 0)
+				continue;
+			else if (r == 0) {
+				submodule_free();
+				checkout_entry(ce, state, NULL);
+				gitmodules_config();
+				git_config(submodule_config, NULL);
+			} else
+				break;
+		}
+	}
+}
+
 /*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
 static void unlink_entry(const struct cache_entry *ce)
 {
+	const struct submodule *sub = submodule_from_ce(ce);
+	if (sub) {
+		switch (sub->update_strategy.type) {
+		case SM_UPDATE_UNSPECIFIED:
+		case SM_UPDATE_CHECKOUT:
+		case SM_UPDATE_REBASE:
+		case SM_UPDATE_MERGE:
+			submodule_move_head(ce->name, "HEAD", NULL,
+					    SUBMODULE_MOVE_HEAD_FORCE);
+			break;
+		case SM_UPDATE_NONE:
+		case SM_UPDATE_COMMAND:
+			return; /* Do not touch the submodule. */
+		}
+	}
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
@@ -301,6 +371,9 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
+	if (should_update_submodules() && o->update && !o->dry_run)
+		reload_gitmodules_file(index, &state);
+
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -1358,17 +1431,26 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 	if (!lstat(ce->name, &st)) {
 		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
 		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
+
+		if (submodule_from_ce(ce)) {
+			int r = check_submodule_move_head(ce,
+				"HEAD", oid_to_hex(&ce->oid), o);
+			if (r)
+				return o->gently ? -1 :
+					add_rejected_path(o, error_type, ce->name);
+			return 0;
+		}
+
 		if (!changed)
 			return 0;
 		/*
-		 * NEEDSWORK: the current default policy is to allow
-		 * submodule to be out of sync wrt the superproject
-		 * index.  This needs to be tightened later for
-		 * submodules that are marked to be automatically
-		 * checked out.
+		 * Historic default policy was to allow submodule to be out
+		 * of sync wrt the superproject index. If the submodule was
+		 * not considered interesting above, we don't care here.
 		 */
 		if (S_ISGITLINK(ce->ce_mode))
 			return 0;
+
 		errno = 0;
 	}
 	if (errno == ENOENT)
@@ -1412,7 +1494,11 @@ static int verify_clean_submodule(const char *old_sha1,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
-	return 0;
+	if (!submodule_from_ce(ce))
+		return 0;
+
+	return check_submodule_move_head(ce, old_sha1,
+					 oid_to_hex(&ce->oid), o);
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
@@ -1578,9 +1664,15 @@ static int verify_absent_1(const struct cache_entry *ce,
 		path = xmemdupz(ce->name, len);
 		if (lstat(path, &st))
 			ret = error_errno("cannot stat '%s'", path);
-		else
-			ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
-						 &st, error_type, o);
+		else {
+			if (submodule_from_ce(ce))
+				ret = check_submodule_move_head(ce,
+								oid_to_hex(&ce->oid),
+								NULL, o);
+			else
+				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
+							 &st, error_type, o);
+		}
 		free(path);
 		return ret;
 	} else if (lstat(ce->name, &st)) {
@@ -1588,6 +1680,10 @@ static int verify_absent_1(const struct cache_entry *ce,
 			return error_errno("cannot stat '%s'", ce->name);
 		return 0;
 	} else {
+		if (submodule_from_ce(ce))
+			return check_submodule_move_head(ce, oid_to_hex(&ce->oid),
+							 NULL, o);
+
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
 					  error_type, o);
@@ -1643,6 +1739,15 @@ static int merged_entry(const struct cache_entry *ce,
 			return -1;
 		}
 		invalidate_ce_path(merge, o);
+
+		if (submodule_from_ce(ce)) {
+			int ret = check_submodule_move_head(ce, NULL,
+							    oid_to_hex(&ce->oid),
+							    o);
+			if (ret)
+				return ret;
+		}
+
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
 		/*
 		 * See if we can re-use the old CE directly?
@@ -1663,6 +1768,14 @@ static int merged_entry(const struct cache_entry *ce,
 			update |= old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
 			invalidate_ce_path(old, o);
 		}
+
+		if (submodule_from_ce(ce)) {
+			int ret = check_submodule_move_head(ce, oid_to_hex(&old->oid),
+							    oid_to_hex(&ce->oid),
+							    o);
+			if (ret)
+				return ret;
+		}
 	} else {
 		/*
 		 * Previously unmerged entry left as an existence
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6d00..6c48117b84 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -21,6 +21,7 @@ enum unpack_trees_error_types {
 	ERROR_SPARSE_NOT_UPTODATE_FILE,
 	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_ORPHANED_REMOVED,
+	ERROR_WOULD_LOSE_SUBMODULE,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty


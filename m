Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDEFC1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757523AbcLCAbM (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:12 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32989 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbcLCAau (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:50 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so112884022pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pVM1KxAz6WrMbRtvhEJlaYe96+jYG+Efx98DLnHzG6M=;
        b=UWEwNwSpF2MekGZ9eudBj0N8bRDOYMWEORH8hX5f4qqdE4vUpC0566Eumi9Xt5I1Lh
         lEazVu20pEZL2JKGIsn+XB6uU4AVEl+dOAq1Nb690uUwV6SaHA01JKXkQDOATxQkvQak
         b/s2xWqn0BCjQGNhJE9Pw3VqXH5L6LAwIGKtFlXsTU+AZCipjzELj5rAjoLDVLzG/xKc
         CfmCH9937dQKxdJHhACQphdbAUr/bC1Nayok9vIRyzwNowZQAMSZw+CcAG2cFXDLWFB6
         O9gVBIcDb06+cZb7EmNp/XdsYmMtoMAvLCYQz80ceAXSLMoe4l0gcd6+rFBKQeiYicGc
         jNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pVM1KxAz6WrMbRtvhEJlaYe96+jYG+Efx98DLnHzG6M=;
        b=UkkYryApYvhliqO2+jzHZBGw7nNxIydqRCBGF9oVc2Rs6h8JYugBf1k5bmrvwtfN47
         l55z6TS905E0yTXU4flkvC42FU1jd8JU+r7LI0PTCa/p86+sHeJ5HDEKJbMgAjZt00+5
         tjniJWCoKNTKVRCxpKSr+8jlviz17beADk7JzrSY8iRyQV8uBnxJ7H1CJR3TAs3s6baF
         Lm6NQ+rtpyHu0YjWDfwFP6Q8zrmQSORe68u4sHk5Ok4L5nYdbztTeWI0ctuu7tNVpwnk
         oA3UcT2GYEpFqjZfHbHUq63i833us4KRYqOvkZQSd4NjYuLmkJaD3EFGXExmVHdvfKiC
         jzSw==
X-Gm-Message-State: AKaTC00RCq1RZjvLynF/6b1DVSnznAp6/l1Rs76pvXjoUsruPiN6tHbrCcdw/BBsF7CbVeeq
X-Received: by 10.84.141.1 with SMTP id 1mr101343091plu.133.1480725049693;
        Fri, 02 Dec 2016 16:30:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id g82sm10247926pfb.43.2016.12.02.16.30.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 14/17] submodule: teach unpack_trees() to update submodules
Date:   Fri,  2 Dec 2016 16:30:19 -0800
Message-Id: <20161203003022.29797-15-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c        |  7 +++---
 unpack-trees.c | 76 +++++++++++++++++++++++++++++++++++++++++++++-------------
 unpack-trees.h |  1 +
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/entry.c b/entry.c
index a668025b8e..3ed885b886 100644
--- a/entry.c
+++ b/entry.c
@@ -267,7 +267,7 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
-		if (!changed)
+		if (!changed && (!S_ISDIR(st.st_mode) || !S_ISGITLINK(ce->ce_mode)))
 			return 0;
 		if (!state->force) {
 			if (!state->quiet)
@@ -284,9 +284,10 @@ int checkout_entry(struct cache_entry *ce,
 		 * just do the right thing)
 		 */
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
-			if (S_ISGITLINK(ce->ce_mode))
+			if (S_ISGITLINK(ce->ce_mode)) {
+				schedule_submodule_for_update(ce, 1);
 				return 0;
+			}
 			if (!state->force)
 				return error("%s is a directory", path.buf);
 			remove_subtree(&path);
diff --git a/unpack-trees.c b/unpack-trees.c
index db03293347..8b0f6dfd1a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -29,6 +29,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
 
+	/* ERROR_NOT_UPTODATE_SUBMODULE */
+	"Updating submodule '%s' would lose modifications in it",
+
 	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
 	"Untracked working tree file '%s' would be overwritten by merge.",
 
@@ -81,6 +84,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in it:\n%s");
 
+	msgs[ERROR_NOT_UPTODATE_SUBMODULE] =
+		_("Updating the following submodules would lose modifications in them:\n%s");
+
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
@@ -1320,19 +1326,17 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
-		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
-		if (!changed)
-			return 0;
-		/*
-		 * NEEDSWORK: the current default policy is to allow
-		 * submodule to be out of sync wrt the superproject
-		 * index.  This needs to be tightened later for
-		 * submodules that are marked to be automatically
-		 * checked out.
-		 */
-		if (S_ISGITLINK(ce->ce_mode))
-			return 0;
+		if (S_ISGITLINK(ce->ce_mode)) {
+			if (!submodule_is_interesting(ce->name))
+				return 0;
+			if (ce_stage(ce) ? is_submodule_checkout_safe(ce->name, &ce->oid)
+			    : !is_submodule_modified(ce->name, 1))
+				return 0;
+		} else {
+			int flags = CE_MATCH_IGNORE_VALID | CE_MATCH_IGNORE_SKIP_WORKTREE;
+			if (!ie_match_stat(o->src_index, ce, &st, flags))
+				return 0;
+		}
 		errno = 0;
 	}
 	if (errno == ENOENT)
@@ -1355,6 +1359,38 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }
 
+/*
+ * When a submodule gets turned into an unmerged entry, we want it to be
+ * up-to-date regarding the merge changes.
+ */
+static int verify_uptodate_submodule(const struct cache_entry *old,
+				     const struct cache_entry *new,
+				     struct unpack_trees_options *o)
+{
+	struct stat st;
+
+	if (o->index_only ||
+	    (!((old->ce_flags & CE_VALID) || ce_skip_worktree(old)) &&
+	      (o->reset || ce_uptodate(old))))
+		return 0;
+
+	if (!submodule_is_interesting(new->name))
+		return 0;
+
+	if (lstat(old->name, &st)) {
+		if (errno == ENOENT)
+			return 0;
+		return o->gently ? -1 :
+			add_rejected_path(o, ERROR_NOT_UPTODATE_SUBMODULE,
+					  old->name);
+	}
+
+	if (S_ISGITLINK(new->ce_mode))
+		return !is_submodule_checkout_safe(new->name, &new->oid);
+	else
+		return !ok_to_remove_submodule(old->name);
+}
+
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
@@ -1616,9 +1652,17 @@ static int merged_entry(const struct cache_entry *ce,
 			copy_cache_entry(merge, old);
 			update = 0;
 		} else {
-			if (verify_uptodate(old, o)) {
-				free(merge);
-				return -1;
+			if (S_ISGITLINK(old->ce_mode) ||
+			    S_ISGITLINK(merge->ce_mode)) {
+				if (verify_uptodate_submodule(old, merge, o)) {
+					free(merge);
+					return -1;
+				}
+			} else {
+				if (verify_uptodate(old, o)) {
+					free(merge);
+					return -1;
+				}
 			}
 			/* Migrate old flags over */
 			update |= old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
diff --git a/unpack-trees.h b/unpack-trees.h
index 36a73a6d00..bee874088a 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -15,6 +15,7 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
 	ERROR_NOT_UPTODATE_DIR,
+	ERROR_NOT_UPTODATE_SUBMODULE,
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
-- 
2.11.0.rc2.28.g2673dad


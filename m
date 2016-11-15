Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BF22042F
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030200AbcKOXHU (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:07:20 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33523 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935117AbcKOXHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:07:16 -0500
Received: by mail-pf0-f174.google.com with SMTP id d2so38574593pfd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RKZhQoZP026fko2Vtuql0KQFj8Qrb2dItiAR6XshyFg=;
        b=l4GQ/ydgerR/pGS+W+nYD05si90J4wdF/G8rWmu1iVcz5CkRm2+xZPT8QVKoJeS9re
         gIaIXeNDBDv8nuJNhI0s/4tTNrw8G7lvmKTPs7nylosFPJrGZ926dLxQo/24JavqWT+Z
         xaBusX+esKXqH6CDvZz9lDoQFVvTl5pfySk9Uo49KsLLigObUEHAt20Eukbb1AIGDC6J
         lfoNWfTsWAA1nr8c5WxcnxYJddU/jEhy9NjzMZzE4WhziDSvVOzzPo52T8sm2fqpu9BJ
         8u+Ws5i4UqXYftiGwUtTSN/2BNBwa8nyIpmFYLWPOPQIJ7nAAuQpqzLLPG0NJjr/B940
         s7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RKZhQoZP026fko2Vtuql0KQFj8Qrb2dItiAR6XshyFg=;
        b=nExfxRPqj6glBvJfyY+HaF1o2pzw1fG4GePR69lMGgrgH+d1q9Pf366YKKTzRvZDdV
         CYmwgUUC3sa438RhcgaSdTzCmKiObMV6VV4J20032inFg97UogRPNE4qMpLB45R+8G7f
         R+e3zIIfEmXQUcRrjyXqMxavBtRzLcfzEbWykujoukyVhAY0C0TS0LFWDcINwO+N6wLf
         BQmLkOtSbnIGQ96WkiWdePYHs9NviU3LVvegy60MIU5D5Q2fziJuekA9lOJCFIOz/k1E
         0XZgv2zlCrzG5o75p9wAkDye1/hDuYTlB0SKv2l9/HZc0yhIxoi7dr5p0HSBa5cuVsKH
         OC2g==
X-Gm-Message-State: ABUngvdXHDkItC75nmjNevEHcWMiyPUHG87iZ2W5RZwVQ/0Gw2CrNWG9HnLGJS+2H+BvI0mw
X-Received: by 10.99.129.200 with SMTP id t191mr1127260pgd.180.1479251229682;
        Tue, 15 Nov 2016 15:07:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id x90sm46296227pfk.73.2016.11.15.15.07.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/16] submodule: teach unpack_trees() to update submodules
Date:   Tue, 15 Nov 2016 15:06:48 -0800
Message-Id: <20161115230651.23953-14-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c        |  7 +++--
 unpack-trees.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 unpack-trees.h |  1 +
 3 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/entry.c b/entry.c
index 2330b6e..dd829ec 100644
--- a/entry.c
+++ b/entry.c
@@ -270,7 +270,7 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
-		if (!changed)
+		if (!changed && (!S_ISDIR(st.st_mode) || !S_ISGITLINK(ce->ce_mode)))
 			return 0;
 		if (!state->force) {
 			if (!state->quiet)
@@ -287,9 +287,10 @@ int checkout_entry(struct cache_entry *ce,
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
index 576e1d5..c5c22ed 100644
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
 
@@ -80,6 +83,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in it:\n%s");
+	msgs[ERROR_NOT_UPTODATE_SUBMODULE] =
+		_("Updating the following submodules would lose modifications in it:\n%s");
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_commit_before_merge
@@ -1315,19 +1320,18 @@ static int verify_uptodate_1(const struct cache_entry *ce,
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
+		if (!S_ISGITLINK(ce->ce_mode)) {
+			int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
+			unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
+			if (!changed)
+				return 0;
+		} else {
+			if (!submodule_is_interesting(ce->name, null_sha1))
+				return 0;
+			if (ce_stage(ce) ? is_submodule_checkout_safe(ce->name, &ce->oid)
+			    : !is_submodule_modified(ce->name, 1))
+				return 0;
+		}
 		errno = 0;
 	}
 	if (errno == ENOENT)
@@ -1350,6 +1354,59 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
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
+	if (o->index_only
+	    || (!((old->ce_flags & CE_VALID) || ce_skip_worktree(old))
+		&& (o->reset || ce_uptodate(old))))
+		return 0;
+	if (!submodule_is_interesting(new->name, null_sha1))
+		return 0;
+	if (!lstat(old->name, &st)) {
+		unsigned changed = ie_match_stat(o->src_index, old, &st,
+						 CE_MATCH_IGNORE_VALID|
+						 CE_MATCH_IGNORE_SKIP_WORKTREE);
+		if (!changed) {
+			/* old is always a submodule */
+			if (S_ISGITLINK(new->ce_mode)) {
+				/*
+				 * new is also a submodule, so check if we care
+				 * and then if can checkout the new sha1 safely
+				 */
+				if (submodule_is_interesting(old->name, null_sha1)
+				    && is_submodule_checkout_safe(new->name, &new->oid))
+					return 0;
+			} else {
+				/*
+				 * new is not a submodule any more, so only
+				 * care if we care:
+				 */
+				if (submodule_is_interesting(old->name, null_sha1)
+				    && ok_to_remove_submodule(old->name))
+					return 0;
+			}
+		} else {
+			if (S_ISGITLINK(new->ce_mode))
+				return !is_submodule_checkout_safe(new->name, &new->oid);
+			else
+				return !ok_to_remove_submodule(old->name);
+		}
+		errno = 0;
+	}
+	if (errno == ENOENT)
+		return 0;
+	return o->gently ? -1 :
+		add_rejected_path(o, ERROR_NOT_UPTODATE_SUBMODULE, old->name);
+}
+
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
@@ -1608,9 +1665,17 @@ static int merged_entry(const struct cache_entry *ce,
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
index 36a73a6..bee8740 100644
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
2.10.1.469.g00a8914


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F5E1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755931AbdAFVDl (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:03:41 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35684 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdAFVDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:03:34 -0500
Received: by mail-pg0-f41.google.com with SMTP id i5so190559405pgh.2
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e6zQgKQQzdd+ZEC+uv6WIr/p+AiIJ/sqFf0BiBz7Fik=;
        b=nQDkabuvsOBG2Lte/uatnkiPf43F1/CGMPbyg4jnMLsegW94EkMW3ovsBoHIXxkwuS
         AzU/pSyVJIyyk6s+n9fxPhgkJQgEpFzc/Azb/3byDoeVmiPlhawOnu/W8V5FT5tylEzk
         3iyjCiUo+3xOSdG5THcHrw/Dgv8kcDkIADn3VGHe2w4VX3cH6UCEV6BnvVy8tFyEN3DP
         A7y+F+msw2SaNVDQwhDykHqDw0gHzA3V2A+e4f7ztoU/iWjvphEShE4RmA75LFUyEfGP
         nifvUKQhVA3xU9UaB2dBxIiwHr+HpWjqiQMRdzqpWJYuQpsBZcojOE9iSE8v1jqLFEsB
         a4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6zQgKQQzdd+ZEC+uv6WIr/p+AiIJ/sqFf0BiBz7Fik=;
        b=FZebkHVcbDX41jRaBxsn4oD08y6UW0Xnngr8DyZ95p5TeVi1YBvAAgYnRGfaz0QixO
         067cU7O/zQlrSYLqshU0eZTxTTVLxNZFMJnYLQf7xP9IkA4nKTF3amyzQkaFvx1pza70
         SYsjL0u8sqhsXFDK8UDHa6rPZErXnzP38BOvzGGc930cFKiTk9nQDTKFsrJCYZXGsFNR
         nOXMLMWpKke51y1Kv7TVt27W4uXbDEFUlrsHX4BwXw7qaeYRwGdFB6lNTSao0FBsXzVV
         x4DhPFUQC+0nf6nPvxNCPosrsItabS6oPforWsWzryCREARWLBFYIctKQNtNlsdBGR0Z
         iXBQ==
X-Gm-Message-State: AIkVDXL8EfK0/tA1aWwWjXAnhijBgPGNF0q7jBFkuCOvgFj0mJyGbujYrzAVDDB+ce2ceq6g
X-Received: by 10.84.217.199 with SMTP id d7mr171303341plj.165.1483736613971;
        Fri, 06 Jan 2017 13:03:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:b5c6:5d9b:cb8b:89ed])
        by smtp.gmail.com with ESMTPSA id e127sm4341552pfh.89.2017.01.06.13.03.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Jan 2017 13:03:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/5] unpack-trees: move checkout state into check_updates
Date:   Fri,  6 Jan 2017 13:03:26 -0800
Message-Id: <20170106210330.31761-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.31.g919a8d0.dirty
In-Reply-To: <20170106210330.31761-1-sbeller@google.com>
References: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
 <20170106210330.31761-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checkout state was introduced via 16da134b1f9
(read-trees: refactor the unpack_trees() part, 2006-07-30). An attempt to
refactor the checkout state was done in b56aa5b268e (unpack-trees: pass
checkout state explicitly to check_updates(), 2016-09-13), but we can
go even further.

The `struct checkout state` is not used in unpack_trees apart from
initializing it, so move it into the function that makes use of it,
which is `check_updates`.

Reviewed-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index bc56195e27..55c75b4d6a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -237,77 +237,82 @@ static void display_error_msgs(struct unpack_trees_options *o)
 }
 
 /*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
 static void unlink_entry(const struct cache_entry *ce)
 {
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
 		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-static int check_updates(struct unpack_trees_options *o,
-			 const struct checkout *state)
+static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
+	int i, errs = 0;
+
 	struct progress *progress = NULL;
 	struct index_state *index = &o->result;
-	int i;
-	int errs = 0;
+	struct checkout state = CHECKOUT_INIT;
+
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+	state.istate = index;
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
 			const struct cache_entry *ce = index->cache[cnt];
 			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
 				total++;
 		}
 
 		progress = start_progress_delay(_("Checking out files"),
 						total, 50, 1);
 		cnt = 0;
 	}
 
 	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
+		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
 	for (i = 0; i < index->cache_nr; i++) {
 		const struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update && !o->dry_run)
 				unlink_entry(ce);
 			continue;
 		}
 	}
-	remove_marked_cache_entries(&o->result);
+	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
 			if (ce->ce_flags & CE_WT_REMOVE)
 				die("BUG: both update and delete flags are set on %s",
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, state, NULL);
+				errs |= checkout_entry(ce, &state, NULL);
 			}
 		}
 	}
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
 	return errs != 0;
 }
 
 static int verify_uptodate_sparse(const struct cache_entry *ce,
 				  struct unpack_trees_options *o);
 static int verify_absent_sparse(const struct cache_entry *ce,
 				enum unpack_trees_error_types,
 				struct unpack_trees_options *o);
 
@@ -1113,38 +1118,33 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 
 static int verify_absent(const struct cache_entry *,
 			 enum unpack_trees_error_types,
 			 struct unpack_trees_options *);
 /*
  * N-way merge "len" trees.  Returns 0 on success, -1 on failure to manipulate the
  * resulting index, -2 on failure to reflect the changes to the work tree.
  *
  * CE_ADDED, CE_UNPACKED and CE_NEW_SKIP_WORKTREE are used internally
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
-	struct checkout state = CHECKOUT_INIT;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
-	state.force = 1;
-	state.quiet = 1;
-	state.refresh_cache = 1;
-	state.istate = &o->result;
 
 	memset(&el, 0, sizeof(el));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		char *sparse = git_pathdup("info/sparse-checkout");
 		if (add_excludes_from_file_to_list(sparse, "", 0, &el, 0) < 0)
 			o->skip_sparse_checkout = 1;
 		else
 			o->el = &el;
 		free(sparse);
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized = 1;
@@ -1257,31 +1257,31 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		if (ret < 0)
 			goto return_failed;
 		/*
 		 * Sparse checkout is meant to narrow down checkout area
 		 * but it does not make sense to narrow down to empty working
 		 * tree. This is usually a mistake in sparse checkout rules.
 		 * Do not allow users to do that.
 		 */
 		if (o->result.cache_nr && empty_worktree) {
 			ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
 			goto done;
 		}
 	}
 
 	o->src_index = NULL;
-	ret = check_updates(o, &state) ? (-2) : 0;
+	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
 		if (!ret) {
 			if (!o->result.cache_tree)
 				o->result.cache_tree = cache_tree();
 			if (!cache_tree_fully_valid(o->result.cache_tree))
 				cache_tree_update(&o->result,
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
 		discard_index(&o->result);
 	}
 
-- 
2.11.0.31.g919a8d0.dirty


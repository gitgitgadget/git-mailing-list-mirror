Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2671F404
	for <e@80x24.org>; Tue, 14 Aug 2018 17:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbeHNUR0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:17:26 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39807 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388318AbeHNURZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:17:25 -0400
Received: by mail-yw1-f74.google.com with SMTP id u1-v6so26989896ywg.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KMZH6kK1HqvtvqtnxhgtpV0A3qlkxZokROdq3GuOWOc=;
        b=o10unfxFIIib3S/HaWX+KlDXc6kZPfJDINCSJ8tGxfICEpB5jbHrsM1q0p6edhCCm4
         VXxbNr0FH8IzmbWgM/PI4wRE/LllUt23gu650bt/lEu5rM6tNnIzdZCUyLQgl1kSLfpP
         cROkyiIyLRuXX3DC6t/4I7EaRW0R+ldY/j0vgPrx9syoZPgS+JgHJXS3fUleI7QwrYJA
         cKbKLosmHSLjr+bcZ/0/yix1rVC0cotmNLHT9FlDbImSHRdB0L4FVN88BaEicHD0oZUT
         aR0XT97O91DnW/RyVDK6ZG0dN2gkKlHrt9ysFnPZbBQmcJNbva9ndswqktZ9MY8eszKE
         G5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KMZH6kK1HqvtvqtnxhgtpV0A3qlkxZokROdq3GuOWOc=;
        b=UMjQKDiEQbCWxvIZ1llT8RsmY7Q/oastMPfOe+aPa93rgV8XQbF8qTqOG2tNvHAjmx
         7fibxDE4rGlP6zoNgwgME9CFiUgw73SblrlNfdlsxWuds5r4OG0cKdcsS8ZULKNBfA8b
         aUBUk5H1T/SDZERcVpmcpZ28g/j/5E42P+FS08jFO355WDGWeST3x5u0dxfzW11CI+1W
         KGCy8eQBi28nhGuwwqQXDl/Lf3uV16OWMdvRctNGkXTyPSrYOqX1I7isP9f9Tt1s3v47
         HONJ/bQt7+7hWQbG6fdmc2Po7cje2pFTK43M9+/wlmS3+1k4Cp7kHymnzl04JVp2IYuW
         WGYw==
X-Gm-Message-State: AOUpUlEpgoiDqtjGniv8D+/m6CI00iQ8/V9xANMwWQzS7A1mBgHhhDZZ
        qs9p8OoqcFwmBBoUBhJo8z6BldLOz30XUFrlsFn2khQs6/tNuF11sSahjWp2nVwIO1tIje6Uu2T
        8xRAcj87EBe9FqAAd7XXjakOITcZOIXsHoRHLBQuXjD8+2wg9Nm6VaWQDhGY=
X-Google-Smtp-Source: AA+uWPwJ/YL6dMUv76hs1ZY+G8Ac7MmlRwU0As5bTpYVR4K5f2P61qycAiZB/KrFDvyEKWGK0+flSmhXMZEW
X-Received: by 2002:a25:d454:: with SMTP id m81-v6mr3831364ybf.64.1534267757479;
 Tue, 14 Aug 2018 10:29:17 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:28:11 -0700
In-Reply-To: <cover.1534267611.git.matvore@google.com>
Message-Id: <e01e202cb0445b72dc52a1c8763dbd9c737fb86e.1534267611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534267611.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v4 4/6] rev-list: handle missing tree objects properly
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we assumed only blob objects could be missing. This patch
makes rev-list handle missing trees like missing blobs. A missing tree
will cause an error if --missing indicates an error should be caused,
and the hash is printed even if the tree is missing.

In list-objects.c we no longer print a message to stderr if a tree
object is missing (quiet_on_missing is always true). I couldn't find
any place where this would matter, or where the caller of
traverse_commit_list would need to be fixed to show the error. However,
in the future it would be trivial to make the caller show the message if
we needed to.

This is not tested very thoroughly, since we cannot create promisor
objects in tests without using an actual partial clone. t0410 has a
promise_and_delete utility function, but the is_promisor_object function
does not return 1 for objects deleted in this way. More tests will will
come in a patch that implements a filter that can be used with git
clone.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/rev-list.c                     | 11 +++--
 list-objects.c                         | 17 +++++--
 revision.h                             |  1 +
 t/t0410-partial-clone.sh               | 66 ++++++++++++++++++++++++++
 t/t5317-pack-objects-filter-objects.sh | 13 +++++
 5 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5b07f3f4a..49d6deed7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "object.h"
 #include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
@@ -209,7 +210,8 @@ static inline void finish_object__ma(struct object *obj)
 	 */
 	switch (arg_missing_action) {
 	case MA_ERROR:
-		die("missing blob object '%s'", oid_to_hex(&obj->oid));
+		die("missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
 		return;
 
 	case MA_ALLOW_ANY:
@@ -222,8 +224,8 @@ static inline void finish_object__ma(struct object *obj)
 	case MA_ALLOW_PROMISOR:
 		if (is_promisor_object(&obj->oid))
 			return;
-		die("unexpected missing blob object '%s'",
-		    oid_to_hex(&obj->oid));
+		die("unexpected missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
 		return;
 
 	default:
@@ -235,7 +237,7 @@ static inline void finish_object__ma(struct object *obj)
 static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+	if (!has_object_file(&obj->oid)) {
 		finish_object__ma(obj);
 		return 1;
 	}
@@ -373,6 +375,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+	revs.do_not_die_on_missing_tree = 1;
 
 	/*
 	 * Scan the argument list before invoking setup_revisions(), so that we
diff --git a/list-objects.c b/list-objects.c
index f9b51db7a..e88474a2d 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -143,6 +143,7 @@ static void process_tree(struct traversal_context *ctx,
 	struct rev_info *revs = ctx->revs;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
+	int parsed;
 
 	if (!revs->tree_objects)
 		return;
@@ -150,7 +151,9 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, 1) < 0) {
+
+	parsed = parse_tree_gently(tree, 1) >= 0;
+	if (!parsed) {
 		if (revs->ignore_missing_links)
 			return;
 
@@ -163,7 +166,8 @@ static void process_tree(struct traversal_context *ctx,
 		    is_promisor_object(&obj->oid))
 			return;
 
-		die("bad tree object %s", oid_to_hex(&obj->oid));
+		if (!revs->do_not_die_on_missing_tree)
+			die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
 	strbuf_addstr(base, name);
@@ -178,7 +182,14 @@ static void process_tree(struct traversal_context *ctx,
 	if (base->len)
 		strbuf_addch(base, '/');
 
-	process_tree_contents(ctx, tree, base);
+	/*
+	 * NEEDSWORK: we should not have to process this tree's contents if the
+	 * filter wants to exclude all its contents AND the filter doesn't need
+	 * to collect the omitted OIDs. We should add a LOFR_SKIP_TREE bit which
+	 * allows skipping all children.
+	 */
+	if (parsed)
+		process_tree_contents(ctx, tree, base);
 
 	if (!(obj->flags & USER_GIVEN) && ctx->filter_fn) {
 		r = ctx->filter_fn(LOFS_END_TREE, obj,
diff --git a/revision.h b/revision.h
index c599c34da..c94243543 100644
--- a/revision.h
+++ b/revision.h
@@ -124,6 +124,7 @@ struct rev_info {
 			first_parent_only:1,
 			line_level_traverse:1,
 			tree_blobs_in_commit_order:1,
+			do_not_die_on_missing_tree:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4984ca583..74e3c5767 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -186,6 +186,72 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	! grep $FOO out
 '
 
+test_expect_success 'show missing tree objects with --missing=print' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+	test_commit -C repo baz &&
+
+	TREE=$(git -C repo rev-parse bar^{tree}) &&
+
+	promise_and_delete $TREE &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo rev-list --quiet --missing=print --objects HEAD >missing_objs 2>rev_list_err &&
+	echo "?$TREE" >expected &&
+	test_cmp expected missing_objs &&
+
+	# do not complain when a missing tree cannot be parsed
+	! grep -q "Could not read " rev_list_err
+'
+
+test_expect_success 'missing tree objects with --missing=allow-any and --exclude-promisor-objects' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+	test_commit -C repo baz &&
+
+	promise_and_delete $(git -C repo rev-parse bar^{tree}) &&
+	promise_and_delete $(git -C repo rev-parse foo^{tree}) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo rev-list --missing=allow-any --objects HEAD >objs 2>rev_list_err &&
+	test_line_count = 0 rev_list_err &&
+	# 3 commits, 3 blobs, and 1 tree
+	test_line_count = 7 objs &&
+
+	# Do the same for --exclude-promisor-objects, but with all trees gone.
+	promise_and_delete $(git -C repo rev-parse baz^{tree}) &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >objs 2>rev_list_err &&
+	test_line_count = 0 rev_list_err &&
+	# 3 commits, no blobs or trees
+	test_line_count = 3 objs
+'
+
+test_expect_success 'missing non-root tree object and rev-list' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	mkdir repo/dir &&
+	echo foo > repo/dir/foo &&
+	git -C repo add dir/foo &&
+	git -C repo commit -m "commit dir/foo" &&
+
+	promise_and_delete $(git -C repo rev-parse HEAD:dir) &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	git -C repo rev-list --missing=allow-any --objects HEAD >objs 2>rev_list_err &&
+	test_line_count = 0 rev_list_err &&
+	# 1 commit and 1 tree
+	test_line_count = 2 objs
+'
+
 test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	rm -rf repo &&
 	test_create_repo repo &&
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 6710c8bc8..5e35f33bf 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -59,6 +59,19 @@ test_expect_success 'verify normal and blob:none packfiles have same commits/tre
 	test_cmp observed expected
 '
 
+test_expect_success 'get an error for missing tree object' '
+	git init r5 &&
+	echo foo > r5/foo &&
+	git -C r5 add foo &&
+	git -C r5 commit -m "foo" &&
+	del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
+	rm r5/.git/objects/$del &&
+	test_must_fail git -C r5 pack-objects --rev --stdout 2>bad_tree <<-EOF &&
+	HEAD
+	EOF
+	grep -q "bad tree object" bad_tree
+'
+
 # Test blob:limit=<n>[kmg] filter.
 # We boundary test around the size parameter.  The filter is strictly less than
 # the value, so size 500 and 1000 should have the same results, but 1001 should
-- 
2.18.0.865.gffc8e1a3cd6-goog


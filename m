Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19FA720281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbdI2UM1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:27 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:54270 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdI2UMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:19 -0400
Received: by mail-pg0-f46.google.com with SMTP id j70so344999pgc.10
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bzqmHWmAF4VgUS0UDSbpc3ql/6EjLa0SzfMUkXVNfZc=;
        b=YoUZ5l86DB2g1b9KsbydkFxJZRgdwoXJGmLeV+jAitlQiSg1n1pcAREwQ5A3dOnifr
         N4JDczYoifV54oaX6d/1kFZN7qmCM2QBwqsJZOgbS7jTUeKrdSBifnwdNR0JUR9Ja5RJ
         ICgqNwhyKAT0lOEfM83qrG5DdPBQADTEOBdZ8AvnIjqkyMtcmAMeZXxl3ZmUk3n74B4Q
         BOHIGPxr7UtAJ5sELuCA9msGU+9q280RSGSjRBtNw43JUtbOsnn81GxMkohvKcQEhgT4
         kkdyLFOzc6D6/IC1GZKekfPf/GfB7ieowNNwmQtRdz2rbXw20sD6t6WGXUbNdK8rAxJd
         9Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bzqmHWmAF4VgUS0UDSbpc3ql/6EjLa0SzfMUkXVNfZc=;
        b=k9uemiEEFKGSpMjBtmWbd5aGRfJegWVRpaHpWo2iAXiAFExmOj8sF4Dxj/yNok3UZ9
         XQzzxF8bWcX4p8RmitgPTHiIygtxMZQ07pvYRkt5VQeFjjwLYYwGHCh3DwUOUJWJLI6C
         jPckpvwUcKcTyPpQvm0UVkt2CoXgoGleWNKxPdPQi3+4HkSuTOocQUmF9tUhg6oU2IjN
         ep7YrzRtOkk8c5k1imKb4ASar0Dd6eqC/kdiC2A8biv/6uTfqXKUs1H2AKDCmWaxBiU6
         W1QRiM2h/sNsNHoifWlAhheoYlIik1wGp/DdNs/9kTbbr5h5KbtG0wuYTzIBtdpoXt+8
         nFaA==
X-Gm-Message-State: AHPjjUgqAOlhbanBqM9QYatNpIo2C6/FG3Vx7ga/fqpgrNuohSHAF0e5
        8kQxceYaDqvgvmWPFRUO/ebhV3uBWc0=
X-Google-Smtp-Source: AOwi7QDiNoJKzuwOR8C99mdzQ2TEgSzadlzS2cDUURz6WCi05wqQFq46Y6CFG+jTUEEkF3JtajZifg==
X-Received: by 10.98.157.73 with SMTP id i70mr8808841pfd.268.1506715938191;
        Fri, 29 Sep 2017 13:12:18 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:16 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 08/18] rev-list: support termination at promisor objects
Date:   Fri, 29 Sep 2017 13:11:44 -0700
Message-Id: <bfad85445506615386ca49c2129bc27c4156c568.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach rev-list to support termination of an object traversal at any
object from a promisor remote (whether one that the local repo also has,
or one that the local repo knows about because it has another promisor
object that references it).

This will be used subsequently in gc and in the connectivity check used
by fetch.

For efficiency, if an object is referenced by a promisor object, and is
in the local repo only as a non-promisor object, object traversal will
not stop there. This is to avoid building the list of promisor object
references.

(In list-objects.c, the case where obj is NULL in process_blob() and
process_tree() do not need to be changed because those happen only when
there is a conflict between the expected type and the existing object.
If the object doesn't exist, an object will be synthesized, which is
fine.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/rev-list.c       |  13 ++++++
 list-objects.c           |  16 +++++++-
 object.c                 |   2 +-
 revision.c               |  33 +++++++++++++++-
 revision.h               |   5 ++-
 t/t0410-partial-clone.sh | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 165 insertions(+), 5 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c1c74d4a7..bba800cb9 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -12,6 +12,7 @@
 #include "bisect.h"
 #include "progress.h"
 #include "reflog-walk.h"
+#include "packfile.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -287,6 +288,18 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+
+	/*
+	 * Scan the argument list before invoking setup_revisions(), so that we
+	 * know if fetch_if_missing needs to be set to 0.
+	 */
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--exclude-promisor-objects")) {
+			fetch_if_missing = 0;
+			break;
+		}
+	}
+
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	memset(&info, 0, sizeof(info));
diff --git a/list-objects.c b/list-objects.c
index b3931fa43..8a98192dd 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "packfile.h"
 
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
@@ -24,6 +25,13 @@ static void process_blob(struct rev_info *revs,
 		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+	if (!has_object_file(&obj->oid)) {
+		if (revs->exclude_promisor_objects &&
+		    is_promisor_object(&obj->oid)) {
+			return;
+		}
+		/* error message will be reported later */
+	}
 	obj->flags |= SEEN;
 
 	pathlen = path->len;
@@ -77,6 +85,8 @@ static void process_tree(struct rev_info *revs,
 	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
+	int gently = revs->ignore_missing_links ||
+		     revs->exclude_promisor_objects;
 
 	if (!revs->tree_objects)
 		return;
@@ -84,9 +94,13 @@ static void process_tree(struct rev_info *revs,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, revs->ignore_missing_links) < 0) {
+	if (parse_tree_gently(tree, gently) < 0) {
 		if (revs->ignore_missing_links)
 			return;
+		if (revs->exclude_promisor_objects &&
+		    is_promisor_object(&obj->oid)) {
+			return;
+		}
 		die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
diff --git a/object.c b/object.c
index 321d7e920..0f2490145 100644
--- a/object.c
+++ b/object.c
@@ -252,7 +252,7 @@ struct object *parse_object(const struct object_id *oid)
 	if (obj && obj->parsed)
 		return obj;
 
-	if ((obj && obj->type == OBJ_BLOB) ||
+	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
 	     sha1_object_info(oid->hash, NULL) == OBJ_BLOB)) {
 		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
diff --git a/revision.c b/revision.c
index f9a90d71d..f92d03bfe 100644
--- a/revision.c
+++ b/revision.c
@@ -197,6 +197,8 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
+		if (revs->exclude_promisor_objects && is_promisor_object(oid))
+			return NULL;
 		die("bad object %s", name);
 	}
 	object->flags |= flags;
@@ -789,9 +791,17 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
-
-		if (parse_commit_gently(p, revs->ignore_missing_links) < 0)
+		int gently = revs->ignore_missing_links ||
+			     revs->exclude_promisor_objects;
+		if (parse_commit_gently(p, gently) < 0) {
+			if (revs->exclude_promisor_objects &&
+			    is_promisor_object(&p->object.oid)) {
+				if (revs->first_parent_only)
+					break;
+				continue;
+			}
 			return -1;
+		}
 		if (revs->show_source && !p->util)
 			p->util = commit->util;
 		p->object.flags |= left_flag;
@@ -2103,6 +2113,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
+	} else if (!strcmp(arg, "--exclude-promisor-objects")) {
+		if (fetch_if_missing)
+			die("BUG: exclude_promisor_objects can only be used when fetch_if_missing is 0");
+		revs->exclude_promisor_objects = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
@@ -2848,6 +2862,16 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN);
 }
 
+static int mark_uninteresting(const struct object_id *oid,
+			      struct packed_git *pack,
+			      uint32_t pos,
+			      void *unused)
+{
+	struct object *o = parse_object(oid);
+	o->flags |= UNINTERESTING | SEEN;
+	return 0;
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -2876,6 +2900,11 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
+	if (revs->exclude_promisor_objects) {
+		for_each_packed_object(mark_uninteresting, NULL,
+				       FOR_EACH_OBJECT_PROMISOR_ONLY);
+	}
+
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
diff --git a/revision.h b/revision.h
index 3a3d3e2cf..341711ab7 100644
--- a/revision.h
+++ b/revision.h
@@ -121,7 +121,10 @@ struct rev_info {
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1,
-			line_level_traverse:1;
+			line_level_traverse:1,
+
+			/* for internal use only */
+			exclude_promisor_objects:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 8a90f6ab3..3ca6af5cd 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -160,6 +160,107 @@ test_expect_success 'fetching of missing objects' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
+test_expect_success 'rev-list stops traversal at missing and promised commit' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+
+	FOO=$(git -C repo rev-parse foo) &&
+	promise_and_delete "$FOO" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
+	grep $(git -C repo rev-parse bar) out &&
+	! grep $FOO out
+'
+
+test_expect_success 'rev-list stops traversal at missing and promised tree' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	mkdir repo/a_dir &&
+	echo something >repo/a_dir/something &&
+	git -C repo add a_dir/something &&
+	git -C repo commit -m bar &&
+
+	# foo^{tree} (tree referenced from commit)
+	TREE=$(git -C repo rev-parse foo^{tree}) &&
+
+	# a tree referenced by HEAD^{tree} (tree referenced from tree)
+	TREE2=$(git -C repo ls-tree HEAD^{tree} | grep " tree " | head -1 | cut -b13-52) &&
+
+	promise_and_delete "$TREE" &&
+	promise_and_delete "$TREE2" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	grep $(git -C repo rev-parse foo) out &&
+	! grep $TREE out &&
+	grep $(git -C repo rev-parse HEAD) out &&
+	! grep $TREE2 out
+'
+
+test_expect_success 'rev-list stops traversal at missing and promised blob' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	echo something >repo/something &&
+	git -C repo add something &&
+	git -C repo commit -m foo &&
+
+	BLOB=$(git -C repo hash-object -w something) &&
+	promise_and_delete "$BLOB" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	grep $(git -C repo rev-parse HEAD) out &&
+	! grep $BLOB out
+'
+
+test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+	test_commit -C repo baz &&
+
+	COMMIT=$(git -C repo rev-parse foo) &&
+	TREE=$(git -C repo rev-parse bar^{tree}) &&
+	BLOB=$(git hash-object repo/baz.t) &&
+	printf "%s\n%s\n%s\n" $COMMIT $TREE $BLOB | pack_as_from_promisor &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
+	! grep $COMMIT out &&
+	! grep $TREE out &&
+	! grep $BLOB out &&
+	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
+'
+
+test_expect_success 'rev-list accepts missing and promised objects on command line' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+	test_commit -C repo baz &&
+
+	COMMIT=$(git -C repo rev-parse foo) &&
+	TREE=$(git -C repo rev-parse bar^{tree}) &&
+	BLOB=$(git hash-object repo/baz.t) &&
+
+	promise_and_delete $COMMIT &&
+	promise_and_delete $TREE &&
+	promise_and_delete $BLOB &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
+'
+
 LIB_HTTPD_PORT=12345  # default port, 410, cannot be used as non-root
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
-- 
2.14.2.822.g60be5d43e6-goog


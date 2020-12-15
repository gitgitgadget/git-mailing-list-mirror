Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0593FC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 20:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB96822B47
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 20:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgLOUCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 15:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLOUCu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 15:02:50 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFE8C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 12:02:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mz17so205579pjb.5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=QB/HGASPbuZ1nypVVYPF8eg6ROTcwwRrcp9SYQMiSt0=;
        b=H9aAhpGZfwl7SyXRoursPHeYR0Vt5SFqJ7jO4sqlwk43e5/suxRjxYuyosuV3NvC6V
         ge1PQDfmGYQfmo5oEWp9G7U7O/88HLgfsn5ahWRVst4pO0meBKhuFsfxGbY4tkaJLKT4
         NxNKxr3/iMcW6Lldco8HKFKaPIGwQF7l1KIOjMg3JYFIrnnUwN5FwHB6hQQI/Noolqje
         /1hXIJSHAPGMgwcs14e0UEGEFqc8jiNQKoWMT2nzHwq6+zg4Q8ov2zI8XJK2TykOQ/ga
         0ceixwWOEnsscOv/8y+gQb4UHG/uBVWjvMXTBxP0izu0lyHGt1bmaONPJSaUzJfly6nj
         NSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=QB/HGASPbuZ1nypVVYPF8eg6ROTcwwRrcp9SYQMiSt0=;
        b=DCeXXhHYg3/PxHwZcuptIdIk5mOlxzSJUwpfI5eqLymKyhND2K+jq7rwgcMZA1aNNt
         OFzlGo34cQk2tOkuv3a1Y8u5eoYdAdr1J+1sMdZ5Q5+ujermTY9qreemZvDriS9YDDeZ
         hA98GTgNpluBn0KSV+fzDCWMOj5IN1D7UXBKgCEScWJNHbfJj2w3jsSCGk5Qm2m3kkln
         V5lFiAqo+Aztmb/SmXOOIp5DdgdvE6INm0wRrM1kNoN6nwh4idOju6nr/Ffv4/GMSmFR
         p+K7s4RL9Kw4QFmpVzhrwOyFdSJoGn+77e+RS3FPA0qGt/wfeZAEPaXg/orcoTggsOk+
         te2w==
X-Gm-Message-State: AOAM533OO34EJdh0cdn4tcW74fKKgWoglBCm1QQ5//x6Dk5fgDgUOeRz
        849VnOos1as+hPFBHqTwz5Y+u1jF9/juD3wH9LV4wzf5JWE9dBAS/PqmLkdXnhVTcuJcN1qMj2B
        iToFjm+00CQ11fyuG2gp/ajRL1LnurJESXMFn9JS/MRUWxrDR6HD317DgJ5RETVXg1o3nKPESJR
        ly
X-Google-Smtp-Source: ABdhPJyymZNjph+dlcaXKjlAJpiz88DXThpcy8sZAy4m908O3uZC+7eSclmEz6281PNJYCUkGrFC4zIDLbgc5tu/9qbr
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3741:: with SMTP id
 ne1mr459155pjb.119.1608062530124; Tue, 15 Dec 2020 12:02:10 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:02:07 -0800
Message-Id: <20201215200207.1083655-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH] checkout: send commit provenance during prefetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a partial clone, whenever Git needs a missing object, it will fetch
it from the repo's promisor remote(s), sometimes as part of a bulk
prefetch. Currently, if the server handling such fetches does not accept
requests for objects unless the objects are reachable, it needs to
compute reachability from all refs.

This can be improved by sending the commit from which the prefetch
request came - a server that understands this would then only need to
check that this commit is reachable, and check that the object is
reachable from that commit.

Therefore, teach the partial clone fetching mechanism to support a
"provenance" argument, and plumb the commit provenance from checkout to
the partial clone fetching mechanism.

In the future, other commands can be similarly upgraded. Other possible
future improvements include better diagnostic messages when a prefetch
fails.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Sending a commit hint in this situation is something we've been
discussing at $DAYJOB, so here's a preliminary version - the client side
is done, but neither the server side nor the exact protocol details are
finished. Protocol-wise, in this patch, I'm just sending the provenance
commit as a server option.

This essentially splits reachability-of-blob, which almost certainly
requires loading a bitmap, into 2 parts: reachability-of-commit (which,
from my limited experience, can be more quickly done using a regular
object walk) and reachability-of-blob-from-commit (which, at worst,
requires fewer bitmaps to be loaded). I don't have timings for how it
works in practice, though.

I'm also not sure if the final version should have the client declare
that all blobs are reachable from the root tree(s) of the provenance
commit(s), or merely that all blobs are reachable from the provenance
commit(s) (that is, including their ancestors).

I'm sending this out early in the hope that other people using partial
clone will chime in.
---
 builtin/checkout.c       |  4 ++++
 builtin/index-pack.c     |  2 +-
 builtin/pack-objects.c   |  2 +-
 diff.c                   |  2 +-
 diffcore-rename.c        |  2 +-
 promisor-remote.c        | 12 +++++++++---
 promisor-remote.h        |  3 ++-
 sha1-file.c              |  2 +-
 t/t5616-partial-clone.sh |  7 +++++--
 unpack-trees.c           |  3 ++-
 unpack-trees.h           |  7 +++++++
 11 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b82119129..7f9fd65808 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -634,6 +634,8 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.provenance_commit =
+		info->commit ? &info->commit->object.oid : NULL;
 	init_checkout_metadata(&opts.meta, info->refname,
 			       info->commit ? &info->commit->object.oid : &null_oid,
 			       NULL);
@@ -724,6 +726,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.quiet = opts->merge && old_branch_info->commit;
 		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
+		topts.provenance_commit = new_branch_info->commit ?
+			&new_branch_info->commit->object.oid : NULL;
 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
 				       new_branch_info->commit ?
 				       &new_branch_info->commit->object.oid :
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4b8d86e0ad..83801826d6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1402,7 +1402,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 			oid_array_append(&to_fetch, &d->oid);
 		}
 		promisor_remote_get_direct(the_repository,
-					   to_fetch.oid, to_fetch.nr);
+					   to_fetch.oid, to_fetch.nr, NULL);
 		oid_array_clear(&to_fetch);
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5617c01b5a..741dcc9a24 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1720,7 +1720,7 @@ static void prefetch_to_pack(uint32_t object_index_start) {
 		oid_array_append(&to_fetch, &entry->idx.oid);
 	}
 	promisor_remote_get_direct(the_repository,
-				   to_fetch.oid, to_fetch.nr);
+				   to_fetch.oid, to_fetch.nr, NULL);
 	oid_array_clear(&to_fetch);
 }
 
diff --git a/diff.c b/diff.c
index 643f4f3f6d..68491fc398 100644
--- a/diff.c
+++ b/diff.c
@@ -6622,7 +6622,7 @@ void diff_queued_diff_prefetch(void *repository)
 	/*
 	 * NEEDSWORK: Consider deduplicating the OIDs sent.
 	 */
-	promisor_remote_get_direct(repo, to_fetch.oid, to_fetch.nr);
+	promisor_remote_get_direct(repo, to_fetch.oid, to_fetch.nr, NULL);
 
 	oid_array_clear(&to_fetch);
 }
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d367a6d244..ebc65fa272 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -161,7 +161,7 @@ static void prefetch(void *prefetch_options)
 		diff_add_if_missing(options->repo, &to_fetch,
 				    rename_src[i].p->one);
 	}
-	promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
+	promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr, NULL);
 	oid_array_clear(&to_fetch);
 }
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 3c572b1c81..ee44d1334e 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -14,7 +14,8 @@ void set_repository_format_partial_clone(char *partial_clone)
 
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
-			 int oid_nr)
+			 int oid_nr,
+			 struct object_id *provenance_commit)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	int i;
@@ -26,6 +27,9 @@ static int fetch_objects(const char *remote_name,
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--filter=blob:none", "--stdin", NULL);
+	if (provenance_commit)
+		strvec_pushf(&child.args, "--server-option=provenance=%s",
+			     oid_to_hex(provenance_commit));
 	if (start_command(&child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
@@ -224,7 +228,8 @@ static int remove_fetched_oids(struct repository *repo,
 
 int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
-			       int oid_nr)
+			       int oid_nr,
+			       struct object_id *provenance_commit)
 {
 	struct promisor_remote *r;
 	struct object_id *remaining_oids = (struct object_id *)oids;
@@ -238,7 +243,8 @@ int promisor_remote_get_direct(struct repository *repo,
 	promisor_remote_init();
 
 	for (r = promisors; r; r = r->next) {
-		if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
+		if (fetch_objects(r->name, remaining_oids, remaining_nr,
+				  provenance_commit) < 0) {
 			if (remaining_nr == 1)
 				continue;
 			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
diff --git a/promisor-remote.h b/promisor-remote.h
index c7a14063c5..44d1b152e6 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -30,7 +30,8 @@ int has_promisor_remote(void);
  */
 int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
-			       int oid_nr);
+			       int oid_nr,
+			       struct object_id *provenance_commit);
 
 /*
  * This should be used only once from setup.c to set the value we got
diff --git a/sha1-file.c b/sha1-file.c
index c3c49d2fa5..51ed339a0c 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1534,7 +1534,7 @@ static int do_oid_object_info_extended(struct repository *r,
 			 * promisor_remote_get_direct(), such that arbitrary
 			 * repositories work.
 			 */
-			promisor_remote_get_direct(r, real, 1);
+			promisor_remote_get_direct(r, real, 1, NULL);
 			already_retried = 1;
 			continue;
 		}
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 2ea66205cf..4b290060f5 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -56,11 +56,14 @@ test_expect_success 'verify that .promisor file contains refs fetched' '
 
 # checkout master to force dynamic object fetch of blobs at HEAD.
 test_expect_success 'verify checkout with dynamic object fetch' '
+	rm -f trace &&
 	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
 	test_line_count = 4 observed &&
-	git -C pc1 checkout master &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C pc1 checkout master &&
 	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
-	test_line_count = 0 observed
+	test_line_count = 0 observed &&
+	HEAD_HASH="$(git -C pc1 rev-parse HEAD)" &&
+	grep "server-option=provenance=$HEAD_HASH" trace
 '
 
 # create new commits in "src" repo to establish a blame history on file.1.txt
diff --git a/unpack-trees.c b/unpack-trees.c
index 323280dd48..d5dc06a70a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -457,7 +457,8 @@ static int check_updates(struct unpack_trees_options *o,
 			oid_array_append(&to_fetch, &ce->oid);
 		}
 		promisor_remote_get_direct(the_repository,
-					   to_fetch.oid, to_fetch.nr);
+					   to_fetch.oid, to_fetch.nr,
+					   o->provenance_commit);
 		oid_array_clear(&to_fetch);
 	}
 	for (i = 0; i < index->cache_nr; i++) {
diff --git a/unpack-trees.h b/unpack-trees.h
index 2e87875b15..a6e126c39d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -89,6 +89,13 @@ struct unpack_trees_options {
 
 	struct pattern_list *pl; /* for internal use */
 	struct checkout_metadata meta;
+
+	/*
+	 * Optional: The commit that this request comes from. Only used when
+	 * this repository is a partial clone; this is a hint to the server when
+	 * prefetching is needed.
+	 */
+	struct object_id *provenance_commit;
 };
 
 int unpack_trees(unsigned n, struct tree_desc *t,
-- 
2.29.2.684.gfbc64c5ab5-goog


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5293AC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192B964EBB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhBJXD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhBJXD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:26 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F97C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:46 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id l14so1743632qvp.2
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78SKJ97a5WgXWOxax5yqcBJQxrGJJ/dk0S4rFLYxh/8=;
        b=uokN1VnjxIG1wBj258bva+lPZKgDCW2UJru53UL5K8yMcM4WnpGBI/14n8Eay33gHO
         /6jG2myhS4MyOFR4kC+mlWTa7TM70xb0qo0ZFfZs4jSW8SsJx81uebVQg8nhw0+47w1I
         9cG00prxLNdRAOAqVLAU8PcKBUvorHtEtEQXuBB3hDaRjiseYE1kDJ1tiQWVzdZ5mFFQ
         1VrdnQyY/6rFLs2rlUkF0zPqZOyVtzSrEcyLFCOUibg25fexG+Jj/wyToU58KVhpn1d4
         cuEFumARB6BvsbtS4PumqxRmio4pK+mQOMO+r9pkZcdz4Z6VUpj2KWC9KqEo38OLeo6V
         ag8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78SKJ97a5WgXWOxax5yqcBJQxrGJJ/dk0S4rFLYxh/8=;
        b=jozU3EpA4U4/TNeuzUJFkE09NzT+Pp2xXSC4S1/Jowa0uIcftXzD+sOPC7+JgPOSay
         LEnGZ+nh4sWBqlvB50fjbZv0dSz7KYBfz0U0rXJs8Y6WN6FoQR3u1khmBKeNt6F+it69
         TmfZjaFHxjYLa2Jrqe83IDxMcFC7iU45WEz2zse2uaJrnhNzMVwoscdkLoHwvX/XJT8q
         W7APxtUI3aTOaSrWw+wrzG5xNCjks3MfkeIF6bpBhVxgVqvlBpYj49bGW1aGjZzXqpaX
         +p/ILGfFXvW3l07B9/1StRi5xptOwpcSpof6SEKaoB1zWN+kOzoUKh8w3PFZLut4Bp3F
         ClzQ==
X-Gm-Message-State: AOAM532+r9LIB4+fOiOulA+N3k051NhXwqneE/8b5AhOjeBcJlfOem91
        u9tWZmbsDK0nh0smjTF6QJXDDX5x/i4OTID/
X-Google-Smtp-Source: ABdhPJzPSjnYbEzHmRnt5jmpVnF1GV806z8aT6eGmzal9bDxu2xJhqVGa83kltkEmhfNZcvqHfRrKA==
X-Received: by 2002:a0c:f589:: with SMTP id k9mr5211661qvm.0.1612998165202;
        Wed, 10 Feb 2021 15:02:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id 14sm2531127qkr.70.2021.02.10.15.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:02:44 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:02:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 2/9] midx: allow marking a pack as preferred
Message-ID: <4a358d57cf6e834cd1756e70bf713d4d104f321e.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple packs in the multi-pack index contain the same object, the
MIDX machinery must make a choice about which pack it associates with
that object. Prior to this patch, the lowest-ordered[1] pack was always
selected.

Pack selection for duplicate objects is relatively unimportant today,
but it will become important for multi-pack bitmaps. This is because we
can only invoke the pack-reuse mechanism when all of the bits for reused
objects come from the reuse pack (in order to ensure that all reused
deltas can find their base objects in the same pack).

To encourage the pack selection process to prefer one pack over another
(the pack to be preferred is the one a caller would like to later use as
a reuse pack), introduce the concept of a "preferred pack". When
provided, the MIDX code will always prefer an object found in a
preferred pack over any other.

No format changes are required to store the preferred pack, since it
will be able to be inferred with a corresponding MIDX bitmap, by looking
up the pack associated with the object in the first bit position (this
ordering is described in detail in a subsequent commit).

[1]: the ordering is specified by MIDX internals; for our purposes we
can consider the "lowest ordered" pack to be "the one with the
most-recent mtime.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt       | 11 ++-
 Documentation/technical/multi-pack-index.txt |  5 +-
 builtin/multi-pack-index.c                   | 10 +-
 builtin/repack.c                             |  2 +-
 midx.c                                       | 97 ++++++++++++++++++--
 midx.h                                       |  2 +-
 t/t5319-multi-pack-index.sh                  | 39 ++++++++
 7 files changed, 151 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index eb0caa0439..dd14eab781 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,8 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress] <subcommand>
+'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
+	[--preferred-pack=<pack>] <subcommand>
 
 DESCRIPTION
 -----------
@@ -27,6 +28,14 @@ OPTIONS
 	Turn progress on/off explicitly. If neither is specified, progress is
 	shown if standard error is connected to a terminal.
 
+--preferred-pack=<pack>::
+	When using the `write` subcommand, optionally specify the
+	tie-breaking pack used when multiple packs contain the same
+	object. Incompatible with other subcommands, including `repack`,
+	which may repack the pack marked as preferred. If not given, the
+	preferred pack is inferred from an existing `multi-pack-index`,
+	if one exists, otherwise the pack with the lowest mtime.
+
 The following subcommands are available:
 
 write::
diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index e8e377a59f..fb688976c4 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -43,8 +43,9 @@ Design Details
   a change in format.
 
 - The MIDX keeps only one record per object ID. If an object appears
-  in multiple packfiles, then the MIDX selects the copy in the most-
-  recently modified packfile.
+  in multiple packfiles, then the MIDX selects the copy in the
+  preferred packfile, otherwise selecting from the most-recently
+  modified packfile.
 
 - If there exist packfiles in the pack directory not registered in
   the MIDX, then those packfiles are loaded into the `packed_git`
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5bf88cd2a8..4d1ea3fe84 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "midx.h"
 #include "trace2.h"
+#include "object-store.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
 	N_("git multi-pack-index [<options>] (write|verify|expire|repack --batch-size=<size>)"),
@@ -12,6 +13,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 
 static struct opts_multi_pack_index {
 	const char *object_dir;
+	const char *preferred_pack;
 	unsigned long batch_size;
 	int progress;
 } opts;
@@ -24,6 +26,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
+		OPT_STRING(0, "preferred-pack", &opts.preferred_pack, N_("preferred-pack"),
+		  N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
@@ -51,6 +55,9 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return 1;
 	}
 
+	if (strcmp(argv[0], "write") && opts.preferred_pack)
+		die(_("'--preferred-pack' requires 'write'"));
+
 	trace2_cmd_mode(argv[0]);
 
 	if (!strcmp(argv[0], "repack"))
@@ -60,7 +67,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		die(_("--batch-size option is only for 'repack' subcommand"));
 
 	if (!strcmp(argv[0], "write"))
-		return write_midx_file(opts.object_dir, flags);
+		return write_midx_file(opts.object_dir, opts.preferred_pack,
+				       flags);
 	if (!strcmp(argv[0], "verify"))
 		return verify_midx_file(the_repository, opts.object_dir, flags);
 	if (!strcmp(argv[0], "expire"))
diff --git a/builtin/repack.c b/builtin/repack.c
index 01440de2d5..9f00806805 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -523,7 +523,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	remove_temporary_files();
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
-		write_midx_file(get_object_directory(), 0);
+		write_midx_file(get_object_directory(), NULL, 0);
 
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
diff --git a/midx.c b/midx.c
index 05c40a98e0..064670c0c0 100644
--- a/midx.c
+++ b/midx.c
@@ -451,6 +451,24 @@ static int pack_info_compare(const void *_a, const void *_b)
 	return strcmp(a->pack_name, b->pack_name);
 }
 
+static int lookup_idx_or_pack_name(struct pack_info *info,
+				   uint32_t nr,
+				   const char *pack_name)
+{
+	uint32_t lo = 0, hi = nr;
+	while (lo < hi) {
+		uint32_t mi = lo + (hi - lo) / 2;
+		int cmp = cmp_idx_or_pack_name(pack_name, info[mi].pack_name);
+		if (cmp < 0)
+			hi = mi;
+		else if (cmp > 0)
+			lo = mi + 1;
+		else
+			return mi;
+	}
+	return -1;
+}
+
 struct pack_list {
 	struct pack_info *info;
 	uint32_t nr;
@@ -502,6 +520,7 @@ struct pack_midx_entry {
 	uint32_t pack_int_id;
 	time_t pack_mtime;
 	uint64_t offset;
+	unsigned preferred : 1;
 };
 
 static int midx_oid_compare(const void *_a, const void *_b)
@@ -513,6 +532,12 @@ static int midx_oid_compare(const void *_a, const void *_b)
 	if (cmp)
 		return cmp;
 
+	/* Sort objects in a preferred pack first when multiple copies exist. */
+	if (a->preferred > b->preferred)
+		return -1;
+	if (a->preferred < b->preferred)
+		return 1;
+
 	if (a->pack_mtime > b->pack_mtime)
 		return -1;
 	else if (a->pack_mtime < b->pack_mtime)
@@ -540,7 +565,8 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
 static void fill_pack_entry(uint32_t pack_int_id,
 			    struct packed_git *p,
 			    uint32_t cur_object,
-			    struct pack_midx_entry *entry)
+			    struct pack_midx_entry *entry,
+			    int preferred)
 {
 	if (nth_packed_object_id(&entry->oid, p, cur_object) < 0)
 		die(_("failed to locate object %d in packfile"), cur_object);
@@ -549,6 +575,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
 	entry->pack_mtime = p->mtime;
 
 	entry->offset = nth_packed_object_offset(p, cur_object);
+	entry->preferred = !!preferred;
 }
 
 /*
@@ -565,7 +592,8 @@ static void fill_pack_entry(uint32_t pack_int_id,
 static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						  struct pack_info *info,
 						  uint32_t nr_packs,
-						  uint32_t *nr_objects)
+						  uint32_t *nr_objects,
+						  uint32_t preferred_pack)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
 	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
@@ -602,12 +630,17 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 				nth_midxed_pack_midx_entry(m,
 							   &entries_by_fanout[nr_fanout],
 							   cur_object);
+				if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
+					entries_by_fanout[nr_fanout].preferred = 1;
+				else
+					entries_by_fanout[nr_fanout].preferred = 0;
 				nr_fanout++;
 			}
 		}
 
 		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
 			uint32_t start = 0, end;
+			int preferred = cur_pack == preferred_pack;
 
 			if (cur_fanout)
 				start = get_pack_fanout(info[cur_pack].p, cur_fanout - 1);
@@ -615,7 +648,11 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 
 			for (cur_object = start; cur_object < end; cur_object++) {
 				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
-				fill_pack_entry(cur_pack, info[cur_pack].p, cur_object, &entries_by_fanout[nr_fanout]);
+				fill_pack_entry(cur_pack,
+						info[cur_pack].p,
+						cur_object,
+						&entries_by_fanout[nr_fanout],
+						preferred);
 				nr_fanout++;
 			}
 		}
@@ -794,7 +831,9 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 }
 
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
-			       struct string_list *packs_to_drop, unsigned flags)
+			       struct string_list *packs_to_drop,
+			       const char *preferred_pack_name,
+			       unsigned flags)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -813,6 +852,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
+	int preferred_pack_idx = -1;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name))
@@ -853,7 +893,18 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (packs.m && packs.nr == packs.m->num_packs && !packs_to_drop)
 		goto cleanup;
 
-	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
+	if (preferred_pack_name) {
+		for (i = 0; i < packs.nr; i++) {
+			if (!cmp_idx_or_pack_name(preferred_pack_name,
+						  packs.info[i].pack_name)) {
+				preferred_pack_idx = i;
+				break;
+			}
+		}
+	}
+
+	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries,
+				     preferred_pack_idx);
 
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
@@ -913,6 +964,31 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
 	}
 
+	/*
+	 * Recompute the preferred_pack_idx (if applicable) according to the
+	 * permuted pack order.
+	 */
+	preferred_pack_idx = -1;
+	if (preferred_pack_name) {
+		preferred_pack_idx = lookup_idx_or_pack_name(packs.info,
+							     packs.nr,
+							     preferred_pack_name);
+		if (preferred_pack_idx < 0)
+			warning(_("unknown preferred pack: '%s'"),
+				preferred_pack_name);
+		else {
+			uint32_t orig = packs.info[preferred_pack_idx].orig_pack_int_id;
+			uint32_t perm = pack_perm[orig];
+
+			if (perm == PACK_EXPIRED) {
+				warning(_("preferred pack '%s' is expired"),
+					preferred_pack_name);
+				preferred_pack_idx = -1;
+			} else
+				preferred_pack_idx = perm;
+		}
+	}
+
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
@@ -1042,9 +1118,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	return result;
 }
 
-int write_midx_file(const char *object_dir, unsigned flags)
+int write_midx_file(const char *object_dir,
+		    const char *preferred_pack_name,
+		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL, flags);
+	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
+				   flags);
 }
 
 void clear_midx_file(struct repository *r)
@@ -1279,7 +1358,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, m, &packs_to_drop, flags);
+		result = write_midx_internal(object_dir, m, &packs_to_drop, NULL, flags);
 
 	string_list_clear(&packs_to_drop, 0);
 	return result;
@@ -1468,7 +1547,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, m, NULL, flags);
+	result = write_midx_internal(object_dir, m, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
diff --git a/midx.h b/midx.h
index b18cf53bc4..e7fea61109 100644
--- a/midx.h
+++ b/midx.h
@@ -47,7 +47,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
-int write_midx_file(const char *object_dir, unsigned flags);
+int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2fc3aadbd1..9304b33484 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -31,6 +31,14 @@ midx_read_expect () {
 	test_cmp expect actual
 }
 
+midx_expect_object_offset () {
+	OID="$1"
+	OFFSET="$2"
+	OBJECT_DIR="$3"
+	test-tool read-midx --show-objects $OBJECT_DIR >actual &&
+	grep "^$OID $OFFSET" actual
+}
+
 test_expect_success 'setup' '
 	test_oid_cache <<-EOF
 	idxoff sha1:2999
@@ -234,6 +242,37 @@ test_expect_success 'warn on improper hash version' '
 	)
 '
 
+test_expect_success 'midx picks objects from preferred pack' '
+	test_when_finished rm -rf preferred.git &&
+	git init --bare preferred.git &&
+	(
+		cd preferred.git &&
+
+		a=$(echo "a" | git hash-object -w --stdin) &&
+		b=$(echo "b" | git hash-object -w --stdin) &&
+		c=$(echo "c" | git hash-object -w --stdin) &&
+
+		# Set up two packs, duplicating the object "B" at different
+		# offsets.
+		git pack-objects objects/pack/test-AB <<-EOF &&
+		$a
+		$b
+		EOF
+		bc=$(git pack-objects objects/pack/test-BC <<-EOF
+		$b
+		$c
+		EOF
+		) &&
+
+		git multi-pack-index --object-dir=objects \
+			--preferred-pack=test-BC-$bc.idx write 2>err &&
+		test_must_be_empty err &&
+
+		ofs=$(git show-index <objects/pack/test-BC-$bc.idx | grep $b |
+			cut -d" " -f1) &&
+		midx_expect_object_offset $b $ofs objects
+	)
+'
 
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
-- 
2.30.0.667.g81c0cbc6fd


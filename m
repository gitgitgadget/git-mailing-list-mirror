Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B21C4360C
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B4E64ECE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCKRF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhCKRFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:12 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B83C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:11 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id a7so22653949iok.12
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o7kdbT0FcRN7KdLdpb1qj/OP+dI7U4COzNjs19x8PB8=;
        b=sxqBsbGSBfFQWMBHb7A+DBndTeivb4aHs4qdRQuhABB5ZAfVzYM+uXFfJQI7bq3+/G
         XtWarXPy8a5SzNjfUH0L/AazcXd3sG2JViugbHuRM8aVnLCgGERSUfxfTDUXRGYrab48
         fXvMWTFASCLsXioZB53jaGhIx/0YS0w4Lc/YgmrKa3B5eJsgtrn+hpdorxWK3JvDAwDr
         KMRkvFSzLexXcna1+ljAGkT4E9oX7VBMEBFtlmX+BCtos3W/rUXc1gThwxrgc446F5Xw
         TqH75YcL/PjubhNjDJvcyqTm1BCStWZY+CHOw1jLV927WrIBnWC+6VO2gd/4G2uIRiii
         bhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7kdbT0FcRN7KdLdpb1qj/OP+dI7U4COzNjs19x8PB8=;
        b=cWwEaLdjLyPjHygMPXD5zNLNWEhZypmgMOIxhJNxMxrD4iQjJzYBZxFyta2MNsqipq
         4eiSe5jnDy+BqsTRJnIt5GDrWp60qZVTHH5YB9GQp4YRQ0ct2hQbHi7995MRQa8uZlAc
         c2edKpz1cYYz0Onfdoy+YwU2TeADDQam4iJR54ebOkrKy3vcllqRfuQv6X5LxccdcQ5l
         weXyBWyGBy/fAjx9KK1bz+QkjbtS8T6uzKgPKH4viYjQnJFY7xk7gBq3d7AztctY/f2L
         8gKMPjCQUr5GhwrosKx1QKbSO7iCL2PHbHcAS7QCKBzX6M/4QVHn1Q1+x5w408dGpHzB
         IHFQ==
X-Gm-Message-State: AOAM533uxIpjs9oPDLF6/WqVR3psyZUGmuD6pxDIgl77m1aGttidSHcB
        YRnhAUg6rjE51MLY5K2LeEha6Op4t5jbof56
X-Google-Smtp-Source: ABdhPJwyWG3K/e8ydupB6IprjKrcB7Dn6VQBMUtzDRDDXtlUhqXUTxATtqeNmzxjXKVSREZZlkUYfQ==
X-Received: by 2002:a02:9a0a:: with SMTP id b10mr4565191jal.132.1615482310610;
        Thu, 11 Mar 2021 09:05:10 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id y13sm306080ioc.36.2021.03.11.09.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:10 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 08/16] midx: allow marking a pack as preferred
Message-ID: <30194a6786bec51e0f41de0e6c855dc2297806c6.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
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
 Documentation/git-multi-pack-index.txt       | 14 ++-
 Documentation/technical/multi-pack-index.txt |  5 +-
 builtin/multi-pack-index.c                   | 18 +++-
 builtin/repack.c                             |  2 +-
 midx.c                                       | 92 ++++++++++++++++++--
 midx.h                                       |  2 +-
 t/t5319-multi-pack-index.sh                  | 39 +++++++++
 7 files changed, 154 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index eb0caa0439..ffd601bc17 100644
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
@@ -30,7 +31,16 @@ OPTIONS
 The following subcommands are available:
 
 write::
-	Write a new MIDX file.
+	Write a new MIDX file. The following options are available for
+	the `write` sub-command:
++
+--
+	--preferred-pack=<pack>::
+		Optionally specify the tie-breaking pack used when
+		multiple packs contain the same object. If not given,
+		ties are broken in favor of the pack with the lowest
+		mtime.
+--
 
 verify::
 	Verify the contents of the MIDX file.
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
index 243b6ccc7c..92f358f212 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -4,9 +4,10 @@
 #include "parse-options.h"
 #include "midx.h"
 #include "trace2.h"
+#include "object-store.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
-	N_("git multi-pack-index [<options>] write")
+	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -43,6 +44,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 
 static struct opts_multi_pack_index {
 	const char *object_dir;
+	const char *preferred_pack;
 	unsigned long batch_size;
 	unsigned flags;
 } opts;
@@ -63,7 +65,16 @@ static struct option *add_common_options(struct option *prev)
 
 static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
-	struct option *options = common_opts;
+	struct option *options;
+	static struct option builtin_multi_pack_index_write_options[] = {
+		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
+			   N_("preferred-pack"),
+			   N_("pack for reuse when computing a multi-pack bitmap")),
+		OPT_END(),
+	};
+
+	options = parse_options_dup(builtin_multi_pack_index_write_options);
+	options = add_common_options(options);
 
 	trace2_cmd_mode(argv[0]);
 
@@ -74,7 +85,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
 
-	return write_midx_file(opts.object_dir, opts.flags);
+	return write_midx_file(opts.object_dir, opts.preferred_pack,
+			       opts.flags);
 }
 
 static int cmd_multi_pack_index_verify(int argc, const char **argv)
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
index 971faa8cfc..46f55ff6cf 100644
--- a/midx.c
+++ b/midx.c
@@ -431,6 +431,24 @@ static int pack_info_compare(const void *_a, const void *_b)
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
 struct write_midx_context {
 	struct pack_info *info;
 	uint32_t nr;
@@ -445,6 +463,8 @@ struct write_midx_context {
 	uint32_t *pack_perm;
 	unsigned large_offsets_needed:1;
 	uint32_t num_large_offsets;
+
+	int preferred_pack_idx;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -489,6 +509,7 @@ struct pack_midx_entry {
 	uint32_t pack_int_id;
 	time_t pack_mtime;
 	uint64_t offset;
+	unsigned preferred : 1;
 };
 
 static int midx_oid_compare(const void *_a, const void *_b)
@@ -500,6 +521,12 @@ static int midx_oid_compare(const void *_a, const void *_b)
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
@@ -527,7 +554,8 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
 static void fill_pack_entry(uint32_t pack_int_id,
 			    struct packed_git *p,
 			    uint32_t cur_object,
-			    struct pack_midx_entry *entry)
+			    struct pack_midx_entry *entry,
+			    int preferred)
 {
 	if (nth_packed_object_id(&entry->oid, p, cur_object) < 0)
 		die(_("failed to locate object %d in packfile"), cur_object);
@@ -536,6 +564,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
 	entry->pack_mtime = p->mtime;
 
 	entry->offset = nth_packed_object_offset(p, cur_object);
+	entry->preferred = !!preferred;
 }
 
 /*
@@ -552,7 +581,8 @@ static void fill_pack_entry(uint32_t pack_int_id,
 static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						  struct pack_info *info,
 						  uint32_t nr_packs,
-						  uint32_t *nr_objects)
+						  uint32_t *nr_objects,
+						  int preferred_pack)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
 	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
@@ -589,12 +619,17 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
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
@@ -602,7 +637,11 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 
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
@@ -777,7 +816,9 @@ static int write_midx_large_offsets(struct hashfile *f,
 }
 
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
-			       struct string_list *packs_to_drop, unsigned flags)
+			       struct string_list *packs_to_drop,
+			       const char *preferred_pack_name,
+			       unsigned flags)
 {
 	char *midx_name;
 	uint32_t i;
@@ -828,7 +869,19 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
 		goto cleanup;
 
-	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr);
+	ctx.preferred_pack_idx = -1;
+	if (preferred_pack_name) {
+		for (i = 0; i < ctx.nr; i++) {
+			if (!cmp_idx_or_pack_name(preferred_pack_name,
+						  ctx.info[i].pack_name)) {
+				ctx.preferred_pack_idx = i;
+				break;
+			}
+		}
+	}
+
+	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
+					 ctx.preferred_pack_idx);
 
 	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
@@ -889,6 +942,24 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
 	}
 
+	/* Check that the preferred pack wasn't expired (if given). */
+	if (preferred_pack_name) {
+		int preferred_idx = lookup_idx_or_pack_name(ctx.info,
+							    ctx.nr,
+							    preferred_pack_name);
+		if (preferred_idx < 0)
+			warning(_("unknown preferred pack: '%s'"),
+				preferred_pack_name);
+		else {
+			uint32_t orig = ctx.info[preferred_idx].orig_pack_int_id;
+			uint32_t perm = ctx.pack_perm[orig];
+
+			if (perm == PACK_EXPIRED)
+				warning(_("preferred pack '%s' is expired"),
+					preferred_pack_name);
+		}
+	}
+
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
@@ -947,9 +1018,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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
@@ -1184,7 +1258,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, m, &packs_to_drop, flags);
+		result = write_midx_internal(object_dir, m, &packs_to_drop, NULL, flags);
 
 	string_list_clear(&packs_to_drop, 0);
 	return result;
@@ -1373,7 +1447,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
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
index b4afab1dfc..fd94ba9053 100755
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
+			write --preferred-pack=test-BC-$bc.idx 2>err &&
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


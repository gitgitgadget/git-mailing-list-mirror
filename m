Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5AEEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFTOWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjFTOV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:57 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1E1996
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-561b7729a12so85460387b3.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270906; x=1689862906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMg8/uIfdj5gdnzcxiQyU/e2pchPOSQNvIz5lFyJQC0=;
        b=Q8e68pq82mxPE5erotgB1AJ+jUoEKTeYSXMim4+WHUfj65t9SRzLp6M396fV997IfU
         LcoAXcj1jA6od760cGrTcoIQFtTtxrjGmbdGTXO1RYcRSeg24ZsLoqTNSfsaa1lM1x0f
         CFMNa6Ef4ZPHJSUfdnmqlhco1PTbD05cuqP1+w8MrRYhJlkN1+Gs/XOgPKmJerrikY73
         7I1/8fpUMOMXsVCI51CDfCADTEjpsU1qh0oluI1omuy9vZTA/uPy3iQCD3TNN77rjCs7
         iptgvVhSLb7JkwSOscOkg/aQ2LD49WsjCyAJjuO86HO73pt4Lk04aRGJJW28OWEpjLn0
         koUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270906; x=1689862906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMg8/uIfdj5gdnzcxiQyU/e2pchPOSQNvIz5lFyJQC0=;
        b=SYHRs5kWzcLkCz4DODuYykOJqUjmI8Xk9c4DMkD8OwJORuGX1YsGzdTOXVS2OOfPtn
         uxQdDbVXN+pWszHc8xmz2AML0Shv2gjl+Gs0s++YA0MrjNRMhoYmLonQlpvfimb2piX2
         EEpP/z+oekuRev38bgeZZ0zbH7FFggmzaLMLDA2GbGCqo8dQPx0/LjnKIwAi/55Ezudr
         NreSnBEn6DUk3diG4NT3sZW9amxrzywdFcDMv+ntHvNKORrKCKmb9nRdFv2awY5CSxgr
         YCC3cxuG89nvI2+htL6FwdB8AQ/VKkdYsMUlrVAekmDtsNG16T9O5fI3yjAA4Ty37Zcn
         F8Ow==
X-Gm-Message-State: AC+VfDw26JPxjK8qCHxHLUQOVK4KbeNmiZzhC8exX+RSBaFbfZkJlNAy
        vXw/FwcSp5MEPN3Ax2Fq7JAs05QIfseUFPAvtSSlHjCg
X-Google-Smtp-Source: ACHHUZ7jCEDsqjRYMWyC3hAemMd/OxEyS1m5UeQcZ31NxVFAJdr82WFgFqlIUyIJ9oknvxwaKwIa6Q==
X-Received: by 2002:a0d:cbcb:0:b0:56c:e5a3:3e09 with SMTP id n194-20020a0dcbcb000000b0056ce5a33e09mr20418040ywd.15.1687270905839;
        Tue, 20 Jun 2023 07:21:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z192-20020a0dd7c9000000b005702bfb19bfsm504534ywd.130.2023.06.20.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:45 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
Message-ID: <386ed468fa7157e90f2f7324199a68974a7860cc.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When iterating through the `packed-refs` file in order to answer a query
like:

    $ git for-each-ref --exclude=refs/__hidden__

it would be useful to avoid walking over all of the entries in
`refs/__hidden__/*` when possible, since we know that the ref-filter
code is going to throw them away anyways.

In certain circumstances, doing so is possible. The algorithm for doing
so is as follows:

  - For each excluded pattern, find the first record that matches it,
    and the first record that *doesn't* match it (i.e. the location
    you'd next want to consider when excluding that pattern).

  - Sort the set of excluded regions from the previous step in ascending
    order of the first location within the `packed-refs` file that
    matches.

  - Clean up the results from the previous step: discard empty regions,
    and combine adjacent regions. The set of regions which remains is
    referred to as the "jump list", and never contains any references
    which should be included in the result set.

Then when iterating through the `packed-refs` file, if `iter->pos` is
ever contained in one of the regions from the previous steps, advance
`iter->pos` past the end of that region, and continue enumeration.

Note that we only perform this optimization when none of the excluded
pattern(s) have special meta-characters in them. For a pattern like
"refs/foo[ac]", the excluded regions ("refs/fooa", "refs/fooc", and
everything underneath them) are not connected. A future implementation
that handles this case may split the character class (pretending as if
two patterns were excluded: "refs/fooa", and "refs/fooc").

There are a few other gotchas worth considering. First, note that the
jump list is sorted, so once we jump past a region, we can avoid
considering it (or any regions preceding it) again. The member
`jump_pos` is used to track the first next-possible region to jump
through.

Second, note that the jump list is best-effort, since we do not handle
loose references, and because of the meta-character issue above. The
jump list may not skip past all references which won't appear in the
results, but will never skip over a reference which does appear in the
result set.

In repositories with a large number of hidden references, the speed-up
can be significant. Tests here are done with a copy of linux.git with a
reference "refs/pull/N" pointing at every commit, as in:

    $ git rev-list HEAD | awk '{ print "create refs/pull/" NR " " $0 }' |
        git update-ref --stdin
    $ git pack-refs --all

, it is significantly faster to have `for-each-ref` jump over the
excluded references, as opposed to filtering them out after the fact:

    $ hyperfine \
      'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"' \
      'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"'
    Benchmark 1: git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"
      Time (mean ± σ):     802.7 ms ±   2.1 ms    [User: 691.6 ms, System: 147.0 ms]
      Range (min … max):   800.0 ms … 807.7 ms    10 runs

    Benchmark 2: git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"
      Time (mean ± σ):       4.7 ms ±   0.3 ms    [User: 0.7 ms, System: 4.0 ms]
      Range (min … max):     4.3 ms …   6.7 ms    422 runs

    Summary
      'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"' ran
      172.03 ± 9.60 times faster than 'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"'

Using the jump list is fairly straightforward (see the changes to
`refs/packed-backend.c::next_record()`), but constructing the list is
not. To ensure that the construction is correct, add a new suite of
tests in t1419 covering various corner cases (overlapping regions,
partially overlapping regions, adjacent regions, etc.).

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c              |   6 +-
 refs/packed-backend.c     | 160 ++++++++++++++++++++++++++++++++++++--
 t/helper/test-ref-store.c |  10 +++
 t/t1419-exclude-refs.sh   | 101 ++++++++++++++++++++++++
 4 files changed, 269 insertions(+), 8 deletions(-)
 create mode 100755 t/t1419-exclude-refs.sh

diff --git a/ref-filter.c b/ref-filter.c
index 5e7ed204dc..ddc7f5204f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2209,12 +2209,14 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
-		return for_each_fullref_in("", cb, cb_data);
+		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						 "", filter->exclude.v, cb, cb_data);
 	}
 
 	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
 						 NULL, filter->name_patterns,
-						 NULL, cb, cb_data);
+						 filter->exclude.v,
+						 cb, cb_data);
 }
 
 /*
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index d9b61d9e03..f624c9921a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -303,7 +303,8 @@ static int cmp_packed_ref_records(const void *v1, const void *v2)
  * Compare a snapshot record at `rec` to the specified NUL-terminated
  * refname.
  */
-static int cmp_record_to_refname(const char *rec, const char *refname)
+static int cmp_record_to_refname(const char *rec, const char *refname,
+				 int start)
 {
 	const char *r1 = rec + the_hash_algo->hexsz + 1;
 	const char *r2 = refname;
@@ -312,7 +313,7 @@ static int cmp_record_to_refname(const char *rec, const char *refname)
 		if (*r1 == '\n')
 			return *r2 ? -1 : 0;
 		if (!*r2)
-			return 1;
+			return start ? 1 : -1;
 		if (*r1 != *r2)
 			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
 		r1++;
@@ -528,7 +529,8 @@ static int load_contents(struct snapshot *snapshot)
 }
 
 static const char *find_reference_location_1(struct snapshot *snapshot,
-					     const char *refname, int mustexist)
+					     const char *refname, int mustexist,
+					     int start)
 {
 	/*
 	 * This is not *quite* a garden-variety binary search, because
@@ -558,7 +560,7 @@ static const char *find_reference_location_1(struct snapshot *snapshot,
 
 		mid = lo + (hi - lo) / 2;
 		rec = find_start_of_record(lo, mid);
-		cmp = cmp_record_to_refname(rec, refname);
+		cmp = cmp_record_to_refname(rec, refname, start);
 		if (cmp < 0) {
 			lo = find_end_of_record(mid, hi);
 		} else if (cmp > 0) {
@@ -591,7 +593,22 @@ static const char *find_reference_location_1(struct snapshot *snapshot,
 static const char *find_reference_location(struct snapshot *snapshot,
 					   const char *refname, int mustexist)
 {
-	return find_reference_location_1(snapshot, refname, mustexist);
+	return find_reference_location_1(snapshot, refname, mustexist, 1);
+}
+
+/*
+ * Find the place in `snapshot->buf` after the end of the record for
+ * `refname`. In other words, find the location of first thing *after*
+ * `refname`.
+ *
+ * Other semantics are identical to the ones in
+ * `find_reference_location()`.
+ */
+static const char *find_reference_location_end(struct snapshot *snapshot,
+					       const char *refname,
+					       int mustexist)
+{
+	return find_reference_location_1(snapshot, refname, mustexist, 0);
 }
 
 /*
@@ -785,6 +802,13 @@ struct packed_ref_iterator {
 	/* The end of the part of the buffer that will be iterated over: */
 	const char *eof;
 
+	struct jump_list_entry {
+		const char *start;
+		const char *end;
+	} *jump;
+	size_t jump_nr, jump_alloc;
+	size_t jump_cur;
+
 	/* Scratch space for current values: */
 	struct object_id oid, peeled;
 	struct strbuf refname_buf;
@@ -802,14 +826,34 @@ struct packed_ref_iterator {
  */
 static int next_record(struct packed_ref_iterator *iter)
 {
-	const char *p = iter->pos, *eol;
+	const char *p, *eol;
 
 	strbuf_reset(&iter->refname_buf);
 
+	/*
+	 * If iter->pos is contained within a skipped region, jump past
+	 * it.
+	 *
+	 * Note that each skipped region is considered at most once,
+	 * since they are ordered based on their starting position.
+	 */
+	while (iter->jump_cur < iter->jump_nr) {
+		struct jump_list_entry *curr = &iter->jump[iter->jump_cur];
+		if (iter->pos < curr->start)
+			break; /* not to the next jump yet */
+
+		iter->jump_cur++;
+		if (iter->pos < curr->end) {
+			iter->pos = curr->end;
+			break;
+		}
+	}
+
 	if (iter->pos == iter->eof)
 		return ITER_DONE;
 
 	iter->base.flags = REF_ISPACKED;
+	p = iter->pos;
 
 	if (iter->eof - p < the_hash_algo->hexsz + 2 ||
 	    parse_oid_hex(p, &iter->oid, &p) ||
@@ -917,6 +961,7 @@ static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
 	int ok = ITER_DONE;
 
 	strbuf_release(&iter->refname_buf);
+	free(iter->jump);
 	release_snapshot(iter->snapshot);
 	base_ref_iterator_free(ref_iterator);
 	return ok;
@@ -928,6 +973,106 @@ static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 	.abort = packed_ref_iterator_abort
 };
 
+static int jump_list_entry_cmp(const void *va, const void *vb)
+{
+	const struct jump_list_entry *a = va;
+	const struct jump_list_entry *b = vb;
+
+	if (a->start < b->start)
+		return -1;
+	if (a->start > b->start)
+		return 1;
+	return 0;
+}
+
+static int has_glob_special(const char *str)
+{
+	const char *p;
+	for (p = str; *p; p++) {
+		if (is_glob_special(*p))
+			return 1;
+	}
+	return 0;
+}
+
+static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
+					struct snapshot *snapshot,
+					const char **excluded_patterns)
+{
+	size_t i, j;
+	const char **pattern;
+	struct jump_list_entry *last_disjoint;
+
+	if (!excluded_patterns)
+		return;
+
+	for (pattern = excluded_patterns; *pattern; pattern++) {
+		struct jump_list_entry *e;
+
+		/*
+		 * We can't feed any excludes with globs in them to the
+		 * refs machinery.  It only understands prefix matching.
+		 * We likewise can't even feed the string leading up to
+		 * the first meta-character, as something like "foo[a]"
+		 * should not exclude "foobar" (but the prefix "foo"
+		 * would match that and mark it for exclusion).
+		 */
+		if (has_glob_special(*pattern))
+			continue;
+
+		ALLOC_GROW(iter->jump, iter->jump_nr + 1, iter->jump_alloc);
+
+		e = &iter->jump[iter->jump_nr++];
+		e->start = find_reference_location(snapshot, *pattern, 0);
+		e->end = find_reference_location_end(snapshot, *pattern, 0);
+	}
+
+	if (!iter->jump_nr) {
+		/*
+		 * Every entry in exclude_patterns has a meta-character,
+		 * nothing to do here.
+		 */
+		return;
+	}
+
+	QSORT(iter->jump, iter->jump_nr, jump_list_entry_cmp);
+
+	/*
+	 * As an optimization, merge adjacent entries in the jump list
+	 * to jump forwards as far as possible when entering a skipped
+	 * region.
+	 *
+	 * For example, if we have two skipped regions:
+	 *
+	 *	[[A, B], [B, C]]
+	 *
+	 * we want to combine that into a single entry jumping from A to
+	 * C.
+	 */
+	last_disjoint = iter->jump;
+
+	for (i = 1, j = 1; i < iter->jump_nr; i++) {
+		struct jump_list_entry *ours = &iter->jump[i];
+
+		if (ours->start == ours->end) {
+			/* ignore empty regions (no matching entries) */
+			continue;
+		} else if (ours->start <= last_disjoint->end) {
+			/* overlapping regions extend the previous one */
+			last_disjoint->end = last_disjoint->end > ours->end
+				? last_disjoint->end : ours->end;
+		} else {
+			/* otherwise, insert a new region */
+			iter->jump[j++] = *ours;
+			last_disjoint = ours;
+
+		}
+	}
+
+	iter->jump_nr = j;
+	iter->jump_cur = 0;
+}
+
 static struct ref_iterator *packed_ref_iterator_begin(
 		struct ref_store *ref_store,
 		const char *prefix, const char **exclude_patterns,
@@ -963,6 +1108,9 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
 
+	if (exclude_patterns)
+		populate_excluded_jump_list(iter, snapshot, exclude_patterns);
+
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a6977b5e83..08b6d5a86c 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -184,6 +184,15 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 	return refs_for_each_ref_in(refs, prefix, each_ref, NULL);
 }
 
+static int cmd_for_each_ref__exclude(struct ref_store *refs, const char **argv)
+{
+	const char *prefix = notnull(*argv++, "prefix");
+	const char **exclude_patterns = argv;
+
+	return refs_for_each_fullref_in(refs, prefix, exclude_patterns, each_ref,
+					NULL);
+}
+
 static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 {
 	struct object_id oid = *null_oid();
@@ -316,6 +325,7 @@ static struct command commands[] = {
 	{ "delete-refs", cmd_delete_refs },
 	{ "rename-ref", cmd_rename_ref },
 	{ "for-each-ref", cmd_for_each_ref },
+	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
 	{ "resolve-ref", cmd_resolve_ref },
 	{ "verify-ref", cmd_verify_ref },
 	{ "for-each-reflog", cmd_for_each_reflog },
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
new file mode 100755
index 0000000000..bc534c8ea1
--- /dev/null
+++ b/t/t1419-exclude-refs.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='test exclude_patterns functionality in main ref store'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+for_each_ref__exclude () {
+	test-tool ref-store main for-each-ref--exclude "$@" >actual.raw
+	cut -d ' ' -f 2 actual.raw
+}
+
+for_each_ref () {
+	git for-each-ref --format='%(refname)' "$@"
+}
+
+test_expect_success 'setup' '
+	test_commit --no-tag base &&
+	base="$(git rev-parse HEAD)" &&
+
+	for name in foo bar baz quux
+	do
+		for i in 1 2 3
+		do
+			echo "create refs/heads/$name/$i $base" || return 1
+		done || return 1
+	done >in &&
+	echo "delete refs/heads/main" >>in &&
+
+	git update-ref --stdin <in &&
+	git pack-refs --all
+'
+
+test_expect_success 'excluded region in middle' '
+	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
+	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'excluded region at beginning' '
+	for_each_ref__exclude refs/heads refs/heads/bar >actual &&
+	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'excluded region at end' '
+	for_each_ref__exclude refs/heads refs/heads/quux >actual &&
+	for_each_ref refs/heads/foo refs/heads/bar refs/heads/baz >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'disjoint excluded regions' '
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual &&
+	for_each_ref refs/heads/baz refs/heads/foo >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'adjacent, non-overlapping excluded regions' '
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual &&
+	for_each_ref refs/heads/foo refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'overlapping excluded regions' '
+	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual &&
+	for_each_ref refs/heads/foo refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'several overlapping excluded regions' '
+	for_each_ref__exclude refs/heads \
+		refs/heads/bar refs/heads/baz refs/heads/foo >actual &&
+	for_each_ref refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'non-matching excluded section' '
+	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual &&
+	for_each_ref >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'meta-characters are discarded' '
+	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
+	for_each_ref >expect &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
2.41.0.44.gf2359540d2


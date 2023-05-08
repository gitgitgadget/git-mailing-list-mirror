Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B2C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjEHWAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjEHWAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:21 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4802A59F9
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-559ded5e170so75048617b3.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583210; x=1686175210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgGZeyce8W0QZZ370IlNHcF36abGDFrZnbfxGCwVQUs=;
        b=Tw9oTmAreb62qLHwaIwKYlooGElV4jwn357KjXRuyxulTf1Clq7oG2Lh0/4uOBjvrj
         ADu6ur4OH3r+J56+plsQMs+1XSoQgoB/Kfk8D/eucmYTRrqcLuPYfhBjVbXVUmBS5PM6
         +PfZ1+2wrO904QJEL1QqmIeeRZxxZl0BHIcXmiq5RWj667sbOzHClivLFDvn7XQAmU7E
         xgXxBtjkG+G3Yptzd0zpXioxeXzLQo6oAjD82t9zfydn5+EfmAwOoU+oVDWV2eBEL1Zr
         R52Vd+kR7N1po2dMB+Llg3Ty+tbo1p89DK6xPsk9reH8Z9lOjIJRUdCc7zLLXm5+3pr0
         X+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583210; x=1686175210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgGZeyce8W0QZZ370IlNHcF36abGDFrZnbfxGCwVQUs=;
        b=DUTkWpw0ApsF5f5mRHGDUmd6Y9jgLGpRStxj4TT3ZLxxTS76QE71zCIrNYu0lJGB9E
         +RwaFzMQ7Xkvx97kmGldujrhSgiA8TYce5IjQQuPl1aPlLIzfAFRG1QMPLSmf166TDdQ
         CK+vCtM1XTLkMdPEPZTRmuPZNU4fI0EaHk+nTdRIadbs4INFBFTWNJuClP/eF4Cs2wIA
         ReIGbeE41Tg6CfVxQm1w3MAUmFUPFdFaueex1XSKcQCF7CWCef75fy7WPPGE+aohmwF9
         oEQ2HT0pNjZehR256we94PUEg5p2fr7ekpqtV0YBXrKZUQiUwTQTYATLEldp5gds9heS
         tY+A==
X-Gm-Message-State: AC+VfDxhTEcZEEbXUfOmhkHHs96e+dl/6jRv6Pk4qqH2TbvPomMeRVY3
        sXTRlgQd6U09i8CoPW0J5r9j1bL2Xou30zOQqrD4JQ==
X-Google-Smtp-Source: ACHHUZ7QAX1uGqSw+C3geJY2B/GN0Fq7oEOnYHz4GrmwLPuPFabo4b88ys41GPEGZW60ZUcXVu+T8A==
X-Received: by 2002:a81:6d05:0:b0:55a:c51:9a15 with SMTP id i5-20020a816d05000000b0055a0c519a15mr13279148ywc.22.1683583210147;
        Mon, 08 May 2023 15:00:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n12-20020a819c4c000000b005460251b0d9sm2783092ywa.82.2023.05.08.15.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:09 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/15] refs/packed-backend.c: implement skip lists to avoid
 excluded pattern(s)
Message-ID: <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
    and the first pattern that *doesn't* match it (i.e. the location
    you'd next want to consider when excluding that pattern).

  - Sort the patterns by their starting location within the
    `packed-refs` file.

  - Construct a skip list of regions by combining adjacent and
    overlapping regions from the previous step.

  - When iterating through the `packed-refs` file, if `iter->pos` is
    ever contained in one of the regions from the previous steps,
    advance `iter->pos` past the end of that region, and continue
    enumeration.

Note that this optimization is only possible when none of the excluded
pattern(s) have special meta-characters in them. To see why this is the
case, consider the exclusion pattern "refs/foo[a]". In general, in order
to find the location of the first record that matches this pattern, we
could only consider up to the first meta-character, "refs/foo". But this
doesn't work, since the excluded region we'd come up with would include
"refs/foobar", even though it is not excluded.

There are a few other gotchas worth considering. First, note that the
skip list is sorted, so once we skip past a region, we can avoid
considering it (or any regions preceding it) again. The member
`skip_pos` is used to track the first next-possible region to jump
through.

Second, note that the exclusion list is best-effort, since we do not
handle loose references, and because of the meta-character issue above.

In repositories with a large number of hidden references, the speed-up
can be significant. Tests here are done with a copy of linux.git with a
reference "refs/pull/N" pointing at every commit, as in:

    $ git rev-list HEAD | awk '{ print "create refs/pull/" NR " " $0 }' |
        git update-ref --stdin
    $ git pack-refs --all

, it is significantly faster to have `for-each-ref` skip over the
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

Using the skip list is fairly straightforward (see the changes to
`refs/packed-backend.c::next_record()`), but constructing the list is
not. To ensure that the construction is correct, add a new suite of
tests in t1419 covering various corner cases (overlapping regions,
partially overlapping regions, adjacent regions, etc.).

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c              |   5 +-
 refs/packed-backend.c     | 150 +++++++++++++++++++++++++++++++++++++-
 t/helper/test-ref-store.c |  10 +++
 t/t1419-exclude-refs.sh   | 101 +++++++++++++++++++++++++
 4 files changed, 263 insertions(+), 3 deletions(-)
 create mode 100755 t/t1419-exclude-refs.sh

diff --git a/ref-filter.c b/ref-filter.c
index c8ced1104b..56ebd332fa 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2208,12 +2208,13 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
 		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						 "", NULL, cb, cb_data);
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
index 98f96bf3ee..137a4233f6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -595,6 +595,21 @@ static const char *find_reference_location(struct snapshot *snapshot,
 	return find_reference_location_1(snapshot, refname, mustexist, 1);
 }
 
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
+}
+
 /*
  * Create a newly-allocated `snapshot` of the `packed-refs` file in
  * its current state and return it. The return value will already have
@@ -786,6 +801,13 @@ struct packed_ref_iterator {
 	/* The end of the part of the buffer that will be iterated over: */
 	const char *eof;
 
+	struct skip_list_entry {
+		const char *start;
+		const char *end;
+	} *skip;
+	size_t skip_nr, skip_alloc;
+	size_t skip_pos;
+
 	/* Scratch space for current values: */
 	struct object_id oid, peeled;
 	struct strbuf refname_buf;
@@ -803,14 +825,34 @@ struct packed_ref_iterator {
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
+	while (iter->skip_pos < iter->skip_nr) {
+		struct skip_list_entry *curr = &iter->skip[iter->skip_pos];
+		if (iter->pos < curr->start)
+			break; /* not to the next jump yet */
+
+		iter->skip_pos++;
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
@@ -918,6 +960,7 @@ static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
 	int ok = ITER_DONE;
 
 	strbuf_release(&iter->refname_buf);
+	free(iter->skip);
 	release_snapshot(iter->snapshot);
 	base_ref_iterator_free(ref_iterator);
 	return ok;
@@ -929,6 +972,108 @@ static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 	.abort = packed_ref_iterator_abort
 };
 
+static int skip_list_entry_cmp(const void *va, const void *vb)
+{
+	const struct skip_list_entry *a = va;
+	const struct skip_list_entry *b = vb;
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
+static const char *ptr_max(const char *x, const char *y)
+{
+	if (x > y)
+		return x;
+	return y;
+}
+
+static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
+					struct snapshot *snapshot,
+					const char **excluded_patterns)
+{
+	size_t i, j;
+	const char **pattern;
+
+	if (!excluded_patterns)
+		return;
+
+	for (pattern = excluded_patterns; *pattern; pattern++) {
+		struct skip_list_entry *e;
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
+		ALLOC_GROW(iter->skip, iter->skip_nr + 1, iter->skip_alloc);
+
+		e = &iter->skip[iter->skip_nr++];
+		e->start = find_reference_location(snapshot, *pattern, 0);
+		e->end = find_reference_location_end(snapshot, *pattern, 0);
+	}
+
+	if (!iter->skip_nr) {
+		/*
+		 * Every entry in exclude_patterns has a meta-character,
+		 * nothing to do here.
+		 */
+		return;
+	}
+
+	QSORT(iter->skip, iter->skip_nr, skip_list_entry_cmp);
+
+	/*
+	 * As an optimization, merge adjacent entries in the skip list
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
+	for (i = 1, j = 1; i < iter->skip_nr; i++) {
+		struct skip_list_entry *ours = &iter->skip[i];
+		struct skip_list_entry *prev = &iter->skip[i - 1];
+
+		if (ours->start == ours->end) {
+			/* ignore empty regions (no matching entries) */
+			continue;
+		} else if (prev->end >= ours->start) {
+			/* overlapping regions extend the previous one */
+			prev->end = ptr_max(prev->end, ours->end);
+		} else {
+			/* otherwise, insert a new region */
+			iter->skip[j++] = *ours;
+		}
+	}
+
+	iter->skip_nr = j;
+	iter->skip_pos = 0;
+}
+
 static struct ref_iterator *packed_ref_iterator_begin(
 		struct ref_store *ref_store,
 		const char *prefix, const char **exclude_patterns,
@@ -964,6 +1109,9 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
 
+	if (exclude_patterns)
+		populate_excluded_skip_list(iter, snapshot, exclude_patterns);
+
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 6d8f844e9c..2bff003f7c 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -175,6 +175,15 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
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
@@ -307,6 +316,7 @@ static struct command commands[] = {
 	{ "delete-refs", cmd_delete_refs },
 	{ "rename-ref", cmd_rename_ref },
 	{ "for-each-ref", cmd_for_each_ref },
+	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
 	{ "resolve-ref", cmd_resolve_ref },
 	{ "verify-ref", cmd_verify_ref },
 	{ "for-each-reflog", cmd_for_each_reflog },
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
new file mode 100755
index 0000000000..da5265a5a8
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
+test_expect_success 'for_each_ref__exclude(refs/heads/foo/)' '
+	# region in middle
+	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
+	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'for_each_ref__exclude(refs/heads/bar/)' '
+	# region at beginning
+	for_each_ref__exclude refs/heads refs/heads/bar >actual &&
+	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'for_each_ref__exclude(refs/heads/quux/)' '
+	# region at end
+	for_each_ref__exclude refs/heads refs/heads/quux >actual &&
+	for_each_ref refs/heads/foo refs/heads/bar refs/heads/baz >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/quux/)' '
+	# disjoint regions
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual &&
+	for_each_ref refs/heads/baz refs/heads/foo >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/baz/)' '
+	# adjacent, non-overlapping regions
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual &&
+	for_each_ref refs/heads/foo refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'for_each_ref__exclude(refs/heads/ba refs/heads/baz/)' '
+	# overlapping region
+	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual &&
+	for_each_ref refs/heads/foo refs/heads/quux >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'for_each_ref__exclude(refs/heads/does/not/exist)' '
+	# empty region
+	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual &&
+	for_each_ref >expect &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'for_each_ref__exclude(refs/heads/ba*)' '
+	# discards meta-characters
+	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
+	for_each_ref >expect &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
2.40.1.477.g956c797dfc


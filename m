Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1546B202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 16:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbdIUQtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 12:49:41 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34251 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdIUQtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 12:49:40 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CGpe1w00A0M91Ur01GpfB2; Thu, 21 Sep 2017 17:49:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=r1TGXED2hVWV2PWFCtEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 4/4] ALLOC_GROW: avoid -Wsign-compare warnings
Message-ID: <c97784ce-d85d-2b7a-4eb7-d4043dc1a0b7@ramsayjones.plus.com>
Date:   Thu, 21 Sep 2017 17:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/pack-objects.c |  4 ++--
 config.c               |  2 +-
 diff.c                 |  2 +-
 line-log.c             | 18 +++++++++---------
 line-log.h             |  2 +-
 revision.c             |  2 +-
 tree-walk.c            |  3 +--
 7 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a57b4f058..a6ee653bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2563,8 +2563,8 @@ struct in_pack_object {
 };
 
 struct in_pack {
-	int alloc;
-	int nr;
+	unsigned int alloc;
+	unsigned int  nr;
 	struct in_pack_object *array;
 };
 
diff --git a/config.c b/config.c
index cd5a69e63..aeab02c06 100644
--- a/config.c
+++ b/config.c
@@ -2200,7 +2200,7 @@ static struct {
 	size_t *offset;
 	unsigned int offset_alloc;
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
-	int seen;
+	unsigned int seen;
 } store;
 
 static int matches(const char *key, const char *value)
diff --git a/diff.c b/diff.c
index ea7e5978b..be94ad4f4 100644
--- a/diff.c
+++ b/diff.c
@@ -1541,7 +1541,7 @@ static void emit_rewrite_diff(const char *name_a,
 
 struct diff_words_buffer {
 	mmfile_t text;
-	long alloc;
+	unsigned long alloc;
 	struct diff_words_orig {
 		const char *begin, *end;
 	} *orig;
diff --git a/line-log.c b/line-log.c
index ab0709f9a..545ad0f28 100644
--- a/line-log.c
+++ b/line-log.c
@@ -90,7 +90,7 @@ static int range_cmp(const void *_r, const void *_s)
  */
 static void range_set_check_invariants(struct range_set *rs)
 {
-	int i;
+	unsigned int i;
 
 	if (!rs)
 		return;
@@ -110,8 +110,8 @@ static void range_set_check_invariants(struct range_set *rs)
  */
 void sort_and_merge_range_set(struct range_set *rs)
 {
-	int i;
-	int o = 0; /* output cursor */
+	unsigned int i;
+	unsigned int o = 0; /* output cursor */
 
 	QSORT(rs->ranges, rs->nr, range_cmp);
 
@@ -144,7 +144,7 @@ void sort_and_merge_range_set(struct range_set *rs)
 static void range_set_union(struct range_set *out,
 			     struct range_set *a, struct range_set *b)
 {
-	int i = 0, j = 0;
+	unsigned int i = 0, j = 0;
 	struct range *ra = a->ranges;
 	struct range *rb = b->ranges;
 	/* cannot make an alias of out->ranges: it may change during grow */
@@ -186,7 +186,7 @@ static void range_set_union(struct range_set *out,
 static void range_set_difference(struct range_set *out,
 				  struct range_set *a, struct range_set *b)
 {
-	int i, j =  0;
+	unsigned int i, j =  0;
 	for (i = 0; i < a->nr; i++) {
 		long start = a->ranges[i].start;
 		long end = a->ranges[i].end;
@@ -397,7 +397,7 @@ static void diff_ranges_filter_touched(struct diff_ranges *out,
 				       struct diff_ranges *diff,
 				       struct range_set *rs)
 {
-	int i, j = 0;
+	unsigned int i, j = 0;
 
 	assert(out->target.nr == 0);
 
@@ -426,7 +426,7 @@ static void range_set_shift_diff(struct range_set *out,
 				 struct range_set *rs,
 				 struct diff_ranges *diff)
 {
-	int i, j = 0;
+	unsigned int i, j = 0;
 	long offset = 0;
 	struct range *src = rs->ranges;
 	struct range *target = diff->target.ranges;
@@ -873,7 +873,7 @@ static char *output_prefix(struct diff_options *opt)
 
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
 {
-	int i, j = 0;
+	unsigned int i, j = 0;
 	long p_lines, t_lines;
 	unsigned long *p_ends = NULL, *t_ends = NULL;
 	struct diff_filepair *pair = range->pair;
@@ -906,7 +906,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 		long t_start = range->ranges.ranges[i].start;
 		long t_end = range->ranges.ranges[i].end;
 		long t_cur = t_start;
-		int j_last;
+		unsigned int j_last;
 
 		while (j < diff->target.nr && diff->target.ranges[j].end < t_start)
 			j++;
diff --git a/line-log.h b/line-log.h
index 7a5c24e2d..e2a5ee7c6 100644
--- a/line-log.h
+++ b/line-log.h
@@ -14,7 +14,7 @@ struct range {
 
 /* A set of ranges.  The ranges must always be disjoint and sorted. */
 struct range_set {
-	int alloc, nr;
+	unsigned int alloc, nr;
 	struct range *ranges;
 };
 
diff --git a/revision.c b/revision.c
index f9a90d71d..c8c9cb32c 100644
--- a/revision.c
+++ b/revision.c
@@ -1105,7 +1105,7 @@ static void add_rev_cmdline(struct rev_info *revs,
 			    unsigned flags)
 {
 	struct rev_cmdline_info *info = &revs->cmdline;
-	int nr = info->nr;
+	unsigned int nr = info->nr;
 
 	ALLOC_GROW(info->rev, nr + 1, info->alloc);
 	info->rev[nr].item = item;
diff --git a/tree-walk.c b/tree-walk.c
index c99309069..684f0e337 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -582,12 +582,11 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 	int retval = MISSING_OBJECT;
 	struct dir_state *parents = NULL;
 	size_t parents_alloc = 0;
-	ssize_t parents_nr = 0;
+	size_t i, parents_nr = 0;
 	unsigned char current_tree_sha1[20];
 	struct strbuf namebuf = STRBUF_INIT;
 	struct tree_desc t;
 	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
-	int i;
 
 	init_tree_desc(&t, NULL, 0UL);
 	strbuf_addstr(&namebuf, name);
-- 
2.14.0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10F920248
	for <e@80x24.org>; Wed, 10 Apr 2019 16:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfDJQYt (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 12:24:49 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52521 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfDJQYt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 12:24:49 -0400
Received: by mail-qk1-f202.google.com with SMTP id x23so2423707qka.19
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JYb7GTkCy2YVPCJLwzABj8bSrnvdxCn4t/H5qLhv6qo=;
        b=ry1ZGo8ljkmDwFLbmWyQZge8kEZFi/xPtgZuCRSlXLOg7PUG0qfiRT70K6kVI4OGYh
         NSaNtYcHRVxBwZG+RhjQm77SIX8sWQghku+M8zGOEb2z/yjPwLXzH3rseOe0aDfFPZqj
         jeRqN2pf6XXMQYAME/h7nb/KpCdbVVmDAjUIqwGtBAbDWtbjZdNhejTKOKe2oTDdHC1z
         CXbPe7JISctzvm5CU4HPEz5ro5PQ3vHZA8x0lMJA40KxhV06n4XVtbGh2ddQVu7eMAOl
         0YIt1RH345JVyToNTaUTqtDwcxaXvkm6CdsfvNu5OZLECl0WZgctwMd1NG9OdU56whTd
         U61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JYb7GTkCy2YVPCJLwzABj8bSrnvdxCn4t/H5qLhv6qo=;
        b=GTZ/DW4/rr7hTAa+QNORocTM2ySiIKVqh4AavqZckMyedFERZGinEaGoIgfoZX9xc8
         dZ1OoccboU6m7Ksk9xVZmUSPI2O68zviDEWu9nxhfkAk/K6ReuEFG4vuFbAQMm5I0+S5
         Cj9VpyH9DXiAQzS9DGXC1FO/79PvLZpM7Yi6WcaQtm+WmexN2h/mZ2LE6fdDIAWjmK4B
         iDVW1Dswimx6ODMybOJSC/il3xbVrqkWWRgNu0QqEFFYUuu66zA+GMNnCz0ZteEJxvWZ
         L15CIVW9ege+WxxYFP9+mibXAI76SepZgRpcTqEIm6IEcolJJy4czJQ6Q6x82XXNt/0g
         su9A==
X-Gm-Message-State: APjAAAUG342h3CL5EO3UCtUrKDivykLSnZf3XeSQiGxzySJBOOUX0bao
        Vmc7cUMvVVpsgCCDKKgw/JOUqZOVevehC9fJQNH84X2TEht+tK5OOi34XMvGLOD/9Y3C4sDZhIz
        R/1n2xhXnbcyQgesgXwQT5a4K2AmrUBaUns2mqcGYUnE+VzYqZNAL
X-Google-Smtp-Source: APXvYqzovj3eVrYvmsknGceZUjsFlgDtcN+dklRtkQjR1dDJ+8zYktHvK3yCJogmN+3WV40p152g9QWy
X-Received: by 2002:a37:a256:: with SMTP id l83mr5627446qke.14.1554913488153;
 Wed, 10 Apr 2019 09:24:48 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:24:09 -0400
In-Reply-To: <20190410162409.117264-1-brho@google.com>
Message-Id: <20190410162409.117264-7-brho@google.com>
Mime-Version: 1.0
References: <20190410162409.117264-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v6 6/6] blame: use a fingerprint heuristic to match ignored lines
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     Michael Platings <michael@platin.gs>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces the heuristic used to identify lines from ignored commits
with one that finds likely candidate lines in the parent's version of
the file.

The old heuristic simply assigned lines in the target to the same line
number (plus offset) in the parent.  The new function uses a
fingerprinting algorithm to detect similarity between lines.

The fingerprint code and the idea to use them for blame came from
Michael Platings <michael@platin.gs>.

For each line changed in the target, i.e. in a blame_entry touched by a
target's diff, guess_line_blames() finds the best line in the parent,
above a magic threshold.  Ties are broken by proximity of the parent
line number to the target's line.

We actually make two passes.  The first pass checks in the diff chunk
associated with the blame entry - specifically from blame_chunk().
Often times, those diff chunks are small; any 'context' in a normal diff
chunk is broken up into multiple calls to blame_chunk().  We make a
second pass over the entire parent, with a slightly higher threshold.

Here's an example of the difference the fingerprinting makes.  Consider
a file with four commits:

	commit-a 11) void new_func_1(void *x, void *y);
	commit-b 12) void new_func_2(void *x, void *y);
	commit-c 13) some_line_c
	commit-d 14) some_line_d

After a commit 'X', we have:

	commit-X 11) void new_func_1(void *x,
	commit-X 12)                 void *y);
	commit-X 13) void new_func_2(void *x,
	commit-X 14)                 void *y);
	commit-c 15) some_line_c
	commit-d 16) some_line_d

When we blame-ignored with the old algorithm, we get:

	commit-a 11) void new_func_1(void *x,
	commit-b 12)                 void *y);
	00000000 13) void new_func_2(void *x,
	00000000 14)                 void *y);
	commit-c 15) some_line_c
	commit-d 16) some_line_d

Where commit-b is blamed for 12 instead of 13.  With the fingerprint
algorithm, we get:

	commit-a 11) void new_func_1(void *x,
	commit-b 12)                 void *y);
	commit-b 13) void new_func_2(void *x,
	commit-b 14)                 void *y);
	commit-c 15) some_line_c
	commit-d 16) some_line_d

Note both lines 12 and 14 are given to commit b.  Their match is above
the FINGERPRINT_CHUNK_THRESHOLD, and they tied.  Specifically, parent
lines 11 and 12 both match these lines.  The algorithm chose parent line
12, since that was closest to the target line numbers of 12 and 14.

If we increase the threshold, say to 10, those two lines won't match,
and will be treated as 'unblamable.'

For an example of scanning the entire parent for a match, consider:

	commit-a 30) #include <sys/header_a.h>
	commit-b 31) #include <header_b.h>
	commit-c 32) #include <header_c.h>

Then commit X alphabetizes them:

	commit-X 30) #include <header_b.h>
	commit-X 31) #include <header_c.h>
	commit-X 32) #include <sys/header_a.h>

If we just check the parent's chunk (i.e. the first pass), we'd get:

	commit-b 30) #include <header_b.h>
	commit-c 31) #include <header_c.h>
	00000000 32) #include <sys/header_a.h>

That's because commit X consists of two chunks: one chunk is removing
sys/header_a.h, then some context, and the second chunk is adding
sys/header_a.h.

If we scan the entire parent file, we get:

	commit-b 30) #include <header_b.h>
	commit-c 31) #include <header_c.h>
	commit-a 32) #include <sys/header_a.h>

Suggested-by: Michael Platings <michael@platin.gs>
Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 9 deletions(-)

diff --git a/blame.c b/blame.c
index a42dff80b1a5..da2d664b38af 100644
--- a/blame.c
+++ b/blame.c
@@ -340,6 +340,84 @@ static int find_line_starts(int **line_starts, const char *buf,
 	return num;
 }
 
+struct fingerprint {
+	struct hashmap map;
+	struct hashmap_entry *entries;
+};
+
+static void get_fingerprint(struct fingerprint *result,
+			    const char *line_begin,
+			    const char *line_end)
+{
+	unsigned int hash;
+	char c0, c1;
+	const char *p;
+	int map_entry_count = line_end - line_begin - 1;
+	struct hashmap_entry *entry = xcalloc(map_entry_count,
+					      sizeof(struct hashmap_entry));
+
+	hashmap_init(&result->map, NULL, NULL, map_entry_count);
+	result->entries = entry;
+	for (p = line_begin; p + 1 < line_end; ++p, ++entry) {
+		c0 = *p;
+		c1 = *(p + 1);
+		/* Ignore whitespace pairs */
+		if (isspace(c0) && isspace(c1))
+			continue;
+		hash = tolower(c0) | (tolower(c1) << 8);
+		hashmap_entry_init(entry, hash);
+		hashmap_put(&result->map, entry);
+	}
+}
+
+static void free_fingerprint(struct fingerprint *f)
+{
+	hashmap_free(&f->map, 0);
+	free(f->entries);
+}
+
+static int fingerprint_similarity(struct fingerprint *a,
+				  struct fingerprint *b)
+{
+	int intersection = 0;
+	struct hashmap_iter iter;
+	struct hashmap_entry *entry;
+
+	hashmap_iter_init(&b->map, &iter);
+
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (hashmap_get(&a->map, entry, NULL))
+			++intersection;
+	}
+	return intersection;
+}
+
+static void get_line_fingerprints(struct fingerprint *fingerprints,
+				  const char *content,
+				  const int *line_starts,
+				  int first_line,
+				  int nr_lines)
+{
+	int i;
+
+	line_starts += first_line;
+	for (i = 0; i < nr_lines; ++i) {
+		const char *linestart = content + line_starts[i];
+		const char *lineend = content + line_starts[i + 1];
+
+		get_fingerprint(fingerprints + i, linestart, lineend);
+	}
+}
+
+static void free_chunk_fingerprints(struct fingerprint *fingerprints,
+				    int nr_fingerprints)
+{
+	int i;
+
+	for (i = 0; i < nr_fingerprints; i++)
+		free_fingerprint(&fingerprints[i]);
+}
+
 static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
 {
 	int *line_starts;
@@ -348,14 +426,16 @@ static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *file)
 		return;
 	o->num_lines = find_line_starts(&line_starts, o->file.ptr,
 					o->file.size);
-	/* TODO: Will fill in fingerprints in a future commit */
 	o->fingerprints = xcalloc(sizeof(struct fingerprint), o->num_lines);
+	get_line_fingerprints(o->fingerprints, o->file.ptr, line_starts,
+			      0, o->num_lines);
 	free(line_starts);
 }
 
 static void drop_origin_fingerprints(struct blame_origin *o)
 {
 	if (o->fingerprints) {
+		free_chunk_fingerprints(o->fingerprints, o->num_lines);
 		o->num_lines = 0;
 		FREE_AND_NULL(o->fingerprints);
 	}
@@ -935,27 +1015,69 @@ static int are_lines_adjacent(struct blame_line_tracker *first,
 	       first->s_lno + 1 == second->s_lno;
 }
 
+static void scan_parent_range(struct fingerprint *p_fps,
+			      struct fingerprint *t_fps, int t_idx,
+			      int from, int nr_lines,
+			      int *best_sim_val, int *best_sim_idx)
+{
+	int sim, p_idx;
+
+	for (p_idx = from; p_idx < from + nr_lines; p_idx++) {
+		sim = fingerprint_similarity(&t_fps[t_idx], &p_fps[p_idx]);
+		if (sim < *best_sim_val)
+			continue;
+		/* Break ties with the closest-to-target line number */
+		if (sim == *best_sim_val && *best_sim_idx != -1 &&
+		    abs(*best_sim_idx - t_idx) < abs(p_idx - t_idx))
+			continue;
+		*best_sim_val = sim;
+		*best_sim_idx = p_idx;
+	}
+}
+
 /*
- * This cheap heuristic assigns lines in the chunk to their relative location in
- * the parent's chunk.  Any additional lines are left with the target.
+ * The CHUNK threshold is for how similar we must be within a diff chunk, which
+ * is typically the adjacent '-' and '+' sections in a diff, separated by the
+ * ' ' context.
+ *
+ * We have a greater threshold for similarity for lines in any part of the
+ * parent's file.  If no line in the parent meets the appropriate threshold,
+ * then the blame_entry will stay with the target and be considered
+ * 'unblamable'.
  */
+#define FINGERPRINT_CHUNK_THRESHOLD	1
+#define FINGERPRINT_FILE_THRESHOLD	10
+
 static void guess_line_blames(struct blame_entry *e,
 			      struct blame_origin *parent,
 			      struct blame_origin *target,
 			      int offset, int parent_slno, int parent_len,
 			      struct blame_line_tracker *line_blames)
 {
-	int i, parent_idx;
+	int i, target_idx;
 
 	for (i = 0; i < e->num_lines; i++) {
-		parent_idx = e->s_lno + i + offset;
-		if (parent_slno <= parent_idx &&
-		    parent_idx < parent_slno + parent_len) {
+		int best_val = FINGERPRINT_CHUNK_THRESHOLD;
+		int best_idx = -1;
+
+		target_idx = e->s_lno + i;
+		scan_parent_range(parent->fingerprints,
+				  target->fingerprints, target_idx,
+				  parent_slno, parent_len,
+				  &best_val, &best_idx);
+		if (best_idx == -1) {
+			best_val = FINGERPRINT_FILE_THRESHOLD;
+			scan_parent_range(parent->fingerprints,
+					  target->fingerprints, target_idx,
+					  0, parent->num_lines,
+					  &best_val, &best_idx);
+		}
+		if (best_idx >= 0) {
 			line_blames[i].is_parent = 1;
-			line_blames[i].s_lno = parent_idx;
+			line_blames[i].s_lno = best_idx;
 		} else {
 			line_blames[i].is_parent = 0;
-			line_blames[i].s_lno = e->s_lno + i;
+			line_blames[i].s_lno = target_idx;
 		}
 	}
 }
-- 
2.21.0.392.gf8f6787159e-goog


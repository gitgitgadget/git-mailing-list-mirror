Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5404F20248
	for <e@80x24.org>; Wed,  3 Apr 2019 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfDCQCZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 12:02:25 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:46674 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDCQCY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 12:02:24 -0400
Received: by mail-yb1-f201.google.com with SMTP id w7so12931624ybp.13
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vTMv3QPI6Pla6XvF00bREwFsePuzc1VMiiGs3G9vnyA=;
        b=tyE2NTLOEQplqXycBWJh6xw4AmV8EgpfTKP9fhp8vqWGtyaGAg2d+3jXrL66cxLUFc
         567NsZOfZZOcIw0QKClI546h4vSzu6OQ79CF+ka5pL7Kqtz3x7EobXBVoLBQfvl7L1eM
         fbrbJgpNjtD4QnN+CiFigm21+VD59RGnJ98F0aBX28lNODL3JvxwKbPJ2vQ/Cti6I4EZ
         4Yc4vPU6PdjNeGeE1TVkkkEDciJG85BhlXyx8sX+Nwy/CUT2Fvrv7LNBddDlZASSsaXK
         81qAFwwVuTHDTFcHcJiesWQWluGH1GO/aMtGa1Pd1pG3H/GdUVVEqb/nt6PEfGdAPseh
         WJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vTMv3QPI6Pla6XvF00bREwFsePuzc1VMiiGs3G9vnyA=;
        b=VBtS0s/DwjdJO2TVGph77eosffuV85Epbx5eBbrIOuLN8lBSy2VQpPuQQr6P1jYOEh
         rqtwVe2r2e614eGXZKRtmJESiIQ9Wh7TrSzqaj+W8x/r40428EcZ4hAaNeF+/J3ZDXpv
         pyarcDSQZxonSfK5eazUVeBeiEzNAPIdmSSiKJcT9BXY9YzHRGkISymRwU9Is1G/dPhV
         WDLN7y1XNU7ZT0C0Z503SVH7tiZoxT2yE+pj3PwI+I6pgugDIEE09UDnh9b6ErNyU8qI
         Q7ImqZ+KH4d/dIoTa6vfOOe7KGMHhrFuZ+jHlbOTTvixlfTP0XRA4OO3qKJHm5g+RaG7
         TAkQ==
X-Gm-Message-State: APjAAAU572+pNRUoBGWD7zBgiO0H/qtsOZ9wWdNJVcxv//MXLjxEBoky
        jCSUWrbmmw7u0GIOJ4L6qvlV/E+IQWzmU6bKBZl28v+NWYRDx6l9FPT+DosjPSDAV7NoDgHsou2
        t0VMjPME/KpASogE48VUPtvE8QRIjUf8g9ariogdzy3gUVt3rJ7ZK
X-Google-Smtp-Source: APXvYqwa1JI1/ISpyrfOi9tdtrcLAdZ3paSYiJ5oU2SZ1CsfsDGdHXVC6dkl7K+rYP6aPUTyqumZ8Xmh
X-Received: by 2002:a25:370a:: with SMTP id e10mr174863yba.81.1554307342683;
 Wed, 03 Apr 2019 09:02:22 -0700 (PDT)
Date:   Wed,  3 Apr 2019 12:02:07 -0400
In-Reply-To: <20190403160207.149174-1-brho@google.com>
Message-Id: <20190403160207.149174-7-brho@google.com>
Mime-Version: 1.0
References: <20190403160207.149174-1-brho@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines
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
number (plus offset) in the parent.  The new function uses
fingerprinting based on the sum of the bitwise-ORed bits in a string.

The fingerprint code and the idea to use them for blame
came from Michael Platings <michael@platin.gs>.

For each line in the target, guess_line_blames() finds the best line in
the parent, above a magic threshold (1 byte pair, currently).  Ties are
broken by proximity of the parent line number to the target's line.

Here's an example of the difference between algorithms.  Consider a file
with four commits:

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
the FINGERPRINT_THRESHOLD, and they tied.  Specifically, parent lines 11
and 12 both match these lines.  The algorithm chose parent line 12,
since that was closest to the target line numbers of 12 and 14.

If we increase the threshold, say to 10, those two lines won't match,
and will be treated as 'unblamable.'

TODO:
- Is '1' a decent threshold?  Add another user option?

- Can we decrease that FINGERPRINT_LENGTH?  Or do something about the
TODO about using a set data structure?

- How about matching *outside* the parent's diff hunk?  Right now, this
just looks in the parent's hunk for a match.  But a better match may be
elsewhere in the file.  This might happen when the diff has too small of
a -M.  If we do this, then consider caching the fingerprints for a
parent's entire file, since multiple target blame_entries may check the
entire parent's space.  Also, if we do this, we probably need to sort the
parent's blame list (again), since the spliced entries point outside of
the diff hunk's range in the parent's address space.

- If we never intend to match outside the parent's diff hunk, then we
might be able to short-circuit guess_line_blames() when the parent's
chunk length is 0.  Doing this somewhat limits the algorithms, and would
be a performance optimization, which I didn't want to do without numbers
saying we needed it.

- Fix up this commit + message.  I'd be up for splitting it more,
particularly if Michael wants his contributions/fingerprinting in his
own commit.

Suggested-by: Michael Platings <michael@platin.gs>
Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/blame.c b/blame.c
index c06cbd906658..50511a300059 100644
--- a/blame.c
+++ b/blame.c
@@ -915,27 +915,109 @@ static int are_lines_adjacent(struct blame_line_tracker *first,
 	       first->s_lno + 1 == second->s_lno;
 }
 
-/*
- * This cheap heuristic assigns lines in the chunk to their relative location in
- * the parent's chunk.  Any additional lines are left with the target.
+/* https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel */
+static int bitcount(uint32_t v)
+{
+	v = v - ((v >> 1) & 0x55555555u);
+	v = (v & 0x33333333u) + ((v >> 2) & 0x33333333u);
+	return (((v + (v >> 4)) & 0xf0f0f0fu) * 0x1010101u) >> 24;
+}
+
+#define FINGERPRINT_LENGTH (8 * 256)
+#define FINGERPRINT_THRESHOLD 1
+/* This is just a bitset indicating which byte pairs are present.
+ * e.g. the string "good goo" has pairs "go", "oo", "od", "d ", " g"
+ * String similarity is calculated as a bitwise or and counting the set bits.
+ *
+ * TODO for the string lengths we typically deal with, this would probably be
+ * implemented more efficiently with a set data structure.
  */
+struct fingerprint {
+	uint32_t bits[FINGERPRINT_LENGTH];
+};
+
+static void get_fingerprint(struct fingerprint *result, const char *line_begin,
+			    const char *line_end)
+{
+	for (const char *p = line_begin; p + 1 < line_end; ++p) {
+		unsigned int c = tolower(*p) | (tolower(*(p + 1)) << 8);
+
+		result->bits[c >> 5] |= 1u << (c & 0x1f);
+	}
+}
+
+static int fingerprint_similarity(const struct fingerprint *a,
+				  const struct fingerprint *b)
+{
+	int intersection = 0;
+
+	for (int i = 0; i < FINGERPRINT_LENGTH; ++i)
+		intersection += bitcount(a->bits[i] & b->bits[i]);
+	return intersection;
+}
+
+static void get_chunk_fingerprints(struct fingerprint *fingerprints,
+				   const char *content,
+				   const int *line_starts,
+				   long chunk_start,
+				   long chunk_length)
+{
+	line_starts += chunk_start;
+	for (int i = 0; i != chunk_length; ++i) {
+		const char *linestart = content + line_starts[i];
+		const char *lineend = content + line_starts[i + 1];
+
+		get_fingerprint(fingerprints + i, linestart, lineend);
+	}
+}
+
 static void guess_line_blames(struct blame_entry *e,
 			      struct blame_origin *parent,
 			      struct blame_origin *target,
 			      int offset, int delta,
 			      struct blame_line_tracker *line_blames)
 {
+	struct fingerprint *fp_parent, *fp_target;
 	int nr_parent_lines = e->num_lines - delta;
 
+	fp_parent = xcalloc(sizeof(struct fingerprint), nr_parent_lines);
+	fp_target = xcalloc(sizeof(struct fingerprint), e->num_lines);
+
+	get_chunk_fingerprints(fp_parent, parent->file.ptr,
+			       parent->line_starts,
+			       e->s_lno + offset, nr_parent_lines);
+	get_chunk_fingerprints(fp_target, target->file.ptr,
+			       target->line_starts,
+			       e->s_lno, e->num_lines);
+
 	for (int i = 0; i < e->num_lines; i++) {
-		if (i < nr_parent_lines) {
+		int best_sim_val = FINGERPRINT_THRESHOLD;
+		int best_sim_idx = -1;
+		int sim;
+
+		for (int j = 0; j < nr_parent_lines; j++) {
+			sim = fingerprint_similarity(&fp_target[i],
+						     &fp_parent[j]);
+			if (sim < best_sim_val)
+				continue;
+			/* Break ties with the closest-to-target line number */
+			if (sim == best_sim_val && best_sim_idx != -1 &&
+			    abs(best_sim_idx - i) < abs(j - i))
+				continue;
+			best_sim_val = sim;
+			best_sim_idx = j;
+		}
+		if (best_sim_idx >= 0) {
 			line_blames[i].is_parent = 1;
-			line_blames[i].s_lno = e->s_lno + i + offset;
+			line_blames[i].s_lno = e->s_lno + offset + best_sim_idx;
 		} else {
 			line_blames[i].is_parent = 0;
 			line_blames[i].s_lno = e->s_lno + i;
 		}
 	}
+
+	free(fp_parent);
+	free(fp_target);
 }
 
 /*
-- 
2.21.0.392.gf8f6787159e-goog


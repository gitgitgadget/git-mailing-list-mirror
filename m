Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61CC1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391226AbfFJPaq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:30:46 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:44872 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391219AbfFJPao (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:30:44 -0400
Received: by mail-vs1-f74.google.com with SMTP id j186so3171727vsc.11
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Un9REOx/IZpoDzjitf5QBV6tXyco6TYaDvbmtB+l3XI=;
        b=DIROkU4VD/uOnzLpVLMc7tOKHRNpm0Bc7S4mCOEsDsKWdlZ0R469GVRrku/+mYkv83
         BY9tAdt88qAn6nhdAbETjVH2uhkoBgnBEoR0JjNUeTsUYK/kKKdRlMLdrWRGc4f+2vpU
         nHru3Ro/3h+/hlZOqzqMBch+lVwc0hew6kQXD6apPhlSuSkmQsI35m6MoQEmgkLVVny4
         nrRFXwiifndJ4VQjYiq+VNGUd9SMFOk5+FUqEQ+8yUoStny8TsdYtKRHScx7Um2xNkbY
         1TSDhXgRUgjcSq2vlH1w8AgQnu8o0x6OcN2TLiRjXdZ/WEZJB/JT+MYeFv2aeM7kDCye
         maKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Un9REOx/IZpoDzjitf5QBV6tXyco6TYaDvbmtB+l3XI=;
        b=NJPKvDZpjzngcmdLS2UknL2eOLaErcN1ShyiaSCe4ZeJ+uGY+BWUILp47iK7A+K1VM
         6whyoySLM1rqKnPp9rGDECk4ONNvtE++pMwvVM6/aepTgFkmXhspqrL759J9yEJPzEXH
         V+hhtG/jgfW6HC5VwAGlT2AKST3WF1G0/qX3J4rsKlATZZLledp5wnrzKXzbzXvCsoHs
         8SEOOQu6mJRONJ/O5ZCnBlOdOgxVbOQEAPXkidL1u/1Ts2IrjFYNFxfqBDwQ26UY8T66
         ss/WUI3xKumI4F8sJdSBaS+lB+Mzf0kIDXDLivOtzsrVWs622+V+sf1Wf98tvEO+bq2W
         Fc9g==
X-Gm-Message-State: APjAAAXJhLZCiVZz+jarzEoAI2nA0j7hODNzg/grxo0uBKS3NkEFLLt2
        UZoGNFZUCoZ2PFgAkO3+TacnrWgG7t5nIdnY4O2YInYU0ugJJYapuly4BZVj0408lZQ9o81KWwh
        7NskctG2jvD3i2ZA2yI6vO2kVl+BKFFTVEmcMj20MS378GRvTiT8v
X-Google-Smtp-Source: APXvYqxUNl3hL+PzNrWRRFqSLRYIlSpR2qlrQNsa8rnCHIViChzQlthRuZl5YD3HHWuCTSKmpkTj+cDQ
X-Received: by 2002:ab0:2746:: with SMTP id c6mr5122090uap.76.1560180642389;
 Mon, 10 Jun 2019 08:30:42 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:30:12 -0400
In-Reply-To: <20190610153014.42055-1-brho@google.com>
Message-Id: <20190610153014.42055-8-brho@google.com>
Mime-Version: 1.0
References: <20190610153014.42055-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v8 7/9] blame: add a fingerprint heuristic to match ignored lines
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
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

This algorithm will replace the heuristic used to identify lines from
ignored commits with one that finds likely candidate lines in the
parent's version of the file.  The actual replacement occurs in an
upcoming commit.

The old heuristic simply assigned lines in the target to the same line
number (plus offset) in the parent. The new function uses a
fingerprinting algorithm to detect similarity between lines.

The new heuristic is designed to accurately match changes made
mechanically by formatting tools such as clang-format and clang-tidy.
These tools make changes such as breaking up lines to fit within a
character limit or changing identifiers to fit with a naming convention.
The heuristic is not intended to match more extensive refactoring
changes and may give misleading results in such cases.

In most cases formatting tools preserve line ordering, so the heuristic
is optimised for such cases. (Some types of changes do reorder lines
e.g. sorting keep the line content identical, the git blame -M option
can already be used to address this). The reason that it is advantageous
to rely on ordering is due to source code repeating the same character
sequences often e.g. declaring an identifier on one line and using that
identifier on several subsequent lines.  This means that lines can look
very similar to each other which presents a problem when doing fuzzy
matching. Relying on ordering gives us extra clues to point towards the
true match.

The heuristic operates on a single diff chunk change at a time. It
creates a =E2=80=9Cfingerprint=E2=80=9D for each line on each side of the c=
hange.
Fingerprints are described in detail in the comment for `struct
fingerprint`, but essentially are a multiset of the character pairs in a
line. The heuristic first identifies the line in the target entry whose
fingerprint is most clearly matched to a line fingerprint in the parent
entry. Where fingerprints match identically, the position of the lines
is used as a tie-break. The heuristic locks in the best match, and
subtracts the fingerprint of the line in the target entry from the
fingerprint of the line in the parent entry to prevent other lines being
matched on the same parts of that line. It then repeats the process
recursively on the section of the chunk before the match, and then the
section of the chunk after the match.

Here's an example of the difference the fingerprinting makes. Consider
a file with two commits:

        commit-a 1) void func_1(void *x, void *y);
        commit-b 2) void func_2(void *x, void *y);

After a commit 'X', we have:

        commit-X 1) void func_1(void *x,
        commit-X 2)             void *y);
        commit-X 3) void func_2(void *x,
        commit-X 4)             void *y);

When we blame-ignored with the old algorithm, we get:

        commit-a 1) void func_1(void *x,
        commit-b 2)             void *y);
        commit-X 3) void func_2(void *x,
        commit-X 4)             void *y);

Where commit-b is blamed for 2 instead of 3.  With the fingerprint
algorithm, we get:

        commit-a 1) void func_1(void *x,
        commit-a 2)             void *y);
        commit-b 3) void func_2(void *x,
        commit-b 4)             void *y);

Note line 2 could be matched with either commit-a or commit-b as it is
equally similar to both lines, but is matched with commit-a because its
position as a fraction of the new line range is more similar to commit-a
as a fraction of the old line range. Line 4 is also equally similar to
both lines, but as it appears after line 3 which will be matched first
it cannot be matched with an earlier line.

For many more examples, see t/t8014-blame-ignore-fuzzy.sh which contains
example parent and target files and the line numbers in the parent that
must be matched.

Signed-off-by: Michael Platings <michael@platin.gs>
---
 blame.c                       | 642 ++++++++++++++++++++++++++++++++++
 t/t8014-blame-ignore-fuzzy.sh | 435 +++++++++++++++++++++++
 2 files changed, 1077 insertions(+)
 create mode 100755 t/t8014-blame-ignore-fuzzy.sh

diff --git a/blame.c b/blame.c
index 49698a306e5a..103838546e07 100644
--- a/blame.c
+++ b/blame.c
@@ -340,6 +340,648 @@ static int find_line_starts(int **line_starts, const =
char *buf,
 	return num;
 }
=20
+struct fingerprint_entry;
+
+/* A fingerprint is intended to loosely represent a string, such that two
+ * fingerprints can be quickly compared to give an indication of the simil=
arity
+ * of the strings that they represent.
+ *
+ * A fingerprint is represented as a multiset of the lower-cased byte pair=
s in
+ * the string that it represents. Whitespace is added at each end of the
+ * string. Whitespace pairs are ignored. Whitespace is converted to '\0'.
+ * For example, the string "Darth   Radar" will be converted to the follow=
ing
+ * fingerprint:
+ * {"\0d", "da", "da", "ar", "ar", "rt", "th", "h\0", "\0r", "ra", "ad", "=
r\0"}
+ *
+ * The similarity between two fingerprints is the size of the intersection=
 of
+ * their multisets, including repeated elements. See fingerprint_similarit=
y for
+ * examples.
+ *
+ * For ease of implementation, the fingerprint is implemented as a map
+ * of byte pairs to the count of that byte pair in the string, instead of
+ * allowing repeated elements in a set.
+ */
+struct fingerprint {
+	struct hashmap map;
+	/* As we know the maximum number of entries in advance, it's
+	 * convenient to store the entries in a single array instead of having
+	 * the hashmap manage the memory.
+	 */
+	struct fingerprint_entry *entries;
+};
+
+/* A byte pair in a fingerprint. Stores the number of times the byte pair
+ * occurs in the string that the fingerprint represents.
+ */
+struct fingerprint_entry {
+	/* The hashmap entry - the hash represents the byte pair in its
+	 * entirety so we don't need to store the byte pair separately.
+	 */
+	struct hashmap_entry entry;
+	/* The number of times the byte pair occurs in the string that the
+	 * fingerprint represents.
+	 */
+	int count;
+};
+
+/* See `struct fingerprint` for an explanation of what a fingerprint is.
+ * \param result the fingerprint of the string is stored here. This must b=
e
+ * 		 freed later using free_fingerprint.
+ * \param line_begin the start of the string
+ * \param line_end the end of the string
+ */
+static void get_fingerprint(struct fingerprint *result,
+			    const char *line_begin,
+			    const char *line_end)
+{
+	unsigned int hash, c0 =3D 0, c1;
+	const char *p;
+	int max_map_entry_count =3D 1 + line_end - line_begin;
+	struct fingerprint_entry *entry =3D xcalloc(max_map_entry_count,
+		sizeof(struct fingerprint_entry));
+	struct fingerprint_entry *found_entry;
+
+	hashmap_init(&result->map, NULL, NULL, max_map_entry_count);
+	result->entries =3D entry;
+	for (p =3D line_begin; p <=3D line_end; ++p, c0 =3D c1) {
+		/* Always terminate the string with whitespace.
+		 * Normalise whitespace to 0, and normalise letters to
+		 * lower case. This won't work for multibyte characters but at
+		 * worst will match some unrelated characters.
+		 */
+		if ((p =3D=3D line_end) || isspace(*p))
+			c1 =3D 0;
+		else
+			c1 =3D tolower(*p);
+		hash =3D c0 | (c1 << 8);
+		/* Ignore whitespace pairs */
+		if (hash =3D=3D 0)
+			continue;
+		hashmap_entry_init(entry, hash);
+
+		found_entry =3D hashmap_get(&result->map, entry, NULL);
+		if (found_entry) {
+			found_entry->count +=3D 1;
+		} else {
+			entry->count =3D 1;
+			hashmap_add(&result->map, entry);
+			++entry;
+		}
+	}
+}
+
+static void free_fingerprint(struct fingerprint *f)
+{
+	hashmap_free(&f->map, 0);
+	free(f->entries);
+}
+
+/* Calculates the similarity between two fingerprints as the size of the
+ * intersection of their multisets, including repeated elements. See
+ * `struct fingerprint` for an explanation of the fingerprint representati=
on.
+ * The similarity between "cat mat" and "father rather" is 2 because "at" =
is
+ * present twice in both strings while the similarity between "tim" and "m=
it"
+ * is 0.
+ */
+static int fingerprint_similarity(struct fingerprint *a, struct fingerprin=
t *b)
+{
+	int intersection =3D 0;
+	struct hashmap_iter iter;
+	const struct fingerprint_entry *entry_a, *entry_b;
+
+	hashmap_iter_init(&b->map, &iter);
+
+	while ((entry_b =3D hashmap_iter_next(&iter))) {
+		if ((entry_a =3D hashmap_get(&a->map, entry_b, NULL))) {
+			intersection +=3D entry_a->count < entry_b->count ?
+					entry_a->count : entry_b->count;
+		}
+	}
+	return intersection;
+}
+
+/* Subtracts byte-pair elements in B from A, modifying A in place.
+ */
+static void fingerprint_subtract(struct fingerprint *a, struct fingerprint=
 *b)
+{
+	struct hashmap_iter iter;
+	struct fingerprint_entry *entry_a;
+	const struct fingerprint_entry *entry_b;
+
+	hashmap_iter_init(&b->map, &iter);
+
+	while ((entry_b =3D hashmap_iter_next(&iter))) {
+		if ((entry_a =3D hashmap_get(&a->map, entry_b, NULL))) {
+			if (entry_a->count <=3D entry_b->count)
+				hashmap_remove(&a->map, entry_b, NULL);
+			else
+				entry_a->count -=3D entry_b->count;
+		}
+	}
+}
+
+/* Calculate fingerprints for a series of lines.
+ * Puts the fingerprints in the fingerprints array, which must have been
+ * preallocated to allow storing line_count elements.
+ */
+static void get_line_fingerprints(struct fingerprint *fingerprints,
+				  const char *content, const int *line_starts,
+				  long first_line, long line_count)
+{
+	int i;
+	const char *linestart, *lineend;
+
+	line_starts +=3D first_line;
+	for (i =3D 0; i < line_count; ++i) {
+		linestart =3D content + line_starts[i];
+		lineend =3D content + line_starts[i + 1];
+		get_fingerprint(fingerprints + i, linestart, lineend);
+	}
+}
+
+static void free_line_fingerprints(struct fingerprint *fingerprints,
+				   int nr_fingerprints)
+{
+	int i;
+
+	for (i =3D 0; i < nr_fingerprints; i++)
+		free_fingerprint(&fingerprints[i]);
+}
+
+/* This contains the data necessary to linearly map a line number in one h=
alf
+ * of a diff chunk to the line in the other half of the diff chunk that is
+ * closest in terms of its position as a fraction of the length of the chu=
nk.
+ */
+struct line_number_mapping {
+	int destination_start, destination_length,
+		source_start, source_length;
+};
+
+/* Given a line number in one range, offset and scale it to map it onto th=
e
+ * other range.
+ * Essentially this mapping is a simple linear equation but the calculatio=
n is
+ * more complicated to allow performing it with integer operations.
+ * Another complication is that if a line could map onto many lines in the
+ * destination range then we want to choose the line at the center of thos=
e
+ * possibilities.
+ * Example: if the chunk is 2 lines long in A and 10 lines long in B then =
the
+ * first 5 lines in B will map onto the first line in the A chunk, while t=
he
+ * last 5 lines will all map onto the second line in the A chunk.
+ * Example: if the chunk is 10 lines long in A and 2 lines long in B then =
line
+ * 0 in B will map onto line 2 in A, and line 1 in B will map onto line 7 =
in A.
+ */
+static int map_line_number(int line_number,
+	const struct line_number_mapping *mapping)
+{
+	return ((line_number - mapping->source_start) * 2 + 1) *
+	       mapping->destination_length /
+	       (mapping->source_length * 2) +
+	       mapping->destination_start;
+}
+
+/* Get a pointer to the element storing the similarity between a line in A
+ * and a line in B.
+ *
+ * The similarities are stored in a 2-dimensional array. Each "row" in the
+ * array contains the similarities for a line in B. The similarities store=
d in
+ * a row are the similarities between the line in B and the nearby lines i=
n A.
+ * To keep the length of each row the same, it is padded out with values o=
f -1
+ * where the search range extends beyond the lines in A.
+ * For example, if max_search_distance_a is 2 and the two sides of a diff =
chunk
+ * look like this:
+ * a | m
+ * b | n
+ * c | o
+ * d | p
+ * e | q
+ * Then the similarity array will contain:
+ * [-1, -1, am, bm, cm,
+ *  -1, an, bn, cn, dn,
+ *  ao, bo, co, do, eo,
+ *  bp, cp, dp, ep, -1,
+ *  cq, dq, eq, -1, -1]
+ * Where similarities are denoted either by -1 for invalid, or the
+ * concatenation of the two lines in the diff being compared.
+ *
+ * \param similarities array of similarities between lines in A and B
+ * \param line_a the index of the line in A, in the same frame of referenc=
e as
+ *	closest_line_a.
+ * \param local_line_b the index of the line in B, relative to the first l=
ine
+ *		       in B that similarities represents.
+ * \param closest_line_a the index of the line in A that is deemed to be
+ *			 closest to local_line_b. This must be in the same
+ *			 frame of reference as line_a. This value defines
+ *			 where similarities is centered for the line in B.
+ * \param max_search_distance_a maximum distance in lines from the closest=
 line
+ * 				in A for other lines in A for which
+ * 				similarities may be calculated.
+ */
+static int *get_similarity(int *similarities,
+			   int line_a, int local_line_b,
+			   int closest_line_a, int max_search_distance_a)
+{
+	assert(abs(line_a - closest_line_a) <=3D
+	       max_search_distance_a);
+	return similarities + line_a - closest_line_a +
+	       max_search_distance_a +
+	       local_line_b * (max_search_distance_a * 2 + 1);
+}
+
+#define CERTAIN_NOTHING_MATCHES -2
+#define CERTAINTY_NOT_CALCULATED -1
+
+/* Given a line in B, first calculate its similarities with nearby lines i=
n A
+ * if not already calculated, then identify the most similar and second mo=
st
+ * similar lines. The "certainty" is calculated based on those two
+ * similarities.
+ *
+ * \param start_a the index of the first line of the chunk in A
+ * \param length_a the length in lines of the chunk in A
+ * \param local_line_b the index of the line in B, relative to the first l=
ine
+ * 		       in the chunk.
+ * \param fingerprints_a array of fingerprints for the chunk in A
+ * \param fingerprints_b array of fingerprints for the chunk in B
+ * \param similarities 2-dimensional array of similarities between lines i=
n A
+ * 		       and B. See get_similarity() for more details.
+ * \param certainties array of values indicating how strongly a line in B =
is
+ * 		      matched with some line in A.
+ * \param second_best_result array of absolute indices in A for the second
+ * 			     closest match of a line in B.
+ * \param result array of absolute indices in A for the closest match of a=
 line
+ * 		 in B.
+ * \param max_search_distance_a maximum distance in lines from the closest=
 line
+ * 				in A for other lines in A for which
+ * 				similarities may be calculated.
+ * \param map_line_number_in_b_to_a parameter to map_line_number().
+ */
+static void find_best_line_matches(
+	int start_a,
+	int length_a,
+	int start_b,
+	int local_line_b,
+	struct fingerprint *fingerprints_a,
+	struct fingerprint *fingerprints_b,
+	int *similarities,
+	int *certainties,
+	int *second_best_result,
+	int *result,
+	const int max_search_distance_a,
+	const struct line_number_mapping *map_line_number_in_b_to_a)
+{
+
+	int i, search_start, search_end, closest_local_line_a, *similarity,
+		best_similarity =3D 0, second_best_similarity =3D 0,
+		best_similarity_index =3D 0, second_best_similarity_index =3D 0;
+
+	/* certainty has already been calculated so no need to redo the work */
+	if (certainties[local_line_b] !=3D CERTAINTY_NOT_CALCULATED)
+		return;
+
+	closest_local_line_a =3D map_line_number(
+		local_line_b + start_b, map_line_number_in_b_to_a) - start_a;
+
+	search_start =3D closest_local_line_a - max_search_distance_a;
+	if (search_start < 0)
+		search_start =3D 0;
+
+	search_end =3D closest_local_line_a + max_search_distance_a + 1;
+	if (search_end > length_a)
+		search_end =3D length_a;
+
+	for (i =3D search_start; i < search_end; ++i) {
+		similarity =3D get_similarity(similarities,
+					    i, local_line_b,
+					    closest_local_line_a,
+					    max_search_distance_a);
+		if (*similarity =3D=3D -1) {
+			/* This value will never exceed 10 but assert just in
+			 * case
+			 */
+			assert(abs(i - closest_local_line_a) < 1000);
+			/* scale the similarity by (1000 - distance from
+			 * closest line) to act as a tie break between lines
+			 * that otherwise are equally similar.
+			 */
+			*similarity =3D fingerprint_similarity(
+				fingerprints_b + local_line_b,
+				fingerprints_a + i) *
+				(1000 - abs(i - closest_local_line_a));
+		}
+		if (*similarity > best_similarity) {
+			second_best_similarity =3D best_similarity;
+			second_best_similarity_index =3D best_similarity_index;
+			best_similarity =3D *similarity;
+			best_similarity_index =3D i;
+		} else if (*similarity > second_best_similarity) {
+			second_best_similarity =3D *similarity;
+			second_best_similarity_index =3D i;
+		}
+	}
+
+	if (best_similarity =3D=3D 0) {
+		/* this line definitely doesn't match with anything. Mark it
+		 * with this special value so it doesn't get invalidated and
+		 * won't be recalculated.
+		 */
+		certainties[local_line_b] =3D CERTAIN_NOTHING_MATCHES;
+		result[local_line_b] =3D -1;
+	} else {
+		/* Calculate the certainty with which this line matches.
+		 * If the line matches well with two lines then that reduces
+		 * the certainty. However we still want to prioritise matching
+		 * a line that matches very well with two lines over matching a
+		 * line that matches poorly with one line, hence doubling
+		 * best_similarity.
+		 * This means that if we have
+		 * line X that matches only one line with a score of 3,
+		 * line Y that matches two lines equally with a score of 5,
+		 * and line Z that matches only one line with a score or 2,
+		 * then the lines in order of certainty are X, Y, Z.
+		 */
+		certainties[local_line_b] =3D best_similarity * 2 -
+			second_best_similarity;
+
+		/* We keep both the best and second best results to allow us to
+		 * check at a later stage of the matching process whether the
+		 * result needs to be invalidated.
+		 */
+		result[local_line_b] =3D start_a + best_similarity_index;
+		second_best_result[local_line_b] =3D
+			start_a + second_best_similarity_index;
+	}
+}
+
+/*
+ * This finds the line that we can match with the most confidence, and
+ * uses it as a partition. It then calls itself on the lines on either sid=
e of
+ * that partition. In this way we avoid lines appearing out of order, and
+ * retain a sensible line ordering.
+ * \param start_a index of the first line in A with which lines in B may b=
e
+ * 		  compared.
+ * \param start_b index of the first line in B for which matching should b=
e
+ * 		  done.
+ * \param length_a number of lines in A with which lines in B may be compa=
red.
+ * \param length_b number of lines in B for which matching should be done.
+ * \param fingerprints_a mutable array of fingerprints in A. The first ele=
ment
+ * 			 corresponds to the line at start_a.
+ * \param fingerprints_b array of fingerprints in B. The first element
+ * 			 corresponds to the line at start_b.
+ * \param similarities 2-dimensional array of similarities between lines i=
n A
+ * 		       and B. See get_similarity() for more details.
+ * \param certainties array of values indicating how strongly a line in B =
is
+ * 		      matched with some line in A.
+ * \param second_best_result array of absolute indices in A for the second
+ * 			     closest match of a line in B.
+ * \param result array of absolute indices in A for the closest match of a=
 line
+ * 		 in B.
+ * \param max_search_distance_a maximum distance in lines from the closest=
 line
+ * 			      in A for other lines in A for which
+ * 			      similarities may be calculated.
+ * \param max_search_distance_b an upper bound on the greatest possible
+ * 			      distance between lines in B such that they will
+ *                              both be compared with the same line in A
+ * 			      according to max_search_distance_a.
+ * \param map_line_number_in_b_to_a parameter to map_line_number().
+ */
+static void fuzzy_find_matching_lines_recurse(
+	int start_a, int start_b,
+	int length_a, int length_b,
+	struct fingerprint *fingerprints_a,
+	struct fingerprint *fingerprints_b,
+	int *similarities,
+	int *certainties,
+	int *second_best_result,
+	int *result,
+	int max_search_distance_a,
+	int max_search_distance_b,
+	const struct line_number_mapping *map_line_number_in_b_to_a)
+{
+	int i, invalidate_min, invalidate_max, offset_b,
+		second_half_start_a, second_half_start_b,
+		second_half_length_a, second_half_length_b,
+		most_certain_line_a, most_certain_local_line_b =3D -1,
+		most_certain_line_certainty =3D -1,
+		closest_local_line_a;
+
+	for (i =3D 0; i < length_b; ++i) {
+		find_best_line_matches(start_a,
+				       length_a,
+				       start_b,
+				       i,
+				       fingerprints_a,
+				       fingerprints_b,
+				       similarities,
+				       certainties,
+				       second_best_result,
+				       result,
+				       max_search_distance_a,
+				       map_line_number_in_b_to_a);
+
+		if (certainties[i] > most_certain_line_certainty) {
+			most_certain_line_certainty =3D certainties[i];
+			most_certain_local_line_b =3D i;
+		}
+	}
+
+	/* No matches. */
+	if (most_certain_local_line_b =3D=3D -1)
+		return;
+
+	most_certain_line_a =3D result[most_certain_local_line_b];
+
+	/*
+	 * Subtract the most certain line's fingerprint in B from the matched
+	 * fingerprint in A. This means that other lines in B can't also match
+	 * the same parts of the line in A.
+	 */
+	fingerprint_subtract(fingerprints_a + most_certain_line_a - start_a,
+			     fingerprints_b + most_certain_local_line_b);
+
+	/* Invalidate results that may be affected by the choice of most
+	 * certain line.
+	 */
+	invalidate_min =3D most_certain_local_line_b - max_search_distance_b;
+	invalidate_max =3D most_certain_local_line_b + max_search_distance_b + 1;
+	if (invalidate_min < 0)
+		invalidate_min =3D 0;
+	if (invalidate_max > length_b)
+		invalidate_max =3D length_b;
+
+	/* As the fingerprint in A has changed, discard previously calculated
+	 * similarity values with that fingerprint.
+	 */
+	for (i =3D invalidate_min; i < invalidate_max; ++i) {
+		closest_local_line_a =3D map_line_number(
+			i + start_b, map_line_number_in_b_to_a) - start_a;
+
+		/* Check that the lines in A and B are close enough that there
+		 * is a similarity value for them.
+		 */
+		if (abs(most_certain_line_a - start_a - closest_local_line_a) >
+			max_search_distance_a) {
+			continue;
+		}
+
+		*get_similarity(similarities, most_certain_line_a - start_a,
+				i, closest_local_line_a,
+				max_search_distance_a) =3D -1;
+	}
+
+	/* More invalidating of results that may be affected by the choice of
+	 * most certain line.
+	 * Discard the matches for lines in B that are currently matched with a
+	 * line in A such that their ordering contradicts the ordering imposed
+	 * by the choice of most certain line.
+	 */
+	for (i =3D most_certain_local_line_b - 1; i >=3D invalidate_min; --i) {
+		/* In this loop we discard results for lines in B that are
+		 * before most-certain-line-B but are matched with a line in A
+		 * that is after most-certain-line-A.
+		 */
+		if (certainties[i] >=3D 0 &&
+		    (result[i] >=3D most_certain_line_a ||
+		     second_best_result[i] >=3D most_certain_line_a)) {
+			certainties[i] =3D CERTAINTY_NOT_CALCULATED;
+		}
+	}
+	for (i =3D most_certain_local_line_b + 1; i < invalidate_max; ++i) {
+		/* In this loop we discard results for lines in B that are
+		 * after most-certain-line-B but are matched with a line in A
+		 * that is before most-certain-line-A.
+		 */
+		if (certainties[i] >=3D 0 &&
+		    (result[i] <=3D most_certain_line_a ||
+		     second_best_result[i] <=3D most_certain_line_a)) {
+			certainties[i] =3D CERTAINTY_NOT_CALCULATED;
+		}
+	}
+
+	/* Repeat the matching process for lines before the most certain line.
+	 */
+	if (most_certain_local_line_b > 0) {
+		fuzzy_find_matching_lines_recurse(
+			start_a, start_b,
+			most_certain_line_a + 1 - start_a,
+			most_certain_local_line_b,
+			fingerprints_a, fingerprints_b, similarities,
+			certainties, second_best_result, result,
+			max_search_distance_a,
+			max_search_distance_b,
+			map_line_number_in_b_to_a);
+	}
+	/* Repeat the matching process for lines after the most certain line.
+	 */
+	if (most_certain_local_line_b + 1 < length_b) {
+		second_half_start_a =3D most_certain_line_a;
+		offset_b =3D most_certain_local_line_b + 1;
+		second_half_start_b =3D start_b + offset_b;
+		second_half_length_a =3D
+			length_a + start_a - second_half_start_a;
+		second_half_length_b =3D
+			length_b + start_b - second_half_start_b;
+		fuzzy_find_matching_lines_recurse(
+			second_half_start_a, second_half_start_b,
+			second_half_length_a, second_half_length_b,
+			fingerprints_a + second_half_start_a - start_a,
+			fingerprints_b + offset_b,
+			similarities +
+				offset_b * (max_search_distance_a * 2 + 1),
+			certainties + offset_b,
+			second_best_result + offset_b, result + offset_b,
+			max_search_distance_a,
+			max_search_distance_b,
+			map_line_number_in_b_to_a);
+	}
+}
+
+/* Find the lines in the parent line range that most closely match the lin=
es in
+ * the target line range. This is accomplished by matching fingerprints in=
 each
+ * blame_origin, and choosing the best matches that preserve the line orde=
ring.
+ * See struct fingerprint for details of fingerprint matching, and
+ * fuzzy_find_matching_lines_recurse for details of preserving line orderi=
ng.
+ *
+ * The performance is believed to be O(n log n) in the typical case and O(=
n^2)
+ * in a pathological case, where n is the number of lines in the target ra=
nge.
+ */
+static int *fuzzy_find_matching_lines(struct blame_origin *parent,
+				      struct blame_origin *target,
+				      int tlno, int parent_slno, int same,
+				      int parent_len)
+{
+	/* We use the terminology "A" for the left hand side of the diff AKA
+	 * parent, and "B" for the right hand side of the diff AKA target. */
+	int start_a =3D parent_slno;
+	int length_a =3D parent_len;
+	int start_b =3D tlno;
+	int length_b =3D same - tlno;
+
+	struct line_number_mapping map_line_number_in_b_to_a =3D {
+		start_a, length_a, start_b, length_b
+	};
+
+	struct fingerprint *fingerprints_a =3D parent->fingerprints;
+	struct fingerprint *fingerprints_b =3D target->fingerprints;
+
+	int i, *result, *second_best_result,
+		*certainties, *similarities, similarity_count;
+
+	/*
+	 * max_search_distance_a means that given a line in B, compare it to
+	 * the line in A that is closest to its position, and the lines in A
+	 * that are no greater than max_search_distance_a lines away from the
+	 * closest line in A.
+	 *
+	 * max_search_distance_b is an upper bound on the greatest possible
+	 * distance between lines in B such that they will both be compared
+	 * with the same line in A according to max_search_distance_a.
+	 */
+	int max_search_distance_a =3D 10, max_search_distance_b;
+
+	if (length_a <=3D 0)
+		return NULL;
+
+	if (max_search_distance_a >=3D length_a)
+		max_search_distance_a =3D length_a ? length_a - 1 : 0;
+
+	max_search_distance_b =3D ((2 * max_search_distance_a + 1) * length_b
+				 - 1) / length_a;
+
+	result =3D xcalloc(sizeof(int), length_b);
+	second_best_result =3D xcalloc(sizeof(int), length_b);
+	certainties =3D xcalloc(sizeof(int), length_b);
+
+	/* See get_similarity() for details of similarities. */
+	similarity_count =3D length_b * (max_search_distance_a * 2 + 1);
+	similarities =3D xcalloc(sizeof(int), similarity_count);
+
+	for (i =3D 0; i < length_b; ++i) {
+		result[i] =3D -1;
+		second_best_result[i] =3D -1;
+		certainties[i] =3D CERTAINTY_NOT_CALCULATED;
+	}
+
+	for (i =3D 0; i < similarity_count; ++i)
+		similarities[i] =3D -1;
+
+	fuzzy_find_matching_lines_recurse(start_a, start_b,
+					  length_a, length_b,
+					  fingerprints_a + start_a,
+					  fingerprints_b + start_b,
+					  similarities,
+					  certainties,
+					  second_best_result,
+					  result,
+					  max_search_distance_a,
+					  max_search_distance_b,
+					  &map_line_number_in_b_to_a);
+
+	free(similarities);
+	free(certainties);
+	free(second_best_result);
+
+	return result;
+}
+
 static void fill_origin_fingerprints(struct blame_origin *o, mmfile_t *fil=
e)
 {
 	int *line_starts;
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
new file mode 100755
index 000000000000..1d8fa1da74c9
--- /dev/null
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -0,0 +1,435 @@
+#!/bin/sh
+
+test_description=3D'git blame ignore fuzzy heuristic'
+. ./test-lib.sh
+
+# short circuit until blame has the fuzzy capabilities
+test_done
+
+pick_author=3D's/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
+
+# Each test is composed of 4 variables:
+# titleN - the test name
+# aN - the initial content
+# bN - the final content
+# expectedN - the line numbers from aN that we expect git blame
+#             on bN to identify, or "Final" if bN itself should
+#             be identified as the origin of that line.
+
+# We start at test 2 because setup will show as test 1
+title2=3D"Regression test for partially overlapping search ranges"
+cat <<EOF >a2
+1
+2
+3
+abcdef
+5
+6
+7
+ijkl
+9
+10
+11
+pqrs
+13
+14
+15
+wxyz
+17
+18
+19
+EOF
+cat <<EOF >b2
+abcde
+ijk
+pqr
+wxy
+EOF
+cat <<EOF >expected2
+4
+8
+12
+16
+EOF
+
+title3=3D"Combine 3 lines into 2"
+cat <<EOF >a3
+if ((maxgrow=3D=3D0) ||
+	( single_line_field && (field->dcols < maxgrow)) ||
+	(!single_line_field && (field->drows < maxgrow)))
+EOF
+cat <<EOF >b3
+if ((maxgrow =3D=3D 0) || (single_line_field && (field->dcols < maxgrow)) =
||
+	(!single_line_field && (field->drows < maxgrow))) {
+EOF
+cat <<EOF >expected3
+2
+3
+EOF
+
+title4=3D"Add curly brackets"
+cat <<EOF >a4
+	if (rows) *rows =3D field->rows;
+	if (cols) *cols =3D field->cols;
+	if (frow) *frow =3D field->frow;
+	if (fcol) *fcol =3D field->fcol;
+EOF
+cat <<EOF >b4
+	if (rows) {
+		*rows =3D field->rows;
+	}
+	if (cols) {
+		*cols =3D field->cols;
+	}
+	if (frow) {
+		*frow =3D field->frow;
+	}
+	if (fcol) {
+		*fcol =3D field->fcol;
+	}
+EOF
+cat <<EOF >expected4
+1
+1
+Final
+2
+2
+Final
+3
+3
+Final
+4
+4
+Final
+EOF
+
+
+title5=3D"Combine many lines and change case"
+cat <<EOF >a5
+for(row=3D0,pBuffer=3Dfield->buf;
+	row<height;
+	row++,pBuffer+=3Dwidth )
+{
+	if ((len =3D (int)( After_End_Of_Data( pBuffer, width ) - pBuffer )) > 0)
+	{
+		wmove( win, row, 0 );
+		waddnstr( win, pBuffer, len );
+EOF
+cat <<EOF >b5
+for (Row =3D 0, PBuffer =3D field->buf; Row < Height; Row++, PBuffer +=3D =
Width) {
+	if ((Len =3D (int)(afterEndOfData(PBuffer, Width) - PBuffer)) > 0) {
+		wmove(win, Row, 0);
+		waddnstr(win, PBuffer, Len);
+EOF
+cat <<EOF >expected5
+1
+5
+7
+8
+EOF
+
+title6=3D"Rename and combine lines"
+cat <<EOF >a6
+bool need_visual_update =3D ((form !=3D (FORM *)0)      &&
+	(form->status & _POSTED) &&
+	(form->current=3D=3Dfield));
+
+if (need_visual_update)
+	Synchronize_Buffer(form);
+
+if (single_line_field)
+{
+	growth =3D field->cols * amount;
+	if (field->maxgrow)
+		growth =3D Minimum(field->maxgrow - field->dcols,growth);
+	field->dcols +=3D growth;
+	if (field->dcols =3D=3D field->maxgrow)
+EOF
+cat <<EOF >b6
+bool NeedVisualUpdate =3D ((Form !=3D (FORM *)0) && (Form->status & _POSTE=
D) &&
+	(Form->current =3D=3D field));
+
+if (NeedVisualUpdate) {
+	synchronizeBuffer(Form);
+}
+
+if (SingleLineField) {
+	Growth =3D field->cols * amount;
+	if (field->maxgrow) {
+		Growth =3D Minimum(field->maxgrow - field->dcols, Growth);
+	}
+	field->dcols +=3D Growth;
+	if (field->dcols =3D=3D field->maxgrow) {
+EOF
+cat <<EOF >expected6
+1
+3
+4
+5
+6
+Final
+7
+8
+10
+11
+12
+Final
+13
+14
+EOF
+
+# Both lines match identically so position must be used to tie-break.
+title7=3D"Same line twice"
+cat <<EOF >a7
+abc
+abc
+EOF
+cat <<EOF >b7
+abcd
+abcd
+EOF
+cat <<EOF >expected7
+1
+2
+EOF
+
+title8=3D"Enforce line order"
+cat <<EOF >a8
+abcdef
+ghijkl
+ab
+EOF
+cat <<EOF >b8
+ghijk
+abcd
+EOF
+cat <<EOF >expected8
+2
+3
+EOF
+
+title9=3D"Expand lines and rename variables"
+cat <<EOF >a9
+int myFunction(int ArgumentOne, Thing *ArgTwo, Blah XuglyBug) {
+	Squiggle FabulousResult =3D squargle(ArgumentOne, *ArgTwo,
+		XuglyBug) + EwwwGlobalWithAReallyLongNameYepTooLong;
+	return FabulousResult * 42;
+}
+EOF
+cat <<EOF >b9
+int myFunction(int argument_one, Thing *arg_asdfgh,
+	Blah xugly_bug) {
+	Squiggle fabulous_result =3D squargle(argument_one,
+		*arg_asdfgh, xugly_bug)
+		+ g_ewww_global_with_a_really_long_name_yep_too_long;
+	return fabulous_result * 42;
+}
+EOF
+cat <<EOF >expected9
+1
+1
+2
+3
+3
+4
+5
+EOF
+
+title10=3D"Two close matches versus one less close match"
+cat <<EOF >a10
+abcdef
+abcdef
+ghijkl
+EOF
+cat <<EOF >b10
+gh
+abcdefx
+EOF
+cat <<EOF >expected10
+Final
+2
+EOF
+
+# The first line of b matches best with the last line of a, but the overal=
l
+# match is better if we match it with the the first line of a.
+title11=3D"Piggy in the middle"
+cat <<EOF >a11
+abcdefg
+ijklmn
+abcdefgh
+EOF
+cat <<EOF >b11
+abcdefghx
+ijklm
+EOF
+cat <<EOF >expected11
+1
+2
+EOF
+
+title12=3D"No trailing newline"
+printf "abc\ndef" >a12
+printf "abx\nstu" >b12
+cat <<EOF >expected12
+1
+Final
+EOF
+
+title13=3D"Reorder includes"
+cat <<EOF >a13
+#include "c.h"
+#include "b.h"
+#include "a.h"
+#include "e.h"
+#include "d.h"
+EOF
+cat <<EOF >b13
+#include "a.h"
+#include "b.h"
+#include "c.h"
+#include "d.h"
+#include "e.h"
+EOF
+cat <<EOF >expected13
+3
+2
+1
+5
+4
+EOF
+
+last_test=3D13
+
+test_expect_success setup '
+	{ for i in $(test_seq 2 $last_test)
+	do
+		# Append each line in a separate commit to make it easy to
+		# check which original line the blame output relates to.
+
+		line_count=3D0 &&
+		{ while IFS=3D read line
+		do
+			line_count=3D$((line_count+1)) &&
+			echo "$line" >>"$i" &&
+			git add "$i" &&
+			test_tick &&
+			GIT_AUTHOR_NAME=3D"$line_count" git commit -m "$line_count"
+		done } <"a$i"
+	done } &&
+
+	{ for i in $(test_seq 2 $last_test)
+	do
+		# Overwrite the files with the final content.
+		cp b$i $i &&
+		git add $i
+	done } &&
+	test_tick &&
+
+	# Commit the final content all at once so it can all be
+	# referred to with the same commit ID.
+	GIT_AUTHOR_NAME=3DFinal git commit -m Final &&
+
+	IGNOREME=3D$(git rev-parse HEAD)
+'
+
+for i in $(test_seq 2 $last_test); do
+	eval title=3D"\$title$i"
+	test_expect_success "$title" \
+	"git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actua=
l && test_cmp expected$i actual"
+done
+
+# This invoked a null pointer dereference when the chunk callback was call=
ed
+# with a zero length parent chunk and there were no more suspects.
+test_expect_success 'Diff chunks with no suspects' '
+	test_write_lines xy1 A B C xy1 >file &&
+	git add file &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D1 git commit -m 1 &&
+
+	test_write_lines xy2 A B xy2 C xy2 >file &&
+	git add file &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D2 git commit -m 2 &&
+	REV_2=3D$(git rev-parse HEAD) &&
+
+	test_write_lines xy3 A >file &&
+	git add file &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D3 git commit -m 3 &&
+	REV_3=3D$(git rev-parse HEAD) &&
+
+	test_write_lines 1 1 >expected &&
+
+	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_au=
thor" >actual &&
+
+	test_cmp expected actual
+	'
+
+test_expect_success 'position matching' '
+	test_write_lines abc def >file2 &&
+	git add file2 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D1 git commit -m 1 &&
+
+	test_write_lines abc def abc def >file2 &&
+	git add file2 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D2 git commit -m 2 &&
+
+	test_write_lines abcx defx abcx defx >file2 &&
+	git add file2 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D3 git commit -m 3 &&
+	REV_3=3D$(git rev-parse HEAD) &&
+
+	test_write_lines abcy defy abcx defx >file2 &&
+	git add file2 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D4 git commit -m 4 &&
+	REV_4=3D$(git rev-parse HEAD) &&
+
+	test_write_lines 1 1 2 2 >expected &&
+
+	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 | sed -e "$pick_a=
uthor" >actual &&
+
+	test_cmp expected actual
+	'
+
+# This fails if each blame entry is processed independently instead of
+# processing each diff change in full.
+test_expect_success 'preserve order' '
+	test_write_lines bcde >file3 &&
+	git add file3 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D1 git commit -m 1 &&
+
+	test_write_lines bcde fghij >file3 &&
+	git add file3 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D2 git commit -m 2 &&
+
+	test_write_lines bcde fghij abcd >file3 &&
+	git add file3 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D3 git commit -m 3 &&
+
+	test_write_lines abcdx fghijx bcdex >file3 &&
+	git add file3 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D4 git commit -m 4 &&
+	REV_4=3D$(git rev-parse HEAD) &&
+
+	test_write_lines abcdx fghijy bcdex >file3 &&
+	git add file3 &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3D5 git commit -m 5 &&
+	REV_5=3D$(git rev-parse HEAD) &&
+
+	test_write_lines 1 2 3 >expected &&
+
+	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 | sed -e "$pick_a=
uthor" >actual &&
+
+	test_cmp expected actual
+	'
+
+test_done
--=20
2.22.0.rc2.383.gf4fbbf30c2-goog


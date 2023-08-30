Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745F8C6FA8F
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjH3S3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbjH3Qoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453119A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59263889eacso80178567b3.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413868; x=1694018668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MclijXimSCpR5Nlc7plEF634UxdBry5i6rqo/swZo/A=;
        b=j/UXK2XB77Wrcz/0EAalIFdddNTbyKqOCFF68Y3wy674UCnjCP01vCyT50o7GMf3de
         Ot3mck3cX7gTghrFbnOsSETA0nBROl7arxOLjLYhJTKqMJxdPIAwF2gzKCPnlxs9bYha
         JMmggvIEr/iziNqDl36v44x2WxJwwloK83ZIt7gzHB4VcLWgLajt0p8mxlTDlSNQ++Jv
         pUA+RtTiwAkmjq6yJfdrQsFBmUFOSEQNvi9ULiHRuXMB71Zy4yMI5+iXJ1JRh/vgaXaL
         81BFOe48E2c8c7PpT4Nxpq58FEg2HVYvH9ohjh3yaTk0CY/mtBLM0mQe+pMsVRRiW2G9
         8suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413868; x=1694018668;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MclijXimSCpR5Nlc7plEF634UxdBry5i6rqo/swZo/A=;
        b=ZJwdjaaewp2VGEtrylxgB19UJ1eoPQGTNs25lwTCe6FHhVL9HfzvdHrEDQss4LlxSQ
         B8rGCrBLdwdyU8SBtixIs7aMiDAZLDQA/MfezZg18AoUj2rkbeGU+6uGiSwhc/wAT0K8
         n3sAWknzXO9CmklIxBCl3d1rto6tyYKjb5H5LnXLWiZomjDM8a8+1OCf3eTTMYKh0BsI
         bK1bMxYFFGqMcv69VHbIuI1ZDzGLG2Pfwy/NKqNNd3xhg2SFftouDEqEIb12BGj11pe4
         0Bzab0CPmDf8Uvr4Mwtga/BSF0SfMmi0/wuQLAAOHDcVo86nebCm0XVaVd2+YDBs2tTf
         xH5Q==
X-Gm-Message-State: AOJu0YxiKNymJgitz8Gw+2s4Evb7G3PJWR/DHjwJxM94lXr1cb8oGpWL
        UNLxGWFT0T0pMsAZ+IPXfBK+9nbXcjdc8n7LkrN7fXpLSGLygNQhkG8uzpapJ/oBaOnHFrZjMC2
        CZxI12wBEiJRvk3bRFq/r+ulCp7ueMR6qA//s8HfmSByOLNuOIqp22ebvSTvzxaVHkBCRFHPLoS
        6z
X-Google-Smtp-Source: AGHT+IEKs0gZl2Qeu0y9GTZbi1YLMnGfHoWXh/LZOTZAMfQ2/kU2mV69q2BneiVXypdguzkrIgq+xOlISmoSMDGbKuK4
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:258f:0:b0:d7a:bfcf:2d7 with SMTP
 id l137-20020a25258f000000b00d7abfcf02d7mr78766ybl.6.1693413868104; Wed, 30
 Aug 2023 09:44:28 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:54 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <05357f9533d6ca6dd51cce3cd399fbbcedfcf93a.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 14/15] commit-graph: reuse existing Bloom filters where possible
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,
2023-08-01), a bug was described where it's possible for Git to produce
non-murmur3 hashes when the platform's "char" type is signed, and there
are paths with characters whose highest bit is set (i.e. all characters
>=3D 0x80).

That patch allows the caller to control which version of Bloom filters
are read and written. However, even on platforms with a signed "char"
type, it is possible to reuse existing Bloom filters if and only if
there are no changed paths in any commit's first parent tree-diff whose
characters have their highest bit set.

When this is the case, we can reuse the existing filter without having
to compute a new one. This is done by marking trees which are known to
have (or not have) any such paths. When a commit's root tree is verified
to not have any such paths, we mark it as such and declare that the
commit's Bloom filter is reusable.

Note that this heuristic only goes in one direction. If neither a commit
nor its first parent have any paths in their trees with non-ASCII
characters, then we know for certain that a path with non-ASCII
characters will not appear in a tree-diff against that commit's first
parent. The reverse isn't necessarily true: just because the tree-diff
doesn't contain any such paths does not imply that no such paths exist
in either tree.

So we end up recomputing some Bloom filters that we don't strictly have
to (i.e. their bits are the same no matter which version of murmur3 we
use). But culling these out is impossible, since we'd have to perform
the full tree-diff, which is the same effort as computing the Bloom
filter from scratch.

But because we can cache our results in each tree's flag bits, we can
often avoid recomputing many filters, thereby reducing the time it takes
to run

    $ git commit-graph write --changed-paths --reachable

when upgrading from v1 to v2 Bloom filters.

To benchmark this, let's generate a commit-graph in linux.git with v1
changed-paths in generation order[^1]:

    $ git clone git@github.com:torvalds/linux.git
    $ cd linux
    $ git commit-graph write --reachable --changed-paths
    $ graph=3D".git/objects/info/commit-graph"
    $ mv $graph{,.bak}

Then let's time how long it takes to go from v1 to v2 filters (with and
without the upgrade path enabled), resetting the state of the
commit-graph each time:

    $ git config commitGraph.changedPathsVersion 2
    $ hyperfine -p 'cp -f $graph.bak $graph' -L v 0,1 \
        'GIT_TEST_UPGRADE_BLOOM_FILTERS=3D{v} git.compile commit-graph writ=
e --reachable --changed-paths'

On linux.git (where there aren't any non-ASCII paths), the timings
indicate that this patch represents a speed-up over recomputing all
Bloom filters from scratch:

    Benchmark 1: GIT_TEST_UPGRADE_BLOOM_FILTERS=3D0 git.compile commit-grap=
h write --reachable --changed-paths
      Time (mean =C2=B1 =CF=83):     124.873 s =C2=B1  0.316 s    [User: 12=
4.081 s, System: 0.643 s]
      Range (min =E2=80=A6 max):   124.621 s =E2=80=A6 125.227 s    3 runs

    Benchmark 2: GIT_TEST_UPGRADE_BLOOM_FILTERS=3D1 git.compile commit-grap=
h write --reachable --changed-paths
      Time (mean =C2=B1 =CF=83):     79.271 s =C2=B1  0.163 s    [User: 74.=
611 s, System: 4.521 s]
      Range (min =E2=80=A6 max):   79.112 s =E2=80=A6 79.437 s    3 runs

    Summary
      'GIT_TEST_UPGRADE_BLOOM_FILTERS=3D1 git.compile commit-graph write --=
reachable --changed-paths' ran
        1.58 =C2=B1 0.01 times faster than 'GIT_TEST_UPGRADE_BLOOM_FILTERS=
=3D0 git.compile commit-graph write --reachable --changed-paths'

On git.git, we do have some non-ASCII paths, giving us a more modest
improvement from 4.163 seconds to 3.348 seconds, for a 1.24x speed-up.
On my machine, the stats for git.git are:

  - 8,285 Bloom filters computed from scratch
  - 10 Bloom filters generated as empty
  - 4 Bloom filters generated as truncated due to too many changed paths
  - 65,114 Bloom filters were reused when transitioning from v1 to v2.

[^1]: Note that this is is important, since `--stdin-packs` or
  `--stdin-commits` orders commits in the commit-graph by their pack
  position (with `--stdin-packs`) or in the raw input (with
  `--stdin-commits`).

  Since we compute Bloom filters in the same order that commits appear
  in the graph, we must see a commit's (first) parent before we process
  the commit itself. This is only guaranteed to happen when sorting
  commits by their generation number.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bloom.c              | 90 ++++++++++++++++++++++++++++++++++++++++++--
 bloom.h              |  1 +
 commit-graph.c       |  5 +++
 object.h             |  1 +
 t/t4216-log-bloom.sh | 35 ++++++++++++++++-
 5 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/bloom.c b/bloom.c
index 739fa093ba..24dd874e46 100644
--- a/bloom.c
+++ b/bloom.c
@@ -7,6 +7,9 @@
 #include "commit-graph.h"
 #include "commit.h"
 #include "commit-slab.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "config.h"
=20
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
=20
@@ -250,6 +253,73 @@ static void init_truncated_large_filter(struct bloom_f=
ilter *filter,
 	filter->version =3D version;
 }
=20
+#define VISITED   (1u<<21)
+#define HIGH_BITS (1u<<22)
+
+static int has_entries_with_high_bit(struct repository *r, struct tree *t)
+{
+	if (parse_tree(t))
+		return 1;
+
+	if (!(t->object.flags & VISITED)) {
+		struct tree_desc desc;
+		struct name_entry entry;
+
+		init_tree_desc(&desc, t->buffer, t->size);
+		while (tree_entry(&desc, &entry)) {
+			size_t i;
+			for (i =3D 0; i < entry.pathlen; i++) {
+				if (entry.path[i] & 0x80) {
+					t->object.flags |=3D HIGH_BITS;
+					goto done;
+				}
+			}
+
+			if (S_ISDIR(entry.mode)) {
+				struct tree *sub =3D lookup_tree(r, &entry.oid);
+				if (sub && has_entries_with_high_bit(r, sub)) {
+					t->object.flags |=3D HIGH_BITS;
+					goto done;
+				}
+			}
+
+		}
+
+done:
+		t->object.flags |=3D VISITED;
+	}
+
+	return !!(t->object.flags & HIGH_BITS);
+}
+
+static int commit_tree_has_high_bit_paths(struct repository *r,
+					  struct commit *c)
+{
+	struct tree *t;
+	if (repo_parse_commit(r, c))
+		return 1;
+	t =3D repo_get_commit_tree(r, c);
+	if (!t)
+		return 1;
+	return has_entries_with_high_bit(r, t);
+}
+
+static struct bloom_filter *upgrade_filter(struct repository *r, struct co=
mmit *c,
+					   struct bloom_filter *filter,
+					   int hash_version)
+{
+	struct commit_list *p =3D c->parents;
+	if (commit_tree_has_high_bit_paths(r, c))
+		return NULL;
+
+	if (p && commit_tree_has_high_bit_paths(r, p->item))
+		return NULL;
+
+	filter->version =3D hash_version;
+
+	return filter;
+}
+
 struct bloom_filter *get_bloom_filter(struct repository *r, struct commit =
*c)
 {
 	struct bloom_filter *filter;
@@ -292,9 +362,23 @@ struct bloom_filter *get_or_compute_bloom_filter(struc=
t repository *r,
 						     filter, graph_pos);
 	}
=20
-	if ((filter->data && filter->len) &&
-	    (!settings || settings->hash_version =3D=3D filter->version))
-		return filter;
+	if (filter->data && filter->len) {
+		struct bloom_filter *upgrade;
+		if (!settings || settings->hash_version =3D=3D filter->version)
+			return filter;
+
+		/* version mismatch, see if we can upgrade */
+		if (compute_if_not_present &&
+		    git_env_bool("GIT_TEST_UPGRADE_BLOOM_FILTERS", 1)) {
+			upgrade =3D upgrade_filter(r, c, filter,
+						 settings->hash_version);
+			if (upgrade) {
+				if (computed)
+					*computed |=3D BLOOM_UPGRADED;
+				return upgrade;
+			}
+		}
+	}
 	if (!compute_if_not_present)
 		return NULL;
=20
diff --git a/bloom.h b/bloom.h
index bfe389e29c..e3a9b68905 100644
--- a/bloom.h
+++ b/bloom.h
@@ -102,6 +102,7 @@ enum bloom_filter_computed {
 	BLOOM_COMPUTED     =3D (1 << 1),
 	BLOOM_TRUNC_LARGE  =3D (1 << 2),
 	BLOOM_TRUNC_EMPTY  =3D (1 << 3),
+	BLOOM_UPGRADED     =3D (1 << 4),
 };
=20
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
diff --git a/commit-graph.c b/commit-graph.c
index a8e33c0739..a3473df515 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1045,6 +1045,7 @@ struct write_commit_graph_context {
 	int count_bloom_filter_not_computed;
 	int count_bloom_filter_trunc_empty;
 	int count_bloom_filter_trunc_large;
+	int count_bloom_filter_upgraded;
 };
=20
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1651,6 +1652,8 @@ static void trace2_bloom_filter_write_statistics(stru=
ct write_commit_graph_conte
 			   ctx->count_bloom_filter_trunc_empty);
 	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-large",
 			   ctx->count_bloom_filter_trunc_large);
+	trace2_data_intmax("commit-graph", ctx->r, "filter-upgraded",
+			   ctx->count_bloom_filter_upgraded);
 }
=20
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
@@ -1692,6 +1695,8 @@ static void compute_bloom_filters(struct write_commit=
_graph_context *ctx)
 				ctx->count_bloom_filter_trunc_empty++;
 			if (computed & BLOOM_TRUNC_LARGE)
 				ctx->count_bloom_filter_trunc_large++;
+		} else if (computed & BLOOM_UPGRADED) {
+			ctx->count_bloom_filter_upgraded++;
 		} else if (computed & BLOOM_NOT_COMPUTED)
 			ctx->count_bloom_filter_not_computed++;
 		ctx->total_bloom_filter_data_size +=3D filter
diff --git a/object.h b/object.h
index db25714b4e..2e5e08725f 100644
--- a/object.h
+++ b/object.h
@@ -75,6 +75,7 @@ void object_array_init(struct object_array *array);
  * commit-reach.c:                                  16-----19
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
+ * bloom.c:                                                    2122
  * builtin/fsck.c:           0--3
  * builtin/gc.c:             0
  * builtin/index-pack.c:                                     2021
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 940a71d8b8..502115abc3 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -217,6 +217,10 @@ test_filter_trunc_large () {
 	grep "\"key\":\"filter-trunc-large\",\"value\":\"$1\"" $2
 }
=20
+test_filter_upgraded () {
+	grep "\"key\":\"filter-upgraded\",\"value\":\"$1\"" $2
+}
+
 test_expect_success 'correctly report changes over limit' '
 	git init limits &&
 	(
@@ -561,10 +565,19 @@ test_expect_success 'when writing another commit grap=
h, preserve existing versio
 test_expect_success 'when writing commit graph, do not reuse changed-path =
of another version' '
 	git init doublewrite &&
 	test_commit -C doublewrite c "$CENT" &&
+
 	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
-	git -C doublewrite commit-graph write --reachable --changed-paths &&
+	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
+		git -C doublewrite commit-graph write --reachable --changed-paths &&
+	test_filter_computed 1 trace2.txt &&
+	test_filter_upgraded 0 trace2.txt &&
+
 	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
-	git -C doublewrite commit-graph write --reachable --changed-paths &&
+	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
+		git -C doublewrite commit-graph write --reachable --changed-paths &&
+	test_filter_computed 1 trace2.txt &&
+	test_filter_upgraded 0 trace2.txt &&
+
 	(
 		cd doublewrite &&
 		echo "c01f" >expect &&
@@ -573,4 +586,22 @@ test_expect_success 'when writing commit graph, do not=
 reuse changed-path of ano
 	)
 '
=20
+test_expect_success 'when writing commit graph, reuse changed-path of anot=
her version where possible' '
+	git init upgrade &&
+
+	test_commit -C upgrade base no-high-bits &&
+
+	git -C upgrade config --add commitgraph.changedPathsVersion 1 &&
+	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
+		git -C upgrade commit-graph write --reachable --changed-paths &&
+	test_filter_computed 1 trace2.txt &&
+	test_filter_upgraded 0 trace2.txt &&
+
+	git -C upgrade config --add commitgraph.changedPathsVersion 2 &&
+	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
+		git -C upgrade commit-graph write --reachable --changed-paths &&
+	test_filter_computed 0 trace2.txt &&
+	test_filter_upgraded 1 trace2.txt
+'
+
 test_done
--=20
2.42.0.rc2.253.gd59a3bf2b4-goog


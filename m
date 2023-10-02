Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B94E784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjJBCkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBCkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F9EA7
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79fa2125e19so507466239f.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214442; x=1696819242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJjdapxWuM0wr8A2uYOG1s6AXd+bHvGi5oBm5BjCs8k=;
        b=QMIWP8hqEFGIWktoe06gN0ewDkVUAFdhFxLBUZNv5dwZTAJor2jVcA2gYJyml097co
         /OJzGaLf//mdnU7oiWCDsll58y0ouvx+AyaYYGcW8ca2DSb22GY+0IzSRavxTT6mUB3J
         6HuSyxap07QXzBtIaQ6/x+bcKloka3leW7qdV7ZkTgRDWZU3PxDbObDxAxD843bPtJCX
         lIoAV8rnqmUnCPElSOk+GiKnfCzgnv/MOVQZ8FB1N1yUZOVuz79UrFYPlktRsGi8zedi
         PoIH6eT4LVxZ5MBeT3D6W2QwOpXbKaY3Ax0/7FCP0K2+SvapiSSMaBu7XNFSF9BAOApk
         +tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214442; x=1696819242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJjdapxWuM0wr8A2uYOG1s6AXd+bHvGi5oBm5BjCs8k=;
        b=YkkrsLeuB/rdAurtROYR7ADAXURZlm80eUu9QjKwJEknRsazDtzdy87EVYd31IS2af
         3CxsjCE0QI/bTLaemdmoBVsBmsgPGbg/gKIogsaiNc3YK1givKkXAayIZfD90+AsIdIk
         f3/vyQoedNIny7Zuwgvf/8MD61mC17W2a15jNC9QiyGslBYyO5FjorITRMFZfjXWe/E2
         QrlU5W0rE3KiIUJZf6j/nxxxxyVrpoRsnB3cT+QOaJBYBBEtviY3IjexQVRB+7VhACZw
         giib4etkfT5ZOl/ldMWJ8JUW/SCqIq3edv/Q+RJu7Od3GwQmlssUceE43B+q9QtrJ/3q
         rYdg==
X-Gm-Message-State: AOJu0Yxc7iTlgfKqOmMZUiumr5ybVXTfz+JqgJAD1kJn/UPO8mjcfhID
        BLnQD0sRz63nPxAljkLVepshkfD0Shnuyg==
X-Google-Smtp-Source: AGHT+IHtTey+Jo8t6L+/X45lga4O8DXaTKiyL9MU6b4Bl9hkoS9odM2RvdAsGdTe1ElMarWfarZkDA==
X-Received: by 2002:a05:6602:21d1:b0:79a:bbd2:8f5a with SMTP id c17-20020a05660221d100b0079abbd28f5amr11799381ioc.12.1696214442505;
        Sun, 01 Oct 2023 19:40:42 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:42 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 03/30] object-names: support input of oids in any supported hash
Date:   Sun,  1 Oct 2023 21:40:07 -0500
Message-Id: <20231002024034.2611-3-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Support short oids encoded in any algorithm, while ensuring enough of
the oid is specified to disambiguate between all of the oids in the
repository encoded in any algorithm.

By default have the code continue to only accept oids specified in the
storage hash algorithm of the repository, but when something is
ambiguous display all of the possible oids from any accepted oid
encoding.

A new flag is added GET_OID_HASH_ANY that when supplied causes the
code to accept oids specified in any hash algorithm, and to return the
oids that were resolved.

This implements the functionality that allows both SHA-1 and SHA-256
object names, from the "Object names on the command line" section of
the hash function transition document.

Care is taken in get_short_oid so that when the result is ambiguous
the output remains the same if GIT_OID_HASH_ANY was not supplied.  If
GET_OID_HASH_ANY was supplied objects of any hash algorithm that match
the prefix are displayed.

This required updating repo_for_each_abbrev to give it a parameter so
that it knows to look at all hash algorithms.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/rev-parse.c |  2 +-
 hash-ll.h           |  1 +
 object-name.c       | 46 ++++++++++++++++++++++++++++++++++-----------
 object-name.h       |  3 ++-
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index fde8861ca4e0..43e96765400c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -882,7 +882,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (skip_prefix(arg, "--disambiguate=", &arg)) {
-				repo_for_each_abbrev(the_repository, arg,
+				repo_for_each_abbrev(the_repository, arg, the_hash_algo,
 						     show_abbrev, NULL);
 				continue;
 			}
diff --git a/hash-ll.h b/hash-ll.h
index 10d84cc20888..2cfde63ae1cf 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -145,6 +145,7 @@ struct object_id {
 #define GET_OID_RECORD_PATH     0200
 #define GET_OID_ONLY_TO_DIE    04000
 #define GET_OID_REQUIRE_PATH  010000
+#define GET_OID_HASH_ANY      020000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 0bfa29dbbfe9..7dd6e5e47566 100644
--- a/object-name.c
+++ b/object-name.c
@@ -25,6 +25,7 @@
 #include "midx.h"
 #include "commit-reach.h"
 #include "date.h"
+#include "object-file-convert.h"
 
 static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
 
@@ -49,6 +50,7 @@ struct disambiguate_state {
 
 static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
 {
+	/* The hash algorithm of current has already been filtered */
 	if (ds->always_call_fn) {
 		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
 		return;
@@ -134,6 +136,8 @@ static void unique_in_midx(struct multi_pack_index *m,
 {
 	uint32_t num, i, first = 0;
 	const struct object_id *current = NULL;
+	int len = ds->len > ds->repo->hash_algo->hexsz ?
+		ds->repo->hash_algo->hexsz : ds->len;
 	num = m->num_objects;
 
 	if (!num)
@@ -149,7 +153,7 @@ static void unique_in_midx(struct multi_pack_index *m,
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		current = nth_midxed_object_oid(&oid, m, i);
-		if (!match_hash(ds->len, ds->bin_pfx.hash, current->hash))
+		if (!match_hash(len, ds->bin_pfx.hash, current->hash))
 			break;
 		update_candidates(ds, current);
 	}
@@ -159,6 +163,8 @@ static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
 	uint32_t num, i, first = 0;
+	int len = ds->len > ds->repo->hash_algo->hexsz ?
+		ds->repo->hash_algo->hexsz : ds->len;
 
 	if (p->multi_pack_index)
 		return;
@@ -177,7 +183,7 @@ static void unique_in_pack(struct packed_git *p,
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		nth_packed_object_id(&oid, p, i);
-		if (!match_hash(ds->len, ds->bin_pfx.hash, oid.hash))
+		if (!match_hash(len, ds->bin_pfx.hash, oid.hash))
 			break;
 		update_candidates(ds, &oid);
 	}
@@ -188,6 +194,10 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
+	/* Skip, unless oids from the storage hash algorithm are wanted */
+	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
+		return;
+
 	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
 	     m = m->next)
 		unique_in_midx(m, ds);
@@ -326,11 +336,12 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 
 static int init_object_disambiguation(struct repository *r,
 				      const char *name, int len,
+				      const struct git_hash_algo *algo,
 				      struct disambiguate_state *ds)
 {
 	int i;
 
-	if (len < MINIMUM_ABBREV || len > the_hash_algo->hexsz)
+	if (len < MINIMUM_ABBREV || len > GIT_MAX_HEXSZ)
 		return -1;
 
 	memset(ds, 0, sizeof(*ds));
@@ -357,6 +368,7 @@ static int init_object_disambiguation(struct repository *r,
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
 	ds->repo = r;
+	ds->bin_pfx.algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
 	prepare_alt_odb(r);
 	return 0;
 }
@@ -491,9 +503,10 @@ static int repo_collect_ambiguous(struct repository *r UNUSED,
 	return collect_ambiguous(oid, data);
 }
 
-static int sort_ambiguous(const void *a, const void *b, void *ctx)
+static int sort_ambiguous(const void *va, const void *vb, void *ctx)
 {
 	struct repository *sort_ambiguous_repo = ctx;
+	const struct object_id *a = va, *b = vb;
 	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
 	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
@@ -503,8 +516,12 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	 * Sorts by hash within the same object type, just as
 	 * oid_array_for_each_unique() would do.
 	 */
-	if (a_type == b_type)
-		return oidcmp(a, b);
+	if (a_type == b_type) {
+		if (a->algo == b->algo)
+			return oidcmp(a, b);
+		else
+			return a->algo > b->algo ? 1 : -1;
+	}
 
 	/*
 	 * Between object types show tags, then commits, and finally
@@ -533,8 +550,12 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	int status;
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
+	const struct git_hash_algo *algo = r->hash_algo;
+
+	if (flags & GET_OID_HASH_ANY)
+		algo = NULL;
 
-	if (init_object_disambiguation(r, name, len, &ds) < 0)
+	if (init_object_disambiguation(r, name, len, algo, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -588,7 +609,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		if (!ds.ambiguous)
 			ds.fn = NULL;
 
-		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
+		repo_for_each_abbrev(r, ds.hex_pfx, algo, collect_ambiguous, &collect);
 		sort_ambiguous_oid_array(r, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &out))
@@ -610,13 +631,14 @@ static enum get_oid_result get_short_oid(struct repository *r,
 }
 
 int repo_for_each_abbrev(struct repository *r, const char *prefix,
+			 const struct git_hash_algo *algo,
 			 each_abbrev_fn fn, void *cb_data)
 {
 	struct oid_array collect = OID_ARRAY_INIT;
 	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(r, prefix, strlen(prefix), &ds) < 0)
+	if (init_object_disambiguation(r, prefix, strlen(prefix), algo, &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
@@ -787,10 +809,12 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 			      const struct object_id *oid, int len)
 {
+	const struct git_hash_algo *algo =
+		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
 	struct object_id oid_ret;
-	const unsigned hexsz = r->hash_algo->hexsz;
+	const unsigned hexsz = algo->hexsz;
 
 	if (len < 0) {
 		unsigned long count = repo_approximate_object_count(r);
@@ -826,7 +850,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 
 	find_abbrev_len_packed(&mad);
 
-	if (init_object_disambiguation(r, hex, mad.cur_len, &ds) < 0)
+	if (init_object_disambiguation(r, hex, mad.cur_len, algo, &ds) < 0)
 		return -1;
 
 	ds.fn = repo_extend_abbrev_len;
diff --git a/object-name.h b/object-name.h
index 9ae522307148..064ddc97d1fe 100644
--- a/object-name.h
+++ b/object-name.h
@@ -67,7 +67,8 @@ enum get_oid_result get_oid_with_context(struct repository *repo, const char *st
 
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
-int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
+int repo_for_each_abbrev(struct repository *r, const char *prefix,
+			 const struct git_hash_algo *algo, each_abbrev_fn, void *);
 
 int set_disambiguate_hint_config(const char *var, const char *value);
 
-- 
2.41.0


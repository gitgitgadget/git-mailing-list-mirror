Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347F41F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeGLTvj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:39 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45434 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so25145477qti.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jt0NQN7Hu5Lz8EBuKd7hmrVnOFG8wXftuYia3LXMiLg=;
        b=g+pcJ4TiDiduW3yTAi3DBYZ9GKP0vdT6Hw/aeutYI3jVmDMy0HGkJ5atZ+uPfyN6yF
         FQX7JvXa6pK7xOs/LVMyVn0G7j229h0uP9vOaRixeTpCWm3r2mixmYJ5gJNxhuz1tqxQ
         9QCYMTdMxFlmMcd8HCX8nV4uhqR/x7LVBD8dTob2z3/ErAT392/3laku2r7LK9LlZGgm
         rUFqBLCbhX8+XqkBAMDr5LHAcVjRtUv3dynFmpGj1GbpK3gy3yfx5LVpb0NSuvtbWzBk
         l8Jwk0kBQ9tNTCdFMyVUU/fsc6EjPO9VyvZtcu2sD3a3jFeoKW2bRFhhEDoTuDf9VEsh
         VQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jt0NQN7Hu5Lz8EBuKd7hmrVnOFG8wXftuYia3LXMiLg=;
        b=pfob4px8IxRCuqxR68uNkvvgpwFPs+HYtkdFYLAxFVfiqKcdfx4QiE+n8wWEiq56N2
         whiX0CnzzduGFcSspHj1zYwG9lEI40WpYaeruPYTLgEKi09l7SRBHT1kEgtpbIy2JjOK
         ub9516mazVrJfinb23DexrPPgBDeR2i0pfqvnyt5BIkkvoLDkuGu70WJ8gE/DMByGn3Q
         oQynmztcnihFT7tDna7yL+EHezSMjLIKkHZwY7F++y7d2ftgt/bLwiBg9ZtyXDEW0eqy
         BalG6gLxwHedraWpVZsPSFanhx61lfzpZZ84q4TOMlt/irU9bgCnsMjICJtOcJvzl07i
         UP7A==
X-Gm-Message-State: AOUpUlFPu6tMhes/Fk0Jqpo3eRfhTvo7I9kdWUocllASH7wyaXLwXN25
        utEySYEDg3A6GFinnvkI3q05dIEE6Is=
X-Google-Smtp-Source: AAOMgpdFCcfGh1rPx+2Pp3la61Acy59pmPKXnppNS/qZOzY0kHm6c/rQkRMyRJiAVLd+624GREHEvQ==
X-Received: by 2002:ac8:1b88:: with SMTP id z8-v6mr3104258qtj.321.1531424438266;
        Thu, 12 Jul 2018 12:40:38 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:37 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 18/23] midx: use midx in abbreviation calculations
Date:   Thu, 12 Jul 2018 15:39:35 -0400
Message-Id: <20180712193940.21065-19-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c      | 11 +++++++++
 midx.h      |  3 +++
 packfile.c  |  6 +++++
 packfile.h  |  1 +
 sha1-name.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+)

diff --git a/midx.c b/midx.c
index 182535933c..4e014ff6e3 100644
--- a/midx.c
+++ b/midx.c
@@ -203,6 +203,17 @@ int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32
 			    MIDX_HASH_LEN, result);
 }
 
+struct object_id *nth_midxed_object_oid(struct object_id *oid,
+					struct multi_pack_index *m,
+					uint32_t n)
+{
+	if (n >= m->num_objects)
+		return NULL;
+
+	hashcpy(oid->hash, m->chunk_oid_lookup + m->hash_len * n);
+	return oid;
+}
+
 static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 {
 	const unsigned char *offset_data;
diff --git a/midx.h b/midx.h
index 377838c9ca..1b976df873 100644
--- a/midx.h
+++ b/midx.h
@@ -31,6 +31,9 @@ struct multi_pack_index {
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
+struct object_id *nth_midxed_object_oid(struct object_id *oid,
+					struct multi_pack_index *m,
+					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
diff --git a/packfile.c b/packfile.c
index bc763d91b9..c0eb5ac885 100644
--- a/packfile.c
+++ b/packfile.c
@@ -961,6 +961,12 @@ struct packed_git *get_packed_git(struct repository *r)
 	return r->objects->packed_git;
 }
 
+struct multi_pack_index *get_multi_pack_index(struct repository *r)
+{
+	prepare_packed_git(r);
+	return r->objects->multi_pack_index;
+}
+
 struct list_head *get_packed_git_mru(struct repository *r)
 {
 	prepare_packed_git(r);
diff --git a/packfile.h b/packfile.h
index b0eed44c0b..046280caf3 100644
--- a/packfile.h
+++ b/packfile.h
@@ -45,6 +45,7 @@ extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
+struct multi_pack_index *get_multi_pack_index(struct repository *r);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..7dc71201e6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "midx.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
@@ -149,6 +150,32 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 	return 1;
 }
 
+static void unique_in_midx(struct multi_pack_index *m,
+			   struct disambiguate_state *ds)
+{
+	uint32_t num, i, first = 0;
+	const struct object_id *current = NULL;
+	num = m->num_objects;
+
+	if (!num)
+		return;
+
+	bsearch_midx(&ds->bin_pfx, m, &first);
+
+	/*
+	 * At this point, "first" is the location of the lowest object
+	 * with an object name that could match "bin_pfx".  See if we have
+	 * 0, 1 or more objects that actually match(es).
+	 */
+	for (i = first; i < num && !ds->ambiguous; i++) {
+		struct object_id oid;
+		current = nth_midxed_object_oid(&oid, m, i);
+		if (!match_sha(ds->len, ds->bin_pfx.hash, current->hash))
+			break;
+		update_candidates(ds, current);
+	}
+}
+
 static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
@@ -177,8 +204,12 @@ static void unique_in_pack(struct packed_git *p,
 
 static void find_short_packed_object(struct disambiguate_state *ds)
 {
+	struct multi_pack_index *m;
 	struct packed_git *p;
 
+	for (m = get_multi_pack_index(the_repository); m && !ds->ambiguous;
+	     m = m->next)
+		unique_in_midx(m, ds);
 	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -527,6 +558,42 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static void find_abbrev_len_for_midx(struct multi_pack_index *m,
+				     struct min_abbrev_data *mad)
+{
+	int match = 0;
+	uint32_t num, first = 0;
+	struct object_id oid;
+	const struct object_id *mad_oid;
+
+	if (!m->num_objects)
+		return;
+
+	num = m->num_objects;
+	mad_oid = mad->oid;
+	match = bsearch_midx(mad_oid, m, &first);
+
+	/*
+	 * first is now the position in the packfile where we would insert
+	 * mad->hash if it does not exist (or the position of mad->hash if
+	 * it does exist). Hence, we consider a maximum of two objects
+	 * nearby for the abbreviation length.
+	 */
+	mad->init_len = 0;
+	if (!match) {
+		if (nth_midxed_object_oid(&oid, m, first))
+			extend_abbrev_len(&oid, mad);
+	} else if (first < num - 1) {
+		if (nth_midxed_object_oid(&oid, m, first + 1))
+			extend_abbrev_len(&oid, mad);
+	}
+	if (first > 0) {
+		if (nth_midxed_object_oid(&oid, m, first - 1))
+			extend_abbrev_len(&oid, mad);
+	}
+	mad->init_len = mad->cur_len;
+}
+
 static void find_abbrev_len_for_pack(struct packed_git *p,
 				     struct min_abbrev_data *mad)
 {
@@ -565,8 +632,11 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 
 static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
+	struct multi_pack_index *m;
 	struct packed_git *p;
 
+	for (m = get_multi_pack_index(the_repository); m; m = m->next)
+		find_abbrev_len_for_midx(m, mad);
 	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.18.0.118.gd4f65b8d14


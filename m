Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC251F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934514AbeFYOfj (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:39 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41953 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934477AbeFYOfc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:32 -0400
Received: by mail-qk0-f193.google.com with SMTP id d22-v6so1932266qkc.8
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNcGkfPFkEsnggzw9t1mn3Qys9AzLUrFjZhCe55MGzM=;
        b=FuDFU96jiRbgPCityC1EXgJNTG0LEqh7BCQAaYJNVsRM2B60j3qi4N06P/ST6Lkv4g
         vSlcbacq/7XoeaeT4rJ2XB9U8KtTrSfNbevDq4gg4O4Og+HEI7tlYaat6+6WRSbKGGd3
         MbYiNd2w5WlUHHNmkwmxNhFcSdaEHw5ivx4M8KGT9mAoRqkx3oWZ4KvtG7JENQCWrxb4
         G0+0tjct+pC6HQHSN8EKGd2OYjIw+Oo2ZNr1HSnLsURy56Gqjc1BCkdadol8qeE6E9sz
         wEIqaha40jyT3YzTFZJ+SYii3FXkXnE2DL/+SiIw2LTKUce+9VyAusZ3+ulx0Nuu4mSp
         nVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bNcGkfPFkEsnggzw9t1mn3Qys9AzLUrFjZhCe55MGzM=;
        b=Bt9XJmCv0oVdDs4FkmPm6IFXCARmKe4ldSAVlPbQ0wt3V3t1CCweg9C6Xgpr3VpIbS
         CtIvSDW+/SnDvItNyftWf9c4Zlz47qaMNAE07fY4HxniwVXP86B2Fkwdzf3w6IDtYev4
         ppiYOUahagUshn29hpkObAw0R1ifUEOT9jXzbTcn5dAVy3vC9GEtdZLrcrkBlFSLnhdr
         mcJ0oYyKxEJsmHEvqZGnYPoP/r1sbLK1bdRxXMWb7Mo4R2Azpm0rj0akh4IFXhMJDaNg
         OEBV9xMp+6lO324TZ4oIT8+d3Odh7VdS4GUgH4PJfXUG3lgGE4GEXNkpxdkzWgLVF263
         2C7A==
X-Gm-Message-State: APt69E2orp+FOHWcE5sg7gnL6mTITmzDUNmBk4IXtQK30cCGdUyGvIX8
        tNuBRG2ZYX0SHZr4X1ZWqN3NV+zu
X-Google-Smtp-Source: AAOMgpddJ70oGelGZAtaqHXWF6RvOLysv59h9B5fuYpJVt781sjUoESIus1AWjxAV8q6M0yjry5Ktw==
X-Received: by 2002:a37:ab14:: with SMTP id u20-v6mr1627290qke.120.1529937331421;
        Mon, 25 Jun 2018 07:35:31 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:30 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 19/24] midx: use midx in abbreviation calculations
Date:   Mon, 25 Jun 2018 10:34:29 -0400
Message-Id: <20180625143434.89044-20-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 11 ++++++
 midx.h                      |  3 ++
 packfile.c                  |  6 ++++
 packfile.h                  |  1 +
 sha1-name.c                 | 70 +++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh |  3 +-
 6 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 14514d6828..c258e3ebdf 100644
--- a/midx.c
+++ b/midx.c
@@ -201,6 +201,17 @@ int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32
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
index 6b74a0640f..f7c2ec7893 100644
--- a/midx.h
+++ b/midx.h
@@ -7,6 +7,9 @@ struct multi_pack_index;
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
+struct object_id *nth_midxed_object_oid(struct object_id *oid,
+					struct multi_pack_index *m,
+					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
diff --git a/packfile.c b/packfile.c
index 946d0c241f..20b743da91 100644
--- a/packfile.c
+++ b/packfile.c
@@ -963,6 +963,12 @@ struct packed_git *get_packed_git(struct repository *r)
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
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index f7f55ea181..d8a636c7b7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -93,7 +93,8 @@ compare_results_with_midx() {
 	MSG=$1
 	test_expect_success "check normal git operations: $MSG" '
 		midx_git_two_modes "rev-list --objects --all" &&
-		midx_git_two_modes "log --raw"
+		midx_git_two_modes "log --raw" &&
+		midx_git_two_modes "log --oneline"
 	'
 }
 
-- 
2.18.0.24.g1b579a2ee9


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4711020248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfDPJgE (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46928 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so10089312pfj.13
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KY7cFJryrDrtHm7qKvZz96A/R6hF4Knh4B8JuRphWWw=;
        b=Xch5WMnjdmfCfU8B/YuvLHUJsvoc6907o2jMYjhO4DZCBTGN9fB4+DVTakJ7maJwk+
         txfd3ZUbxFjZ84tFtMoJg+eZnHtWXgOgDWP1g1mt4KZ/dYG/F9KY+unXDBbvr4z+zElZ
         5AqRd2gVKbLUJ53si3F8N+wggFCzSEyxG1CcWBq2C05Y6kbEY2i0+/zmZg4ay/yRgimP
         GpioA4WICECy0uIZ83dRHGKutmPv+nqzY/+zADygNCbwkx77DO8wZ1aiiDqNYWQd1Ooa
         VV3NeL43y/rX6Go2z0wY8qTxaen0IFCU4F69l1PRukm9VI2JNDDAHTaP1EFw28NUscL+
         jf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KY7cFJryrDrtHm7qKvZz96A/R6hF4Knh4B8JuRphWWw=;
        b=MLnMsy06xZjLy2BsumiVTstDXkBa6CYm7VbexLDvvK5PnQeNQbvcTbX1t/PmX27XL7
         sogyOm+MVLRrAWC3nci/ZyJT8O3qPmG1soKGpV54WlDYjxxjh4ENR3XQLsjS6t8aUd6A
         39pDULrIaUjqDRq2hhhsHfa6Ppw8H25v0IUsa/2cRq8AiB3Mybb+Jc16YpQ4xq086XUh
         inUR2ykTr+QcBrnvnstFZ/wkhjU7Ou+VJB6xqeHfcnK5QNiPBlu91gM1k1LhFxhCNqUY
         sJqc6wXuhQ0NPb9TFRsxcRHgpDgQPz5ZbsnR3+jYBjQ5ddD4vRaGmE2LsTlwEsCaTrlp
         o+vg==
X-Gm-Message-State: APjAAAVSOlZRESWa6UfBPb6YdIAUaCOjVTqTUCUNFMjfY89Hsk4VflMW
        BApHvBgWaYXmDaZUEiwFaGo=
X-Google-Smtp-Source: APXvYqxzo2trsiF03TpPxMVMgXbB8V0Wv4WCikausAJONJDXuFCJnqwux4HyszTjgFILx7y+C/uVDg==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr44317703pfm.102.1555407362951;
        Tue, 16 Apr 2019 02:36:02 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id u5sm61819360pfm.121.2019.04.16.02.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 16/34] sha1-name.c: store and use repo in struct disambiguate_state
Date:   Tue, 16 Apr 2019 16:33:23 +0700
Message-Id: <20190416093341.17079-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 95 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 36 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 9b57787b76..a75992eb54 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -17,13 +17,14 @@
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
-typedef int (*disambiguate_hint_fn)(const struct object_id *, void *);
+typedef int (*disambiguate_hint_fn)(struct repository *, const struct object_id *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
 	char hex_pfx[GIT_MAX_HEXSZ + 1];
 	struct object_id bin_pfx;
 
+	struct repository *repo;
 	disambiguate_hint_fn fn;
 	void *cb_data;
 	struct object_id candidate;
@@ -38,7 +39,7 @@ struct disambiguate_state {
 static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
 {
 	if (ds->always_call_fn) {
-		ds->ambiguous = ds->fn(current, ds->cb_data) ? 1 : 0;
+		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
 		return;
 	}
 	if (!ds->candidate_exists) {
@@ -58,7 +59,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	}
 
 	if (!ds->candidate_checked) {
-		ds->candidate_ok = ds->fn(&ds->candidate, ds->cb_data);
+		ds->candidate_ok = ds->fn(ds->repo, &ds->candidate, ds->cb_data);
 		ds->disambiguate_fn_used = 1;
 		ds->candidate_checked = 1;
 	}
@@ -71,7 +72,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	}
 
 	/* if we reach this point, we know ds->candidate satisfies fn */
-	if (ds->fn(current, ds->cb_data)) {
+	if (ds->fn(ds->repo, current, ds->cb_data)) {
 		/*
 		 * if both current and candidate satisfy fn, we cannot
 		 * disambiguate.
@@ -89,9 +90,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct object_directory *odb;
 
-	for (odb = the_repository->objects->odb;
-	     odb && !ds->ambiguous;
-	     odb = odb->next) {
+	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next) {
 		int pos;
 		struct oid_array *loose_objects;
 
@@ -182,10 +181,10 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(the_repository); m && !ds->ambiguous;
+	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
 	     m = m->next)
 		unique_in_midx(m, ds);
-	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
+	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -215,7 +214,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 		 * same repository!
 		 */
 		ds->candidate_ok = (!ds->disambiguate_fn_used ||
-				    ds->fn(&ds->candidate, ds->cb_data));
+				    ds->fn(ds->repo, &ds->candidate, ds->cb_data));
 
 	if (!ds->candidate_ok)
 		return SHORT_NAME_AMBIGUOUS;
@@ -224,59 +223,67 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
-static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_commit_only(struct repository *r,
+				    const struct object_id *oid,
+				    void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_COMMIT;
 }
 
-static int disambiguate_committish_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_committish_only(struct repository *r,
+					const struct object_id *oid,
+					void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(the_repository, oid, NULL);
+	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(the_repository, parse_object(the_repository, oid),
-			NULL, 0);
+	obj = deref_tag(r, parse_object(r, oid), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
 }
 
-static int disambiguate_tree_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_tree_only(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
-static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_treeish_only(struct repository *r,
+				     const struct object_id *oid,
+				     void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(the_repository, oid, NULL);
+	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(the_repository, parse_object(the_repository, oid),
-			NULL, 0);
+	obj = deref_tag(r, parse_object(r, oid), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
 }
 
-static int disambiguate_blob_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_blob_only(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -310,7 +317,8 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 	return error("unknown hint type for '%s': %s", var, value);
 }
 
-static int init_object_disambiguation(const char *name, int len,
+static int init_object_disambiguation(struct repository *r,
+				      const char *name, int len,
 				      struct disambiguate_state *ds)
 {
 	int i;
@@ -341,7 +349,8 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb(the_repository);
+	ds->repo = r;
+	prepare_alt_odb(r);
 	return 0;
 }
 
@@ -351,25 +360,25 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
-	if (ds->fn && !ds->fn(oid, ds->cb_data))
+	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
 
-	type = oid_object_info(the_repository, oid, NULL);
+	type = oid_object_info(ds->repo, oid, NULL);
 	if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(the_repository, oid);
+		struct commit *commit = lookup_commit(ds->repo, oid);
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(the_repository, oid);
+		struct tag *tag = lookup_tag(ds->repo, oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
 
 	advise("  %s %s%s",
-	       find_unique_abbrev(oid, DEFAULT_ABBREV),
+	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
 	       type_name(type) ? type_name(type) : "unknown type",
 	       desc.buf);
 
@@ -383,6 +392,13 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int repo_collect_ambiguous(struct repository *r,
+				  const struct object_id *oid,
+				  void *data)
+{
+	return collect_ambiguous(oid, data);
+}
+
 static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
@@ -428,7 +444,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
-	if (init_object_disambiguation(name, len, &ds) < 0)
+	if (init_object_disambiguation(the_repository, name, len, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -483,11 +499,11 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(prefix, strlen(prefix), &ds) < 0)
+	if (init_object_disambiguation(the_repository, prefix, strlen(prefix), &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
-	ds.fn = collect_ambiguous;
+	ds.fn = repo_collect_ambiguous;
 	ds.cb_data = &collect;
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
@@ -543,6 +559,13 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static int repo_extend_abbrev_len(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data)
+{
+	return extend_abbrev_len(oid, cb_data);
+}
+
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
 				     struct min_abbrev_data *mad)
 {
@@ -668,10 +691,10 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 
 	find_abbrev_len_packed(&mad);
 
-	if (init_object_disambiguation(hex, mad.cur_len, &ds) < 0)
+	if (init_object_disambiguation(r, hex, mad.cur_len, &ds) < 0)
 		return -1;
 
-	ds.fn = extend_abbrev_len;
+	ds.fn = repo_extend_abbrev_len;
 	ds.always_call_fn = 1;
 	ds.cb_data = (void *)&mad;
 
-- 
2.21.0.682.g30d2204636


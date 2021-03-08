Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF8C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B175E6527E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCHUFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhCHUEp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:45 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEB3C061761
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so12780110wrx.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNFz6IMdpiVx7Totg5e/mNtkf3J6iAY1VcDfZ3C3JAs=;
        b=UsimX8J/eyh9sILsPK1Z1Gu9w7HHdclOkLF3jAxSOnU95pPly2rLdLbKomUxzK+tRo
         AJ9Ag1thh4LxwFLO5OkXhlOHdqTNjM0oOCZ9+YVV0XGjxR+GVAV1DD40l9dKqsD+2dgb
         nxFRLI8DBfWJNKnkIjgcJCk/qlc/eLaSHAOy1aAgycme7N1wiVZgaUwM3p1nqwSvZh17
         X2OMZ+41H2wQX9VguU454ePp7yFONkbxo73kHknCzQuH4icR0HMX3rel7fBxeCH6igly
         AiJtEpVhm8KvizYT9ZkIb6OkkkI8WtcXcIXDDKyBo2OC9qfzkmyOl76J770QL3uaa5oM
         p86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNFz6IMdpiVx7Totg5e/mNtkf3J6iAY1VcDfZ3C3JAs=;
        b=RrbTqv/Q6M+5gwGaf39MXkuHPlfDZuuXYzYzOt7zFkMLH/LIX3n0v14QbirlIQ8IB7
         oQlH20t3jBxDs6M+nrrGx70MUyYNcA0ZHNz4rYFX7iwbckkMaOkLobhdnUZgooxQJK6Z
         F2Dx9MXICayaW8pQJunoFrzj9+Wu5YM3cFZr2vbo9adc2gWTg2hoWXO24fhJuwkP9kyj
         9L0GsG69elAy4RT2ZjWwWBHodsafyoY4dDVqlw9MBYa3FAGXs4qk9jzwWUxgBL9wrvAU
         PYqTVxSMegJ1L+bXodByXhFwbPg1cxUlHzUmkwMQhXavoGHYAzqIldMmVfo6ef6HVxI3
         iy/Q==
X-Gm-Message-State: AOAM533J7Kdrd7PdAUstaJpS9k8wnjRxLMIzDc7AUUKj4C4LGdaB0W5M
        MAWfx0KgSs7l4FVK8zeyz7H/uuDgegcfrg==
X-Google-Smtp-Source: ABdhPJyxaUH0lrMw5DHVO8QR4hRJ6u1uXrkn+w/G0NAW/S/jszG237uBi1xZfYOyICGNmoVAEtH4jQ==
X-Received: by 2002:a5d:4148:: with SMTP id c8mr12229110wrq.91.1615233883480;
        Mon, 08 Mar 2021 12:04:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] oid_object_info(): return "enum object_type"
Date:   Mon,  8 Mar 2021 21:04:22 +0100
Message-Id: <20210308200426.21824-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change oid_object_info() to return an "enum object_type", this is what
it did anyway, except that it hardcoded -1 instead of an
OBJ_BAD.

Let's instead have it return the "enum object_type", at which point
callers will expect OBJ_BAD. This allows for refactoring code that
e.g. expected any "< 0" value, but would only have to deal with
OBJ_BAD (= -1).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c          |  2 +-
 builtin/cat-file.c       |  2 +-
 builtin/index-pack.c     |  6 +++---
 builtin/mktree.c         |  2 +-
 builtin/pack-objects.c   |  4 ++--
 builtin/replace.c        |  2 +-
 builtin/tag.c            |  2 +-
 builtin/unpack-objects.c |  6 +++++-
 object-file.c            | 11 +++++------
 object-name.c            | 18 +++++++++---------
 object-store.h           |  2 +-
 packfile.c               |  4 +---
 reachable.c              |  5 +++--
 13 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..5dd3c38a8c6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -810,7 +810,7 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 	oidcpy(&oid, oid_ret);
 	while (1) {
 		struct object *obj;
-		int kind = oid_object_info(r, &oid, NULL);
+		enum object_type kind = oid_object_info(r, &oid, NULL);
 		if (kind == OBJ_COMMIT) {
 			oidcpy(oid_ret, &oid);
 			return 0;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e8..1d989c62a4e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -133,7 +133,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 'p':
 		type = oid_object_info(the_repository, &oid, NULL);
-		if (type < 0)
+		if (type == OBJ_BAD)
 			die("Not a valid object name %s", obj_name);
 
 		/* custom pretty-print here */
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bad57488079..253cfb07fbd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -236,8 +236,8 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = oid_object_info(the_repository, &obj->oid, &size);
-		if (type <= 0)
+		enum object_type type = oid_object_info(the_repository, &obj->oid, &size);
+		if (type == OBJ_BAD)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
 		if (type != obj->type)
@@ -820,7 +820,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		unsigned long has_size;
 		read_lock();
 		has_type = oid_object_info(the_repository, oid, &has_size);
-		if (has_type < 0)
+		if (has_type == OBJ_BAD)
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
 			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 891991b00d6..e6f8e0edb23 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -118,7 +118,7 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 
 	/* Check the type of object identified by sha1 */
 	obj_type = oid_object_info(the_repository, &oid, NULL);
-	if (obj_type < 0) {
+	if (obj_type == OBJ_BAD) {
 		if (allow_missing) {
 			; /* no problem - missing objects are presumed to be of the right type */
 		} else {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d62aaf59a0..e60ae4ebd9a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2222,7 +2222,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
 		packing_data_lock(&to_pack);
-		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
+		if (oid_object_info(the_repository, &e->idx.oid, &size) == OBJ_BAD)
 			die(_("unable to get size of %s"),
 			    oid_to_hex(&e->idx.oid));
 		packing_data_unlock(&to_pack);
@@ -3198,7 +3198,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
-	if (type < 0) {
+	if (type == OBJ_BAD) {
 		warning(_("loose object at %s could not be examined"), path);
 		return 0;
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index cd487659117..e9e151ae957 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -322,7 +322,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 		return error(_("not a valid object name: '%s'"), object_ref);
 
 	type = oid_object_info(the_repository, &old_oid, NULL);
-	if (type < 0)
+	if (type == OBJ_BAD)
 		return error(_("unable to get object type for %s"),
 			     oid_to_hex(&old_oid));
 
diff --git a/builtin/tag.c b/builtin/tag.c
index d403417b562..18206341409 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -260,7 +260,7 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	char *path = NULL;
 
 	type = oid_object_info(the_repository, object, NULL);
-	if (type <= OBJ_NONE)
+	if (type == OBJ_BAD)
 		die(_("bad object type."));
 
 	if (type == OBJ_TAG)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dd4a75e030d..c88daa3a5b1 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -203,7 +203,11 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 	if (!(obj->flags & FLAG_OPEN)) {
 		unsigned long size;
 		int type = oid_object_info(the_repository, &obj->oid, &size);
-		if (type != obj->type || type <= 0)
+		if (type == OBJ_BAD)
+			die(_("unable to get object type for %s"),
+			    oid_to_hex(&obj->oid));
+		if (type != obj->type)
+			/* todo to new function */
 			die("object of unexpected type");
 		obj->flags |= FLAG_WRITTEN;
 		return 0;
diff --git a/object-file.c b/object-file.c
index cd30c2b5590..8be6ce56133 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1573,10 +1573,9 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 }
 
 
-/* returns enum object_type or negative */
-int oid_object_info(struct repository *r,
-		    const struct object_id *oid,
-		    unsigned long *sizep)
+enum object_type oid_object_info(struct repository *r,
+				 const struct object_id *oid,
+				 unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1585,7 +1584,7 @@ int oid_object_info(struct repository *r,
 	oi.sizep = sizep;
 	if (oid_object_info_extended(r, oid, &oi,
 				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
-		return -1;
+		return OBJ_BAD;
 	return type;
 }
 
@@ -2265,7 +2264,7 @@ int read_pack_header(int fd, struct pack_header *header)
 void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
-	if (type < 0)
+	if (type == OBJ_BAD)
 		die(_("%s is not a valid object"), oid_to_hex(oid));
 	if (type != expect)
 		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
diff --git a/object-name.c b/object-name.c
index 64202de60b1..c6c3fd5228b 100644
--- a/object-name.c
+++ b/object-name.c
@@ -239,7 +239,7 @@ static int disambiguate_committish_only(struct repository *r,
 					void *cb_data_unused)
 {
 	struct object *obj;
-	int kind;
+	enum object_type kind;
 
 	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_COMMIT)
@@ -258,7 +258,7 @@ static int disambiguate_tree_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data_unused)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	enum object_type kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
@@ -267,7 +267,7 @@ static int disambiguate_treeish_only(struct repository *r,
 				     void *cb_data_unused)
 {
 	struct object *obj;
-	int kind;
+	enum object_type kind;
 
 	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
@@ -286,7 +286,7 @@ static int disambiguate_blob_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data_unused)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	enum object_type kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -361,7 +361,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
 	const struct disambiguate_state *ds = data;
 	struct strbuf desc = STRBUF_INIT;
-	int type;
+	enum object_type type;
 
 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
@@ -405,10 +405,10 @@ static int repo_collect_ambiguous(struct repository *r,
 static int sort_ambiguous(const void *a, const void *b, void *ctx)
 {
 	struct repository *sort_ambiguous_repo = ctx;
-	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
-	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
-	int a_type_sort;
-	int b_type_sort;
+	enum object_type a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
+	enum object_type b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
+	enum object_type a_type_sort;
+	enum object_type b_type_sort;
 
 	/*
 	 * Sorts by hash within the same object type, just as
diff --git a/object-store.h b/object-store.h
index 541dab08586..e9ab6aff2ab 100644
--- a/object-store.h
+++ b/object-store.h
@@ -203,7 +203,7 @@ static inline void *repo_read_object_file(struct repository *r,
 #endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
+enum object_type oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
 int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
diff --git a/packfile.c b/packfile.c
index 1fec12ac5f4..17c8c3222eb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1266,7 +1266,7 @@ static int retry_bad_packed_offset(struct repository *r,
 				   struct packed_git *p,
 				   off_t obj_offset)
 {
-	int type;
+	enum object_type type;
 	uint32_t pos;
 	struct object_id oid;
 	if (offset_to_pack_pos(p, obj_offset, &pos) < 0)
@@ -1274,8 +1274,6 @@ static int retry_bad_packed_offset(struct repository *r,
 	nth_packed_object_id(&oid, p, pack_pos_to_index(p, pos));
 	mark_bad_packed_object(p, oid.hash);
 	type = oid_object_info(r, &oid, NULL);
-	if (type <= OBJ_NONE)
-		return OBJ_BAD;
 	return type;
 }
 
diff --git a/reachable.c b/reachable.c
index 77a60c70a5d..85f04492ea1 100644
--- a/reachable.c
+++ b/reachable.c
@@ -80,8 +80,6 @@ static void add_recent_object(const struct object_id *oid,
 	 * commits and tags to have been parsed.
 	 */
 	type = oid_object_info(the_repository, oid, NULL);
-	if (type < 0)
-		die("unable to get object info for %s", oid_to_hex(oid));
 
 	switch (type) {
 	case OBJ_TAG:
@@ -94,6 +92,9 @@ static void add_recent_object(const struct object_id *oid,
 	case OBJ_BLOB:
 		obj = (struct object *)lookup_blob(the_repository, oid);
 		break;
+	case OBJ_BAD:
+		die("unable to get object info for %s", oid_to_hex(oid));
+		break;
 	default:
 		die("unknown object type for %s: %s",
 		    oid_to_hex(oid), type_name(type));
-- 
2.31.0.rc1.210.g0f8085a843c


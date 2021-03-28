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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB0C433E2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8261613
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhC1COz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhC1COJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027EC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so9305499wrt.8
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lx90BTOGL9jzuTVg21a/+ic/5cUCs0Jk2HDVniXDzWs=;
        b=XEpAKQF5KovKjZK0FbFHBCVNCg8WDvUsrb3t0UdtYOppz6hpV5WJE4hlKkLWhjcpiV
         sPOcARNYtSB1wWHG32uf197LYGvfYmwFX1kLnUxlk5AnaS5PdJwTojlmW9wCm6K5fiXp
         RPMvaD6bMFkSrvfpVR09pX6lPimbA/dlfItd+Oql0y0rhSnKMYu5Gj1H+CnjQjBjFdyC
         aVMYYn0FN4ktBjB/WK6PXPBve9gWkYzd6dfB1UmtRQ80tT37v8GMiavZgLovMXGdXh5U
         4Usmy4SzEAeo/IW5K/H0TTxHm3fUG+52uznOW0S85TBaKasrWiUwDl5KDjytH7tYbJ5K
         p7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lx90BTOGL9jzuTVg21a/+ic/5cUCs0Jk2HDVniXDzWs=;
        b=SfLXRtYDE0pRsW7TkNBuelepoycDNgns4K2ZPZ8OuU5jf1yqHHcOsmhzLn+3wx7Jm7
         wZ8UDJu32tyvPm7h0XgnGFQ3Oz2LvsEVXUsKa4cmfzoE9bd7WTWg5fCkG9pA4on25N9C
         jB/0jhg78c+ErZkI+VU+dRRy0+a37dgOJZj8yLRiopDt8VQJGuOk9FSWzILNU1UY3CYc
         Hgt126tItAZSMojlE1MFhjAZ1CRnDHAulhvqevJx7K3jYWVin4bTTfzFwUzJnOoz2npU
         UvbJCtGdvYyGTCe48vyFEu6q4/cDFMHui3s8L2GAeRVhHVi78FQQDk/6T/uCK1jMt375
         o8aA==
X-Gm-Message-State: AOAM530KUUkwHuywbfLIB7XvEM6lTlhszglBlAJgquUxFVWBoTosXK6X
        VGab2HcL5TkoXtBWn0yqwmUc104+wLZIqA==
X-Google-Smtp-Source: ABdhPJxQ9q7tW+UagV6gNKx2Sc/PQDblrFPJUBg5H2IsgDpAEyrLKv0i+eCeiY8ID/Z3K7o0nNO2hA==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr21984385wrm.1.1616897647572;
        Sat, 27 Mar 2021 19:14:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] object-file.c: make oid_object_info() return "enum object_type"
Date:   Sun, 28 Mar 2021 04:13:34 +0200
Message-Id: <patch-04.11-c10082f4fac-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change oid_object_info() to return an "enum object_type". Unlike
oid_object_info_extended() function the simpler oid_object_info()
explicitly returns the oi.typep member, which is itself an "enum
object_type".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c      |  2 +-
 builtin/index-pack.c |  2 +-
 object-file.c        |  8 +++-----
 object-name.c        | 19 +++++++++----------
 object-store.h       |  4 +++-
 packfile.c           |  2 +-
 6 files changed, 18 insertions(+), 19 deletions(-)

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
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 21899687e2c..17376db1e39 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -236,7 +236,7 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = oid_object_info(the_repository, &obj->oid, &size);
+		enum object_type type = oid_object_info(the_repository, &obj->oid, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
diff --git a/object-file.c b/object-file.c
index b7c26b67355..8ed54d6f621 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1572,11 +1572,9 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	return ret;
 }
 
-
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
diff --git a/object-name.c b/object-name.c
index 64202de60b1..4d7f0c66cf2 100644
--- a/object-name.c
+++ b/object-name.c
@@ -239,9 +239,8 @@ static int disambiguate_committish_only(struct repository *r,
 					void *cb_data_unused)
 {
 	struct object *obj;
-	int kind;
+	enum object_type kind = oid_object_info(r, oid, NULL);
 
-	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -258,7 +257,7 @@ static int disambiguate_tree_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data_unused)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	enum object_type kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
@@ -267,7 +266,7 @@ static int disambiguate_treeish_only(struct repository *r,
 				     void *cb_data_unused)
 {
 	struct object *obj;
-	int kind;
+	enum object_type kind;
 
 	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
@@ -286,7 +285,7 @@ static int disambiguate_blob_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data_unused)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	enum object_type kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -361,7 +360,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
 	const struct disambiguate_state *ds = data;
 	struct strbuf desc = STRBUF_INIT;
-	int type;
+	enum object_type type;
 
 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
@@ -405,10 +404,10 @@ static int repo_collect_ambiguous(struct repository *r,
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
index ec32c23dcb5..eab9674d085 100644
--- a/object-store.h
+++ b/object-store.h
@@ -208,7 +208,9 @@ static inline void *repo_read_object_file(struct repository *r,
 #endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
+enum object_type oid_object_info(struct repository *r,
+				 const struct object_id *,
+				 unsigned long *);
 
 int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
diff --git a/packfile.c b/packfile.c
index 6661f3325a4..3ee01ea7323 100644
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
-- 
2.31.1.442.g6c06c9fe35c


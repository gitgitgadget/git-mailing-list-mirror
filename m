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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2606C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE13E611AD
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDIIdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhDIIdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:33:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F7C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:33:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g5so659446ejx.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEbpMnfDkLJXfmbRDOvHvzdkLQZBhzrmf8fXC+1ulP4=;
        b=nDVULDk3PZ80rMq3D0PBuKlNaM9YVnYP1P8+W90rJbGFFNOTFtpSnaoGD1nhb6GSlc
         OfgABZWovWqdD3PwDfQvINR3wqze3mn3g9zG7/TJSedT0rrfqSTxeDVyjtRsiSMBW7pe
         2AuGuQ+jB49ddbox5AiVzOZnMyjTyRDEAp+Z/9HXEBVAv7UL2YrkGBpxLbXDzeLRPZsL
         F59XIRIZKcWkJbbHkeiIquv0iQcTv4/NOdDxN7RB+yC6fNMW03LhLNQVBGcNe4Vkz/q1
         yPXV4HwphLxyMEAtxmOtil6gIVbwQUBDmGIIMxFfCTau8kDogib2Zh1KdfTplxXMN0m2
         d5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEbpMnfDkLJXfmbRDOvHvzdkLQZBhzrmf8fXC+1ulP4=;
        b=hVxHvv8blLQD+1WrSLv+t/ajVmkUdFjzTR59Bak4S2XGU5MZ6fVpwc3BZ5Af5UeW7V
         r/kNgyiHsCB3b/JeeAAozKwftP3ilkLP7gIZVoiqnCOw5fY2YysHSzXMa2adLxSVwAae
         OTLdkPr6aVGCWmIHdA+x3ZGcSqHArvrJr/wpQnNxsIKyq/b1IJAbDo7IR7aWvFbeho+F
         yaTmgsO89oZg6N8T/NR7VyM2sfBJxrGdJ7TKkb7XBCnqOcdfgyQrmDBWN/ukHpR+BcVo
         Zw3tJAPnVjnhNWi2FHNWS0MNh4isWNlTRJqiHNBy4uYoxxYUWtHHv8DUV+QvZJmhRjNv
         AiqQ==
X-Gm-Message-State: AOAM531/gmuD4TZDAnob1JDObvgvlHs4/dxAUkg3PsnfsRhOGSp//2hQ
        8b3Ia88C84FUwk8uhmxvNBd120kK6KUIgg==
X-Google-Smtp-Source: ABdhPJwpUNRTgZxedUEETp9dZf+ubWvE8nsWOfMahKx79/dnk/Q+4r5mOe0ow5aQwa0fh3WMOcMR/A==
X-Received: by 2002:a17:906:6044:: with SMTP id p4mr15268790ejj.82.1617957186535;
        Fri, 09 Apr 2021 01:33:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n17sm1016707edq.32.2021.04.09.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:33:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] object-file.c: make oid_object_info() return "enum object_type"
Date:   Fri,  9 Apr 2021 10:32:52 +0200
Message-Id: <patch-4.6-ebea1b2b50-20210409T082935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
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
index 641523ff9a..5dd3c38a8c 100644
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
index 15507b5cff..c0e3768c32 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -237,7 +237,7 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = oid_object_info(the_repository, &obj->oid, &size);
+		enum object_type type = oid_object_info(the_repository, &obj->oid, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
diff --git a/object-file.c b/object-file.c
index b7c26b6735..8ed54d6f62 100644
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
index 64202de60b..4d7f0c66cf 100644
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
index ec32c23dcb..eab9674d08 100644
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
index 6661f3325a..3ee01ea732 100644
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
2.31.1.592.gdf54ba9003


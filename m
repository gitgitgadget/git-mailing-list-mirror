Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D9C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D240613C5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhDTMv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhDTMvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1DAC06138C
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so4766014edb.2
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MPs2S/im8D2lzLX+buuuH67o3VpGqcSiM2FQH9dlw3Q=;
        b=EuAfGpzKV4hallFCafEfdJ+H08cLBIfnuxn9q8Dg5PbqLv1aGl1shjPE+u67TFS9U4
         S8twpR108scQSh+gCsvduWLjC7YrCBUdz9p0r+VKayw9H1c7JNe5FwXZ2n7TkrplmMwZ
         gfuINrgcvv22eiKJ1KomLv47qbfGBj/Oc9ZiTJ6CsKkEaFFoj7sDtK88KlSlBbc5Wh4f
         3XBL1a+g2JCBGDL5F5a3iRuWH3gMl1IJ/MC5d4EigoVeuJrAaxoZSezofD2DvoTUt5UX
         9U4fVrNUm0bshNQGOfHmweyfkVyCOPDAdOFlY6jEtVIjmTmIeSKG6o5FXlA65ulrL5I6
         KL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPs2S/im8D2lzLX+buuuH67o3VpGqcSiM2FQH9dlw3Q=;
        b=ZvWUfuLMjJ7rk/jCbyBersMWse9nBx0vDh/S5Gt8dwof8K/yjC/n3+v+AzlW7k1WNA
         qBxVGAv9thhbkyfO9WICUHU6EYbWmo0k+8+1Im4iDdD39mcI5BrpVNwEz3vLx5ssjB+l
         gjC9ZKglV3GQOEc6KovB7+8/8MImwm/q+6qZESnnrZO6YUUogG7vKY5QKCYGz5g83l4d
         7S/mXWwdmvYl2yqcWqlG2YiD7TjVZ7Eo99BbrvJINVkP6QbvnHjDNdgbNxeA5Yxs5TBX
         R5HAhXXsgugsHL2QQsA8mPk3+sE8ZCp8qEsP/sazivPjM7ncVyerLLJOdeaZTpAuMDLj
         fRhA==
X-Gm-Message-State: AOAM533pNBviGbEM3gdqQt/+Me9f5EcoEGL1RbFqFsOh288e6ORkOjH+
        g+8algUanlq+2EQlAQjHH5XJK/rNr4/exQ==
X-Google-Smtp-Source: ABdhPJyDVbMigzjhB9oxPLNNwyJA+G/hupt0Yn3tZAaddRMndRNv6cT+1DA3AhJmffF4Ry2UY/hK0g==
X-Received: by 2002:a50:9e03:: with SMTP id z3mr20231636ede.190.1618923048661;
        Tue, 20 Apr 2021 05:50:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] object-file.c: take type id, not string, in read_object_with_reference()
Date:   Tue, 20 Apr 2021 14:50:37 +0200
Message-Id: <patch-04.10-48aca62864-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the read_object_with_reference() function take "enum object_type"
instead of a "const char *" with a type name that it converted via
type_from_string().

Out of the nine callers of this function, only one wanted to pass a
"const char *". The others were simply passing along the
{commit,tree}_type string constants.

That one caller in builtin/cat-file.c did not expect to pass a "raw"
type (i.e. in invalid "--literally" type, but one gotten from
type_from_string(). Furthermore the read_object_with_reference()
function itself was calling type_from_string(), so this whole thing
amounted to unnecessarily going back and forth.

This API design dates back to f4913f91a96 ([PATCH] Accept commit in
some places when tree is needed., 2005-04-20). At that time there
wasn't an API like type_from_string(). That only arrived in
df8436622fb (formalize typename(), and add its reverse
type_from_string(), 2007-02-26).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c     | 7 ++++---
 builtin/fast-import.c  | 6 +++---
 builtin/grep.c         | 4 ++--
 builtin/pack-objects.c | 2 +-
 cache.h                | 2 +-
 object-file.c          | 7 +++----
 tree-walk.c            | 6 +++---
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e..46fc7a32ba 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -66,7 +66,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
 	struct object_id oid;
-	enum object_type type;
+	enum object_type type, exp_type_id;
 	char *buf;
 	unsigned long size;
 	struct object_context obj_context;
@@ -154,7 +154,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		break;
 
 	case 0:
-		if (type_from_string(exp_type) == OBJ_BLOB) {
+		exp_type_id = type_from_string(exp_type);
+		if (exp_type_id == OBJ_BLOB) {
 			struct object_id blob_oid;
 			if (oid_object_info(the_repository, &oid, NULL) == OBJ_TAG) {
 				char *buffer = read_object_file(&oid, &type,
@@ -177,7 +178,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			 */
 		}
 		buf = read_object_with_reference(the_repository,
-						 &oid, exp_type, &size, NULL);
+						 &oid, exp_type_id, &size, NULL);
 		break;
 
 	default:
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3afa81cf9a..ee52be02f8 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2481,7 +2481,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		unsigned long size;
 		char *buf = read_object_with_reference(the_repository,
 						       &commit_oid,
-						       commit_type, &size,
+						       OBJ_COMMIT, &size,
 						       &commit_oid);
 		if (!buf || size < the_hash_algo->hexsz + 6)
 			die("Not a valid commit: %s", p);
@@ -2553,7 +2553,7 @@ static void parse_from_existing(struct branch *b)
 		char *buf;
 
 		buf = read_object_with_reference(the_repository,
-						 &b->oid, commit_type, &size,
+						 &b->oid, OBJ_COMMIT, &size,
 						 &b->oid);
 		parse_from_commit(b, buf, size);
 		free(buf);
@@ -2649,7 +2649,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			unsigned long size;
 			char *buf = read_object_with_reference(the_repository,
 							       &n->oid,
-							       commit_type,
+							       OBJ_COMMIT,
 							       &size, &n->oid);
 			if (!buf || size < the_hash_algo->hexsz + 6)
 				die("Not a valid commit: %s", from);
diff --git a/builtin/grep.c b/builtin/grep.c
index 5de725f904..f2a73c92fa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -467,7 +467,7 @@ static int grep_submodule(struct grep_opt *opt,
 		object = parse_object_or_die(oid, NULL);
 		obj_read_unlock();
 		data = read_object_with_reference(&subrepo,
-						  &object->oid, tree_type,
+						  &object->oid, OBJ_TREE,
 						  &size, NULL);
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&object->oid));
@@ -635,7 +635,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		int hit, len;
 
 		data = read_object_with_reference(opt->repo,
-						  &obj->oid, tree_type,
+						  &obj->oid, OBJ_TREE,
 						  &size, NULL);
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a1e33d7507..feb0320371 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1649,7 +1649,7 @@ static void add_preferred_base(struct object_id *oid)
 		return;
 
 	data = read_object_with_reference(the_repository, oid,
-					  tree_type, &size, &tree_oid);
+					  OBJ_TREE, &size, &tree_oid);
 	if (!data)
 		return;
 
diff --git a/cache.h b/cache.h
index 148d9ab5f1..dad9792c74 100644
--- a/cache.h
+++ b/cache.h
@@ -1508,7 +1508,7 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
-				 const char *required_type,
+				 enum object_type object_type,
 				 unsigned long *size,
 				 struct object_id *oid_ret);
 
diff --git a/object-file.c b/object-file.c
index 624af408cd..d2f223dcef 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1669,25 +1669,24 @@ void *read_object_file_extended(struct repository *r,
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
-				 const char *required_type_name,
+				 enum object_type object_type,
 				 unsigned long *size,
 				 struct object_id *actual_oid_return)
 {
-	enum object_type type, required_type;
 	void *buffer;
 	unsigned long isize;
 	struct object_id actual_oid;
 
-	required_type = type_from_string(required_type_name);
 	oidcpy(&actual_oid, oid);
 	while (1) {
 		int ref_length = -1;
 		const char *ref_type = NULL;
+		enum object_type type;
 
 		buffer = repo_read_object_file(r, &actual_oid, &type, &isize);
 		if (!buffer)
 			return NULL;
-		if (type == required_type) {
+		if (type == object_type) {
 			*size = isize;
 			if (actual_oid_return)
 				oidcpy(actual_oid_return, &actual_oid);
diff --git a/tree-walk.c b/tree-walk.c
index 2d6226d5f1..e5db9291e1 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -89,7 +89,7 @@ void *fill_tree_descriptor(struct repository *r,
 	void *buf = NULL;
 
 	if (oid) {
-		buf = read_object_with_reference(r, oid, tree_type, &size, NULL);
+		buf = read_object_with_reference(r, oid, OBJ_TREE, &size, NULL);
 		if (!buf)
 			die("unable to read tree %s", oid_to_hex(oid));
 	}
@@ -605,7 +605,7 @@ int get_tree_entry(struct repository *r,
 	unsigned long size;
 	struct object_id root;
 
-	tree = read_object_with_reference(r, tree_oid, tree_type, &size, &root);
+	tree = read_object_with_reference(r, tree_oid, OBJ_TREE, &size, &root);
 	if (!tree)
 		return -1;
 
@@ -677,7 +677,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 			unsigned long size;
 			tree = read_object_with_reference(r,
 							  &current_tree_oid,
-							  tree_type, &size,
+							  OBJ_TREE, &size,
 							  &root);
 			if (!tree)
 				goto done;
-- 
2.31.1.723.ga5d7868e4a


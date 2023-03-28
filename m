Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BE4C761AF
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjC1OAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjC1N7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5682C65A
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so7501617wms.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5HdgbCf0+5SA+dAZehBkI8l2FvgV46ofCTAHSXfZ/g=;
        b=FFBgPtPBhJ1usOsxHNT+IE5lYgq6zfgCeFkDIU2cvZG0tfw8n97E6bB1Cx43TOCSXF
         UanwhNJV6c3Cq/3QlIe7w+iSynDwQsw13jxRbZ0JGi7dvaShZXl9zZLgISWg/5lwJvbO
         1Z0AR19gZqgW6LlH8BYmHjpZmZ1zrAw0zLpDasA1Oy207wb8QJWug26H+WfDgEgkYRX5
         OuCKIhbeONRM3DX+OWoThpizwr7KT92WHW6/KG+uXPykklcigUFPmlMJ8oB8AYIThR8C
         NrzslbxMZGbm6s2F+DiNAtl5Uwy9sTo0tPSkA/Un8YSDZKiGTqqAz5My9JJaWjuSMnCA
         1ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5HdgbCf0+5SA+dAZehBkI8l2FvgV46ofCTAHSXfZ/g=;
        b=yNiQTucel3qn9QQQTQpOgBxNpE1jmSf4L4gNv0gEKTHv7CMNHaW/Pm/Ru7KBp08udE
         F3Tg/wADxKIFVUrrz/tFv0ndrYrVqX3QxfsNovBVZXJo/BUE77V/+JmeE+dbxbezZ3bh
         xsHG+5rRTo7m55LxSlxJL2z8DEGUUA9Yw+WtvthYY+HXP1GlIOvtmRfQvNbE23KW235r
         J8YZPOVuWh5EodKWSfLIGSYiveW5uduJoBiEWLkr/jEfb6f8l1vY6hWHQkVOIzmTuLUv
         3F938x3anVg8jb6F+G3JuLoN5nJEBwD0TM2fh1SVQRWgLIYbzCBbSuVU/3BF72xChs3T
         FbqA==
X-Gm-Message-State: AO0yUKW43Bh7xvFBizb4xOk+9bVPHBN4NpUgxfBM6tt9j8BVJW1Thrwi
        jf0sj3Jf+Ix1aLBTxei1CcTMQDn7Kn3tpw==
X-Google-Smtp-Source: AK7set9dqylrFBjgCF6gNYiZCq1BZ56YCSqOLwIg8QrHaCFO8SBOYOHp6pQshQuMGz0t5SyBde2D7Q==
X-Received: by 2002:a1c:ed02:0:b0:3eb:38e6:f650 with SMTP id l2-20020a1ced02000000b003eb38e6f650mr11387147wmh.41.1680011957230;
        Tue, 28 Mar 2023 06:59:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/17] cocci: apply the "object-store.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:50 +0200
Message-Id: <patch-v2-09.17-1866d473f1b-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"object-store.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c                                       |  9 +++++---
 archive.c                                     |  2 +-
 bisect.c                                      |  5 ++--
 blame.c                                       | 11 +++++----
 builtin/cat-file.c                            | 23 +++++++++++--------
 builtin/clone.c                               |  6 ++---
 builtin/difftool.c                            |  3 ++-
 builtin/fast-export.c                         |  5 ++--
 builtin/fast-import.c                         |  7 +++---
 builtin/fetch.c                               | 12 +++++-----
 builtin/grep.c                                |  6 +++--
 builtin/index-pack.c                          |  9 +++++---
 builtin/log.c                                 |  2 +-
 builtin/merge-tree.c                          |  9 +++++---
 builtin/mktag.c                               |  3 ++-
 builtin/notes.c                               |  7 +++---
 builtin/pack-objects.c                        | 22 ++++++++++++------
 builtin/receive-pack.c                        |  2 +-
 builtin/remote.c                              |  2 +-
 builtin/show-ref.c                            |  2 +-
 builtin/tag.c                                 |  4 ++--
 builtin/unpack-file.c                         |  2 +-
 builtin/unpack-objects.c                      |  5 ++--
 bulk-checkin.c                                |  2 +-
 bundle.c                                      |  2 +-
 cache-tree.c                                  |  8 +++----
 combine-diff.c                                |  2 +-
 commit.c                                      |  3 ++-
 contrib/coccinelle/the_repository.cocci       | 10 ++++++++
 .../coccinelle/the_repository.pending.cocci   | 10 --------
 dir.c                                         |  2 +-
 entry.c                                       |  3 ++-
 fetch-pack.c                                  |  8 +++----
 fmt-merge-msg.c                               |  3 ++-
 fsck.c                                        |  2 +-
 http-push.c                                   | 11 +++++----
 http-walker.c                                 |  4 ++--
 list-objects.c                                |  2 +-
 mailmap.c                                     |  2 +-
 match-trees.c                                 |  4 ++--
 merge-blobs.c                                 |  6 +++--
 merge-ort.c                                   |  2 +-
 merge-recursive.c                             |  5 ++--
 notes-cache.c                                 |  2 +-
 notes-merge.c                                 |  2 +-
 notes.c                                       | 12 ++++++----
 object-file.c                                 |  2 +-
 object-store.h                                |  7 ------
 read-cache.c                                  |  5 ++--
 reflog.c                                      |  5 ++--
 remote.c                                      |  2 +-
 rerere.c                                      |  5 ++--
 send-pack.c                                   |  6 ++---
 shallow.c                                     |  6 ++---
 submodule-config.c                            |  3 ++-
 tag.c                                         |  5 ++--
 tree.c                                        |  3 ++-
 upload-pack.c                                 |  8 +++----
 walker.c                                      |  2 +-
 xdiff-interface.c                             |  2 +-
 60 files changed, 184 insertions(+), 142 deletions(-)

diff --git a/apply.c b/apply.c
index ed6abc7722f..23789bb2d12 100644
--- a/apply.c
+++ b/apply.c
@@ -3203,7 +3203,8 @@ static int apply_binary(struct apply_state *state,
 		unsigned long size;
 		char *result;
 
-		result = read_object_file(&oid, &type, &size);
+		result = repo_read_object_file(the_repository, &oid, &type,
+					       &size);
 		if (!result)
 			return error(_("the necessary postimage %s for "
 				       "'%s' cannot be read"),
@@ -3266,7 +3267,8 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		unsigned long sz;
 		char *result;
 
-		result = read_object_file(oid, &type, &sz);
+		result = repo_read_object_file(the_repository, oid, &type,
+					       &sz);
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
@@ -3494,7 +3496,8 @@ static int resolve_to(struct image *image, const struct object_id *result_id)
 
 	clear_image(image);
 
-	image->buf = read_object_file(result_id, &type, &size);
+	image->buf = repo_read_object_file(the_repository, result_id, &type,
+					   &size);
 	if (!image->buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(result_id));
 	image->len = size;
diff --git a/archive.c b/archive.c
index cb7ca69cce1..c6eaa6d6146 100644
--- a/archive.c
+++ b/archive.c
@@ -86,7 +86,7 @@ static void *object_file_to_archive(const struct archiver_args *args,
 			       (args->tree ? &args->tree->object.oid : NULL), oid);
 
 	path += args->baselen;
-	buffer = read_object_file(oid, type, sizep);
+	buffer = repo_read_object_file(the_repository, oid, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
diff --git a/bisect.c b/bisect.c
index b1639a9de7f..5998e4b2e32 100644
--- a/bisect.c
+++ b/bisect.c
@@ -149,8 +149,9 @@ static void show_list(const char *debug, int counted, int nr,
 		unsigned commit_flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
-		char *buf = read_object_file(&commit->object.oid, &type,
-					     &size);
+		char *buf = repo_read_object_file(the_repository,
+						  &commit->object.oid, &type,
+						  &size);
 		const char *subject_start;
 		int subject_len;
 
diff --git a/blame.c b/blame.c
index 0f2751de83b..c42ceea5ae1 100644
--- a/blame.c
+++ b/blame.c
@@ -1029,8 +1029,9 @@ static void fill_origin_blob(struct diff_options *opt,
 				    &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
-			file->ptr = read_object_file(&o->blob_oid, &type,
-						     &file_size);
+			file->ptr = repo_read_object_file(the_repository,
+							  &o->blob_oid, &type,
+							  &file_size);
 		file->size = file_size;
 
 		if (!file->ptr)
@@ -2839,8 +2840,10 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 				    &sb->final_buf_size))
 			;
 		else
-			sb->final_buf = read_object_file(&o->blob_oid, &type,
-							 &sb->final_buf_size);
+			sb->final_buf = repo_read_object_file(the_repository,
+							      &o->blob_oid,
+							      &type,
+							      &sb->final_buf_size);
 
 		if (!sb->final_buf)
 			die(_("cannot read blob %s for path %s"),
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9e7e03ade41..a7bcb55b40d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -64,7 +64,7 @@ static int filter_object(const char *path, unsigned mode,
 {
 	enum object_type type;
 
-	*buf = read_object_file(oid, &type, size);
+	*buf = repo_read_object_file(the_repository, oid, &type, size);
 	if (!*buf)
 		return error(_("cannot read object %s '%s'"),
 			     oid_to_hex(oid), path);
@@ -156,7 +156,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		goto cleanup;
 
 	case 'e':
-		return !has_object_file(&oid);
+		return !repo_has_object_file(the_repository, &oid);
 
 	case 'w':
 
@@ -191,7 +191,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			ret = stream_blob(&oid);
 			goto cleanup;
 		}
-		buf = read_object_file(&oid, &type, &size);
+		buf = repo_read_object_file(the_repository, &oid, &type,
+					    &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
@@ -211,8 +212,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (exp_type_id == OBJ_BLOB) {
 			struct object_id blob_oid;
 			if (oid_object_info(the_repository, &oid, NULL) == OBJ_TAG) {
-				char *buffer = read_object_file(&oid, &type,
-								&size);
+				char *buffer = repo_read_object_file(the_repository,
+								     &oid,
+								     &type,
+								     &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
 				    get_oid_hex(target, &blob_oid))
@@ -387,9 +390,10 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 				if (!textconv_object(the_repository,
 						     data->rest, 0100644, oid,
 						     1, &contents, &size))
-					contents = read_object_file(oid,
-								    &type,
-								    &size);
+					contents = repo_read_object_file(the_repository,
+									 oid,
+									 &type,
+									 &size);
 				if (!contents)
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
@@ -406,7 +410,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		unsigned long size;
 		void *contents;
 
-		contents = read_object_file(oid, &type, &size);
+		contents = repo_read_object_file(the_repository, oid, &type,
+						 &size);
 
 		if (use_mailmap) {
 			size_t s = size;
diff --git a/builtin/clone.c b/builtin/clone.c
index 462c286274c..e50e7e2c06e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -548,9 +548,9 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (ends_with(ref->name, "^{}"))
 			continue;
-		if (!has_object_file_with_flags(&ref->old_oid,
-						OBJECT_INFO_QUICK |
-						OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid,
+						     OBJECT_INFO_QUICK |
+						     OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
 		update_ref(msg, ref->name, &ref->old_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 01681d0fb88..74466332b58 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -296,7 +296,8 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 	} else {
 		enum object_type type;
 		unsigned long size;
-		data = read_object_file(oid, &type, &size);
+		data = repo_read_object_file(the_repository, oid, &type,
+					     &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
 				oid_to_hex(oid), path);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index fc5859dc9fa..166f51b100a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -297,7 +297,7 @@ static void export_blob(const struct object_id *oid)
 		object = (struct object *)lookup_blob(the_repository, oid);
 		eaten = 0;
 	} else {
-		buf = read_object_file(oid, &type, &size);
+		buf = repo_read_object_file(the_repository, oid, &type, &size);
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
@@ -767,7 +767,8 @@ static void handle_tag(const char *name, struct tag *tag)
 		return;
 	}
 
-	buf = read_object_file(&tag->object.oid, &type, &size);
+	buf = repo_read_object_file(the_repository, &tag->object.oid, &type,
+				    &size);
 	if (!buf)
 		die("could not read tag %s", oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index e4566490d91..7a7987b67de 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1266,7 +1266,7 @@ static void load_tree(struct tree_entry *root)
 			die("Can't load tree %s", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		buf = read_object_file(oid, &type, &size);
+		buf = repo_read_object_file(the_repository, oid, &type, &size);
 		if (!buf || type != OBJ_TREE)
 			die("Can't load tree %s", oid_to_hex(oid));
 	}
@@ -2937,7 +2937,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	char *buf;
 
 	if (!oe || oe->pack_id == MAX_PACK_ID) {
-		buf = read_object_file(oid, &type, &size);
+		buf = repo_read_object_file(the_repository, oid, &type, &size);
 	} else {
 		type = oe->type;
 		buf = gfi_unpack_entry(oe, &size);
@@ -3045,7 +3045,8 @@ static struct object_entry *dereference(struct object_entry *oe,
 		buf = gfi_unpack_entry(oe, &size);
 	} else {
 		enum object_type unused;
-		buf = read_object_file(oid, &unused, &size);
+		buf = repo_read_object_file(the_repository, oid, &unused,
+					    &size);
 	}
 	if (!buf)
 		die("Can't load object %s", oid_to_hex(oid));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 16dc2a33cac..0ee5d269768 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -408,9 +408,9 @@ static void find_non_local_tags(const struct ref *refs,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !has_object_file_with_flags(&ref->old_oid, quick_flags) &&
+			    !repo_has_object_file_with_flags(the_repository, &ref->old_oid, quick_flags) &&
 			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
-			    !has_object_file_with_flags(&item->oid, quick_flags) &&
+			    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
 			    !oidset_contains(&fetch_oids, &item->oid))
 				clear_item(item);
 			item = NULL;
@@ -424,7 +424,7 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !has_object_file_with_flags(&item->oid, quick_flags) &&
+		    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
 		    !oidset_contains(&fetch_oids, &item->oid))
 			clear_item(item);
 
@@ -445,7 +445,7 @@ static void find_non_local_tags(const struct ref *refs,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !has_object_file_with_flags(&item->oid, quick_flags) &&
+	    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
 	    !oidset_contains(&fetch_oids, &item->oid))
 		clear_item(item);
 
@@ -1322,8 +1322,8 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 * we need all direct targets to exist.
 	 */
 	for (r = rm; r; r = r->next) {
-		if (!has_object_file_with_flags(&r->old_oid,
-						OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (!repo_has_object_file_with_flags(the_repository, &r->old_oid,
+						     OBJECT_INFO_SKIP_FETCH_OBJECT))
 			return -1;
 	}
 
diff --git a/builtin/grep.c b/builtin/grep.c
index c590fcb19dd..49fc0c69095 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -562,7 +562,8 @@ static int grep_cache(struct grep_opt *opt,
 			void *data;
 			unsigned long size;
 
-			data = read_object_file(&ce->oid, &type, &size);
+			data = repo_read_object_file(the_repository, &ce->oid,
+						     &type, &size);
 			init_tree_desc(&tree, data, size);
 
 			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
@@ -652,7 +653,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = read_object_file(&entry.oid, &type, &size);
+			data = repo_read_object_file(the_repository,
+						     &entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(&entry.oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b451755f405..e823a73b357 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -804,7 +804,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (startup_info->have_repository) {
 		read_lock();
 		collision_test_needed =
-			has_object_file_with_flags(oid, OBJECT_INFO_QUICK);
+			repo_has_object_file_with_flags(the_repository, oid,
+							OBJECT_INFO_QUICK);
 		read_unlock();
 	}
 
@@ -824,7 +825,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
 			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
-		has_data = read_object_file(oid, &has_type, &has_size);
+		has_data = repo_read_object_file(the_repository, oid,
+						 &has_type, &has_size);
 		read_unlock();
 		if (!data)
 			data = new_data = get_data_from_pack(obj_entry);
@@ -1417,7 +1419,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		data = read_object_file(&d->oid, &type, &size);
+		data = repo_read_object_file(the_repository, &d->oid, &type,
+					     &size);
 		if (!data)
 			continue;
 
diff --git a/builtin/log.c b/builtin/log.c
index 11ba99d6b48..28085547aa8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -676,7 +676,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_object_file(oid, &type, &size);
+	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
 	int offset = 0;
 
 	if (!buf)
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index dd23ee684c7..590532706eb 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -70,7 +70,9 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	const char *path = entry->path;
 
 	if (!entry->stage)
-		return read_object_file(&entry->blob->object.oid, &type, size);
+		return repo_read_object_file(the_repository,
+					     &entry->blob->object.oid, &type,
+					     size);
 	base = NULL;
 	if (entry->stage == 1) {
 		base = entry->blob;
@@ -93,8 +95,9 @@ static void *origin(struct merge_list *entry, unsigned long *size)
 	enum object_type type;
 	while (entry) {
 		if (entry->stage == 2)
-			return read_object_file(&entry->blob->object.oid,
-						&type, size);
+			return repo_read_object_file(the_repository,
+						     &entry->blob->object.oid,
+						     &type, size);
 		entry = entry->link;
 	}
 	return NULL;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 42c2457c705..4849b8b37c3 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -52,7 +52,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 	void *buffer;
 	const struct object_id *repl;
 
-	buffer = read_object_file(tagged_oid, &type, &size);
+	buffer = repo_read_object_file(the_repository, tagged_oid, &type,
+				       &size);
 	if (!buffer)
 		die(_("could not read tagged object '%s'"),
 		    oid_to_hex(tagged_oid));
diff --git a/builtin/notes.c b/builtin/notes.c
index 9aea5a4b27b..4b13943be7f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -126,7 +126,7 @@ static void copy_obj_to_fd(int fd, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_object_file(oid, &type, &size);
+	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
 	if (buf) {
 		if (size)
 			write_or_die(fd, buf, size);
@@ -261,7 +261,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	if (repo_get_oid(the_repository, arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_object_file(&object, &type, &len)))
+	if (!(buf = repo_read_object_file(the_repository, &object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
 	if (type != OBJ_BLOB) {
 		free(buf);
@@ -618,7 +618,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
-		char *prev_buf = read_object_file(note, &type, &size);
+		char *prev_buf = repo_read_object_file(the_repository, note,
+						       &type, &size);
 
 		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 545b8bddc8e..068e6326c1d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -290,11 +290,13 @@ static void *get_delta(struct object_entry *entry)
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 
-	buf = read_object_file(&entry->idx.oid, &type, &size);
+	buf = repo_read_object_file(the_repository, &entry->idx.oid, &type,
+				    &size);
 	if (!buf)
 		die(_("unable to read %s"), oid_to_hex(&entry->idx.oid));
-	base_buf = read_object_file(&DELTA(entry)->idx.oid, &type,
-				    &base_size);
+	base_buf = repo_read_object_file(the_repository,
+					 &DELTA(entry)->idx.oid, &type,
+					 &base_size);
 	if (!base_buf)
 		die("unable to read %s",
 		    oid_to_hex(&DELTA(entry)->idx.oid));
@@ -456,7 +458,9 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 				       &size, NULL)) != NULL)
 			buf = NULL;
 		else {
-			buf = read_object_file(&entry->idx.oid, &type, &size);
+			buf = repo_read_object_file(the_repository,
+						    &entry->idx.oid, &type,
+						    &size);
 			if (!buf)
 				die(_("unable to read %s"),
 				    oid_to_hex(&entry->idx.oid));
@@ -1667,7 +1671,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	/* Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
-	data = read_object_file(oid, &type, &size);
+	data = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!data)
 		return NULL;
 	if (type != OBJ_TREE) {
@@ -2527,7 +2531,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/* Load data if not already done */
 	if (!trg->data) {
 		packing_data_lock(&to_pack);
-		trg->data = read_object_file(&trg_entry->idx.oid, &type, &sz);
+		trg->data = repo_read_object_file(the_repository,
+						  &trg_entry->idx.oid, &type,
+						  &sz);
 		packing_data_unlock(&to_pack);
 		if (!trg->data)
 			die(_("object %s cannot be read"),
@@ -2540,7 +2546,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->data) {
 		packing_data_lock(&to_pack);
-		src->data = read_object_file(&src_entry->idx.oid, &type, &sz);
+		src->data = repo_read_object_file(the_repository,
+						  &src_entry->idx.oid, &type,
+						  &sz);
 		packing_data_unlock(&to_pack);
 		if (!src->data) {
 			if (src_entry->preferred_base) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e2b7202b04c..90d117beaf5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1493,7 +1493,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 	}
 
-	if (!is_null_oid(new_oid) && !has_object_file(new_oid)) {
+	if (!is_null_oid(new_oid) && !repo_has_object_file(the_repository, new_oid)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", oid_to_hex(new_oid));
 		ret = "bad pack";
diff --git a/builtin/remote.c b/builtin/remote.c
index 729f6f3643a..a6b100dce7f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -443,7 +443,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 			info->status = PUSH_STATUS_UPTODATE;
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
-		else if (has_object_file(&ref->old_oid) &&
+		else if (repo_has_object_file(the_repository, &ref->old_oid) &&
 			 ref_newer(&ref->new_oid, &ref->old_oid))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index b5a68e23e65..63a5bb1efae 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -27,7 +27,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 	const char *hex;
 	struct object_id peeled;
 
-	if (!has_object_file(oid))
+	if (!repo_has_object_file(the_repository, oid))
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 7af7eaa4139..61fd55d62e2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -211,7 +211,7 @@ static void write_tag_body(int fd, const struct object_id *oid)
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
 
-	orig = buf = read_object_file(oid, &type, &size);
+	orig = buf = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!buf)
 		return;
 	if (parse_signature(buf, size, &payload, &signature)) {
@@ -362,7 +362,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		strbuf_addstr(sb, "object of unknown type");
 		break;
 	case OBJ_COMMIT:
-		if ((buf = read_object_file(oid, &type, &size))) {
+		if ((buf = repo_read_object_file(the_repository, oid, &type, &size))) {
 			subject_len = find_commit_subject(buf, &subject_start);
 			strbuf_insert(sb, sb->len, subject_start, subject_len);
 		} else {
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index b9e258a553f..9cbc295e193 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -11,7 +11,7 @@ static char *create_temp_file(struct object_id *oid)
 	unsigned long size;
 	int fd;
 
-	buf = read_object_file(oid, &type, &size);
+	buf = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1908dcfcffb..2e0ca419190 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -444,7 +444,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		delta_data = get_data(delta_size);
 		if (!delta_data)
 			return;
-		if (has_object_file(&base_oid))
+		if (repo_has_object_file(the_repository, &base_oid))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
 					      delta_data, delta_size))
@@ -510,7 +510,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (resolve_against_held(nr, &base_oid, delta_data, delta_size))
 		return;
 
-	base = read_object_file(&base_oid, &type, &base_size);
+	base = repo_read_object_file(the_repository, &base_oid, &type,
+				     &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
 		      oid_to_hex(&base_oid));
diff --git a/bulk-checkin.c b/bulk-checkin.c
index d64cd5c52d0..556a34ba7d4 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -126,7 +126,7 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
 	int i;
 
 	/* The object may already exist in the repository */
-	if (has_object_file(oid))
+	if (repo_has_object_file(the_repository, oid))
 		return 1;
 
 	/* Might want to keep the list sorted */
diff --git a/bundle.c b/bundle.c
index 99d7de97f6c..bce0c7f99e8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -294,7 +294,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	if (revs->max_age == -1 && revs->min_age == -1)
 		goto out;
 
-	buf = read_object_file(&tag->oid, &type, &size);
+	buf = repo_read_object_file(the_repository, &tag->oid, &type, &size);
 	if (!buf)
 		goto out;
 	line = memmem(buf, size, "\ntagger ", 8);
diff --git a/cache-tree.c b/cache-tree.c
index 9d46ecef091..d71b9befd9a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -231,7 +231,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	int i;
 	if (!it)
 		return 0;
-	if (it->entry_count < 0 || !has_object_file(&it->oid))
+	if (it->entry_count < 0 || !repo_has_object_file(the_repository, &it->oid))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -282,7 +282,7 @@ static int update_one(struct cache_tree *it,
 		}
 	}
 
-	if (0 <= it->entry_count && has_object_file(&it->oid))
+	if (0 <= it->entry_count && repo_has_object_file(the_repository, &it->oid))
 		return it->entry_count;
 
 	/*
@@ -388,7 +388,7 @@ static int update_one(struct cache_tree *it,
 		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
 			!must_check_existence(ce);
 		if (is_null_oid(oid) ||
-		    (!ce_missing_ok && !has_object_file(oid))) {
+		    (!ce_missing_ok && !repo_has_object_file(the_repository, oid))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
@@ -436,7 +436,7 @@ static int update_one(struct cache_tree *it,
 		struct object_id oid;
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &oid);
-		if (has_object_file_with_flags(&oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (repo_has_object_file_with_flags(the_repository, &oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
diff --git a/combine-diff.c b/combine-diff.c
index e917362faf7..6077d4ec498 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -333,7 +333,7 @@ static char *grab_blob(struct repository *r,
 		*size = fill_textconv(r, textconv, df, &blob);
 		free_filespec(df);
 	} else {
-		blob = read_object_file(oid, &type, size);
+		blob = repo_read_object_file(the_repository, oid, &type, size);
 		if (type != OBJ_BLOB)
 			die("object '%s' is not a blob!", oid_to_hex(oid));
 	}
diff --git a/commit.c b/commit.c
index 127ec79b2d3..cfd14f7d975 100644
--- a/commit.c
+++ b/commit.c
@@ -1215,7 +1215,8 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	desc = merge_remote_util(parent);
 	if (!desc || !desc->obj)
 		return;
-	buf = read_object_file(&desc->obj->oid, &type, &size);
+	buf = repo_read_object_file(the_repository, &desc->obj->oid, &type,
+				    &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
 	if (!parse_signature(buf, size, &payload, &signature))
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 3c0bd8781e7..fa159aba5b5 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -77,6 +77,16 @@
 |
 - diff_setup
 + repo_diff_setup
+// object-store.h
+|
+- read_object_file
++ repo_read_object_file
+|
+- has_object_file
++ repo_has_object_file
+|
+- has_object_file_with_flags
++ repo_has_object_file_with_flags
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 00461ee86b3..69e9694111e 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,17 +5,7 @@
 @@
 @@
 (
-// object-store.h
-- read_object_file
-+ repo_read_object_file
-|
-- has_object_file
-+ repo_has_object_file
-|
-- has_object_file_with_flags
-+ repo_has_object_file_with_flags
 // pretty.h
-|
 - format_commit_message
 + repo_format_commit_message
 // packfile.h
diff --git a/dir.c b/dir.c
index d5bb199f4b4..b06a100514d 100644
--- a/dir.c
+++ b/dir.c
@@ -268,7 +268,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 	*size_out = 0;
 	*data_out = NULL;
 
-	data = read_object_file(oid, &type, &sz);
+	data = repo_read_object_file(the_repository, oid, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return -1;
diff --git a/entry.c b/entry.c
index c97cfa833bb..8c21f98b9e8 100644
--- a/entry.c
+++ b/entry.c
@@ -87,7 +87,8 @@ void *read_blob_entry(const struct cache_entry *ce, size_t *size)
 {
 	enum object_type type;
 	unsigned long ul;
-	void *blob_data = read_object_file(&ce->oid, &type, &ul);
+	void *blob_data = repo_read_object_file(the_repository, &ce->oid,
+						&type, &ul);
 
 	*size = ul;
 	if (blob_data) {
diff --git a/fetch-pack.c b/fetch-pack.c
index 4ddabb4ec76..12675052f97 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -764,9 +764,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (!commit) {
 			struct object *o;
 
-			if (!has_object_file_with_flags(&ref->old_oid,
-						OBJECT_INFO_QUICK |
-						OBJECT_INFO_SKIP_FETCH_OBJECT))
+			if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid,
+							     OBJECT_INFO_QUICK |
+							     OBJECT_INFO_SKIP_FETCH_OBJECT))
 				continue;
 			o = parse_object(the_repository, &ref->old_oid);
 			if (!o || o->type != OBJ_COMMIT)
@@ -1965,7 +1965,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
-			if (has_object_file(&oid[i]))
+			if (repo_has_object_file(the_repository, &oid[i]))
 				oid_array_append(&extra, &oid[i]);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 29a1afa2485..5aab1d06619 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -518,7 +518,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
 		unsigned long size;
-		char *buf = read_object_file(oid, &type, &size);
+		char *buf = repo_read_object_file(the_repository, oid, &type,
+						  &size);
 		char *origbuf = buf;
 		unsigned long len = size;
 		struct signature_check sigc = { NULL };
diff --git a/fsck.c b/fsck.c
index 0d752d57717..adbe8bf59e7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1334,7 +1334,7 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		if (oidset_contains(blobs_done, oid))
 			continue;
 
-		buf = read_object_file(oid, &type, &size);
+		buf = repo_read_object_file(the_repository, oid, &type, &size);
 		if (!buf) {
 			if (is_promisor_object(oid))
 				continue;
diff --git a/http-push.c b/http-push.c
index e149daeff3d..8c852ff646b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -363,7 +363,8 @@ static void start_put(struct transfer_request *request)
 	ssize_t size;
 	git_zstream stream;
 
-	unpacked = read_object_file(&request->obj->oid, &type, &len);
+	unpacked = repo_read_object_file(the_repository, &request->obj->oid,
+					 &type, &len);
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
 	/* Set it up */
@@ -1428,7 +1429,7 @@ static void one_remote_ref(const char *refname)
 	 * Fetch a copy of the object if it doesn't exist locally - it
 	 * may be required for updating server info later.
 	 */
-	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
+	if (repo->can_update_info_refs && !repo_has_object_file(the_repository, &ref->old_oid)) {
 		obj = lookup_unknown_object(the_repository, &ref->old_oid);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
@@ -1629,14 +1630,14 @@ static int delete_remote_branch(const char *pattern, int force)
 			return error("Remote HEAD symrefs too deep");
 		if (is_null_oid(&head_oid))
 			return error("Unable to resolve remote HEAD");
-		if (!has_object_file(&head_oid))
+		if (!repo_has_object_file(the_repository, &head_oid))
 			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", oid_to_hex(&head_oid));
 
 		/* Remote branch must resolve to a known object */
 		if (is_null_oid(&remote_ref->old_oid))
 			return error("Unable to resolve remote branch %s",
 				     remote_ref->name);
-		if (!has_object_file(&remote_ref->old_oid))
+		if (!repo_has_object_file(the_repository, &remote_ref->old_oid))
 			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, oid_to_hex(&remote_ref->old_oid));
 
 		/* Remote branch must be an ancestor of remote HEAD */
@@ -1856,7 +1857,7 @@ int cmd_main(int argc, const char **argv)
 		if (!force_all &&
 		    !is_null_oid(&ref->old_oid) &&
 		    !ref->force) {
-			if (!has_object_file(&ref->old_oid) ||
+			if (!repo_has_object_file(the_repository, &ref->old_oid) ||
 			    !ref_newer(&ref->peer_ref->new_oid,
 				       &ref->old_oid)) {
 				/*
diff --git a/http-walker.c b/http-walker.c
index c3e902c40e6..4588e6a340a 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -136,7 +136,7 @@ static int fill_active_slot(struct walker *walker)
 	list_for_each_safe(pos, tmp, head) {
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
-			if (has_object_file(&obj_req->oid))
+			if (repo_has_object_file(the_repository, &obj_req->oid))
 				obj_req->state = COMPLETE;
 			else {
 				start_object_request(walker, obj_req);
@@ -493,7 +493,7 @@ static int fetch_object(struct walker *walker, unsigned char *hash)
 	if (!obj_req)
 		return error("Couldn't find request for %s in the queue", hex);
 
-	if (has_object_file(&obj_req->oid)) {
+	if (repo_has_object_file(the_repository, &obj_req->oid)) {
 		if (obj_req->req)
 			abort_http_object_request(obj_req->req);
 		abort_object_request(obj_req);
diff --git a/list-objects.c b/list-objects.c
index d75132cfd73..6e6e7ce61ea 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -65,7 +65,7 @@ static void process_blob(struct traversal_context *ctx,
 	 * of missing objects.
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
-	    !has_object_file(&obj->oid) &&
+	    !repo_has_object_file(the_repository, &obj->oid) &&
 	    is_promisor_object(&obj->oid))
 		return;
 
diff --git a/mailmap.c b/mailmap.c
index ed8289aea58..f68f664bb1b 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ static int read_mailmap_blob(struct string_list *map, const char *name)
 	if (repo_get_oid(the_repository, name, &oid) < 0)
 		return 0;
 
-	buf = read_object_file(&oid, &type, &size);
+	buf = repo_read_object_file(the_repository, &oid, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB)
diff --git a/match-trees.c b/match-trees.c
index c38dcbac7c6..5877fc64a8f 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -56,7 +56,7 @@ static void *fill_tree_desc_strict(struct tree_desc *desc,
 	enum object_type type;
 	unsigned long size;
 
-	buffer = read_object_file(hash, &type, &size);
+	buffer = repo_read_object_file(the_repository, hash, &type, &size);
 	if (!buffer)
 		die("unable to read tree (%s)", oid_to_hex(hash));
 	if (type != OBJ_TREE)
@@ -189,7 +189,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	if (*subpath)
 		subpath++;
 
-	buf = read_object_file(oid1, &type, &sz);
+	buf = repo_read_object_file(the_repository, oid1, &type, &sz);
 	if (!buf)
 		die("cannot read tree %s", oid_to_hex(oid1));
 	init_tree_desc(&desc, buf, sz);
diff --git a/merge-blobs.c b/merge-blobs.c
index aedcab81138..5632ff6abb6 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -12,7 +12,8 @@ static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 	unsigned long size;
 	enum object_type type;
 
-	buf = read_object_file(&obj->object.oid, &type, &size);
+	buf = repo_read_object_file(the_repository, &obj->object.oid, &type,
+				    &size);
 	if (!buf)
 		return -1;
 	if (type != OBJ_BLOB) {
@@ -78,7 +79,8 @@ void *merge_blobs(struct index_state *istate, const char *path,
 			return NULL;
 		if (!our)
 			our = their;
-		return read_object_file(&our->object.oid, &type, size);
+		return repo_read_object_file(the_repository, &our->object.oid,
+					     &type, size);
 	}
 
 	if (fill_mmfile_blob(&f1, our) < 0)
diff --git a/merge-ort.c b/merge-ort.c
index 186e26d90a0..607e2c263f1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3506,7 +3506,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 	void *buf;
 	enum object_type type;
 	unsigned long size;
-	buf = read_object_file(oid, &type, &size);
+	buf = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!buf)
 		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
diff --git a/merge-recursive.c b/merge-recursive.c
index 6eeb4844f38..9c80b7aa3a7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -951,7 +951,8 @@ static int update_file_flags(struct merge_options *opt,
 			goto update_index;
 		}
 
-		buf = read_object_file(&contents->oid, &type, &size);
+		buf = repo_read_object_file(the_repository, &contents->oid,
+					    &type, &size);
 		if (!buf) {
 			ret = err(opt, _("cannot read object %s '%s'"),
 				  oid_to_hex(&contents->oid), path);
@@ -3021,7 +3022,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 	void *buf;
 	enum object_type type;
 	unsigned long size;
-	buf = read_object_file(oid, &type, &size);
+	buf = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!buf)
 		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
diff --git a/notes-cache.c b/notes-cache.c
index 9dfd251a815..38466091360 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -81,7 +81,7 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
 		return NULL;
-	value = read_object_file(value_oid, &type, &size);
+	value = repo_read_object_file(the_repository, value_oid, &type, &size);
 
 	*outsize = size;
 	return value;
diff --git a/notes-merge.c b/notes-merge.c
index d26c826963e..571ecf15c7e 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -327,7 +327,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 {
 	enum object_type type;
 	unsigned long size;
-	void *buf = read_object_file(note, &type, &size);
+	void *buf = repo_read_object_file(the_repository, note, &type, &size);
 
 	if (!buf)
 		die("cannot read note %s for object %s",
diff --git a/notes.c b/notes.c
index 427cfdac294..d40affc0f2f 100644
--- a/notes.c
+++ b/notes.c
@@ -788,7 +788,7 @@ static int prune_notes_helper(const struct object_id *object_oid,
 	struct note_delete_list **l = (struct note_delete_list **) cb_data;
 	struct note_delete_list *n;
 
-	if (has_object_file(object_oid))
+	if (repo_has_object_file(the_repository, object_oid))
 		return 0; /* nothing to do for this note */
 
 	/* failed to find object => prune this note */
@@ -809,13 +809,15 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 
 	/* read in both note blob objects */
 	if (!is_null_oid(new_oid))
-		new_msg = read_object_file(new_oid, &new_type, &new_len);
+		new_msg = repo_read_object_file(the_repository, new_oid,
+						&new_type, &new_len);
 	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
 		free(new_msg);
 		return 0;
 	}
 	if (!is_null_oid(cur_oid))
-		cur_msg = read_object_file(cur_oid, &cur_type, &cur_len);
+		cur_msg = repo_read_object_file(the_repository, cur_oid,
+						&cur_type, &cur_len);
 	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
 		free(cur_msg);
 		free(new_msg);
@@ -871,7 +873,7 @@ static int string_list_add_note_lines(struct string_list *list,
 		return 0;
 
 	/* read_sha1_file NUL-terminates */
-	data = read_object_file(oid, &t, &len);
+	data = repo_read_object_file(the_repository, oid, &t, &len);
 	if (t != OBJ_BLOB || !data || !len) {
 		free(data);
 		return t != OBJ_BLOB || !data;
@@ -1266,7 +1268,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!oid)
 		return;
 
-	if (!(msg = read_object_file(oid, &type, &msglen)) || type != OBJ_BLOB) {
+	if (!(msg = repo_read_object_file(the_repository, oid, &type, &msglen)) || type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
diff --git a/object-file.c b/object-file.c
index 8fab8dbe80b..5944f51a3e0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1680,7 +1680,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	struct cached_object *co;
 
 	hash_object_file(the_hash_algo, buf, len, type, oid);
-	if (has_object_file_with_flags(oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
+	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
 	    find_cached_object(oid))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
diff --git a/object-store.h b/object-store.h
index 82201ec3e7b..62a683af4d6 100644
--- a/object-store.h
+++ b/object-store.h
@@ -245,9 +245,6 @@ void *repo_read_object_file(struct repository *r,
 			    const struct object_id *oid,
 			    enum object_type *type,
 			    unsigned long *size);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define read_object_file(oid, type, size) repo_read_object_file(the_repository, oid, type, size)
-#endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
@@ -387,10 +384,6 @@ int has_object(struct repository *r, const struct object_id *oid,
 int repo_has_object_file(struct repository *r, const struct object_id *oid);
 int repo_has_object_file_with_flags(struct repository *r,
 				    const struct object_id *oid, int flags);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define has_object_file(oid) repo_has_object_file(the_repository, oid)
-#define has_object_file_with_flags(oid, flags) repo_has_object_file_with_flags(the_repository, oid, flags)
-#endif
 
 /*
  * Return true iff an alternate object database has a loose object
diff --git a/read-cache.c b/read-cache.c
index c1d47b9fc83..4518a40ac06 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -265,7 +265,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 	if (strbuf_readlink(&sb, ce->name, expected_size))
 		return -1;
 
-	buffer = read_object_file(&ce->oid, &type, &size);
+	buffer = repo_read_object_file(the_repository, &ce->oid, &type, &size);
 	if (buffer) {
 		if (size == sb.len)
 			match = memcmp(buffer, sb.buf, size);
@@ -3555,7 +3555,8 @@ void *read_blob_data_from_index(struct index_state *istate,
 	}
 	if (pos < 0)
 		return NULL;
-	data = read_object_file(&istate->cache[pos]->oid, &type, &sz);
+	data = repo_read_object_file(the_repository, &istate->cache[pos]->oid,
+				     &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
diff --git a/reflog.c b/reflog.c
index 6e8362e7a2f..510663e1e51 100644
--- a/reflog.c
+++ b/reflog.c
@@ -28,7 +28,8 @@ static int tree_is_complete(const struct object_id *oid)
 	if (!tree->buffer) {
 		enum object_type type;
 		unsigned long size;
-		void *data = read_object_file(oid, &type, &size);
+		void *data = repo_read_object_file(the_repository, oid, &type,
+						   &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
 			return 0;
@@ -39,7 +40,7 @@ static int tree_is_complete(const struct object_id *oid)
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
-		if (!has_object_file(&entry.oid) ||
+		if (!repo_has_object_file(the_repository, &entry.oid) ||
 		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
 			complete = 0;
diff --git a/remote.c b/remote.c
index 37cb5213795..9219ebb8962 100644
--- a/remote.c
+++ b/remote.c
@@ -1761,7 +1761,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!has_object_file(&ref->old_oid))
+			else if (!repo_has_object_file(the_repository, &ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
 				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
diff --git a/rerere.c b/rerere.c
index a67abaab077..0ec546b744f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -967,8 +967,9 @@ static int handle_cache(struct index_state *istate,
 			break;
 		i = ce_stage(ce) - 1;
 		if (!mmfile[i].ptr) {
-			mmfile[i].ptr = read_object_file(&ce->oid, &type,
-							 &size);
+			mmfile[i].ptr = repo_read_object_file(the_repository,
+							      &ce->oid, &type,
+							      &size);
 			mmfile[i].size = size;
 		}
 	}
diff --git a/send-pack.c b/send-pack.c
index 423a5cfe22d..2cb313a5023 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -43,9 +43,9 @@ int option_parse_push_signed(const struct option *opt,
 static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 {
 	if (negative &&
-	    !has_object_file_with_flags(oid,
-					OBJECT_INFO_SKIP_FETCH_OBJECT |
-					OBJECT_INFO_QUICK))
+	    !repo_has_object_file_with_flags(the_repository, oid,
+					     OBJECT_INFO_SKIP_FETCH_OBJECT |
+					     OBJECT_INFO_QUICK))
 		return;
 
 	if (negative)
diff --git a/shallow.c b/shallow.c
index 138bcfe009c..ce21f66e5e1 100644
--- a/shallow.c
+++ b/shallow.c
@@ -303,7 +303,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & QUICK) {
-		if (!has_object_file(&graft->oid))
+		if (!repo_has_object_file(the_repository, &graft->oid))
 			return 0;
 	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
@@ -468,7 +468,7 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 	ALLOC_ARRAY(info->ours, sa->nr);
 	ALLOC_ARRAY(info->theirs, sa->nr);
 	for (i = 0; i < sa->nr; i++) {
-		if (has_object_file(sa->oid + i)) {
+		if (repo_has_object_file(the_repository, sa->oid + i)) {
 			struct commit_graft *graft;
 			graft = lookup_commit_graft(the_repository,
 						    &sa->oid[i]);
@@ -496,7 +496,7 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		if (has_object_file(oid + info->theirs[i]))
+		if (repo_has_object_file(the_repository, oid + info->theirs[i]))
 			dst++;
 	}
 	info->nr_theirs = dst;
diff --git a/submodule-config.c b/submodule-config.c
index 57972c3e131..d0111e99937 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -590,7 +590,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	if (submodule)
 		goto out;
 
-	config = read_object_file(&oid, &type, &config_size);
+	config = repo_read_object_file(the_repository, &oid, &type,
+				       &config_size);
 	if (!config || type != OBJ_BLOB)
 		goto out;
 
diff --git a/tag.c b/tag.c
index 85c348ad824..911cd3178ca 100644
--- a/tag.c
+++ b/tag.c
@@ -55,7 +55,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 				repo_find_unique_abbrev(the_repository, oid, DEFAULT_ABBREV),
 				type_name(type));
 
-	buf = read_object_file(oid, &type, &size);
+	buf = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
 				name_to_report ?
@@ -217,7 +217,8 @@ int parse_tag(struct tag *item)
 
 	if (item->object.parsed)
 		return 0;
-	data = read_object_file(&item->object.oid, &type, &size);
+	data = repo_read_object_file(the_repository, &item->object.oid, &type,
+				     &size);
 	if (!data)
 		return error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
diff --git a/tree.c b/tree.c
index e33f4009ac9..955b53f6a57 100644
--- a/tree.c
+++ b/tree.c
@@ -130,7 +130,8 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_object_file(&item->object.oid, &type, &size);
+	buffer = repo_read_object_file(the_repository, &item->object.oid,
+				       &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
diff --git a/upload-pack.c b/upload-pack.c
index 41b9362cf1b..54be6a61910 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -500,8 +500,8 @@ static int got_oid(struct upload_pack_data *data,
 {
 	if (get_oid_hex(hex, oid))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!has_object_file_with_flags(oid,
-					OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
+	if (!repo_has_object_file_with_flags(the_repository, oid,
+					     OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
 		return -1;
 	return do_got_oid(data, oid);
 }
@@ -1601,8 +1601,8 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 	for (i = 0; i < data->haves.nr; i++) {
 		const struct object_id *oid = &data->haves.oid[i];
 
-		if (!has_object_file_with_flags(oid,
-						OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (!repo_has_object_file_with_flags(the_repository, oid,
+						     OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
 			continue;
 
 		oid_array_append(common, oid);
diff --git a/walker.c b/walker.c
index 5275070de76..e86f85e5283 100644
--- a/walker.c
+++ b/walker.c
@@ -146,7 +146,7 @@ static int process(struct walker *walker, struct object *obj)
 		return 0;
 	obj->flags |= SEEN;
 
-	if (has_object_file(&obj->oid)) {
+	if (repo_has_object_file(the_repository, &obj->oid)) {
 		/* We already have it, so we should scan it now. */
 		obj->flags |= TO_SCAN;
 	}
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 5baf6ceb947..0617fadbfbb 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -184,7 +184,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 		return;
 	}
 
-	ptr->ptr = read_object_file(oid, &type, &size);
+	ptr->ptr = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!ptr->ptr || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 	ptr->size = size;
-- 
2.40.0.rc1.1034.g5867a1b10c5


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B04C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378359AbiBDXtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378312AbiBDXs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6122E009522
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c192so5605016wma.4
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxKz5Qkm6uSJ3ElwfffUCwT8sAUW4dv7wwfq98QSexE=;
        b=p4E2FX+v3yDT/3Hx8xpfqHLdXnIIzc7UnXu9KYSfdMLusV40E6Ndbo5vm7zzrnnXiI
         HOsnHJNy3Z1YNaBKWydYSd7X3Y6OGecFmBHQRhUyDh9uoTemrMqFd0pE7W85XGF1K3pK
         T0wQqfBrEWtXqN0PPJwRq5uu6Uz8STHb3hHSLcaBO5/d25XDRshzfdispaghxuVszSl2
         nwQJHNNV5AEUbu2YCpYIrbwDnO6Keb4jTD7wQktxpEFOG8igWuRrEaUF1I9SihRGJJbN
         1dfSLJhXUYiWd6mCDp39ebrDu9B8i8Zew8+rXqBrupJ+Ry5JKtEvHwgpht261naAC9Nh
         rTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxKz5Qkm6uSJ3ElwfffUCwT8sAUW4dv7wwfq98QSexE=;
        b=VKW9Mn1UspNdkU/IFc56+oRcKb8tUVPN7ebpLHb0hHIG7C9vaLDPMMb7n/54skern3
         MhlZ+G4AJNdSn3yoUaxJAy0Tbh3RMh/H/0AFPzU4U1g0t+4KNQNMFq0hx/XMG+yIYdVw
         15pYicsXVDPnxKkljfmOX49moPQB3Q0QDAxREvsRSQmFU+nW2PurhUD5zdnZIKPpG3iN
         mgDuPXnGtD+SIWWF9+cOu76Nis/qA0ewQgQxqNnp0UvVu7v0ZdPt8k854ijdHtjR6TDi
         2Y9FEMA7CffHmVaHd2yFIYw0C+E7dm0XSYrdIhqv3zmUeyexxkV7crgEU2mcKUaIlagL
         hm+Q==
X-Gm-Message-State: AOAM530Kmoq95jkHo0dmzAPpug3ka+zIUZkYUd8fWVGhKx8s/RkC1sbD
        jkcMxS7uNm1wdUCgJ1LNF4w/yCkRtd2YUQ==
X-Google-Smtp-Source: ABdhPJxzJ0tJfGH46dCuSChqwZNu0gEmIR+uJaudmcKRqrMK4Wy9Mt6jSElA4ewZBEL6pRbTRtiIvA==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr4194158wmh.157.1644018531028;
        Fri, 04 Feb 2022 15:48:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/12] object-file API: pass an enum to read_object_with_reference()
Date:   Sat,  5 Feb 2022 00:48:34 +0100
Message-Id: <patch-v3-12.12-d2d355e6bb8-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the read_object_with_reference() function to take an "enum
object_type". It was not prepared to handle an arbitrary "const
char *type", as it was itself calling type_from_string().

Let's change the only caller that passes in user data to use
type_from_string(), and convert the rest to use e.g. "OBJ_TREE"
instead of "tree_type".

The "cat-file" caller is not on the codepath that
handles"--allow-unknown", so the type_from_string() there is safe. Its
use of type_from_string() doesn't functionally differ from that of the
pre-image.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c     | 11 +++++++----
 builtin/fast-import.c  |  6 +++---
 builtin/grep.c         |  4 ++--
 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 object-file.c          |  5 ++---
 tree-walk.c            |  6 +++---
 7 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d94050e6c18..3c5bc505e0a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -154,7 +154,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		break;
 
 	case 0:
-		if (type_from_string(exp_type) == OBJ_BLOB) {
+	{
+		enum object_type exp_type_id = type_from_string(exp_type);
+
+		if (exp_type_id == OBJ_BLOB) {
 			struct object_id blob_oid;
 			if (oid_object_info(the_repository, &oid, NULL) == OBJ_TAG) {
 				char *buffer = read_object_file(&oid, &type,
@@ -176,10 +179,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			 * fall-back to the usual case.
 			 */
 		}
-		buf = read_object_with_reference(the_repository,
-						 &oid, exp_type, &size, NULL);
+		buf = read_object_with_reference(the_repository, &oid,
+						 exp_type_id, &size, NULL);
 		break;
-
+	}
 	default:
 		die("git cat-file: unknown option: %s", exp_type);
 	}
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 123df7d9a53..c52e807f56e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2483,7 +2483,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		unsigned long size;
 		char *buf = read_object_with_reference(the_repository,
 						       &commit_oid,
-						       commit_type, &size,
+						       OBJ_COMMIT, &size,
 						       &commit_oid);
 		if (!buf || size < the_hash_algo->hexsz + 6)
 			die("Not a valid commit: %s", p);
@@ -2555,7 +2555,7 @@ static void parse_from_existing(struct branch *b)
 		char *buf;
 
 		buf = read_object_with_reference(the_repository,
-						 &b->oid, commit_type, &size,
+						 &b->oid, OBJ_COMMIT, &size,
 						 &b->oid);
 		parse_from_commit(b, buf, size);
 		free(buf);
@@ -2651,7 +2651,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			unsigned long size;
 			char *buf = read_object_with_reference(the_repository,
 							       &n->oid,
-							       commit_type,
+							       OBJ_COMMIT,
 							       &size, &n->oid);
 			if (!buf || size < the_hash_algo->hexsz + 6)
 				die("Not a valid commit: %s", from);
diff --git a/builtin/grep.c b/builtin/grep.c
index 9e34a820ad4..75e07b5623a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
 		object_type = oid_object_info(subrepo, oid, NULL);
 		obj_read_unlock();
 		data = read_object_with_reference(subrepo,
-						  oid, tree_type,
+						  oid, OBJ_TREE,
 						  &size, NULL);
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(oid));
@@ -651,7 +651,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		int hit, len;
 
 		data = read_object_with_reference(opt->repo,
-						  &obj->oid, tree_type,
+						  &obj->oid, OBJ_TREE,
 						  &size, NULL);
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..c4df3df3141 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1802,7 +1802,7 @@ static void add_preferred_base(struct object_id *oid)
 		return;
 
 	data = read_object_with_reference(the_repository, oid,
-					  tree_type, &size, &tree_oid);
+					  OBJ_TREE, &size, &tree_oid);
 	if (!data)
 		return;
 
diff --git a/cache.h b/cache.h
index 2027803c49a..0e7fc8b7c2f 100644
--- a/cache.h
+++ b/cache.h
@@ -1561,7 +1561,7 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
-				 const char *required_type,
+				 enum object_type required_type,
 				 unsigned long *size,
 				 struct object_id *oid_ret);
 
diff --git a/object-file.c b/object-file.c
index c75c12dd0ba..6cbdb836cb7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1737,16 +1737,15 @@ void *read_object_file_extended(struct repository *r,
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
-				 const char *required_type_name,
+				 enum object_type required_type,
 				 unsigned long *size,
 				 struct object_id *actual_oid_return)
 {
-	enum object_type type, required_type;
+	enum object_type type;
 	void *buffer;
 	unsigned long isize;
 	struct object_id actual_oid;
 
-	required_type = type_from_string(required_type_name);
 	oidcpy(&actual_oid, oid);
 	while (1) {
 		int ref_length = -1;
diff --git a/tree-walk.c b/tree-walk.c
index 3a94959d64a..506234b4b81 100644
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
2.35.1.940.ge7a5b4b05f2


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEB820281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbdI2UMN (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:13 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:53761 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdI2UMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:10 -0400
Received: by mail-pf0-f182.google.com with SMTP id x78so328532pff.10
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=r8mgVD+1P/dwFjosE0gqBzHlMju2Bm8iWQzky0zA7eU=;
        b=Aeg4M13z7FuHr/lGx4pPPCFWL5YFGs16h1bCgKsHS7dFvhtwD0IzPwa+QVYgo+F0PG
         gMBHFJFrRw2pEbtgUs3BRYxaYXNJrCh2PSUCMNDnuvcbOJqEKU1y7yvOmY102rmIxmF+
         Jgeb27ah6RmKALNNkXyBWC0rdk8PfErIdWT/PXRvafUVx+FcxO6U8pH6psBDKFfQLkey
         zRkMpgnHGCIhjCtwXMgfwsCecvKTMr/58uGXg2gNbw2yyJk4MrpRrDo4Uk5Hj2RGYrOE
         o5MHX+/EVAPrktpep6KHpRYNA72nj+ir0LclL78Ir/J/79R6W9GxCAiQOcJggvoCuZ8b
         v3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=r8mgVD+1P/dwFjosE0gqBzHlMju2Bm8iWQzky0zA7eU=;
        b=AYz/+YTDkjX5s8hBeTV31oSz0ymZzQ9eQzqmcMQx6jRSJeN8a9jts1MhKIL8xIGolx
         hQ3Z/nzYPey90ZNKJrTRurLX9vYEX3m/2v3suJWjnv8BgkcNmn3wzL2bVkowlAQGIsAe
         JLuLRJgxtEE7rLUIQu+HerCPRLgIzb7rk8YH0iD+dbjbXrYK369rYh85ieowY4/cNSbd
         PkyXyJS36VHfAwHvvE2B5HzO85iSga++W4Sww8ZkoOcOYj6E/HjNz8VvjEVYPOPqJQ2A
         vsBPD7EK7Fmiz1vl6sU/4ijevLmapM4VjD+SBAiOq43qusrLo3Id8YvdlpXY+1xvozPn
         gCtg==
X-Gm-Message-State: AHPjjUhxf7MhUG6x2kfA9HF0Qxyv87n9hY/6ovjIrOMKQfjh5A70UUDV
        BeQYjy+L53zFvJ7WiIfY9aC7Kfa1LbY=
X-Google-Smtp-Source: AOwi7QBoC72jLLzzinl4KvkfrgT/ENdwKUQp61u+y9jLzFYH6vy4yo0QBHN8P7HCB4R/NktFvoBbVA==
X-Received: by 10.98.138.17 with SMTP id y17mr8937675pfd.149.1506715929706;
        Fri, 29 Sep 2017 13:12:09 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 01/18] fsck: introduce partialclone extension
Date:   Fri, 29 Sep 2017 13:11:37 -0700
Message-Id: <a8c2d9c11c8bfba214cbd69f8c82697d384c0b55.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git does not support repos with very large numbers of objects
or repos that wish to minimize manipulation of certain blobs (for
example, because they are very large) very well, even if the user
operates mostly on part of the repo, because Git is designed on the
assumption that every referenced object is available somewhere in the
repo storage. In such an arrangement, the full set of objects is usually
available in remote storage, ready to be lazily downloaded.

Introduce the ability to have missing objects in a repo.  This
functionality is guarded behind a new repository extension option
`extensions.partialClone`. See the update to
Documentation/technical/repository-version.txt in this patch for more
information.

Teach fsck about the new state of affairs. In this commit, teach fsck
that missing promisor objects referenced from the reflog are not an
error case; in future commits, fsck will be taught about other cases.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/repository-version.txt | 12 ++++
 builtin/fsck.c                                 |  2 +-
 cache.h                                        |  5 +-
 environment.c                                  |  1 +
 packfile.c                                     | 77 +++++++++++++++++++++++-
 packfile.h                                     | 13 +++++
 setup.c                                        |  7 ++-
 t/t0410-partial-clone.sh                       | 81 ++++++++++++++++++++++++++
 8 files changed, 192 insertions(+), 6 deletions(-)
 create mode 100755 t/t0410-partial-clone.sh

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad37986..074ccb9e0 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,15 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`partialClone`
+~~~~~~~~~~~~~~
+
+When the config key `extensions.partialClone` is set, a remote is
+designated as a "promisor remote". Objects referenced by packed objects
+obtained from that promisor remote do not need to be in the local repo.
+Instead, the promisor remote promises that all such objects can be
+fetched from it in the future, and Git will fetch those objects when
+needed.
+
+The value of this key is the name of the aforementioned promisor remote.
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1e4c471b4..97d1e621e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -403,7 +403,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
 			obj->flags |= USED;
 			mark_object_reachable(obj);
-		} else {
+		} else if (!is_promisor_object(oid)) {
 			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
 		}
diff --git a/cache.h b/cache.h
index a916bc79e..437206d06 100644
--- a/cache.h
+++ b/cache.h
@@ -853,10 +853,12 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
+extern char *repository_format_partial_clone;
 
 struct repository_format {
 	int version;
 	int precious_objects;
+	char *partial_clone;
 	int is_bare;
 	char *work_tree;
 	struct string_list unknown_extensions;
@@ -1578,7 +1580,8 @@ extern struct packed_git {
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 freshened:1,
-		 do_not_close:1;
+		 do_not_close:1,
+		 pack_promisor:1;
 	unsigned char sha1[20];
 	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/environment.c b/environment.c
index f1f934b6f..624385fb2 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,7 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
+char *repository_format_partial_clone;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/packfile.c b/packfile.c
index f86fa051c..88f424320 100644
--- a/packfile.c
+++ b/packfile.c
@@ -8,6 +8,11 @@
 #include "list.h"
 #include "streaming.h"
 #include "sha1-lookup.h"
+#include "commit.h"
+#include "object.h"
+#include "tag.h"
+#include "tree-walk.h"
+#include "tree.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -638,10 +643,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		return NULL;
 
 	/*
-	 * ".pack" is long enough to hold any suffix we're adding (and
+	 * ".promisor" is long enough to hold any suffix we're adding (and
 	 * the use xsnprintf double-checks that)
 	 */
-	alloc = st_add3(path_len, strlen(".pack"), 1);
+	alloc = st_add3(path_len, strlen(".promisor"), 1);
 	p = alloc_packed_git(alloc);
 	memcpy(p->pack_name, path, path_len);
 
@@ -649,6 +654,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;
 
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".promisor");
+	if (!access(p->pack_name, F_OK))
+		p->pack_promisor = 1;
+
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
@@ -776,7 +785,8 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (ends_with(de->d_name, ".idx") ||
 		    ends_with(de->d_name, ".pack") ||
 		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep"))
+		    ends_with(de->d_name, ".keep") ||
+		    ends_with(de->d_name, ".promisor"))
 			string_list_append(&garbage, path.buf);
 		else
 			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
@@ -1884,6 +1894,9 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	for (p = packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
+		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		    !p->pack_promisor)
+			continue;
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;
@@ -1894,3 +1907,61 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	}
 	return r ? r : pack_errors;
 }
+
+static int add_promisor_object(const struct object_id *oid,
+			       struct packed_git *pack,
+			       uint32_t pos,
+			       void *set_)
+{
+	struct oidset *set = set_;
+	struct object *obj = parse_object(oid);
+	if (!obj)
+		return 1;
+
+	oidset_insert(set, oid);
+
+	/*
+	 * If this is a tree, commit, or tag, the objects it refers
+	 * to are also promisor objects. (Blobs refer to no objects.)
+	 */
+	if (obj->type == OBJ_TREE) {
+		struct tree *tree = (struct tree *)obj;
+		struct tree_desc desc;
+		struct name_entry entry;
+		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+			/*
+			 * Error messages are given when packs are
+			 * verified, so do not print any here.
+			 */
+			return 0;
+		while (tree_entry_gently(&desc, &entry))
+			oidset_insert(set, entry.oid);
+	} else if (obj->type == OBJ_COMMIT) {
+		struct commit *commit = (struct commit *) obj;
+		struct commit_list *parents = commit->parents;
+
+		oidset_insert(set, &commit->tree->object.oid);
+		for (; parents; parents = parents->next)
+			oidset_insert(set, &parents->item->object.oid);
+	} else if (obj->type == OBJ_TAG) {
+		struct tag *tag = (struct tag *) obj;
+		oidset_insert(set, &tag->tagged->oid);
+	}
+	return 0;
+}
+
+int is_promisor_object(const struct object_id *oid)
+{
+	static struct oidset promisor_objects;
+	static int promisor_objects_prepared;
+
+	if (!promisor_objects_prepared) {
+		if (repository_format_partial_clone) {
+			for_each_packed_object(add_promisor_object,
+					       &promisor_objects,
+					       FOR_EACH_OBJECT_PROMISOR_ONLY);
+		}
+		promisor_objects_prepared = 1;
+	}
+	return oidset_contains(&promisor_objects, oid);
+}
diff --git a/packfile.h b/packfile.h
index 0cdeb54dc..a7fca598d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,6 +1,8 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
+#include "oidset.h"
+
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
  * extension "ext". The result is written into the strbuf "buf", overwriting
@@ -124,6 +126,11 @@ extern int has_sha1_pack(const unsigned char *sha1);
 
 extern int has_pack_index(const unsigned char *sha1);
 
+/*
+ * Only iterate over packs obtained from the promisor remote.
+ */
+#define FOR_EACH_OBJECT_PROMISOR_ONLY 2
+
 /*
  * Iterate over packed objects in both the local
  * repository and any alternates repositories (unless the
@@ -135,4 +142,10 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
+/*
+ * Return 1 if an object in a promisor packfile is or refers to the given
+ * object, 0 otherwise.
+ */
+extern int is_promisor_object(const struct object_id *oid);
+
 #endif
diff --git a/setup.c b/setup.c
index 6d8380acd..35c9da806 100644
--- a/setup.c
+++ b/setup.c
@@ -420,7 +420,11 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
-		else
+		else if (!strcmp(ext, "partialclone")) {
+			if (!value)
+				return config_error_nonbool(var);
+			data->partial_clone = xstrdup(value);
+		} else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
 		data->is_bare = git_config_bool(var, value);
@@ -463,6 +467,7 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	}
 
 	repository_format_precious_objects = candidate.precious_objects;
+	repository_format_partial_clone = candidate.partial_clone;
 	string_list_clear(&candidate.unknown_extensions, 0);
 	if (!has_common) {
 		if (candidate.is_bare != -1) {
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
new file mode 100755
index 000000000..3ddb3b98f
--- /dev/null
+++ b/t/t0410-partial-clone.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='partial clone'
+
+. ./test-lib.sh
+
+delete_object () {
+	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
+}
+
+pack_as_from_promisor () {
+	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
+	>repo/.git/objects/pack/pack-$HASH.promisor
+}
+
+test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	C=$(git -C repo commit-tree -m c -p $A HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# State that we got $C, which refers to $A, from promisor
+	printf "$C\n" | pack_as_from_promisor &&
+
+	# Normally, it fails
+	test_must_fail git -C repo fsck &&
+
+	# But with the extension, it succeeds
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object, but promised by a tag, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	git -C repo tag -a -m d my_tag_name $A &&
+	T=$(git -C repo rev-parse my_tag_name) &&
+	git -C repo tag -d my_tag_name &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	# State that we got $T, which refers to $A, from promisor
+	printf "$T\n" | pack_as_from_promisor &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck
+'
+
+test_expect_success 'missing reflog object alone fails fsck, even with extension set' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
+
+	# Reference $A only from reflog, and delete it
+	git -C repo branch my_branch "$A" &&
+	git -C repo branch -f my_branch my_commit &&
+	delete_object repo "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	test_must_fail git -C repo fsck
+'
+
+test_done
-- 
2.14.2.822.g60be5d43e6-goog


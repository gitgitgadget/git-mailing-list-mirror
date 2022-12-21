Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2477C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 13:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiLUNsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiLUNrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 08:47:53 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234921AA04
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:47:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u19so36917972ejm.8
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V30b4GxHORXnG8y/ezRAhtebnmpbZbbRiU9WQI7BZRs=;
        b=CXCRGX3GuXrHNjgxKDvDikVbu/yfXkwvDRKXd0EuC/C32GsMxrUZ00oWbWGmgONMBR
         Te3j5uLTr3giGDOzOw+dMk0uJbbiMtHkRzRaf971pbKOy75d6w5XPeKjKPo/8lFIAok3
         BWufDsi7MIXLX7fC5Mf4Qoa36d8zhA3Bd/v6IJRRT/hqh4IivhBzoIuw7rENt1pUvjzX
         Qa5yST4nI6KHQLFdH2H38rAjQvIgfbm5WVN5LyN3fsorU0YAzSht4oisgt/lUOHVJ4G7
         3K8yr2iuSHmOt1Hw1ZuNNWUxEDrCmrGtUCmBgbkG10R6qTWE8rqSdeOTTBlX/YHGUi0Y
         9WJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V30b4GxHORXnG8y/ezRAhtebnmpbZbbRiU9WQI7BZRs=;
        b=qHyApJNo24tgElDUl2a0Km9DI0/q+rIlExEsZAuI8jQNxxmgbUAqh6aO2KpJKCfhMh
         d/y7F/Kf2ECw/LztSvWT3CNtAANfFjyWBRkg4ujZV2l+U07/9B4JfC11g33wWxZG5ciY
         +0/8Uq6W/pdFYG9qFa54LFMWoxem5M6GgaYLH3BbFBcBmJXG6lqzCMWDuWN2IdIzeiB1
         1/88/KJg/pQVnNMyz6+riRpTFok0u5YNBUkF9riPo3v0xOYMzxLLBvex8YfsVLDbT1fo
         2vCEptMdfZ/UqAHUhckea4FLVuUzmEBA7/KwI3zRi09pmuifNMo+vesn0iAIanROZyMH
         vqig==
X-Gm-Message-State: AFqh2krBRmVeJIHXVZWAqlV8NQ9U3PYvKONOprAgnJi8wn1lEjWnBRCr
        KZxdhMwKgvGry9vZvFNWtou/zEryWuNhFrqXZLs=
X-Google-Smtp-Source: AMrXdXtXErsIzIn5hMP/ngOppgEgy2JD2ypiTyyxXuacBC4bhjpGncqahNlx6syJjjFdFYZlnYGwfQ==
X-Received: by 2002:a17:906:6dd4:b0:836:e6f7:8138 with SMTP id j20-20020a1709066dd400b00836e6f78138mr1566213ejt.13.1671630469123;
        Wed, 21 Dec 2022 05:47:49 -0800 (PST)
Received: from localhost.localdomain ([79.140.126.226])
        by smtp.gmail.com with ESMTPSA id la7-20020a170907780700b007815ca7ae57sm7186254ejc.212.2022.12.21.05.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:47:48 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 2/2] attr: add flag `--revision` to work with revisions
Date:   Wed, 21 Dec 2022 14:47:32 +0100
Message-Id: <a161dbdf8b70354716d0bfeccc707c242c7f33a1.1671630304.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671630304.git.karthik.188@gmail.com>
References: <https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/> <cover.1671630304.git.karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The contents of the .gitattributes files may evolve over time, but "git
check-attr" always checks attributes against them in the working tree
and/or in the index. It may be beneficial to optionally allow the users
to check attributes taken from a commit other than HEAD against paths.

Add a new flag `--revision` which will allow users to check the
attributes against a commit (actually any tree-ish would do). When the
user uses this flag, we go through the stack of .gitattributes files but
instead of checking the current working tree and/or in the index, we
check the blobs from the provided tree-ish object. This allows the
command to also be used in bare repositories.

Since we use a tree-ish object, the user can pass "--revision
HEAD:subdirectory" and all the attributes will be looked up as if
subdirectory was the root directory of the repository.

We cannot simply use the `<rev>:<path>` syntax without the `--revision`
flag, similar to how it is used in `git show` because any non-flag
parameter before `--` is treated as an attribute and any parameter after
`--` is treated as a pathname.

The change involves creating a new function `read_attr_from_blob`, which
given the path reads the blob for the path against the provided revision and
parses the attributes line by line. This function is plugged into
`read_attr()` function wherein we go through the stack of attributes
files.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
Co-authored-by: toon@iotcl.com
---
 Documentation/git-check-attr.txt |  9 ++-
 archive.c                        |  2 +-
 attr.c                           | 99 +++++++++++++++++++++++---------
 attr.h                           |  7 ++-
 builtin/check-attr.c             | 36 +++++++-----
 builtin/pack-objects.c           |  2 +-
 convert.c                        |  2 +-
 ll-merge.c                       |  4 +-
 pathspec.c                       |  2 +-
 t/t0003-attributes.sh            | 64 ++++++++++++++++++++-
 userdiff.c                       |  2 +-
 ws.c                             |  2 +-
 12 files changed, 178 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 84f41a8e82..174019c71d 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,8 +9,8 @@ git-check-attr - Display gitattributes information
 SYNOPSIS
 --------
 [verse]
-'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
-'git check-attr' --stdin [-z] [-a | --all | <attr>...]
+'git check-attr' [--revision <revision>] [-a | --all | <attr>...] [--] <pathname>...
+'git check-attr' --stdin [-z] [--revision <revision>] [-a | --all | <attr>...]
 
 DESCRIPTION
 -----------
@@ -36,6 +36,11 @@ OPTIONS
 	If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
+--revision=<revision>::
+	Check attributes against the specified commit. All the attributes will
+	be checked against the provided revision. Paths provided as part of the
+	revision will be treated as the root directory.
+
 \--::
 	Interpret all preceding arguments as attributes and all following
 	arguments as path names.
diff --git a/archive.c b/archive.c
index 941495f5d7..81ff76fce9 100644
--- a/archive.c
+++ b/archive.c
@@ -120,7 +120,7 @@ static const struct attr_check *get_archive_attrs(struct index_state *istate,
 	static struct attr_check *check;
 	if (!check)
 		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, NULL, path, check);
 	return check;
 }
 
diff --git a/attr.c b/attr.c
index 42ad6de8c7..6c69e82080 100644
--- a/attr.c
+++ b/attr.c
@@ -11,8 +11,12 @@
 #include "exec-cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "strbuf.h"
+#include "tree-walk.h"
 #include "utf8.h"
 #include "quote.h"
+#include "revision.h"
+#include "object-store.h"
 #include "thread-utils.h"
 
 const char git_attr__true[] = "(builtin)true";
@@ -729,14 +733,62 @@ static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 	return res;
 }
 
-static struct attr_stack *read_attr_from_index(struct index_state *istate,
-					       const char *path,
-					       unsigned flags)
+static struct attr_stack *read_attr_from_buf(char *buf, const char *path,
+					     unsigned flags)
 {
 	struct attr_stack *res;
-	char *buf, *sp;
+	char *sp;
 	int lineno = 0;
 
+	if (!buf)
+		return NULL;
+
+	CALLOC_ARRAY(res, 1);
+	for (sp = buf; *sp;) {
+		char *ep;
+		int more;
+
+		ep = strchrnul(sp, '\n');
+		more = (*ep == '\n');
+		*ep = '\0';
+		handle_attr_line(res, sp, path, ++lineno, flags);
+		sp = ep + more;
+	}
+	free(buf);
+
+	return res;
+}
+
+static struct attr_stack *read_attr_from_blob(struct index_state *istate,
+					      const struct object_id *tree_oid,
+					      const char *path, unsigned flags)
+{
+	struct object_id oid;
+	unsigned long sz;
+	enum object_type type;
+	void *buf;
+	unsigned short mode;
+
+	if (!tree_oid)
+		return NULL;
+
+	if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
+		return NULL;
+
+	buf = read_object_file(&oid, &type, &sz);
+	if (!buf || type != OBJ_BLOB) {
+		free(buf);
+		return NULL;
+	}
+
+	return read_attr_from_buf(buf, path, flags);
+}
+
+static struct attr_stack *read_attr_from_index(struct index_state *istate,
+					       const char *path, unsigned flags)
+{
+	char *buf;
+
 	if (!istate)
 		return NULL;
 
@@ -758,28 +810,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 	if (!buf)
 		return NULL;
 
-	CALLOC_ARRAY(res, 1);
-	for (sp = buf; *sp; ) {
-		char *ep;
-		int more;
-
-		ep = strchrnul(sp, '\n');
-		more = (*ep == '\n');
-		*ep = '\0';
-		handle_attr_line(res, sp, path, ++lineno, flags);
-		sp = ep + more;
-	}
-	free(buf);
-	return res;
+	return read_attr_from_buf(buf, path, flags);
 }
 
 static struct attr_stack *read_attr(struct index_state *istate,
+				    const struct object_id *tree_oid,
 				    const char *path, unsigned flags)
 {
 	struct attr_stack *res = NULL;
 
 	if (direction == GIT_ATTR_INDEX) {
 		res = read_attr_from_index(istate, path, flags);
+	} else if (tree_oid) {
+		res = read_attr_from_blob(istate, tree_oid, path, flags);
 	} else if (!is_bare_repository()) {
 		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(istate, path, flags);
@@ -839,6 +882,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
 }
 
 static void bootstrap_attr_stack(struct index_state *istate,
+				 const struct object_id *tree_oid,
 				 struct attr_stack **stack)
 {
 	struct attr_stack *e;
@@ -864,7 +908,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	}
 
 	/* root directory */
-	e = read_attr(istate, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
+	e = read_attr(istate, tree_oid, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
@@ -878,6 +922,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
 }
 
 static void prepare_attr_stack(struct index_state *istate,
+			       const struct object_id *tree_oid,
 			       const char *path, int dirlen,
 			       struct attr_stack **stack)
 {
@@ -899,7 +944,7 @@ static void prepare_attr_stack(struct index_state *istate,
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack(istate, stack);
+	bootstrap_attr_stack(istate, tree_oid, stack);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
@@ -954,7 +999,7 @@ static void prepare_attr_stack(struct index_state *istate,
 		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
 		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
 
-		next = read_attr(istate, pathbuf.buf, READ_ATTR_NOFOLLOW);
+		next = read_attr(istate, tree_oid, pathbuf.buf, READ_ATTR_NOFOLLOW);
 
 		/* reset the pathbuf to not include "/.gitattributes" */
 		strbuf_setlen(&pathbuf, len);
@@ -1074,8 +1119,8 @@ static void determine_macros(struct all_attrs_item *all_attrs,
  * Otherwise all attributes are collected.
  */
 static void collect_some_attrs(struct index_state *istate,
-			       const char *path,
-			       struct attr_check *check)
+			       const struct object_id *tree_oid,
+			       const char *path, struct attr_check *check)
 {
 	int pathlen, rem, dirlen;
 	const char *cp, *last_slash = NULL;
@@ -1094,7 +1139,7 @@ static void collect_some_attrs(struct index_state *istate,
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(istate, path, dirlen, &check->stack);
+	prepare_attr_stack(istate, tree_oid, path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
 	determine_macros(check->all_attrs, check->stack);
 
@@ -1103,12 +1148,12 @@ static void collect_some_attrs(struct index_state *istate,
 }
 
 void git_check_attr(struct index_state *istate,
-		    const char *path,
+		    const struct object_id *tree_oid, const char *path,
 		    struct attr_check *check)
 {
 	int i;
 
-	collect_some_attrs(istate, path, check);
+	collect_some_attrs(istate, tree_oid, path, check);
 
 	for (i = 0; i < check->nr; i++) {
 		size_t n = check->items[i].attr->attr_nr;
@@ -1119,13 +1164,13 @@ void git_check_attr(struct index_state *istate,
 	}
 }
 
-void git_all_attrs(struct index_state *istate,
+void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
 		   const char *path, struct attr_check *check)
 {
 	int i;
 
 	attr_check_reset(check);
-	collect_some_attrs(istate, path, check);
+	collect_some_attrs(istate, tree_oid, path, check);
 
 	for (i = 0; i < check->all_attrs_nr; i++) {
 		const char *name = check->all_attrs[i].attr->name;
diff --git a/attr.h b/attr.h
index 3fb40cced0..f4a2bedd68 100644
--- a/attr.h
+++ b/attr.h
@@ -1,6 +1,8 @@
 #ifndef ATTR_H
 #define ATTR_H
 
+#include "hash.h"
+
 /**
  * gitattributes mechanism gives a uniform way to associate various attributes
  * to set of paths.
@@ -190,13 +192,14 @@ void attr_check_free(struct attr_check *check);
 const char *git_attr_name(const struct git_attr *);
 
 void git_check_attr(struct index_state *istate,
-		    const char *path, struct attr_check *check);
+		    const struct object_id *tree_oid, const char *path,
+		    struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-void git_all_attrs(struct index_state *istate,
+void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
 		   const char *path, struct attr_check *check);
 
 enum git_attr_direction {
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 0fef10eb6b..04640e0297 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,3 +1,4 @@
+#include "repository.h"
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
@@ -9,9 +10,10 @@
 static int all_attrs;
 static int cached_attrs;
 static int stdin_paths;
+static char *revision;
 static const char * const check_attr_usage[] = {
-N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
-N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
+N_("git check-attr [--revision <revision>] [-a | --all | <attr>...] [--] <pathname>..."),
+N_("git check-attr --stdin [-z] [--revision <revision>] [-a | --all | <attr>...]"),
 NULL
 };
 
@@ -23,6 +25,7 @@ static const struct option check_attr_options[] = {
 	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
 	OPT_BOOL('z', NULL, &nul_term_line,
 		 N_("terminate input and output records by a NUL character")),
+	OPT_STRING(0, "revision", &revision, N_("revision"), N_("check attributes at this revision")),
 	OPT_END()
 };
 
@@ -55,27 +58,26 @@ static void output_attr(struct attr_check *check, const char *file)
 	}
 }
 
-static void check_attr(const char *prefix,
-		       struct attr_check *check,
-		       int collect_all,
+static void check_attr(const char *prefix, struct attr_check *check,
+		       const struct object_id *tree_oid, int collect_all,
 		       const char *file)
+
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(&the_index, full_path, check);
+		git_all_attrs(&the_index, tree_oid, full_path, check);
 	} else {
-		git_check_attr(&the_index, full_path, check);
+		git_check_attr(&the_index, tree_oid, full_path, check);
 	}
 	output_attr(check, file);
 
 	free(full_path);
 }
 
-static void check_attr_stdin_paths(const char *prefix,
-				   struct attr_check *check,
-				   int collect_all)
+static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
+				   const struct object_id *tree_oid, int collect_all)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -89,7 +91,7 @@ static void check_attr_stdin_paths(const char *prefix,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, check, collect_all, buf.buf);
+		check_attr(prefix, check, tree_oid, collect_all, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -105,6 +107,7 @@ static NORETURN void error_with_usage(const char *msg)
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct attr_check *check;
+	struct object_id *tree_oid = NULL;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
@@ -176,11 +179,18 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (revision) {
+		tree_oid = xmalloc(sizeof(struct object_id));
+
+		if (repo_get_oid_tree(the_repository, revision, tree_oid))
+			error("%s: not a valid revision", revision);
+	}
+
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, check, all_attrs);
+		check_attr_stdin_paths(prefix, check, tree_oid, all_attrs);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, check, all_attrs, argv[i]);
+			check_attr(prefix, check, tree_oid, all_attrs, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 573d0b20b7..89535cfa6a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1318,7 +1318,7 @@ static int no_try_delta(const char *path)
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
-	git_check_attr(the_repository->index, path, check);
+	git_check_attr(the_repository->index, NULL, path, check);
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
 	return 0;
diff --git a/convert.c b/convert.c
index 9b67649032..a54d1690c0 100644
--- a/convert.c
+++ b/convert.c
@@ -1308,7 +1308,7 @@ void convert_attrs(struct index_state *istate,
 		git_config(read_convert_config, NULL);
 	}
 
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, NULL, path, check);
 	ccheck = check->items;
 	ca->crlf_action = git_path_check_crlf(ccheck + 4);
 	if (ca->crlf_action == CRLF_UNDEFINED)
diff --git a/ll-merge.c b/ll-merge.c
index 22a603e8af..130d26501c 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -391,7 +391,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 		normalize_file(theirs, path, istate);
 	}
 
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, NULL, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
 		marker_size = atoi(check->items[1].value);
@@ -419,7 +419,7 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 
 	if (!check)
 		check = attr_check_initl("conflict-marker-size", NULL);
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, NULL, path, check);
 	if (check->items[0].value) {
 		marker_size = atoi(check->items[0].value);
 		if (marker_size <= 0)
diff --git a/pathspec.c b/pathspec.c
index 46e77a85fe..48dec2c709 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -732,7 +732,7 @@ int match_pathspec_attrs(struct index_state *istate,
 	if (name[namelen])
 		name = to_free = xmemdupz(name, namelen);
 
-	git_check_attr(istate, name, item->attr_check);
+	git_check_attr(istate, NULL, name, item->attr_check);
 
 	free(to_free);
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index b3aabb8aa3..6e6a909a46 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -25,7 +25,14 @@ attr_check_quote () {
 	git check-attr test -- "$path" >actual &&
 	echo "\"$quoted_path\": test: $expect" >expect &&
 	test_cmp expect actual
+}
+
+attr_check_revision () {
+	path="$1" expect="$2" revision="$3" git_opts="$4" &&
 
+	git $git_opts check-attr --revision $revision test -- "$path" >actual 2>err &&
+	echo "$path: test: $expect" >expect &&
+	test_cmp expect actual
 }
 
 test_expect_success 'open-quoted pathname' '
@@ -33,7 +40,6 @@ test_expect_success 'open-quoted pathname' '
 	attr_check a unspecified
 '
 
-
 test_expect_success 'setup' '
 	mkdir -p a/b/d a/c b &&
 	(
@@ -80,12 +86,38 @@ test_expect_success 'setup' '
 	EOF
 '
 
+test_expect_success 'setup branches' '
+	(
+		echo "f	test=f" &&
+		echo "a/i test=n"
+	) | git hash-object -w --stdin >id &&
+	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
+	git write-tree >id &&
+	tree_id=$(cat id) &&
+	git commit-tree $tree_id -m "random commit message" >id &&
+	commit_id=$(cat id) &&
+	git update-ref refs/heads/branch1 $commit_id &&
+
+	(
+		echo "g test=g" &&
+		echo "a/i test=m"
+	) | git hash-object -w --stdin >id &&
+	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
+	git write-tree >id &&
+	tree_id=$(cat id) &&
+	git commit-tree $tree_id -m "random commit message" >id &&
+	commit_id=$(cat id) &&
+	git update-ref refs/heads/branch2 $commit_id
+'
+
 test_expect_success 'command line checks' '
 	test_must_fail git check-attr &&
 	test_must_fail git check-attr -- &&
 	test_must_fail git check-attr test &&
 	test_must_fail git check-attr test -- &&
 	test_must_fail git check-attr -- f &&
+	test_must_fail git check-attr --revision &&
+	test_must_fail git check-attr --revision not-a-valid-ref &&
 	echo "f" | test_must_fail git check-attr --stdin &&
 	echo "f" | test_must_fail git check-attr --stdin -- f &&
 	echo "f" | test_must_fail git check-attr --stdin test -- f &&
@@ -287,6 +319,15 @@ test_expect_success 'using --git-dir and --work-tree' '
 	)
 '
 
+test_expect_success 'using --revision' '
+	attr_check_revision foo/bar/f f branch1 &&
+	attr_check_revision foo/bar/a/i n branch1 &&
+	attr_check_revision foo/bar/f unspecified branch2 &&
+	attr_check_revision foo/bar/a/i m branch2 &&
+	attr_check_revision foo/bar/g g branch2 &&
+	attr_check_revision foo/bar/g unspecified branch1
+'
+
 test_expect_success 'setup bare' '
 	git clone --template= --bare . bare.git
 '
@@ -306,6 +347,27 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+test_expect_success 'bare repository: with --revision' '
+	(
+		cd bare.git &&
+		(
+			echo "f	test=f" &&
+			echo "a/i test=a/i"
+		) | git hash-object -w --stdin >id &&
+		git update-index --add --cacheinfo 100644 $(cat id) .gitattributes &&
+		git write-tree >id &&
+		tree_id=$(cat id) &&
+		git commit-tree $tree_id -m "random commit message" >id &&
+		commit_id=$(cat id) &&
+		git update-ref refs/heads/master $commit_id &&
+		attr_check_revision f f HEAD &&
+		attr_check_revision a/f f HEAD &&
+		attr_check_revision a/c/f f HEAD &&
+		attr_check_revision a/i a/i HEAD &&
+		attr_check_revision subdir/a/i unspecified HEAD
+	)
+'
+
 test_expect_success 'bare repository: check that --cached honors index' '
 	(
 		cd bare.git &&
diff --git a/userdiff.c b/userdiff.c
index 151d9a5278..b66f090a0b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -412,7 +412,7 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	git_check_attr(istate, path, check);
+	git_check_attr(istate, NULL, path, check);
 
 	if (ATTR_TRUE(check->items[0].value))
 		return &driver_true;
diff --git a/ws.c b/ws.c
index 6e69877f25..eadbbe5667 100644
--- a/ws.c
+++ b/ws.c
@@ -78,7 +78,7 @@ unsigned whitespace_rule(struct index_state *istate, const char *pathname)
 	if (!attr_whitespace_rule)
 		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	git_check_attr(istate, pathname, attr_whitespace_rule);
+	git_check_attr(istate, NULL, pathname, attr_whitespace_rule);
 	value = attr_whitespace_rule->items[0].value;
 	if (ATTR_TRUE(value)) {
 		/* true (whitespace) */
-- 
2.39.0


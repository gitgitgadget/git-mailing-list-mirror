Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07698C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLIVDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiLIVDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 16:03:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE67B0783
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 13:03:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso6501934wmb.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 13:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ii4NDMrtiAWeO6Jc8+uKGuRrLdDer6VJppGk5EvAMc=;
        b=M+9omsOBbJqaQt6z0coGRd/fQCBLaD1p7PN0Cuqms6jXHQEdQVKR+scSLQSuhbDwI5
         rmAxUgdOroP5RTOlr4KGwjQrqOq1tey8SWMFJ8iRLTXBZLkd4s9XCexQlZWC78oaE8+H
         yfMAFkF1kbn3g0fU8TiaMHCc/c3bI/7/nSvvtDJZJ/fvUQWvCh9bR9wkr7dJleKoMa4e
         IBbG4Jeo0tTvyS5Al9yOrbw9uJNSVjONXqScCU28jTlo45bPGNII9ogpgSJzpaLb5VdY
         eHH1b/iG44CsLHHYxQmEgO0B56x1l287fa+d2PthoJjHeqdzeJbfnYbchR7Du6p0sQPs
         uTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ii4NDMrtiAWeO6Jc8+uKGuRrLdDer6VJppGk5EvAMc=;
        b=dfTwzw/7dbldr9p1+K0uUDpRy81imXT/dfhWlSS3jUgc2jLXMX0CEx6dWRXKofe1CY
         geyxy7BTnlWRVkpi5EElol5h5Ek8Aj/BZi5JXJ9Mdvr1nB2V1r69FhsAbEhcLz6Zupjm
         TEiPwROxqqZ0D1JnX1ilVRg9pVM+ARMVjRlAAm0gVHXvb8kauv2Dq9SrTeFAspy/i7Pf
         ZZdKfAT0v9bo4I9vNdOK9ZoNOqfXRS/pCdKcqdz+a5IItdXOZoss/i8wdHbtXzQ7fzWo
         d/mepraT/PtP3vbTbDRssiHrl1xq/wEWOtBjXp2SnNQz6xrqFsGSbku/ovvyFfQ/fmXK
         rzTw==
X-Gm-Message-State: ANoB5pnZ/8W6v7xiH+xy2TCZcQqd+qay91gTqEdOi88fczrs66avgbsP
        IPPHJNrqrn4+M2DA0UhygtKXN+GCiD0N+w==
X-Google-Smtp-Source: AA0mqf6Bc9GMVDvsLHjbe2KMD/bkKfGHCdfHwg6UDSyBnwzSXlC78WYNyP8KHRXBg16mf89HFsvNMQ==
X-Received: by 2002:a7b:c30e:0:b0:3cf:735c:9d54 with SMTP id k14-20020a7bc30e000000b003cf735c9d54mr6322945wmj.1.1670619808247;
        Fri, 09 Dec 2022 13:03:28 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003c701c12a17sm887838wmo.12.2022.12.09.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:03:27 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/2] attr: add flag `-r|--revisions` to work with revisions
Date:   Fri,  9 Dec 2022 22:03:21 +0100
Message-Id: <20221209210321.709156-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209210321.709156-1-karthik.188@gmail.com>
References: <20221209210321.709156-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git check-attr currently doesn't check the git worktree, it either
checks the index or the files directly. This means we cannot check the
attributes for a file against a certain revision.

Add a new flag `--revision`/`-r` which will allow it work with
revisions. This command will now, instead of checking the files/index,
try and receive the blob for the given attribute file against the
provided revision. The flag overrides checking against the index and
filesystem and also works with bare repositories.

We cannot use the `<rev>:<path>` syntax like the one used in `git show`
because any non-flag parameter before `--` is treated as an attribute
and any parameter after `--` is treated as a pathname.

This involves creating a new function `read_attr_from_blob`, which given
the path reads the blob for the path against the provided revision and
parses the attributes line by line. This function is plugged into
`read_attr()` function wherein we go through the different attributes.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 Documentation/git-check-attr.txt |   8 ++-
 archive.c                        |   2 +-
 attr.c                           | 100 ++++++++++++++++++++++---------
 attr.h                           |   7 ++-
 builtin/check-attr.c             |  33 ++++++----
 builtin/pack-objects.c           |   2 +-
 convert.c                        |   2 +-
 ll-merge.c                       |   4 +-
 pathspec.c                       |   2 +-
 t/t0003-attributes.sh            |  64 +++++++++++++++++++-
 userdiff.c                       |   2 +-
 ws.c                             |   2 +-
 12 files changed, 175 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 84f41a8e82..3dc61f0fdc 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,8 +9,8 @@ git-check-attr - Display gitattributes information
 SYNOPSIS
 --------
 [verse]
-'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
-'git check-attr' --stdin [-z] [-a | --all | <attr>...]
+'git check-attr' [-a | --all | <attr>...] [-r <revision>] [--] <pathname>...
+'git check-attr' --stdin [-z] [-a | --all | <attr>...] [-r <revision>]
 
 DESCRIPTION
 -----------
@@ -36,6 +36,10 @@ OPTIONS
 	If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
+--r <revision>::
+--revision=<revision>::
+	Check attributes against the specified revision.
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
index 42ad6de8c7..99883024ec 100644
--- a/attr.c
+++ b/attr.c
@@ -11,8 +11,13 @@
 #include "exec-cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "tree-walk.h"
 #include "utf8.h"
 #include "quote.h"
+#include "revision.h"
+#include "object-store.h"
 #include "thread-utils.h"
 
 const char git_attr__true[] = "(builtin)true";
@@ -729,14 +734,62 @@ static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
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
 
@@ -758,28 +811,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
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
@@ -839,6 +883,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
 }
 
 static void bootstrap_attr_stack(struct index_state *istate,
+				 const struct object_id *tree_oid,
 				 struct attr_stack **stack)
 {
 	struct attr_stack *e;
@@ -864,7 +909,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	}
 
 	/* root directory */
-	e = read_attr(istate, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
+	e = read_attr(istate, tree_oid, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
@@ -878,6 +923,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
 }
 
 static void prepare_attr_stack(struct index_state *istate,
+			       const struct object_id *tree_oid,
 			       const char *path, int dirlen,
 			       struct attr_stack **stack)
 {
@@ -899,7 +945,7 @@ static void prepare_attr_stack(struct index_state *istate,
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack(istate, stack);
+	bootstrap_attr_stack(istate, tree_oid, stack);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
@@ -954,7 +1000,7 @@ static void prepare_attr_stack(struct index_state *istate,
 		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
 		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
 
-		next = read_attr(istate, pathbuf.buf, READ_ATTR_NOFOLLOW);
+		next = read_attr(istate, tree_oid, pathbuf.buf, READ_ATTR_NOFOLLOW);
 
 		/* reset the pathbuf to not include "/.gitattributes" */
 		strbuf_setlen(&pathbuf, len);
@@ -1074,8 +1120,8 @@ static void determine_macros(struct all_attrs_item *all_attrs,
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
@@ -1094,7 +1140,7 @@ static void collect_some_attrs(struct index_state *istate,
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(istate, path, dirlen, &check->stack);
+	prepare_attr_stack(istate, tree_oid, path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
 	determine_macros(check->all_attrs, check->stack);
 
@@ -1103,12 +1149,12 @@ static void collect_some_attrs(struct index_state *istate,
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
@@ -1119,13 +1165,13 @@ void git_check_attr(struct index_state *istate,
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
index 0fef10eb6b..28da31c2a5 100644
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
+N_("git check-attr [-a | --all | <attr>...] [-r <revision>] [--] <pathname>..."),
+N_("git check-attr --stdin [-z] [-a | --all | <attr>...] [-r <revision>]"),
 NULL
 };
 
@@ -23,6 +25,7 @@ static const struct option check_attr_options[] = {
 	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
 	OPT_BOOL('z', NULL, &nul_term_line,
 		 N_("terminate input and output records by a NUL character")),
+	OPT_STRING('r', "revision", &revision, N_("revision"), N_("check attributes at this revision")),
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
+	struct object_id tree_oid;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
@@ -176,11 +179,15 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (revision)
+		if (repo_get_oid_tree(the_repository, revision, &tree_oid))
+			error("%s: not a valid revision", revision);
+
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, check, all_attrs);
+		check_attr_stdin_paths(prefix, check, &tree_oid, all_attrs);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, check, all_attrs, argv[i]);
+			check_attr(prefix, check, &tree_oid, all_attrs, argv[i]);
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
index b3aabb8aa3..042af0239f 100755
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
 
+	git $git_opts check-attr -r $revision test -- "$path" >actual 2>err &&
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
+	test_must_fail git check-attr -r &&
+	test_must_fail git check-attr -r not-a-valid-ref &&
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
2.38.1


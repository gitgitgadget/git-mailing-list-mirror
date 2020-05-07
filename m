Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908ECC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605A220708
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCXQm030"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEGNRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgEGNRt (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3479C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 188so6481733wmc.2
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rWPjZP74fDB5dDeAKF6w5JQg0EJvFWS7OvDjbaqb0zc=;
        b=rCXQm030sDmSmJVzJ9Nj49dbCDRnixcbb7MzgdUQiV4vz1qhZZagdmhYa/2oQlzxvw
         t+doUlYVlvkiHt+49RHjG+JpGfUjiMXicoAj+mHcOFtssZJlFQQdf0IYW9uoo+x+ARvY
         uGLtGXinqPRY30fVanLb02qDy8+mATojUFv6WQuY+co3D1d7sH8M/GKVv5BUC/ScpmUH
         whgJzwGo8NSJrTtokPPayvq8w5x1wcfXFk4G1lNY1KAVfFVmvED+cquNdRZLMLNJSPCH
         yTXznB1GNeyAzbB6WSw1C+oJytvqgwKRaXT4yrrtAR8LCEggJUgYW9EgK1a39GX4fxT0
         PxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rWPjZP74fDB5dDeAKF6w5JQg0EJvFWS7OvDjbaqb0zc=;
        b=LHC5rZGxS3ds6ORl1+8PIPFIbcDXX/NRL9z61bYS46VOL3SsalnhjqcVtRVRjSy4VE
         Exsz7m71sbxN4+4A8f4uiVc1z2WXN1XX5TjyU9L7OJwADrO8WrEmop8JdR6PrkStfCYk
         l0gWeX2cUhBQTZgzNz9pLSgPJ6j2QdGIINngEFlZSCU4bJ1bmtRyYOFfXcdj2UJ1vWvA
         xlsRhjErOm8uKOCyVWtM2TE0OBGI4uW0D192wJnTe9jz5kA0Dy63SFLNuapTMJImN/yE
         NSrXjyYSxAndpZ5qh/RwxloAXBx8isr34DpH7JagLuoKSmq/9Ab3qjoDQTUvNfKTKLE4
         YUdQ==
X-Gm-Message-State: AGi0PuYVu87370zze1ZEApMGYLtWtrZsrAbA4X2yqdqbGKBXoRpr7dKy
        N+MQW3n0caENxRBWrAE5g7dAyw1y
X-Google-Smtp-Source: APiQypIT/pG+Y0xSmblHqz3dmoLnmB6jPrK4pkiT2Z5KP1hMDQzMA6SGYiVYpfsPQ/TqBTq+S3vTWg==
X-Received: by 2002:a1c:e087:: with SMTP id x129mr10752564wmg.127.1588857466846;
        Thu, 07 May 2020 06:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a187sm8098478wmh.40.2020.05.07.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:46 -0700 (PDT)
Message-Id: <2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:36 +0000
Subject: [PATCH 04/10] sparse-checkout: allow in-tree definitions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

One of the difficulties of using the sparse-checkout feature is not
knowing which directories are absolutely needed for working in a portion
of the repository. Some of this can be documented in README files or
included in a bootstrapping tool along with the repository. This is done
in an ad-hoc way by every project that wants to use it.

Let's make this process easier for users by creating a way to define a
useful sparse-checkout definition inside the Git tree data. This has
several benefits. In particular, the data is available to anyone who has
a copy of the repository without needing a different data source.
Second, the needs of the repository can change over time and Git can
present a way to automatically update the working directory as these
sparse-checkout definitions change over time.

When sitting down to design this feature, there were several possible
options.

The first option is to literally include files in the repository that
could replace the sparse-checkout file. This presents full generality
for the repository, but the sparse-checkout patterns may look strange to
a non-expert. While the general case could be useful to some, we are
actively working to make "cone mode" the generally accepted way to work
with sparse-checkout. In cone mode, the user selects a set of
directories to include and all matches are directory-based prefix
matches. This is much faster but also much easier to understand.

Another option would be to interpret a file as a list of necessary
directories. This would match the input to 'git sparse-checkout set'
and output of 'git sparse-checkout list' when in cone mode. However,
there are subtleties around custom data parsers that may not make this
the safest approach.

Both of the above options also suffer from a drawback that the file
format is too simple to allow for extensions in the future. For example,
in a repository with many dependent parts, changing a necessary
directory in a core component would require updating every in-tree
sparse-checkout definition. Since those files are likely very long, this
presents a lot of noise for users to handle as they update these
dependencies.

Instead, let's create a format that can easily be extended to satisfy
this need and any other needs we may want to add in the future. For this
reason, I selected the config file format for these in-tree
sparse-checkout definitions.

To use this feature, add the "--in-tree" option when setting or adding
directories to the sparse-checkout definition. For example:

  $ git sparse-checkout set --in-tree .sparse/base
  $ git sparse-checkout add --in-tree .sparse/extra

These commands add values to the multi-valued config setting
"sparse.inTree". When updating the sparse-checkout definition, these
values describe paths in the repository to find the sparse-checkout
data. After the commands listed earlier, we expect to see the following
in .git/config.worktree:

	[sparse]
		intree = .sparse/base
		intree = .sparse/extra

When applying the sparse-checkout definitions from this config, the
blobs at HEAD:.sparse/base and HEAD:.sparse/extra are loaded. In those
files, the multi-valued config values "sparse.dir" are considered as
the directories to construct a cone mode sparse-checkout file. The end
result is as if these paths were provided to "git sparse-checkout set"
in cone mode.

For example, suppose .sparse/base had the following content:

	[sparse]
		dir = A
		dir = B/C
		dir = D/E/F

and .sparse/extra had the following content:

	[sparse]
		dir = D
		dir = X

Then, the output of "git sparse-checkout list" would be

	A
	B/C
	D
	X

Note that since "D" contains "D/E/F", that directory replaces the
position of "D/E/F" in the list.

Since these are parsed using the config library, the parser is robust
enough to understand comments and complicated string values.

The key benefit to this approach is that it can be extended by defining
new config values. In a later change, we will introduce "sparse.inherit"
to point to another file in the tree. This will solve the problem of
editing many files when core dependencies change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt              |   2 +
 Documentation/config/sparse.txt       |  15 +++
 Documentation/git-sparse-checkout.txt |  43 ++++++++-
 builtin/sparse-checkout.c             |  43 +++++++++
 sparse-checkout.c                     | 128 +++++++++++++++++++++++++-
 sparse-checkout.h                     |  11 +++
 t/t1091-sparse-checkout-builtin.sh    | 101 ++++++++++++++++++++
 7 files changed, 337 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/config/sparse.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 08b13ba72be..40f44948229 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -435,6 +435,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sparse.txt[]
+
 include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
new file mode 100644
index 00000000000..c1fce87cd33
--- /dev/null
+++ b/Documentation/config/sparse.txt
@@ -0,0 +1,15 @@
+sparse.inTree::
+	The `core.sparseCheckout` config option enables the `sparse-checkout`
+	feature, but if there are any values for the multi-valued
+	`sparse.inTree` config option, then the sparse-checkout patterns are
+	defined by parsing the files listed in these values. See
+	linkgit:git-sparse-checkout[1] for more information.
+
+sparse.dir::
+	This config setting is ignored if present in the repository config.
+	Instead, this multi-valued option is present in the files listed by
+	`sparse.inTree` and specifies the directories needed in the
+	working directory. The union of all `sparse.dir` values across all
+	`sparse.inTree` files forms the input for `git sparse-checkout set`
+	in cone mode.  See linkgit:git-sparse-checkout[1] for more
+	information.
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 1a3ace60820..da9322c5e41 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -62,13 +62,20 @@ directories (recursively) as well as files that are siblings of ancestor
 directories. The input format matches the output of `git ls-tree --name-only`.
 This includes interpreting pathnames that begin with a double quote (") as
 C-style quoted strings.
++
+When the `--in-tree` option is provided, the paths provided are interpreted
+as files within the working directory that are used to construct the
+`sparse-checkout` patterns. See 'IN-TREE PATTERN SET' below.
 
 'add'::
 	Update the sparse-checkout file to include additional patterns.
 	By default, these patterns are read from the command-line arguments,
 	but they can be read from stdin using the `--stdin` option. When
 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
-	as directory names as in the 'set' subcommand.
+	as directory names as in the 'set' subcommand. When the `--in-tree`
+	option is provided, the input is interpreted as locations of files
+	describing a sparse-checkout definition as in the 'set' subcommand
+	and the 'IN-TREE PATTERN SET' section below.
 
 'reapply::
 	Reapply the sparsity pattern rules to paths in the working tree.
@@ -197,6 +204,40 @@ case-insensitive check. This corrects for case mismatched filenames in the
 directory.
 
 
+IN-TREE PATTERN SET
+-------------------
+
+As your project changes, your sparse-checkout pattern sets may also change.
+It is important to be able to construct a valid sparse-checkout pattern set
+when switching between points in history. The in-tree pattern sets allow
+versioning cone-mode sparse-checkout patterns next to your other artifacts.
+
+To enable the feature, create a sparse-checkout definition using the Git
+config format. The file should specify the multi-valued config variable
+`sparse.dir` to a list of directories to include in the sparse-checkout
+definition. If multiple files are specified, the resulting sparse-checkout
+definition is the union of all directories from all such files. For
+example, the following file contains a list of three directories, `A`,
+`B/C`, and `D/E/F`:
+
+----------------------------------
+[sparse]
+	dir = A
+	dir = B/C
+# Comments are allowed to describe
+# why a directory is necessary
+	dir = D/E/F
+----------------------------------
+
+Use `git sparse-checkout set --in-tree <path>` to initialize the patterns
+to those included in the file at `<path>`. This will override any existing
+patterns you have in your sparse-checkout file.
+
+After switching between commits with different versions of this file, run
+`git sparse-checkout reapply` to adjust the sparse-checkout patterns to
+the new definition.
+
+
 SUBMODULES
 ----------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fd247e428e4..621f1801c03 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -175,6 +175,7 @@ static char const * const builtin_sparse_checkout_set_usage[] = {
 
 static struct sparse_checkout_set_opts {
 	int use_stdin;
+	int in_tree;
 } set_opts;
 
 static void add_patterns_from_input(struct pattern_list *pl,
@@ -312,12 +313,52 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 	return result;
 }
 
+static int modify_in_tree_list(int argc, const char **argv, enum modify_type m)
+{
+	int result = 0;
+	int i;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+	struct pattern_list pl;
+
+	memset(&pl, 0, sizeof(pl));
+
+	switch(m) {
+	case ADD:
+		if (load_in_tree_list_from_config(the_repository, &sl))
+			return 1;
+		if (!sl.nr)
+			warning(_("the existing in-tree config has no entries; this overwrites the existing sparse-checkout definition."));
+		populate_sparse_checkout_patterns(&pl);
+		break;
+
+	case REPLACE:
+		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+		break;
+	}
+
+	for (i = 0; i < argc; i++)
+		string_list_insert(&sl, argv[i]);
+
+	if (load_in_tree_pattern_list(the_repository, &sl, &pl) ||
+	    set_sparse_in_tree_config(the_repository, &sl) ||
+	    write_patterns_and_update(&pl))
+		result = 1;
+
+	string_list_clear(&sl, 0);
+	clear_pattern_list(&pl);
+
+	return result;
+}
+
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			       enum modify_type m)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
 		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
 			 N_("read patterns from standard in")),
+		OPT_BOOL(0, "in-tree", &set_opts.in_tree,
+			 N_("define the sparse-checkout from files in the tree")),
 		OPT_END(),
 	};
 
@@ -328,6 +369,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	if (set_opts.in_tree)
+		return modify_in_tree_list(argc, argv, m);
 	return modify_pattern_list(argc, argv, m);
 }
 
diff --git a/sparse-checkout.c b/sparse-checkout.c
index 875b620568d..d6c27ca19c4 100644
--- a/sparse-checkout.c
+++ b/sparse-checkout.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "unpack-trees.h"
+#include "object-store.h"
 
 char *get_sparse_checkout_filename(void)
 {
@@ -33,14 +34,113 @@ void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
 	}
 }
 
+int load_in_tree_list_from_config(struct repository *r,
+				  struct string_list *sl)
+{
+	struct string_list_item *item;
+	const struct string_list *cl;
+
+	cl = repo_config_get_value_multi(r, SPARSE_CHECKOUT_IN_TREE);
+
+	if (!cl)
+		return 1;
+
+	for_each_string_list_item(item, cl)
+		string_list_insert(sl, item->string);
+
+	return 0;
+}
+
+static int sparse_dir_cb(const char *var, const char *value, void *data)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct pattern_list *pl = (struct pattern_list *)data;
+
+	if (!strcmp(var, SPARSE_CHECKOUT_DIR)) {
+		strbuf_addstr(&path, value);
+		strbuf_to_cone_pattern(&path, pl);
+		strbuf_release(&path);
+	}
+
+	return 0;
+}
+
+static int load_in_tree_from_blob(struct pattern_list *pl,
+				  struct object_id *oid)
+{
+	return git_config_from_blob_oid(sparse_dir_cb,
+					SPARSE_CHECKOUT_DIR,
+					oid, pl);
+}
+
+int load_in_tree_pattern_list(struct repository *r,
+			      struct string_list *sl,
+			      struct pattern_list *pl)
+{
+	struct index_state *istate = r->index;
+	struct string_list_item *item;
+	struct strbuf path = STRBUF_INIT;
+
+	pl->use_cone_patterns = 1;
+
+	for_each_string_list_item(item, sl) {
+		struct object_id *oid;
+		enum object_type type;
+		int pos = index_name_pos(istate, item->string, strlen(item->string));
+
+		/*
+		 * Exit silently, as this is likely the case where Git
+		 * changed branches to a location where the inherit file
+		 * does not exist. Do not update the sparse-checkout.
+		 */
+		if (pos < 0)
+			return 1;
+
+		oid = &istate->cache[pos]->oid;
+		type = oid_object_info(r, oid, NULL);
+
+		if (type != OBJ_BLOB) {
+			warning(_("expected a file at '%s'; not updating sparse-checkout"),
+				oid_to_hex(oid));
+			return 1;
+		}
+
+		load_in_tree_from_blob(pl, oid);
+	}
+
+	strbuf_release(&path);
+
+	return 0;
+}
+
 int populate_sparse_checkout_patterns(struct pattern_list *pl)
 {
 	int result;
-	char *sparse = get_sparse_checkout_filename();
-
-	pl->use_cone_patterns = core_sparse_checkout_cone;
-	result = add_patterns_from_file_to_list(sparse, "", 0, pl, NULL);
-	free(sparse);
+	const char *in_tree;
+
+	if (!git_config_get_value(SPARSE_CHECKOUT_IN_TREE, &in_tree) &&
+	    in_tree) {
+		struct string_list paths = STRING_LIST_INIT_DUP;
+		/* If we do not have this config, skip this step! */
+		if (load_in_tree_list_from_config(the_repository, &paths) ||
+		    !paths.nr)
+			return 1;
+
+		/* Check diff for paths over from/to. If any changed, reload. */
+		/* or for now, reload always! */
+		hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+		hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
+		pl->use_cone_patterns = 1;
+
+		result = load_in_tree_pattern_list(the_repository, &paths, pl);
+		string_list_clear(&paths, 0);
+	} else {
+		char *sparse = get_sparse_checkout_filename();
+
+		pl->use_cone_patterns = core_sparse_checkout_cone;
+		result = add_patterns_from_file_to_list(sparse, "", 0, pl, NULL);
+		free(sparse);
+	}
 
 	return result;
 }
@@ -243,3 +343,21 @@ void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 
 	insert_recursive_pattern(pl, line);
 }
+
+int set_sparse_in_tree_config(struct repository *r, struct string_list *sl)
+{
+	struct string_list_item *item;
+	const char *config_path = git_path("config.worktree");
+
+	/* clear existing values */
+	git_config_set_multivar_in_file_gently(config_path,
+					       SPARSE_CHECKOUT_IN_TREE,
+					       NULL, NULL, 1);
+
+	for_each_string_list_item(item, sl)
+		git_config_set_multivar_in_file_gently(
+			config_path, SPARSE_CHECKOUT_IN_TREE,
+			item->string, CONFIG_REGEX_NONE, 0);
+
+	return 0;
+}
diff --git a/sparse-checkout.h b/sparse-checkout.h
index e0c840f07f9..993a5701a60 100644
--- a/sparse-checkout.h
+++ b/sparse-checkout.h
@@ -4,14 +4,25 @@
 #include "cache.h"
 #include "repository.h"
 
+#define SPARSE_CHECKOUT_DIR "sparse.dir"
+#define SPARSE_CHECKOUT_IN_TREE "sparse.intree"
+
 struct pattern_list;
 
 char *get_sparse_checkout_filename(void);
 int populate_sparse_checkout_patterns(struct pattern_list *pl);
 void write_patterns_to_file(FILE *fp, struct pattern_list *pl);
 int update_working_directory(struct pattern_list *pl);
+int write_patterns(struct pattern_list *pl, int and_update);
 int write_patterns_and_update(struct pattern_list *pl);
 void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path);
 void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl);
 
+int load_in_tree_list_from_config(struct repository *r,
+				  struct string_list *sl);
+int load_in_tree_pattern_list(struct repository *r,
+			      struct string_list *sl,
+			      struct pattern_list *pl);
+int set_sparse_in_tree_config(struct repository *r, struct string_list *sl);
+
 #endif
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 88cdde255cd..1040bf9c261 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -604,4 +604,105 @@ test_expect_success MINGW 'cone mode replaces backslashes with slashes' '
 	check_files repo/deep a deeper1
 '
 
+test_expect_success 'basis of --in-tree' '
+	git -C repo config auto.crlf false &&
+	cat >folder1 <<-\EOF &&
+	[sparse]
+		dir = folder1
+	EOF
+	cat >folder2 <<-\EOF &&
+	[sparse]
+		dir = folder2
+	EOF
+	cat >deep <<-\EOF &&
+	[sparse]
+		dir = deep
+	EOF
+	cat >deeper1 <<-\EOF &&
+	[sparse]
+		dir = deep/deeper1
+	EOF
+	cat >sparse <<-\EOF &&
+	[sparse]
+		dir = .sparse
+	EOF
+	mkdir repo/.sparse &&
+	for file in folder1 folder2 deep deeper1 sparse
+	do
+		cp $file repo/.sparse/ || return 1
+	done &&
+	git -C repo add .sparse &&
+	git -C repo commit -m "Add sparse specifications" &&
+
+	git -C repo sparse-checkout set --in-tree .sparse/folder1 &&
+	check_files repo a folder1 &&
+	git -C repo config --get-all sparse.inTree >actual-config &&
+	echo .sparse/folder1 >expect-config &&
+	test_cmp expect-config actual-config &&
+	check_files repo a folder1 &&
+
+	git -C repo sparse-checkout set --in-tree .sparse/folder2 &&
+	git -C repo config --get-all sparse.inTree >actual-config &&
+	echo .sparse/folder2 >expect-config &&
+	test_cmp expect-config actual-config &&
+	check_files repo a folder2 &&
+
+	git -C repo sparse-checkout set --in-tree .sparse/deeper1 &&
+	git -C repo config --get-all sparse.inTree >actual-config &&
+	echo .sparse/deeper1 >expect-config &&
+	test_cmp expect-config actual-config &&
+	check_files repo a deep &&
+	check_files repo/deep a deeper1 &&
+
+	git -C repo sparse-checkout set --in-tree .sparse/deeper1 .sparse/deep .sparse/folder1 &&
+	check_files repo a deep folder1 &&
+	check_files repo/deep a deeper1 deeper2 &&
+	cat >expect-list <<-EOF &&
+	deep
+	folder1
+	EOF
+	git -C repo sparse-checkout list >actual-list &&
+	test_cmp expect-list actual-list &&
+
+	git -C repo sparse-checkout set --in-tree .sparse/folder1 .sparse/deeper1 &&
+	git -C repo config --get-all sparse.inTree >actual-config &&
+	cat >expect-config <<-\EOF &&
+	.sparse/deeper1
+	.sparse/folder1
+	EOF
+	test_cmp expect-config actual-config &&
+	check_files repo a deep folder1
+'
+
+test_expect_success '"add" with --in-tree' '
+	git -C repo sparse-checkout set --in-tree .sparse/folder1 &&
+	git -C repo config --get-all sparse.inTree >actual-config &&
+	echo .sparse/folder1 >expect-config &&
+	test_cmp expect-config actual-config &&
+	check_files repo a folder1 &&
+	git -C repo sparse-checkout add --in-tree .sparse/deeper1 &&
+	git -C repo config --get-all sparse.inTree >actual-config &&
+	cat >expect-config <<-\EOF &&
+	.sparse/deeper1
+	.sparse/folder1
+	EOF
+	test_cmp expect-config actual-config &&
+	check_files repo a deep folder1
+'
+
+test_expect_success 'reapply after updating in-tree file' '
+	git -C repo sparse-checkout set --in-tree .sparse/sparse &&
+	check_files repo a &&
+	test_path_is_dir repo/.sparse &&
+	echo "\tdir = folder1" >>repo/.sparse/sparse &&
+	git -C repo commit -a -m "Update sparse file" &&
+	git -C repo sparse-checkout reapply &&
+	check_files repo a folder1 &&
+	test_path_is_dir repo/.sparse &&
+	git -C repo checkout HEAD~1 &&
+	git -C repo sparse-checkout reapply &&
+	check_files repo a &&
+	test_path_is_dir repo/.sparse
+'
+
 test_done
-- 
gitgitgadget


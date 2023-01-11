Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B099FC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 17:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjAKRFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 12:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbjAKREq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 12:04:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56833F136
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 09:02:01 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m3so11585440wmq.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNcFaYDqdKTvr5xri+xzyiWyaMDgrv3u91zXlEuTz+E=;
        b=CSBlpC8LXskoJFfk9gzseWLc8tTPg9YwXqyKC/qoLwr4LznT/1RDhu9m7QXhZ9DYvr
         htLZiClzDsKLgFIlLQcqXONvcCReunJY/Hl5LZe+XIBzhUwve/0nBpw39uIx77SbMlRY
         GT+sZL23GqTCZ3zWsQCD8ao3JiKYKPuerHi9+kaZKwA52Cv9N5Jpg8Yr6IPQRSfR0MpC
         yr+2dLskKMPISBYPL9gCOV1++VwSYrGmzcz2XvxIZSgoFZ+exH3KcH7a2hhqREimGx3b
         Bl//TJWuBDmLSk9Uyaf8FebOUlEzaCOw0GT7mbnW+Ws/XVpjMucZQXnQubih3OFH72+b
         Xjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNcFaYDqdKTvr5xri+xzyiWyaMDgrv3u91zXlEuTz+E=;
        b=mgYrPnaKoh/yAMboTtQdQ5vxxDwqwA3OPBF0zZwPiOHd/gbipnnLIUxJoftANsYudH
         D0/JBpwUXJPdZ6okollvr6bCybe7JZmxdBG84lg+cu6GrVjbg+iwjVZXKGVkXy8qyRoy
         DIF4Hnog5fYeVcW3wEjDPa4RL6Lmxdlo8qx+CTWTo1OJSdhPNauW4Ez2OPCEmT35EJTy
         XaLVzbzCByAQpsp5qm07T5jqIGxLw7wfnGl/Qt0AbbSL8QqeLrMRx2/JjIAksTB8VpZ7
         1CqwY26Rezbsnlv+FTShqrpqoz1Kr06pfvtqctVcbw0n2EuWZJUS5l4Yl2qLN9dIusim
         nHNg==
X-Gm-Message-State: AFqh2kq2zNISAIkB7IjHkk81A0D4nUHkh2VoQ5Ff/zoD9arHS9v8f+1w
        HzfClBLWrZUU3Cqt69uJU/mnLZtTbsE=
X-Google-Smtp-Source: AMrXdXt4agsX9qYx8GVGKOtZK0O8KSCRx/yn4DApRjLVDQ7JHqRpK2v5Zj69YucrcfVG9zdgFAV9yQ==
X-Received: by 2002:a05:600c:4153:b0:3da:f0e:fe34 with SMTP id h19-20020a05600c415300b003da0f0efe34mr1499617wmm.32.1673456520082;
        Wed, 11 Jan 2023 09:02:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003d9b89a39b2sm21153359wms.10.2023.01.11.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:01:59 -0800 (PST)
Message-Id: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 17:01:58 +0000
Subject: [PATCH] ls-tree: add --sparse-filter-oid argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     William Sprent <williams@unity3d.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Sprent <williams@unity3d.com>

There is currently no way to ask git the question "which files would be
part of a sparse checkout of commit X with sparse checkout patterns Y".
One use-case would be that tooling may want know whether sparse checkouts
of two commits contain the same content even if the full trees differ.
Another interesting use-case would be for tooling to use in conjunction
with 'git update-index --index-info'.

'rev-list --objects --filter=sparse:oid' comes close, but as rev-list is
concerned with objects rather than directory trees, it leaves files out
when the same blob occurs in at two different paths.

It is possible to ask git about the sparse status of files currently in
the index with 'ls-files -t'. However, this does not work well when the
caller is interested in another commit, intererested in sparsity
patterns that aren't currently in '.git/info/sparse-checkout', or when
working in with bare repo.

To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
which takes the object id of a blob containing sparse checkout patterns
that filters the output of 'ls-tree'. When filtering with given sparsity
patterns, 'ls-tree' only outputs blobs and commit objects that
match the given patterns.

While it may be valid in some situations to output a tree object -- e.g.
when a cone pattern matches all blobs recursively contained in a tree --
it is less unclear what should be output if a sparse pattern matches
parts of a tree.

To allow for reusing the pattern matching logic found in
'path_in_sparse_checkout_1()' in 'dir.c' with arbitrary patterns,
extract the pattern matching part of the function into its own new
function 'recursively_match_path_with_sparse_patterns()'.

Signed-off-by: William Sprent <williams@unity3d.com>
---
    [RFC] ls-tree: add --sparse-filter-oid argument
    
    Hi,
    
    I found the need for being able to query git about the contents of
    sparse checkouts for arbitrary commits with arbitrary patterns from a
    bare repository. And it seems to me that ls-tree would be the best fit
    for answering those kinds of questions.
    
    I think it makes sense to have git be able to answer these kinds of
    questions, but I haven't been able to find any previous discussions
    about it. And 'sparse-checkout.txt' is mostly around working with the
    patterns in '.git/info/sparse-checkout'. So I figure this feature maybe
    needs a bit of discussion before landing.
    
    I'm also not very well versed in the code base, so please let me know if
    my approach here is off in general. :)
    
    Note that one of the tests only pass when run on top of commit
    5842710dc2 (dir: check for single file cone patterns, 2023-01-03), which
    was submitted separately and is currently is merged to 'next'.
    
    Thanks, William

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1459%2Fwilliams-unity%2Fls-tree-sparse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1459/williams-unity/ls-tree-sparse-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1459

 Documentation/git-ls-tree.txt      |   5 ++
 builtin/ls-tree.c                  |  87 +++++++++++++++++++++++-
 dir.c                              |  46 +++++++------
 dir.h                              |   5 ++
 t/t3106-ls-tree-sparse-checkout.sh | 103 +++++++++++++++++++++++++++++
 5 files changed, 224 insertions(+), 22 deletions(-)
 create mode 100755 t/t3106-ls-tree-sparse-checkout.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 0240adb8eec..69cbfb278eb 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -48,6 +48,11 @@ OPTIONS
 	Show tree entries even when going to recurse them. Has no effect
 	if `-r` was not passed. `-d` implies `-t`.
 
+--sparse-filter-oid=<blob-ish>::
+	Omit showing tree objects and paths that do not match the
+	sparse-checkout specification contained in the blob
+	(or blob-expression) <blob-ish>.
+
 -l::
 --long::
 	Show object size of blob (file) entries.
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281af..8f1fd5c26c2 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -7,12 +7,14 @@
 #include "config.h"
 #include "object-store.h"
 #include "blob.h"
+#include "repository.h"
 #include "tree.h"
 #include "commit.h"
 #include "quote.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "pathspec.h"
+#include "dir.h"
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
@@ -329,12 +331,79 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
 	},
 };
 
+struct sparse_filter_data {
+	read_tree_fn_t fn;
+	struct pattern_list pl;
+	struct strbuf full_path_buf;
+};
+
+static void sparse_filter_data__init(
+	struct sparse_filter_data **d,
+	const char *sparse_oid_name, read_tree_fn_t fn)
+{
+	struct object_id sparse_oid;
+	struct object_context oc;
+
+	(*d) = xcalloc(1, sizeof(**d));
+	(*d)->fn = fn;
+	(*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
+
+	strbuf_init(&(*d)->full_path_buf, 0);
+
+
+	if (get_oid_with_context(the_repository,
+				 sparse_oid_name,
+				 GET_OID_BLOB, &sparse_oid, &oc))
+		die(_("unable to access sparse blob in '%s'"), sparse_oid_name);
+	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &(*d)->pl) < 0)
+		die(_("unable to parse sparse filter data in %s"),
+		    oid_to_hex(&sparse_oid));
+}
+
+static void sparse_filter_data__free(struct sparse_filter_data *d)
+{
+	clear_pattern_list(&d->pl);
+	strbuf_release(&d->full_path_buf);
+	free(d);
+}
+
+static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
+{
+	enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
+	return match > 0;
+}
+
+
+static int filter_sparse(const struct object_id *oid, struct strbuf *base,
+			 const char *pathname, unsigned mode, void *context)
+{
+
+	struct sparse_filter_data *data = context;
+
+	int do_recurse = show_recursive(base->buf, base->len, pathname);
+	if (object_type(mode) == OBJ_TREE)
+		return do_recurse;
+
+	strbuf_reset(&data->full_path_buf);
+	strbuf_addbuf(&data->full_path_buf, base);
+	strbuf_addstr(&data->full_path_buf, pathname);
+
+	if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
+		return 0;
+
+	return data->fn(oid, base, pathname, mode, context);
+}
+
+
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
 	struct tree *tree;
-	int i, full_tree = 0;
+	int ret, i, full_tree = 0;
 	read_tree_fn_t fn = NULL;
+	char *sparse_oid_name = NULL;
+	void *read_tree_context = NULL;
+	struct sparse_filter_data *sparse_filter_data = NULL;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -360,6 +429,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_STRING_F(0, "format", &format, N_("format"),
 					 N_("format to use for the output"),
 					 PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "filter-sparse-oid", &sparse_oid_name, N_("filter-sparse-oid"),
+			   N_("filter output with sparse-checkout specification contained in the blob"),
+			     PARSE_OPT_NONEG),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -433,5 +505,16 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
+	if (sparse_oid_name) {
+		sparse_filter_data__init(&sparse_filter_data, sparse_oid_name, fn);
+		read_tree_context = sparse_filter_data;
+		fn = filter_sparse;
+	}
+
+	ret = !!read_tree(the_repository, tree, &pathspec, fn, read_tree_context);
+
+	if (sparse_filter_data)
+		sparse_filter_data__free(sparse_filter_data);
+
+	return ret;
 }
diff --git a/dir.c b/dir.c
index fbdb24fc819..cf1f843ceac 100644
--- a/dir.c
+++ b/dir.c
@@ -1450,45 +1450,51 @@ int init_sparse_checkout_patterns(struct index_state *istate)
 	return 0;
 }
 
-static int path_in_sparse_checkout_1(const char *path,
-				     struct index_state *istate,
-				     int require_cone_mode)
+int recursively_match_path_with_sparse_patterns(const char *path,
+						struct index_state *istate,
+						int dtype,
+						struct pattern_list *pl)
 {
-	int dtype = DT_REG;
 	enum pattern_match_result match = UNDECIDED;
 	const char *end, *slash;
-
-	/*
-	 * We default to accepting a path if the path is empty, there are no
-	 * patterns, or the patterns are of the wrong type.
-	 */
-	if (!*path ||
-	    init_sparse_checkout_patterns(istate) ||
-	    (require_cone_mode &&
-	     !istate->sparse_checkout_patterns->use_cone_patterns))
-		return 1;
-
 	/*
 	 * If UNDECIDED, use the match from the parent dir (recursively), or
 	 * fall back to NOT_MATCHED at the topmost level. Note that cone mode
 	 * never returns UNDECIDED, so we will execute only one iteration in
 	 * this case.
 	 */
-	for (end = path + strlen(path);
-	     end > path && match == UNDECIDED;
+	for (end = path + strlen(path); end > path && match == UNDECIDED;
 	     end = slash) {
-
 		for (slash = end - 1; slash > path && *slash != '/'; slash--)
 			; /* do nothing */
 
 		match = path_matches_pattern_list(path, end - path,
 				slash > path ? slash + 1 : path, &dtype,
-				istate->sparse_checkout_patterns, istate);
+				pl, istate);
 
 		/* We are going to match the parent dir now */
 		dtype = DT_DIR;
 	}
-	return match > 0;
+
+	return match;
+}
+
+static int path_in_sparse_checkout_1(const char *path,
+				     struct index_state *istate,
+				     int require_cone_mode)
+{
+
+	/*
+	 * We default to accepting a path if the path is empty, there are no
+	 * patterns, or the patterns are of the wrong type.
+	 */
+	if (!*path ||
+	    init_sparse_checkout_patterns(istate) ||
+	    (require_cone_mode &&
+	     !istate->sparse_checkout_patterns->use_cone_patterns))
+		return 1;
+
+	return recursively_match_path_with_sparse_patterns(path, istate, DT_REG, istate->sparse_checkout_patterns) > 0;
 }
 
 int path_in_sparse_checkout(const char *path,
diff --git a/dir.h b/dir.h
index 8acfc044181..d186d271606 100644
--- a/dir.h
+++ b/dir.h
@@ -403,6 +403,11 @@ int path_in_sparse_checkout(const char *path,
 int path_in_cone_mode_sparse_checkout(const char *path,
 				      struct index_state *istate);
 
+int recursively_match_path_with_sparse_patterns(const char *path,
+						struct index_state *istate,
+						int dtype,
+						struct pattern_list *pl);
+
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
 				  const char *pathname, int len);
diff --git a/t/t3106-ls-tree-sparse-checkout.sh b/t/t3106-ls-tree-sparse-checkout.sh
new file mode 100755
index 00000000000..d850950d651
--- /dev/null
+++ b/t/t3106-ls-tree-sparse-checkout.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='ls-tree with sparse filter patterns'
+
+. ./test-lib.sh
+
+check_agrees_with_ls_files () {
+	REPO=repo
+	git -C $REPO submodule deinit -f --all
+	git -C $REPO cat-file -p ${filter_oid} >${REPO}/.git/info/sparse-checkout
+	git -C $REPO sparse-checkout init --cone 2>err
+	git -C $REPO submodule init
+	git -C $REPO ls-files -t| grep -v "^S "|cut -d" " -f2 >ls-files
+	test_cmp ls-files actual
+}
+
+check_same_result_in_bare_repo () {
+	FULL=repo
+	BARE=bare
+	FILTER=$1
+	git -C repo cat-file -p ${filter_oid}| git -C bare hash-object -w --stdin
+	git -C bare ls-tree --name-only --filter-sparse-oid=${filter_oid} -r HEAD >bare-result
+	test_cmp expect bare-result
+}
+
+test_expect_success 'setup' '
+	git init submodule &&
+	(
+		cd submodule &&
+		test_commit file
+	) &&
+
+	git init repo &&
+	(
+		cd repo &&
+		mkdir dir &&
+		test_commit dir/sub-file &&
+		test_commit dir/sub-file2 &&
+		mkdir dir2 &&
+		test_commit dir2/sub-file1 &&
+		test_commit dir2/sub-file2 &&
+		test_commit top-file &&
+		git clone ../submodule submodule &&
+		git submodule add ./submodule &&
+		git submodule absorbgitdirs &&
+		git commit -m"add submodule" &&
+		git sparse-checkout init --cone
+	) &&
+	git clone --bare ./repo bare
+'
+
+test_expect_success 'toplevel filter only shows toplevel file' '
+	filter_oid=$(git -C repo hash-object -w --stdin <<-\EOF
+	/*
+	!/*/
+	EOF
+	) &&
+	cat >expect <<-EOF &&
+	.gitmodules
+	submodule
+	top-file.t
+	EOF
+	git -C repo ls-tree --name-only --filter-sparse-oid=${filter_oid} -r HEAD >actual &&
+	test_cmp expect actual &&
+	check_agrees_with_ls_files &&
+	check_same_result_in_bare_repo ${filter_oid}
+'
+
+test_expect_success 'non cone single file filter' '
+	filter_oid=$(git -C repo hash-object -w --stdin <<-\EOF
+	/dir/sub-file.t
+	EOF
+	) &&
+	cat >expect <<-EOF &&
+	dir/sub-file.t
+	EOF
+	git -C repo ls-tree --name-only --filter-sparse-oid=${filter_oid} -r HEAD >actual &&
+	test_cmp expect actual &&
+	check_agrees_with_ls_files &&
+	check_same_result_in_bare_repo ${filter_oid}
+'
+
+test_expect_success 'cone filter matching one dir' '
+	filter_oid=$(git -C repo hash-object -w --stdin <<-\EOF
+	/*
+	!/*/
+	/dir/
+	EOF
+	) &&
+	cat >expect <<-EOF &&
+	.gitmodules
+	dir/sub-file.t
+	dir/sub-file2.t
+	submodule
+	top-file.t
+	EOF
+	git -C repo ls-tree --name-only --filter-sparse-oid=${filter_oid} -r HEAD >actual &&
+	test_cmp expect actual &&
+	check_agrees_with_ls_files &&
+	check_same_result_in_bare_repo ${filter_oid}
+'
+
+test_done

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget

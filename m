Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2755C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 22:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCPW4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCPW4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 18:56:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889276164
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:56:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so7050784pjt.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679007403;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IE4W25XAP542TqKoiiVE4jMbmLAhE5zr3tgnHH1leKE=;
        b=HW8gxPDQ9/FDPfckBH+oqUIK+5CepuM+OyZp9rD5Qs/K5ZRH9kJza6AStKKP9DB7gc
         JhCQqkWrP2GorOr3uIyOoBXay6s7/ppp/c7Vxa4shfIKGO1xprRsjWO5Hx7SLHxTRFCf
         ZJTKl70I4YgK1GjKK1BmZDcNxJC/ZQOydXH8j5BOoxifJVJDwmmQirASkkJ37PSRlZTU
         M8m5ob4hPUtmtBS9aUdckXVyXJRfwCXVROcoQ+Btx1KbTcUdvBVqfQH3ZyZRtUePm9+t
         tcPobJRdr7KSthbZVI1Xe/VMbQLaq9270LtZqkfasCT76RUYtcsJZZLtN6GWSc0g1PB4
         H2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007403;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE4W25XAP542TqKoiiVE4jMbmLAhE5zr3tgnHH1leKE=;
        b=12r25ibWV4OemQv3tu9MR09c2TZNPxq+A4+FG6K6sqoZRmtpbQXoW5iypSQ3bRey4f
         7Tan38nUvXMYTQDyQ7pQZeXid5fviz+iTbnWWT7Bj0jWI41NwbDFq53NqXXBcHdLDfXM
         DIn8ggvlzMvuPp7SRzo3nGb6sQSCoBQUFgk0HnH22xD082pTGq/mbLH8SDpfmNO2cIwb
         +td+n7Znm9QNl/NLRZWCPXlGVS87sr/RNb0w18XI3HqZKZuPorvS6oPzupvelcb2Ih/2
         f7+eRjDDPBbQkcgN0iH/vycX5p6bs+rQ97cchip40qcQZT3kiiNX/yNkBia02CVF+SMH
         3nxw==
X-Gm-Message-State: AO0yUKXi+NpOtNMRCbA2WlqEv0Uc6B0IhqQ4WmOeINK4/ghWbr79RVew
        ceaMjzNBmQILNBnHhTv0u1AWM5kEH+4=
X-Google-Smtp-Source: AK7set9lG5E80axbHvvHbD7LNlkhB+t0D5gfhrPwz2n/+de3f5fZszV5povlDatOEuUn6T8kAD5NYA==
X-Received: by 2002:a17:903:18d:b0:19e:7f6f:8c32 with SMTP id z13-20020a170903018d00b0019e7f6f8c32mr6452093plg.48.1679007403305;
        Thu, 16 Mar 2023 15:56:43 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c19-20020a170902c1d300b00192d9b86318sm209612plc.137.2023.03.16.15.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 15:56:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: use HEAD for attributes when using bare
 repository
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
        <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
        <xmqqttynqnnj.fsf@gitster.g> <xmqqa60fqld6.fsf@gitster.g>
        <20230314193839.wevenngf324pijhb@pop-os> <xmqqy1nzoyqr.fsf@gitster.g>
        <9E479AA2-2D54-4CAF-899B-B25894B746AA@gmail.com>
Date:   Thu, 16 Mar 2023 15:56:42 -0700
Message-ID: <xmqqcz58i9ud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> Ah I see--in that case, what would be a good object to put this state into? Mabe
> repo_settings?

I personally think a global is good enough for a case like this.  It
is not like the code in the attribute subsystem is structured to
work in multiple repositories at the same time in the first place, so
in repo_settings, the_repository, or elsewhere is just as good as
having it in a plain old file-scope static, and even after moving it
into the_repository or something, the access will initially be done
by referring to the_repository global (which may not even exist by
the time "git --attr-source=<tree>" gets parsed), and not by plumbing
a "struct repository *" parameter through the callchain.

Another thing to note is that there needs a mechanism to convey the
tree object used to read the attributes from down to subprocesses,
e.g. exporting the GIT_ATTR_SOURCE environment variable and make Git
behave as if it saw the "git --attr-source=<tree>" option when such
an environment variable exists, or something.  Otherwise, the custom
attribute source would only take effect inside built-in commands.

In any case, here is what I have now, stealing some tests from your
patch.  I do not think I'll be working on it further at least for
now, so feel free to run with it.  I am not adding the "in a bare
repository, always read from HEAD unless told otherwise", as I do
not see a good way to countermand it from a command line.

----- >8 ----- cut here ----- >8 ----- cut here ----- >8 -----
Subject: [PATCH] attr: teach "--attr-source=<tree>" global option to "git"

Earlier, 47cfc9bd (attr: add flag `--source` to work with tree-ish,
2023-01-14) taught "git check-attr" the "--source=<tree>" option to
allow it to read attribute files from a tree-ish, but did so only
for the command.  Just like "check-attr" users wanted a way to use
attributes from a tree-ish and not from the working tree files,
users of other commands (like "git diff") would benefit from the
same.

Undo most of the UI change the commit made, while keeping the
internal logic to read attributes from a given tree-ish.  Expose the
internal logic via a new "--attr-source=<tree>" command line option
given to "git", so that it can be used with any git command that
runs internally.

The tests were stolen and adjusted from John Cai's effort where only
"git diff" learned the "--attr-source" option to read from a
tree-ish.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive.c                 |  2 +-
 attr.c                    | 34 ++++++++++++++++++++++++++++++++--
 attr.h                    | 13 +++++++++----
 builtin/check-attr.c      | 17 ++++++++---------
 builtin/pack-objects.c    |  2 +-
 convert.c                 |  2 +-
 git.c                     |  3 +++
 ll-merge.c                |  4 ++--
 pathspec.c                |  2 +-
 t/lib-diff-alternative.sh | 31 ++++++++++++++++++++++++++-----
 t/t0003-attributes.sh     |  7 ++++++-
 t/t4018-diff-funcname.sh  | 19 +++++++++++++++++++
 userdiff.c                |  2 +-
 ws.c                      |  2 +-
 14 files changed, 111 insertions(+), 29 deletions(-)

diff --git c/archive.c w/archive.c
index 9aeaf2bd87..385aa5f248 100644
--- c/archive.c
+++ w/archive.c
@@ -120,7 +120,7 @@ static const struct attr_check *get_archive_attrs(struct index_state *istate,
 	static struct attr_check *check;
 	if (!check)
 		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	return check;
 }
 
diff --git c/attr.c w/attr.c
index 1053dfcd4b..d34c7e9d54 100644
--- c/attr.c
+++ w/attr.c
@@ -1165,11 +1165,40 @@ static void collect_some_attrs(struct index_state *istate,
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
+static const char *default_attr_source_tree_object_name;
+
+void set_git_attr_source(const char *tree_object_name)
+{
+	default_attr_source_tree_object_name = xstrdup(tree_object_name);
+}
+
+
+static void compute_default_attr_source(struct object_id *attr_source)
+{
+	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
+		return;
+
+	if (get_oid_treeish(default_attr_source_tree_object_name, attr_source))
+		die(_("bad --attr-source object"));
+}
+
+static struct object_id *default_attr_source(void)
+{
+	static struct object_id attr_source;
+
+	if (is_null_oid(&attr_source))
+		compute_default_attr_source(&attr_source);
+	if (is_null_oid(&attr_source))
+		return NULL;
+	return &attr_source;
+}
+
 void git_check_attr(struct index_state *istate,
-		    const struct object_id *tree_oid, const char *path,
+		    const char *path,
 		    struct attr_check *check)
 {
 	int i;
+	const struct object_id *tree_oid = default_attr_source();
 
 	collect_some_attrs(istate, tree_oid, path, check);
 
@@ -1182,10 +1211,11 @@ void git_check_attr(struct index_state *istate,
 	}
 }
 
-void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
+void git_all_attrs(struct index_state *istate,
 		   const char *path, struct attr_check *check)
 {
 	int i;
+	const struct object_id *tree_oid = default_attr_source();
 
 	attr_check_reset(check);
 	collect_some_attrs(istate, tree_oid, path, check);
diff --git c/attr.h w/attr.h
index 9884ea2bc6..676bd17ce2 100644
--- c/attr.h
+++ w/attr.h
@@ -45,7 +45,7 @@
  * const char *path;
  *
  * setup_check();
- * git_check_attr(&the_index, tree_oid, path, check);
+ * git_check_attr(&the_index, path, check);
  * ------------
  *
  * - Act on `.value` member of the result, left in `check->items[]`:
@@ -120,7 +120,6 @@
 #define ATTR_MAX_FILE_SIZE (100 * 1024 * 1024)
 
 struct index_state;
-struct object_id;
 
 /**
  * An attribute is an opaque object that is identified by its name. Pass the
@@ -135,6 +134,12 @@ struct git_attr;
 struct all_attrs_item;
 struct attr_stack;
 
+/*
+ * The textual object name for the tree-ish used by git_check_attr()
+ * to read attributes from (instead of from the working tree).
+ */
+void set_git_attr_source(const char *);
+
 /*
  * Given a string, return the gitattribute object that
  * corresponds to it.
@@ -203,14 +208,14 @@ void attr_check_free(struct attr_check *check);
 const char *git_attr_name(const struct git_attr *);
 
 void git_check_attr(struct index_state *istate,
-		    const struct object_id *tree_oid, const char *path,
+		    const char *path,
 		    struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
+void git_all_attrs(struct index_state *istate,
 		   const char *path, struct attr_check *check);
 
 enum git_attr_direction {
diff --git c/builtin/check-attr.c w/builtin/check-attr.c
index d7a40e674c..1a7929c980 100644
--- c/builtin/check-attr.c
+++ w/builtin/check-attr.c
@@ -58,7 +58,7 @@ static void output_attr(struct attr_check *check, const char *file)
 }
 
 static void check_attr(const char *prefix, struct attr_check *check,
-		       const struct object_id *tree_oid, int collect_all,
+		       int collect_all,
 		       const char *file)
 
 {
@@ -66,9 +66,9 @@ static void check_attr(const char *prefix, struct attr_check *check,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(&the_index, tree_oid, full_path, check);
+		git_all_attrs(&the_index, full_path, check);
 	} else {
-		git_check_attr(&the_index, tree_oid, full_path, check);
+		git_check_attr(&the_index, full_path, check);
 	}
 	output_attr(check, file);
 
@@ -76,7 +76,7 @@ static void check_attr(const char *prefix, struct attr_check *check,
 }
 
 static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
-				   const struct object_id *tree_oid, int collect_all)
+				   int collect_all)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -90,7 +90,7 @@ static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, check, tree_oid, collect_all, buf.buf);
+		check_attr(prefix, check, collect_all, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -106,7 +106,6 @@ static NORETURN void error_with_usage(const char *msg)
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct attr_check *check;
-	struct object_id *tree_oid = NULL;
 	struct object_id initialized_oid;
 	int cnt, i, doubledash, filei;
 
@@ -182,14 +181,14 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (source) {
 		if (repo_get_oid_tree(the_repository, source, &initialized_oid))
 			die("%s: not a valid tree-ish source", source);
-		tree_oid = &initialized_oid;
+		set_git_attr_source(source);
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, check, tree_oid, all_attrs);
+		check_attr_stdin_paths(prefix, check, all_attrs);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, check, tree_oid, all_attrs, argv[i]);
+			check_attr(prefix, check, all_attrs, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 
diff --git c/builtin/pack-objects.c w/builtin/pack-objects.c
index 74a167a180..d561541b8c 100644
--- c/builtin/pack-objects.c
+++ w/builtin/pack-objects.c
@@ -1320,7 +1320,7 @@ static int no_try_delta(const char *path)
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
-	git_check_attr(the_repository->index, NULL, path, check);
+	git_check_attr(the_repository->index, path, check);
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
 	return 0;
diff --git c/convert.c w/convert.c
index a54d1690c0..9b67649032 100644
--- c/convert.c
+++ w/convert.c
@@ -1308,7 +1308,7 @@ void convert_attrs(struct index_state *istate,
 		git_config(read_convert_config, NULL);
 	}
 
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	ccheck = check->items;
 	ca->crlf_action = git_path_check_crlf(ccheck + 4);
 	if (ca->crlf_action == CRLF_UNDEFINED)
diff --git c/git.c w/git.c
index 6171fd6769..21bddc5718 100644
--- c/git.c
+++ w/git.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "run-command.h"
 #include "alias.h"
+#include "attr.h"
 #include "shallow.h"
 
 #define RUN_SETUP		(1<<0)
@@ -307,6 +308,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			} else {
 				exit(list_cmds(cmd));
 			}
+		} else if (skip_prefix(cmd, "--attr-source=", &cmd)) {
+			set_git_attr_source(cmd);
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git c/ll-merge.c w/ll-merge.c
index 130d26501c..22a603e8af 100644
--- c/ll-merge.c
+++ w/ll-merge.c
@@ -391,7 +391,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 		normalize_file(theirs, path, istate);
 	}
 
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
 		marker_size = atoi(check->items[1].value);
@@ -419,7 +419,7 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 
 	if (!check)
 		check = attr_check_initl("conflict-marker-size", NULL);
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 	if (check->items[0].value) {
 		marker_size = atoi(check->items[0].value);
 		if (marker_size <= 0)
diff --git c/pathspec.c w/pathspec.c
index ab70fcbe61..74e02c75fc 100644
--- c/pathspec.c
+++ w/pathspec.c
@@ -730,7 +730,7 @@ int match_pathspec_attrs(struct index_state *istate,
 	if (name[namelen])
 		name = to_free = xmemdupz(name, namelen);
 
-	git_check_attr(istate, NULL, name, item->attr_check);
+	git_check_attr(istate, name, item->attr_check);
 
 	free(to_free);
 
diff --git c/t/lib-diff-alternative.sh w/t/lib-diff-alternative.sh
index a8f5d3274a..02381eb7f1 100644
--- c/t/lib-diff-alternative.sh
+++ w/t/lib-diff-alternative.sh
@@ -112,15 +112,36 @@ EOF
 
 	STRATEGY=$1
 
-	test_expect_success "$STRATEGY diff from attributes" '
+	test_expect_success "setup attributes files for tests with $STRATEGY" '
+		git checkout -b master &&
 		echo "file* diff=driver" >.gitattributes &&
-		git config diff.driver.algorithm "$STRATEGY" &&
-		test_must_fail git diff --no-index file1 file2 > output &&
-		cat expect &&
-		cat output &&
+		git add file1 file2 .gitattributes &&
+		git commit -m "adding files" &&
+		git checkout -b branchA &&
+		echo "file* diff=driverA" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -m "adding driverA as diff driver" &&
+		git checkout master &&
+		git clone --bare --no-local . bare.git
+	'
+
+	test_expect_success "$STRATEGY diff from attributes" '
+		test_must_fail git -c diff.driver.algorithm=$STRATEGY diff --no-index file1 file2 > output &&
 		test_cmp expect output
 	'
 
+	test_expect_success "diff from attributes with bare repo when branch different than HEAD" '
+		git -C bare.git --attr-source=branchA -c diff.driver.algorithm=myers \
+			-c diff.driverA.algorithm=$STRATEGY \
+			diff HEAD:file1 HEAD:file2 >output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "diff from attributes with bare repo with invalid source" '
+		test_must_fail git -C bare.git --attr-source=invalid-branch diff \
+			HEAD:file1 HEAD:file2
+	'
+
 	test_expect_success "$STRATEGY diff from attributes has valid diffstat" '
 		echo "file* diff=driver" >.gitattributes &&
 		git config diff.driver.algorithm "$STRATEGY" &&
diff --git c/t/t0003-attributes.sh w/t/t0003-attributes.sh
index 89b306cb11..73db37a7f3 100755
--- c/t/t0003-attributes.sh
+++ w/t/t0003-attributes.sh
@@ -30,8 +30,13 @@ attr_check_quote () {
 attr_check_source () {
 	path="$1" expect="$2" source="$3" git_opts="$4" &&
 
-	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
 	echo "$path: test: $expect" >expect &&
+
+	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err &&
+
+	git $git_opts --attr-source="$source" check-attr test -- "$path" >actual 2>err &&
 	test_cmp expect actual &&
 	test_must_be_empty err
 }
diff --git c/t/t4018-diff-funcname.sh w/t/t4018-diff-funcname.sh
index 42a2b9a13b..c8d555771d 100755
--- c/t/t4018-diff-funcname.sh
+++ w/t/t4018-diff-funcname.sh
@@ -63,6 +63,25 @@ do
 		test_i18ngrep ! fatal msg &&
 		test_i18ngrep ! error msg
 	'
+
+	test_expect_success "builtin $p pattern compiles on bare repo with --attr-source" '
+		test_when_finished "rm -rf bare.git" &&
+		git checkout -B master &&
+		git add . &&
+		echo "*.java diff=notexist" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -am "changing gitattributes" &&
+		git checkout -B branchA &&
+		echo "*.java diff=$p" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -am "changing gitattributes" &&
+		git clone --bare --no-local . bare.git &&
+		git -C bare.git symbolic-ref HEAD refs/heads/master &&
+		test_expect_code 1 git -C bare.git --attr-source=branchA \
+			diff --exit-code HEAD:A.java HEAD:B.java 2>msg &&
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
+	'
 done
 
 test_expect_success 'last regexp must not be negated' '
diff --git c/userdiff.c w/userdiff.c
index 58a3d59ef8..156660eaca 100644
--- c/userdiff.c
+++ w/userdiff.c
@@ -415,7 +415,7 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 		check = attr_check_initl("diff", NULL);
 	if (!path)
 		return NULL;
-	git_check_attr(istate, NULL, path, check);
+	git_check_attr(istate, path, check);
 
 	if (ATTR_TRUE(check->items[0].value))
 		return &driver_true;
diff --git c/ws.c w/ws.c
index da3d0e28cb..903bfcd53e 100644
--- c/ws.c
+++ w/ws.c
@@ -79,7 +79,7 @@ unsigned whitespace_rule(struct index_state *istate, const char *pathname)
 	if (!attr_whitespace_rule)
 		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	git_check_attr(istate, NULL, pathname, attr_whitespace_rule);
+	git_check_attr(istate, pathname, attr_whitespace_rule);
 	value = attr_whitespace_rule->items[0].value;
 	if (ATTR_TRUE(value)) {
 		/* true (whitespace) */

Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A104C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1E620936
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2ELrmLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIPCJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgIPCJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 22:09:25 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361DAC061788
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id b13so2796350qvl.2
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3GkaB3U0fkyFxwRPtK0wnejfYC7QOOh5EhGZhYoi1M=;
        b=Y2ELrmLhY9ch4sJZsY0K6V9/6eRUuwo6d4afr/THC5QuBSUWkzxR/ge1FycmWkxouM
         liTTXID/xQurN6lf2mE75CRt95KyVOZ8LaUkyxJGTWB3Np1SEx0RQ3YVGOCPuWT0r9V/
         gvkjeGboCpjHPuMaULB9n7hwE/XnsO7hIOv79Md0+mj40sGiE1FxcmHpSDaA3db8YAIT
         vLtK7g+B2E9z6smYi3McnSVu6+LGCWeIvmJ4uj530FxYF/lms1IK9YQNpJ0L5HNToHpi
         4fGqPznMDejH6mzLXNVmdfUh7QOTXAl7yjA0rMx33OhU+CxrsJ2lzT2zDtfU1De2SKj4
         vTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3GkaB3U0fkyFxwRPtK0wnejfYC7QOOh5EhGZhYoi1M=;
        b=DrKkMV22eiwhsYgRMWnb93pwD44u5oiOCGDQUIMcEQ/4xpLebYJ/h1Bd9ivEi2qSUv
         sB0IQlDg2dmfQrBENKD/6e5V86UYfk2xobB4pBtgaDWK8C7eg3JLcdmctzWCne8Ehor0
         50Z8AKLOIY6UeGFeylkjZw4po2KwBZO8dMSrI+8R7HIWxNDgNB6t4+C0pR8fYx0EdquP
         FzDf8502jfjMkYdkE/NtUO7s/H1f+yNkFs+YqorA/poxEQKOtD+weQ8TYlpnEV5i0sAi
         egyMZVZdj9R/wnzZKOMuJ5h/VjZDJlTAXEqXFEQv7Bwd87v3UZsaFCBpzlcvxUdHhlMV
         MT+Q==
X-Gm-Message-State: AOAM533UGdym6seXnobjiRvPOnK5bEHYvAu8GWlctoVK0vdUbn7Q+315
        YborgbBekwQRFWTr3h2PwYVyvGZTE56WG7CQ
X-Google-Smtp-Source: ABdhPJxxzIMLuT5gWneBGDDlMaUG/qO1ZgosJKRMD2Z6GWI9Nwt/vafnWHgBnR4Z+3lRmCuiMY3RNw==
X-Received: by 2002:a0c:c543:: with SMTP id y3mr4651630qvi.47.1600222163126;
        Tue, 15 Sep 2020 19:09:23 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id k52sm19380373qtc.56.2020.09.15.19.09.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 19:09:22 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v4 3/3] ref-filter: allow merged and no-merged filters
Date:   Tue, 15 Sep 2020 22:08:40 -0400
Message-Id: <20200916020840.84892-4-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200916020840.84892-1-alipman88@gmail.com>
References: <20200913193140.66906-1-alipman88@gmail.com>
 <20200916020840.84892-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable ref-filter to process multiple merged and no-merged filters, and
extend functionality to git branch, git tag and git for-each-ref. This
provides an easy way to check for branches that are "graduation
candidates:"

$ git branch --no-merged master --merged next

If passed more than one merged (or more than one no-merged) filter, refs
must be reachable from any one of the merged commits, and reachable from
none of the no-merged commits.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 Documentation/filters.txt          |  4 ++
 Documentation/git-branch.txt       |  8 ++--
 Documentation/git-for-each-ref.txt |  8 ++--
 Documentation/git-tag.txt          |  6 +--
 builtin/branch.c                   |  6 +--
 builtin/for-each-ref.c             |  2 +-
 builtin/tag.c                      |  8 ++--
 ref-filter.c                       | 64 ++++++++++++++++--------------
 ref-filter.h                       | 12 +++---
 t/t3200-branch.sh                  |  4 --
 t/t3201-branch-contains.sh         | 27 +++++++++++++
 t/t6302-for-each-ref-filter.sh     |  4 +-
 t/t7004-tag.sh                     |  4 +-
 13 files changed, 92 insertions(+), 65 deletions(-)

diff --git a/Documentation/filters.txt b/Documentation/filters.txt
index 4ee17afc01..9bae46d84c 100644
--- a/Documentation/filters.txt
+++ b/Documentation/filters.txt
@@ -1,3 +1,7 @@
 When combining multiple `--contains` and `--no-contains` filters, only
 references that contain at least one of the `--contains` commits and
 contain none of the `--no-contains` commits are shown.
+
+When combining multiple `--merged` and `--no-merged` filters, only
+references that are reachable from at least one of the `--merged`
+commits and from none of the `--no-merged` commits are shown.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index aa5e4da142..290b90639c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git branch' [--color[=<when>] | --no-color] [--show-current]
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column] [--sort=<key>]
-	[(--merged | --no-merged) [<commit>]]
+	[--merged [<commit>]] [--no-merged [<commit>]]
 	[--contains [<commit>]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
@@ -252,13 +252,11 @@ start-point is either a local or remote-tracking branch.
 
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
-	specified commit (HEAD if not specified). Implies `--list`,
-	incompatible with `--no-merged`.
+	specified commit (HEAD if not specified). Implies `--list`.
 
 --no-merged [<commit>]::
 	Only list branches whose tips are not reachable from the
-	specified commit (HEAD if not specified). Implies `--list`,
-	incompatible with `--merged`.
+	specified commit (HEAD if not specified). Implies `--list`.
 
 <branchname>::
 	The name of the branch to create or delete.
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c207ed9551..7b9cf0ef1f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
 		   [--points-at=<object>]
-		   (--merged[=<object>] | --no-merged[=<object>])
+		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 
 DESCRIPTION
@@ -76,13 +76,11 @@ OPTIONS
 
 --merged[=<object>]::
 	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified),
-	incompatible with `--no-merged`.
+	specified commit (HEAD if not specified).
 
 --no-merged[=<object>]::
 	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified),
-	incompatible with `--merged`.
+	specified commit (HEAD if not specified).
 
 --contains[=<object>]::
 	Only list refs which contain the specified commit (HEAD if not
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index dadbd71d62..cc667d7d01 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
 	[--points-at <object>] [--column[=<options>] | --no-column]
 	[--create-reflog] [--sort=<key>] [--format=<format>]
-	[--[no-]merged [<commit>]] [<pattern>...]
+	[--merged <commit>] [--no-merged <commit>] [<pattern>...]
 'git tag' -v [--format=<format>] <tagname>...
 
 DESCRIPTION
@@ -149,11 +149,11 @@ This option is only applicable when listing tags without annotation lines.
 
 --merged [<commit>]::
 	Only list tags whose commits are reachable from the specified
-	commit (`HEAD` if not specified), incompatible with `--no-merged`.
+	commit (`HEAD` if not specified).
 
 --no-merged [<commit>]::
 	Only list tags whose commits are not reachable from the specified
-	commit (`HEAD` if not specified), incompatible with `--merged`.
+	commit (`HEAD` if not specified).
 
 --points-at <object>::
 	Only list tags of the given object (HEAD if not
diff --git a/builtin/branch.c b/builtin/branch.c
index e82301fb1b..efb30b8820 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,7 +26,7 @@
 #include "commit-reach.h"
 
 static const char * const builtin_branch_usage[] = {
-	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
+	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
@@ -688,8 +688,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    !show_current && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
-	    filter.no_commit)
+	if (filter.with_commit || filter.no_commit ||
+	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 57489e4eab..9d1ecda2b8 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,7 +9,7 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
-	N_("git for-each-ref [(--merged | --no-merged) [<commit>]]"),
+	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
 	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
 	NULL
 };
diff --git a/builtin/tag.c b/builtin/tag.c
index 5cbd80dc3e..ecf011776d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -26,7 +26,7 @@ static const char * const git_tag_usage[] = {
 		"\t\t<tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
-		"\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
+		"\t\t[--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
 	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
@@ -457,8 +457,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		if (argc == 0)
 			cmdmode = 'l';
 		else if (filter.with_commit || filter.no_commit ||
-			 filter.points_at.nr || filter.merge_commit ||
-			 filter.lines != -1)
+			 filter.reachable_from || filter.unreachable_from ||
+			 filter.points_at.nr || filter.lines != -1)
 			cmdmode = 'l';
 	}
 
@@ -509,7 +509,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("--no-contains option is only allowed in list mode"));
 	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed in list mode"));
-	if (filter.merge_commit)
+	if (filter.reachable_from || filter.unreachable_from)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag, NULL);
diff --git a/ref-filter.c b/ref-filter.c
index 110bcd741a..785785a757 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2167,9 +2167,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * obtain the commit using the 'oid' available and discard all
 	 * non-commits early. The actual filtering is done later.
 	 */
-	if (filter->merge_commit || filter->with_commit || filter->no_commit || filter->verbose) {
-		commit = lookup_commit_reference_gently(the_repository, oid,
-							1);
+	if (filter->reachable_from || filter->unreachable_from ||
+	    filter->with_commit || filter->no_commit || filter->verbose) {
+		commit = lookup_commit_reference_gently(the_repository, oid, 1);
 		if (!commit)
 			return 0;
 		/* We perform the filtering for the '--contains' option... */
@@ -2231,13 +2231,20 @@ void ref_array_clear(struct ref_array *array)
 	}
 }
 
-static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
+static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
 {
 	struct rev_info revs;
 	int i, old_nr;
-	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array *array = ref_cbdata->array;
 	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
+	struct commit_list *rl;
+
+	struct commit_list *check_reachable_list = reachable ?
+		ref_cbdata->filter->reachable_from :
+		ref_cbdata->filter->unreachable_from;
+
+	if (!check_reachable_list)
+		return;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 
@@ -2247,8 +2254,11 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 		to_clear[i] = item->commit;
 	}
 
-	filter->merge_commit->object.flags |= UNINTERESTING;
-	add_pending_object(&revs, &filter->merge_commit->object, "");
+	for (rl = check_reachable_list; rl; rl = rl->next) {
+		struct commit *merge_commit = rl->item;
+		merge_commit->object.flags |= UNINTERESTING;
+		add_pending_object(&revs, &merge_commit->object, "");
+	}
 
 	revs.limited = 1;
 	if (prepare_revision_walk(&revs))
@@ -2263,14 +2273,19 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 
 		int is_merged = !!(commit->object.flags & UNINTERESTING);
 
-		if (is_merged == (filter->merge == REF_FILTER_MERGED_INCLUDE))
+		if (is_merged == reachable)
 			array->items[array->nr++] = array->items[i];
 		else
 			free_array_item(item);
 	}
 
 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
-	clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
+
+	while (check_reachable_list) {
+		struct commit *merge_commit = pop_commit(&check_reachable_list);
+		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
+	}
+
 	free(to_clear);
 }
 
@@ -2322,8 +2337,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	clear_contains_cache(&ref_cbdata.no_contains_cache);
 
 	/*  Filters that need revision walking */
-	if (filter->merge_commit)
-		do_merge_filter(&ref_cbdata);
+	do_merge_filter(&ref_cbdata, DO_MERGE_FILTER_REACHABLE);
+	do_merge_filter(&ref_cbdata, DO_MERGE_FILTER_UNREACHABLE);
 
 	return ret;
 }
@@ -2541,31 +2556,22 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_filter *rf = opt->value;
 	struct object_id oid;
-	int no_merged = starts_with(opt->long_name, "no");
+	struct commit *merge_commit;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (rf->merge) {
-		if (no_merged) {
-			return error(_("option `%s' is incompatible with --merged"),
-				     opt->long_name);
-		} else {
-			return error(_("option `%s' is incompatible with --no-merged"),
-				     opt->long_name);
-		}
-	}
-
-	rf->merge = no_merged
-		? REF_FILTER_MERGED_OMIT
-		: REF_FILTER_MERGED_INCLUDE;
-
 	if (get_oid(arg, &oid))
 		die(_("malformed object name %s"), arg);
 
-	rf->merge_commit = lookup_commit_reference_gently(the_repository,
-							  &oid, 0);
-	if (!rf->merge_commit)
+	merge_commit = lookup_commit_reference_gently(the_repository, &oid, 0);
+
+	if (!merge_commit)
 		return error(_("option `%s' must point to a commit"), opt->long_name);
 
+	if (starts_with(opt->long_name, "no"))
+		commit_list_insert(merge_commit, &rf->unreachable_from);
+	else
+		commit_list_insert(merge_commit, &rf->reachable_from);
+
 	return 0;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 8ecc33cdfa..2d13928455 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -23,6 +23,9 @@
 #define FILTER_REFS_DETACHED_HEAD  0x0020
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
+#define DO_MERGE_FILTER_UNREACHABLE 0
+#define DO_MERGE_FILTER_REACHABLE   1
+
 struct atom_value;
 
 struct ref_sorting {
@@ -54,13 +57,8 @@ struct ref_filter {
 	struct oid_array points_at;
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
-
-	enum {
-		REF_FILTER_MERGED_NONE = 0,
-		REF_FILTER_MERGED_INCLUDE,
-		REF_FILTER_MERGED_OMIT
-	} merge;
-	struct commit *merge_commit;
+	struct commit_list *reachable_from;
+	struct commit_list *unreachable_from;
 
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 028c88d1b2..c24c6632ee 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1299,10 +1299,6 @@ test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
 '
 
-test_expect_success '--merged is incompatible with --no-merged' '
-	test_must_fail git branch --merged HEAD --no-merged HEAD
-'
-
 test_expect_success '--list during rebase' '
 	test_when_finished "reset_rebase" &&
 	git checkout master &&
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 3cb9dc6cca..efea5c4971 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -187,6 +187,16 @@ test_expect_success 'multiple branch --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'multiple branch --merged' '
+	git branch --merged next --merged master >actual &&
+	cat >expect <<-\EOF &&
+	  master
+	* next
+	  side
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'multiple branch --no-contains' '
 	git branch --no-contains side --no-contains side2 >actual &&
 	cat >expect <<-\EOF &&
@@ -195,6 +205,14 @@ test_expect_success 'multiple branch --no-contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'multiple branch --no-merged' '
+	git branch --no-merged next --no-merged master >actual &&
+	cat >expect <<-\EOF &&
+	  side2
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'branch --contains combined with --no-contains' '
 	git checkout -b seen master &&
 	git merge side &&
@@ -207,6 +225,15 @@ test_expect_success 'branch --contains combined with --no-contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branch --merged combined with --no-merged' '
+	git branch --merged seen --no-merged next >actual &&
+	cat >expect <<-\EOF &&
+	* seen
+	  side2
+	EOF
+	test_cmp expect actual
+'
+
 # We want to set up a case where the walk for the tracking info
 # of one branch crosses the tip of another branch (and make sure
 # that the latter walk does not mess up our flag to see if it was
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 35408d53fd..781e470aea 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -437,8 +437,8 @@ test_expect_success 'check %(if:notequals=<string>)' '
 	test_cmp expect actual
 '
 
-test_expect_success '--merged is incompatible with --no-merged' '
-	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
+test_expect_success '--merged is compatible with --no-merged' '
+	git for-each-ref --merged HEAD --no-merged HEAD
 '
 
 test_expect_success 'validate worktree atom' '
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 74b637deb2..05f411c821 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2015,8 +2015,8 @@ test_expect_success '--merged can be used in non-list mode' '
 	test_cmp expect actual
 '
 
-test_expect_success '--merged is incompatible with --no-merged' '
-	test_must_fail git tag --merged HEAD --no-merged HEAD
+test_expect_success '--merged is compatible with --no-merged' '
+	git tag --merged HEAD --no-merged HEAD
 '
 
 test_expect_success '--merged shows merged tags' '
-- 
2.24.3 (Apple Git-128)


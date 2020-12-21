Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C7FC4332E
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139C022C9C
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgLUSHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgLUSHH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:07:07 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE83C061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:06:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x20so25740659lfe.12
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmxRbRd4hR23BKZFFXUTSpS56FI59Xo3Tn7rG9ylEcw=;
        b=fVlpA6xRGGVEmyXNMPizczBKz6Q+fhRw2l/T1VdLBz/ZHu7Dzrfc18hmaRjp0XaVCo
         tbz2dpxy9BAwIfq7DlE0fYfVYBynBbBqDVd02cBVJCNBKaV0RT2xqV1xe6rbyRdDzLe7
         I+T754H8E0bat0gAtGur0VdrosoQBdGiAhNcbx9UBG42nDDQQ2jmaZM4gbIGCE14Ye/q
         5AWn45Q2QaBsF7LgBNY8z/hhZaSvdKuNsY8Q1UOKFuJZ+9TAov1s5Wrf8C15+drczVxz
         epYF2mOdsXT+5or1CXtAmv7cyKrfQYC4cV12v9CnZ9DPUJcZk+mWGI7gRN3XVtNet1k6
         kyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmxRbRd4hR23BKZFFXUTSpS56FI59Xo3Tn7rG9ylEcw=;
        b=UjWwn65zv4o872L+jE8oBRaqUFgbWneKJo+zUmzBJeQ5Ao3xOh2Pr+kBRfcjkv2exh
         cim1ccUOdnFT/p8YomxvqN/hFnEVmIwHhGu1pU03wyVzlZrned+WL4Y75cBwNxMRlt/x
         qJh1Uo5pe8Tu26S55TUtqZVuCWBqZmtgr85PXIvaH8rCHcW+3r01V7lqf/wXJmxwDVEG
         798cFByfu5xIHbfIeNR9KwliV7A3F/lpds5TLS84djHLEVOxenOLYHOIu3B8HuQgM/by
         YJ/QIvQmqfoSWcbqp6+CONS3nCm/c8o2jz7KXBZAKYvoatzy5ZDdsm3yGRo+NDU6Z73D
         SrQg==
X-Gm-Message-State: AOAM533Fff0xTQctQ5desPPAo/K5zSpIHLu0o7wArzDxm8WlKllLQOt9
        eqB367jOwYZNLxxZQQLjacn4SW8bKWo=
X-Google-Smtp-Source: ABdhPJwe+FT9FBr5vv9LAOWq2Q016OT0CqQDyeVT8rHVfv5jXjzlqfgywzBOddMH2Oj4X2tSDGHZJA==
X-Received: by 2002:ac2:4e8d:: with SMTP id o13mr6724454lfr.259.1608564032623;
        Mon, 21 Dec 2020 07:20:32 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:31 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 00/32] git-log: implement new --diff-merge options
Date:   Mon, 21 Dec 2020 18:19:28 +0300
Message-Id: <20201221152000.13134-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patch series implement new set of options governing diff output
of merge commits, all under the umbrella of single
--diff-merges=<mode> option.

Unlike original -c/--cc options, these new options do not imply -p,
thus allowing for getting diffs for merge commits without provoking of
diff output for regular, non-merge commits. E.g.:

  git log --diff-merges=cc

will output diffs (in dense-combined format) only for merge commits,
whereas:

  git log --cc

enables diffs for all the commits being output, either merges or
simple ones.

There is also another additional functionality provided, allowing to
get the format of "-p --first-parent" without change in history
traversal that --first-parent option causes, like this:

  git log --diff-merges=first-parent

The net result of these series are the following new options:

--diff-merges=	  |  rough original equivalent
------------------+----------------
1|first-parent    | --first-parent (only diff format implications)
m|separate        | -m and enable diff for merges
c|combined        | -c and enable diff for merges, but not for regulars
cc|dense-combined | --cc and enable diff for merges, but not for
		  |      regulars

The series also cleanup logic of handling of diff merges options and
fix an issue found in the original implementation where logically
mutually exclusive options -m/-c/--cc failed to actually override each
other. Neither semantics of these old options nor their interactions
with other options, such as --first-parent and -p, is supposed to be
changed.

The series start with the set of pure refactoring commits that are expected
to introduce no functional changes. These are all commits up to and
including:

"diff-merges: revise revs->diff flag handling"

The aim of these commits is to isolate options handling for diff merges so
that it could be easily understood and tweaked to ease introduction of the
new options.

Then the fix of -m/-c/-cc overriding issue follows, starting with a failing
test and followed by the fix.

Then follows a little bit of additional refactoring in order to
prepare for introduction of the new options, and finally the series
are finished by the implementation, documentation updates, and
some testing for the new options.

Updates in v3:

  * Fixed all the known style issues

  * Revised -m, -c, and -cc description as suggested by Elijah Newren

  * Removed manual abbrevs for diff-merge options

  * Got rid of if(0) ; idiom

  * Renamed regulars_need_diff to all_need_diff to better reflect
    the meaning of the variable.

  * Moved "diff-merges: handle imply -p on -c/--cc logic for log.c"
    closer to the beginning of the series, where it belongs as being
    pure refactoring of the old code.

  * Added code clarification comments to set_diff_merges()

Updates in v2:

  * Move logic of "-c/--cc imply -p" to this module and do not imply
    -p by new --diff-merges options. Instead enable corresponding diff
    output without affecting non-merge commits. This is the most
    significant change with respect to v1 and it starts at 24/33.

  * Add support for old mnemonics: --diff-merges=(m|c|cc) to help
    those who are used to them, and add --diff-merges=1 to cover all
    variants with short mnemonics.

  * Fixed functions definitions style to have open curly brace on its
    own line, pointed to by Junio C Hamano.

  * Tweak --diff-merges=first-parent description, requested by Elijah
    Newren.

  * Fixed git-show documentation not to include description chunk
    relevant to git-log only, noticed by Elijah Newren.

  * Fixed documentation mistake claiming that -p is needed for
    diff-merges options to take effect, noticed by Elijah Newren.

  * Fixed a case where a change was put into wrong commit. The change
    moved to 11/27 form 10/27. Didn't affect end-result in any way.

  * Added short module description to diff-merges.h, as suggested by
    Junio C Hamano.

  * Fixed not returning "argcount" from	diff_merges_parse_opts(),
    noticed by Junio C Hamano.

Updates in v1:

  * Added documentation fix for git-show to include --diff-merges.

  * Fixed typos in commit messages noticed by Philip Oakley.

Signed-off-by: Sergey Organov <sorganov@gmail.com>

Sergey Organov (32):
  revision: factor out parsing of diff-merge related options
  revision: factor out setup of diff-merge related settings
  revision: factor out initialization of diff-merge related settings
  revision: provide implementation for diff merges tweaks
  revision: move diff merges functions to its own diff-merges.c
  diff-merges: rename all functions to have common prefix
  diff-merges: move checks for first_parent_only out of the module
  diff-merges: rename diff_merges_default_to_enable() to match semantics
  diff-merges: re-arrange functions to match the order they are called
    in
  diff-merges: new function diff_merges_suppress()
  diff-merges: new function diff_merges_set_dense_combined_if_unset()
  diff-merges: introduce revs->first_parent_merges flag
  diff-merges: handle imply -p on -c/--cc logic for log.c
  diff-merges: revise revs->diff flag handling
  t4013: support test_expect_failure through ':failure' magic
  t4013: add tests for -m failing to override -c/--cc
  diff-merges: fix -m to properly override -c/--cc
  diff-merges: split 'ignore_merges' field
  diff-merges: group diff-merge flags next to each other inside
    'rev_info'
  diff-merges: get rid of now empty diff_merges_init_revs()
  diff-merges: refactor opt settings into separate functions
  diff-merges: make -m/-c/--cc explicitly mutually exclusive
  diff-merges: implement new values for --diff-merges
  diff-merges: do not imply -p for new options
  diff-merges: let new options enable diff without -p
  diff-merges: add old mnemonic counterparts to --diff-merges
  diff-merges: add '--diff-merges=1' as synonym for 'first-parent'
  doc/git-log: describe new --diff-merges options
  doc/diff-generate-patch: mention new --diff-merges option
  doc/rev-list-options: document --first-parent changes merges format
  doc/git-show: include --diff-merges description
  t4013: add tests for --diff-merges=first-parent

 Documentation/diff-generate-patch.txt         |   6 +-
 Documentation/diff-options.txt                |  51 +++++
 Documentation/git-log.txt                     |  46 +---
 Documentation/git-show.txt                    |   7 +-
 Documentation/rev-list-options.txt            |   5 +
 Makefile                                      |   1 +
 builtin/diff-files.c                          |   5 +-
 builtin/diff.c                                |   9 +-
 builtin/log.c                                 |  22 +-
 builtin/merge.c                               |   3 +-
 diff-merges.c                                 | 146 +++++++++++++
 diff-merges.h                                 |  24 +++
 fmt-merge-msg.c                               |   3 +-
 log-tree.c                                    |  30 +--
 revision.c                                    |  38 +---
 revision.h                                    |   9 +-
 t/t4013-diff-various.sh                       |  11 +-
 t/t4013/diff.log_--cc_-m_-p_master            | 200 ++++++++++++++++++
 ...diff.log_--diff-merges=first-parent_master |  56 +++++
 t/t4013/diff.log_-c_-m_-p_master              | 200 ++++++++++++++++++
 ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++
 21 files changed, 893 insertions(+), 116 deletions(-)
 create mode 100644 diff-merges.c
 create mode 100644 diff-merges.h
 create mode 100644 t/t4013/diff.log_--cc_-m_-p_master
 create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_master
 create mode 100644 t/t4013/diff.log_-c_-m_-p_master
 create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master

Interdiff against v2:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 98db2be423dc..c995e82584f3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -55,8 +55,7 @@ ifdef::git-log[]
 -m:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent. `-m` is different in that it doesn't produce
-	any output without `-p`.
+	for each parent. `-m` doesn't produce any output without `-p`.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
@@ -65,8 +64,8 @@ ifdef::git-log[]
 	differences from each of the parents to the merge result
 	simultaneously instead of showing pairwise diff between a
 	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents. Historically,
-	`-c` enables diff output for non-merge commits as well.
+	only files which were modified from all parents. `-c` implies
+	`-p`.
 +
 --diff-merges=dense-combined:::
 --diff-merges=cc:::
@@ -75,8 +74,7 @@ ifdef::git-log[]
 	`--diff-merges=combined` is further compressed by omitting
 	uninteresting hunks whose contents in the parents have only
 	two variants and the merge result picks one of them without
-	modification.  Historically, `--c` enables diff output for
-	non-merge commits as well.
+	modification.  `--cc` implies `-p`.
 
 --combined-all-paths::
 	This flag causes combined diffs (used for merge commits) to
diff --git a/diff-merges.c b/diff-merges.c
index 63a0d78b7730..146bb50316a6 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -54,23 +54,22 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 {
 	if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
 		suppress(revs);
+		/* Return early to leave revs->merges_need_diff unset */
 		return;
 	}
-	if (0) ;
-	else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent") ||
-		 !strcmp(optarg, "1"))
+
+	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		set_first_parent(revs);
-	else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate") ||
-		 !strcmp(optarg, "m"))
+	else if (!strcmp(optarg, "m") || !strcmp(optarg, "separate"))
 		set_separate(revs);
-	else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined") ||
-		 !strcmp(optarg, "c"))
+	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
 		set_combined(revs);
-	else if (!strcmp(optarg, "dense") || !strcmp(optarg, "dense-combined") ||
-		 !strcmp(optarg, "cc"))
+	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		set_dense_combined(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
+
+	/* The flag is cleared by set_xxx() functions, so don't move this up */
 	revs->merges_need_diff = 1;
 }
 
@@ -84,23 +83,21 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	const char *optarg;
 	const char *arg = argv[0];
 
-	if (!strcmp(arg, "-m"))
+	if (!strcmp(arg, "-m")) {
 		set_m(revs);
-	else if (!strcmp(arg, "-c")) {
+	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->combined_imply_patch = 1;
-	}
-	else if (!strcmp(arg, "--cc")) {
+	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
 		revs->combined_imply_patch = 1;
-	}
-	else if (!strcmp(arg, "--no-diff-merges"))
+	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
-	else if (!strcmp(arg, "--combined-all-paths"))
+	} else if (!strcmp(arg, "--combined-all-paths")) {
 		revs->combined_all_paths = 1;
-	else if ((argcount = parse_long_opt("diff-merges", argv, &optarg)))
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		set_diff_merges(revs, optarg);
-	else
+	} else
 		return 0;
 
 	revs->explicit_diff_merges = 1;
@@ -140,10 +137,8 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-
 	if (revs->combined_imply_patch)
 		revs->diff = 1;
-
 	if (revs->combined_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/log-tree.c b/log-tree.c
index 67060492ca0a..9f50a81e537e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -900,9 +900,9 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	struct commit_list *parents;
 	struct object_id *oid;
 	int is_merge;
-	int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
+	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
 
-	if (!regulars_need_diff && !opt->merges_need_diff)
+	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
 
 	parse_commit_or_die(commit);
@@ -910,7 +910,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 	parents = get_saved_parents(opt, commit);
 	is_merge = parents && parents->next;
-	if(!is_merge && !regulars_need_diff)
+	if (!is_merge && !all_need_diff)
 		return 0;
 
 	/* Root commit? */
-- 
2.25.1


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CEBC433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 07:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhLYH70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 02:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhLYH7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 02:59:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4317C061757
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so21404421wrg.1
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 23:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tiHYI9g2GBcZyhgRwNxpKGsMc2Tf/UyepkB32nfrDmY=;
        b=Nrh9N5m/oDJwfv6Uiocu2zpjOpfXrBUXxDS6vkBWdqd4PfWkSOOWxHRAgBNp//RDpO
         rSybhlTlqmmGpvRaCa/4tGnvc2bPwbItD2l9EO/+rm9liP1/GhGBlXal35Hdp7KyGTbK
         Q+7IPwA7qDnQzkmQ8U8V+xHd7oUSm8+Oo8DfiGHeQsmiEOilXrgcOo5l8NUej7FYhVJB
         RB+YBh5KefTtEnJc/+4tGEU6kd8qD+0YIql9P9ir6dpYDMPod3mJN1iJupldyv73eK3U
         cDb10UpPL3SKK7+wpd2ajoS+M8hJMgIPI7GYD4ptQT0EiNciNdt90BCu6kKTdEtK7rtX
         x6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tiHYI9g2GBcZyhgRwNxpKGsMc2Tf/UyepkB32nfrDmY=;
        b=YLJSvvTEJIxrKqXzUQXBylSD1CuTJibYBtQDmsQflTHJRQzwPubFHocLTe8SaA6TbG
         lZcpUXcY/8vVlRNUrMiPtwJGKJ6oqhZpfIOg4Cgzw33jc6gRguvh+eL/drElL4/BGg3Q
         x+Gc2T6vfbEedQ7Ors3z35sVlV5ASX5OMW5sW3OFOOy13EcQGSXo5mY0uZRaFarKqNhH
         iiIF79Jf59v2uOXMEO3ByIUzAgLow4Wj1O0LSUPJHx0/epub9mlcA/59vnM1HN/FmwcW
         qiwK2hh6sfyGEbiW+JMOaEip47CNgWRqu1dVurnszIuUE0oKSAzRi7Fk64xEVxL4DRHB
         l3fQ==
X-Gm-Message-State: AOAM531tkDhaRng6y0N3b7LkH4RZTVPih46p2sEXRXPndmcxHR+RhVUQ
        bKPF01fK119nLG5IEa9eonPfJCQ1Cy4=
X-Google-Smtp-Source: ABdhPJwBfK9lkJeToe+HvXlG/AQF3OoFjTa26GzwjoBtU67e+ro2Ffk8QO4bbIi3Fus1tRLRmeaDcQ==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr6698686wrr.99.1640419163005;
        Fri, 24 Dec 2021 23:59:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s189sm16046408wme.0.2021.12.24.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 23:59:22 -0800 (PST)
Message-Id: <b3ae62083e14aecdfe909735b4daf0a36fa5e48c.1640419159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Dec 2021 07:59:12 +0000
Subject: [PATCH v2 1/8] show, log: provide a --remerge-diff capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When this option is specified, we remerge all (two parent) merge commits
and diff the actual merge commit to the automatically created version,
in order to show how users removed conflict markers, resolved the
different conflict versions, and potentially added new changes outside
of conflict regions in order to resolve semantic merge problems (or,
possibly, just to hide other random changes).

This capability works by creating a temporary object directory and
marking it as the primary object store.  This makes it so that any blobs
or trees created during the automatic merge easily removable afterwards
by just deleting all objects from the temporary object directory.

There are a few ways that this implementation is suboptimal:
  * `log --remerge-diff` becomes slow, because the temporary object
    directory can fills with many loose objects while running
  * the log output can be muddied with misplaced "warning: cannot merge
    binary files" messages, since ll-merge.c unconditionally writes those
    messages to stderr while running instead of allowing callers to
    manage them.
  * important conflict and warning messages are simply dropped; thus for
    conflicts like modify/delete or rename/rename or file/directory which
    are not representable with content conflict markers, there may be no
    way for a user of --remerge-diff to know that there had been a
    conflict which was resolved (and which possibly motivated other
    changes in the merge commit).
Subsequent commits will address these issues.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-options.txt |  8 ++++
 builtin/log.c                  | 14 ++++++
 diff-merges.c                  | 12 +++++
 log-tree.c                     | 59 +++++++++++++++++++++++
 revision.h                     |  3 +-
 t/t4069-remerge-diff.sh        | 86 ++++++++++++++++++++++++++++++++++
 6 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100755 t/t4069-remerge-diff.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c89d530d3d1..b05f1c9f1c9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -64,6 +64,14 @@ ifdef::git-log[]
 	each of the parents. Separate log entry and diff is generated
 	for each parent.
 +
+--diff-merges=remerge:::
+--diff-merges=r:::
+--remerge-diff:::
+	With this option, two-parent merge commits are remerged to
+	create a temporary tree object -- potentially containing files
+	with conflict markers and such.  A diff is then shown between
+	that temporary tree and the actual merge commit.
++
 --diff-merges=combined:::
 --diff-merges=c:::
 -c:::
diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..d053418fddd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -35,6 +35,7 @@
 #include "repository.h"
 #include "commit-reach.h"
 #include "range-diff.h"
+#include "tmp-objdir.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
@@ -406,6 +407,14 @@ static int cmd_log_walk(struct rev_info *rev)
 	struct commit *commit;
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
+	struct tmp_objdir *remerge_objdir = NULL;
+
+	if (rev->remerge_diff) {
+		remerge_objdir = tmp_objdir_create("remerge-diff");
+		if (!remerge_objdir)
+			die_errno(_("unable to create temporary object directory"));
+		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
+	}
 
 	if (rev->early_output)
 		setup_early_output();
@@ -449,6 +458,9 @@ static int cmd_log_walk(struct rev_info *rev)
 	rev->diffopt.no_free = 0;
 	diff_free(&rev->diffopt);
 
+	if (rev->remerge_diff)
+		tmp_objdir_destroy(remerge_objdir);
+
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
 		return 02;
@@ -1943,6 +1955,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die(_("--name-status does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
 		die(_("--check does not make sense"));
+	if (rev.remerge_diff)
+		die(_("--remerge-diff does not make sense"));
 
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
diff --git a/diff-merges.c b/diff-merges.c
index 5060ccd890b..0af4b3f9191 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -17,6 +17,7 @@ static void suppress(struct rev_info *revs)
 	revs->combined_all_paths = 0;
 	revs->merges_imply_patch = 0;
 	revs->merges_need_diff = 0;
+	revs->remerge_diff = 0;
 }
 
 static void set_separate(struct rev_info *revs)
@@ -45,6 +46,12 @@ static void set_dense_combined(struct rev_info *revs)
 	revs->dense_combined_merges = 1;
 }
 
+static void set_remerge_diff(struct rev_info *revs)
+{
+	suppress(revs);
+	revs->remerge_diff = 1;
+}
+
 static diff_merges_setup_func_t func_by_opt(const char *optarg)
 {
 	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
@@ -57,6 +64,8 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 		return set_combined;
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		return set_dense_combined;
+	else if (!strcmp(optarg, "r") || !strcmp(optarg, "remerge"))
+		return set_remerge_diff;
 	else if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
 		return set_to_default;
 	return NULL;
@@ -110,6 +119,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	} else if (!strcmp(arg, "--cc")) {
 		set_dense_combined(revs);
 		revs->merges_imply_patch = 1;
+	} else if (!strcmp(arg, "--remerge-diff")) {
+		set_remerge_diff(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
diff --git a/log-tree.c b/log-tree.c
index 644893fd8cf..84ed864fc81 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
 #include "object-store.h"
@@ -7,6 +8,7 @@
 #include "tag.h"
 #include "graph.h"
 #include "log-tree.h"
+#include "merge-ort.h"
 #include "reflog-walk.h"
 #include "refs.h"
 #include "string-list.h"
@@ -902,6 +904,51 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 	return !opt->loginfo;
 }
 
+static int do_remerge_diff(struct rev_info *opt,
+			   struct commit_list *parents,
+			   struct object_id *oid,
+			   struct commit *commit)
+{
+	struct merge_options o;
+	struct commit_list *bases;
+	struct merge_result res = {0};
+	struct pretty_print_context ctx = {0};
+	struct commit *parent1 = parents->item;
+	struct commit *parent2 = parents->next->item;
+	struct strbuf parent1_desc = STRBUF_INIT;
+	struct strbuf parent2_desc = STRBUF_INIT;
+
+	/* Setup merge options */
+	init_merge_options(&o, the_repository);
+	o.show_rename_progress = 0;
+
+	ctx.abbrev = DEFAULT_ABBREV;
+	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
+	format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
+	o.branch1 = parent1_desc.buf;
+	o.branch2 = parent2_desc.buf;
+
+	/* Parse the relevant commits and get the merge bases */
+	parse_commit_or_die(parent1);
+	parse_commit_or_die(parent2);
+	bases = get_merge_bases(parent1, parent2);
+
+	/* Re-merge the parents */
+	merge_incore_recursive(&o, bases, parent1, parent2, &res);
+
+	/* Show the diff */
+	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
+	log_tree_diff_flush(opt);
+
+	/* Cleanup */
+	strbuf_release(&parent1_desc);
+	strbuf_release(&parent2_desc);
+	merge_finalize(&o, &res);
+	/* TODO: clean up the temporary object directory */
+
+	return !opt->loginfo;
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -936,6 +983,18 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	}
 
 	if (is_merge) {
+		int octopus = (parents->next->next != NULL);
+
+		if (opt->remerge_diff) {
+			if (octopus) {
+				show_log(opt);
+				fprintf(opt->diffopt.file,
+					"diff: warning: Skipping remerge-diff "
+					"for octopus merges.\n");
+				return 1;
+			}
+			return do_remerge_diff(opt, parents, oid, commit);
+		}
 		if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
 		if (opt->separate_merges) {
diff --git a/revision.h b/revision.h
index 5578bb4720a..13178e6b8f3 100644
--- a/revision.h
+++ b/revision.h
@@ -195,7 +195,8 @@ struct rev_info {
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
-			first_parent_merges:1;
+			first_parent_merges:1,
+			remerge_diff:1;
 
 	/* Format info */
 	int		show_notes;
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
new file mode 100755
index 00000000000..192dbce2bfe
--- /dev/null
+++ b/t/t4069-remerge-diff.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='remerge-diff handling'
+
+. ./test-lib.sh
+
+test_expect_success 'setup basic merges' '
+	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git commit -m base &&
+
+	git branch feature_a &&
+	git branch feature_b &&
+	git branch feature_c &&
+
+	git branch ab_resolution &&
+	git branch bc_resolution &&
+
+	git checkout feature_a &&
+	test_write_lines 1 2 three 4 5 6 7 eight 9 >numbers &&
+	git commit -a -m change_a &&
+
+	git checkout feature_b &&
+	test_write_lines 1 2 tres 4 5 6 7 8 9 >numbers &&
+	git commit -a -m change_b &&
+
+	git checkout feature_c &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 10 >numbers &&
+	git commit -a -m change_c &&
+
+	git checkout bc_resolution &&
+	# fast forward
+	git merge feature_b &&
+	# no conflict
+	git merge feature_c &&
+
+	git checkout ab_resolution &&
+	# fast forward
+	git merge feature_a &&
+	# conflicts!
+	test_must_fail git merge feature_b &&
+	# Resolve conflict...and make another change elsewhere
+	test_write_lines 1 2 drei 4 5 6 7 acht 9 >numbers &&
+	git add numbers &&
+	git merge --continue
+'
+
+test_expect_success 'remerge-diff on a clean merge' '
+	git log -1 --oneline bc_resolution >expect &&
+	git show --oneline --remerge-diff bc_resolution >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'remerge-diff with both a resolved conflict and an unrelated change' '
+	git log -1 --oneline ab_resolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/numbers b/numbers
+	index a1fb731..6875544 100644
+	--- a/numbers
+	+++ b/numbers
+	@@ -1,13 +1,9 @@
+	 1
+	 2
+	-<<<<<<< b0ed5cb (change_a)
+	-three
+	-=======
+	-tres
+	->>>>>>> 6cd3f82 (change_b)
+	+drei
+	 4
+	 5
+	 6
+	 7
+	-eight
+	+acht
+	 9
+	EOF
+	# Hashes above are sha1; rip them out so test works with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff ab_resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget


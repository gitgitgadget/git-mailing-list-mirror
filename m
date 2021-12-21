Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DCEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbhLUSGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbhLUSF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B77C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e5so28559675wrc.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pKHlsgibmU/o0IOqbLJdVchR8Gx/wV+xrht4B9wnqOg=;
        b=Zn5jV/uMSwsS6fbIJ9yBjuRFJXyTLWD0vqrJn0W/OYFP2j53BPiJyYka1PKkK+urOt
         ZSBnHsey9X0V3yX3URRa+kyHiysOfIWiWUBhxegYxYg08/ATddJmUrh/rFpirFdN1AaL
         6hE14PdDBoj8GwFYt4UvYd/coJ9z+cf840mFxUQuVzA51fRmMth4NmW9S4vBMFmGJtkG
         H282nCZ5csTUAIkAebrsupQl3zbDH35TkvVhz6fOLZwodIIM8nivnvyuD+de099FGFVi
         LZ5QNapbekkOBdaTdauU7xUkwgRUZ7IYzC/9aCvK4B5MZhVCxmUVrPt/lkpPPVMGAIkN
         2NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pKHlsgibmU/o0IOqbLJdVchR8Gx/wV+xrht4B9wnqOg=;
        b=cnoKSCL+zjg+B5jAfqdOox7UYR+P4/z28rJ6T0k2T0COZfKBToM+ix4UQUGmT7REJc
         DIygyhBw4dqHaLh6es8ZGgr6NOjLT+WzWCG29vd1K5Ntn/QuMbfBbolR6Z3pJl/0ZKNH
         KJd9paxrC29azI1nf1pm2eZ6xEvOI9JZwEbkYfxTb1jIG7oa2UXZjgPNuSXJyRrmqtQI
         5+ZpxBkjUDsZD1eq6byxyWZc4VMh2fb0x7ubA8UVu/EHpN+VmEAa8M3CRyk789LQ1y0Y
         zDl/gjcUMkW1PD3Lt+PFNGv+AR4YDOQHFHP9RrH9oGnEqFMbEvziXc7tDm+QMGKB5zGV
         uybA==
X-Gm-Message-State: AOAM531e7lztrUj/bHivymOgUsV8GubqS+c2OX+5OHWzAfbjZtBCasH1
        0J1Zf8MjdnAMFY/+V6bPf5iQsunMN6A=
X-Google-Smtp-Source: ABdhPJwi2HqAZq1b5T/iQFrnk7l81ZsJ44Be6GVACkFvtNHMfAg+YuyU1C8+bOK+nrtm5LDMzmlu5Q==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr3492811wrw.620.1640109955714;
        Tue, 21 Dec 2021 10:05:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm18419018wrh.56.2021.12.21.10.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:55 -0800 (PST)
Message-Id: <5d5846be0bd67b8fd850ef2583beef064481a67d.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:47 +0000
Subject: [PATCH 8/9] show, log: provide a --remerge-diff capability
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
marking it as the primary object store, so that any blobs or trees
created during the automatic merge, can be easily removed afterwards by
just deleting all objects from the temporary object directory.  We can
do this after handling each merge commit, in order to avoid the need to
worry about doing `git gc --auto` runs while running `git log
--remerge-diff`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/log.c | 16 ++++++++++++
 diff-merges.c | 12 +++++++++
 log-tree.c    | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.h    |  6 ++++-
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..2b51d8b6aae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -35,6 +35,8 @@
 #include "repository.h"
 #include "commit-reach.h"
 #include "range-diff.h"
+#include "dir.h"
+#include "tmp-objdir.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
@@ -407,6 +409,13 @@ static int cmd_log_walk(struct rev_info *rev)
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
 
+	if (rev->remerge_diff) {
+		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
+		if (!rev->remerge_objdir)
+			die(_("unable to create temporary object directory"));
+		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
+	}
+
 	if (rev->early_output)
 		setup_early_output();
 
@@ -449,6 +458,11 @@ static int cmd_log_walk(struct rev_info *rev)
 	rev->diffopt.no_free = 0;
 	diff_free(&rev->diffopt);
 
+	if (rev->remerge_diff) {
+		tmp_objdir_destroy(rev->remerge_objdir);
+		rev->remerge_objdir = NULL;
+	}
+
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
 		return 02;
@@ -1943,6 +1957,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die(_("--name-status does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
 		die(_("--check does not make sense"));
+	if (rev.remerge_diff)
+		die(_("--remerge_diff does not make sense"));
 
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
index 644893fd8cf..8fef9822a1e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,12 +1,15 @@
 #include "cache.h"
+#include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
 #include "object-store.h"
 #include "repository.h"
+#include "tmp-objdir.h"
 #include "commit.h"
 #include "tag.h"
 #include "graph.h"
 #include "log-tree.h"
+#include "merge-ort.h"
 #include "reflog-walk.h"
 #include "refs.h"
 #include "string-list.h"
@@ -16,6 +19,7 @@
 #include "line-log.h"
 #include "help.h"
 #include "range-diff.h"
+#include "dir.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -902,6 +906,60 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 	return !opt->loginfo;
 }
 
+static int do_remerge_diff(struct rev_info *opt,
+			   struct commit_list *parents,
+			   struct object_id *oid,
+			   struct commit *commit)
+{
+	struct merge_options o;
+	struct commit_list *bases;
+	struct merge_result res;
+	struct pretty_print_context ctx = {0};
+	struct strbuf commit1 = STRBUF_INIT;
+	struct strbuf commit2 = STRBUF_INIT;
+
+	/* Setup merge options */
+	init_merge_options(&o, the_repository);
+	memset(&res, 0, sizeof(res));
+	o.show_rename_progress = 0;
+
+	ctx.abbrev = DEFAULT_ABBREV;
+	format_commit_message(parents->item,       "%h (%s)", &commit1, &ctx);
+	format_commit_message(parents->next->item, "%h (%s)", &commit2, &ctx);
+	o.branch1 = commit1.buf;
+	o.branch2 = commit2.buf;
+	o.record_conflict_msgs_as_headers = 1;
+
+	/* Parse the relevant commits and get the merge bases */
+	parse_commit_or_die(parents->item);
+	parse_commit_or_die(parents->next->item);
+	bases = get_merge_bases(parents->item, parents->next->item);
+
+	/* Re-merge the parents */
+	merge_incore_recursive(&o,
+			       bases, parents->item, parents->next->item,
+			       &res);
+
+	/* Show the diff */
+	opt->diffopt.additional_path_headers = res.path_messages;
+	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
+	log_tree_diff_flush(opt);
+
+	/* Cleanup */
+	opt->diffopt.additional_path_headers = NULL;
+	strbuf_release(&commit1);
+	strbuf_release(&commit2);
+	merge_finalize(&o, &res);
+
+	/* Clean up the temporary object directory */
+	if (opt->remerge_objdir != NULL)
+		tmp_objdir_discard_objects(opt->remerge_objdir);
+	else
+		BUG("unable to remove temporary object directory");
+
+	return !opt->loginfo;
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -936,6 +994,18 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
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
index 5578bb4720a..44efce3f410 100644
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
@@ -317,6 +318,9 @@ struct rev_info {
 
 	/* misc. flags related to '--no-kept-objects' */
 	unsigned keep_pack_cache_flags;
+
+	/* Location where temporary objects for remerge-diff are written. */
+	struct tmp_objdir *remerge_objdir;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
gitgitgadget


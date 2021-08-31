Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE5AC43214
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0D16103D
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbhHaC1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbhHaC1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72E1C06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u9so25060313wrg.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mpIlqEaSefaIJHedVnxM1mdqMRclAA+rexyvGVXumD0=;
        b=ReC5Eh4IR1WKIJcQM0jTl1OCUloN7iVGtZbzx/tYH2p+7L7FTiT/iyPmYQ4r68G5GI
         S/ex4O/vHAo0bx0jy5UJe44GRhhAzwXoYaz79fmojSjMWhmXOT7L7jjNfIzhFyqpe9n3
         feWofPCl5ziCeSB2DPvwMuCdyZZ+ZMT7dTVZyDxYoWZg68QEnMMqBitwfSGbaD5Zprhq
         P1ohJIuyoV7F0DXnM+SlvlcLkfyvCbL5dZyezBMnwxsbejR+mD+Bg93SViQUrkQ9Qy3B
         bqEOFAQCwnlLnH9ZqZiGoxWI8jVgKN+MPt4jiXMdvVPMegwLoyW7cazologPVLVFI17I
         hC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mpIlqEaSefaIJHedVnxM1mdqMRclAA+rexyvGVXumD0=;
        b=Oddmh6+YbfvBdncpqlBbCw61+b6SM+92Udof81o6eeF4CHPMO3Z6OgGMqWyyypmZFS
         3vGqm9N8hAXytItApzI090A/xQPmqZx3PRVj9KDI88oWei819RupF+COREn8ewOFS5YX
         c8Sng96dXyDqzokVihhJMNsTyye74tT9BUzJRlKwIsmRh4x7am4k73D0SaZvK44EG5eB
         Cg++vsRgq7RDPCH7ThljwIoFOAm41t4qlxJornns5qpKgv1yQxHu/b7xPZ5K474Ab4wU
         WrCCFeHqE19E3TmJhNd1ImD7alAZjp1aeFUEPzIgbeyAhIQfVuLBNBo10tjit3DORpEm
         7H1A==
X-Gm-Message-State: AOAM5308q5ZqUljuE1pozTfAQSepysmaPbv/9sFpnNX9NfN0d8V6/bLM
        Jzfdz6thrShAHRVcS4Z08Uio4eonIhs=
X-Google-Smtp-Source: ABdhPJwcfiMbhx1tOwWSI8uQ1CFxJ1dCAKqGBV4m3nfobGHX8nP3lETevAHqFcC3yl7N/kXzk7F6Fg==
X-Received: by 2002:adf:a44d:: with SMTP id e13mr27537291wra.177.1630376805043;
        Mon, 30 Aug 2021 19:26:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm1066429wmj.29.2021.08.30.19.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:44 -0700 (PDT)
Message-Id: <b75e73384fde4f23296bd02eb40455263f805706.1630376800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:39 +0000
Subject: [PATCH 6/7] show, log: provide a --remerge-diff capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
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
 builtin/log.c | 23 +++++++++++++++++
 diff-merges.c | 12 +++++++++
 log-tree.c    | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 revision.h    |  6 ++++-
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 3d7717ba5ca..6c7288716e6 100644
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
@@ -51,6 +53,7 @@ static int default_encode_email_headers = 1;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
+static struct tmp_objdir *tmp_objdir;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
 static const char *fmt_pretty;
@@ -407,6 +410,17 @@ static int cmd_log_walk(struct rev_info *rev)
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
 
+	if (rev->remerge_diff) {
+		tmp_objdir = tmp_objdir_create();
+		if (!tmp_objdir)
+			die(_("unable to create temporary object directory"));
+		tmp_objdir_make_primary(the_repository, tmp_objdir);
+
+		strbuf_init(&rev->remerge_objdir_location, 0);
+		strbuf_addstr(&rev->remerge_objdir_location,
+			      tmp_objdir_path(tmp_objdir));
+	}
+
 	if (rev->early_output)
 		setup_early_output();
 
@@ -449,6 +463,13 @@ static int cmd_log_walk(struct rev_info *rev)
 	rev->diffopt.no_free = 0;
 	diff_free(&rev->diffopt);
 
+	if (rev->remerge_diff) {
+		strbuf_release(&rev->remerge_objdir_location);
+		tmp_objdir_remove_as_primary(the_repository, tmp_objdir);
+		tmp_objdir_destroy(tmp_objdir);
+		tmp_objdir = NULL;
+	}
+
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
 		return 02;
@@ -1943,6 +1964,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die(_("--name-status does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
 		die(_("--check does not make sense"));
+	if (rev.remerge_diff)
+		die(_("--remerge_diff does not make sense"));
 
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
diff --git a/diff-merges.c b/diff-merges.c
index d897fd8a293..3a24c45b8e5 100644
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
@@ -113,6 +122,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
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
index 6dc4412268b..ed69a4da140 100644
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
@@ -16,6 +18,7 @@
 #include "line-log.h"
 #include "help.h"
 #include "range-diff.h"
+#include "dir.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -902,6 +905,60 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
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
+	o.record_conflict_msgs_in_tree = 1;
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
+	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
+	log_tree_diff_flush(opt);
+
+	/* Cleanup */
+	strbuf_release(&commit1);
+	strbuf_release(&commit2);
+	merge_finalize(&o, &res);
+
+	/* Clean up the temporary object directory */
+	if (opt->remerge_objdir_location.buf != NULL &&
+	    *opt->remerge_objdir_location.buf != '\0')
+		remove_dir_recursively(&opt->remerge_objdir_location,
+				       REMOVE_DIR_KEEP_TOPLEVEL);
+	else
+		BUG("unable to remove temporary object directory");
+
+	return !opt->loginfo;
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -936,6 +993,18 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
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
index fbb068da9fb..d6562c52252 100644
--- a/revision.h
+++ b/revision.h
@@ -198,7 +198,8 @@ struct rev_info {
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
-			first_parent_merges:1;
+			first_parent_merges:1,
+			remerge_diff:1;
 
 	/* Format info */
 	int		show_notes;
@@ -320,6 +321,9 @@ struct rev_info {
 
 	/* misc. flags related to '--no-kept-objects' */
 	unsigned keep_pack_cache_flags;
+
+	/* Location where temporary objects for remerge-diff are written. */
+	struct strbuf remerge_objdir_location;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
gitgitgadget


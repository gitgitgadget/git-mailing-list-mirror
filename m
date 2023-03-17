Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A07C7618A
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCQPgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCQPgN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A830B3608E
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so21847825edb.13
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aYZl1dZrBRH0GetNfkBKcgbOhI+iucmbwcqoPqIs3c=;
        b=QCTPbPYhZDlzkkipWz0u6bX4sKLphwkjQiC4KFwtWTBEoQddSJeEXC/s4rA+6SRQHX
         OiEH1gfPDmkwUD7kOUqOW2pzzEwrgl2aAm5mqxaJiAyhstmCHIPUIi1G1r4SbZH8v0l4
         GwpK8Z8kgP60tD0F4KGkzbVd4WpQ5uSFJSFBehP2B4SbMq9onC8Zi0cJTF9kpZnLEFHS
         K1f80mjk3rLNM0Ru6KHyNjyZE91x3M60qFxVyRR7R6RyTJSgsPuFbMBj14ag29Ue4WqM
         ANLDsdVQjzh3Tjvrv/PAudZoN9txKEK8pyehSlJGavBd9ID6sdCq2j3FbhXLXpITeXzB
         V7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aYZl1dZrBRH0GetNfkBKcgbOhI+iucmbwcqoPqIs3c=;
        b=yXHkoDsnO4Mb8hzKC4LZD1qnxTMBUtHmPF00g260bxLNMOHg+XJ1w63bOSqmeKt+Gs
         yYvIJGgbXWHuv0VVeBclGrt42a/b7NHl1KPKUIobdCB+7dvRGbEFKlbiOMVIyzVIidKr
         nHlb53+q1blDG9kzRhajZWzLd3IIGkLhpjdWwRZOLb4wWWlUWXQ00w/hUjx1RDP5wg3a
         GY/aVRjWauECy7j5J936bONUWw6CBcNKrcZvZLY03xsZQPTagOdqppf5WRsaBEazEpBy
         oVWKjrQF7vH8Nv6mrZee5S9bZgFLGC16F8s2zbb4ukcXbk805NUkDB4bm5C8Ut8WWyIE
         O7KQ==
X-Gm-Message-State: AO0yUKUBZ5okr/CQgDLBIvlIVH5JK8HEr3aLBFkUOKLeeJoFKi5B9O68
        SwHqPHz3PUUs8L1nmkqba2OlYdBhrWb82Q==
X-Google-Smtp-Source: AK7set/W5mbiCD2wSg8DBD+kVoZWXCLs8uL8Lx00FnVi7d0qjt1wDx6sTo3zVUKcqhMAjOLcnnWp2w==
X-Received: by 2002:a17:906:844f:b0:8bf:e95c:467b with SMTP id e15-20020a170906844f00b008bfe95c467bmr13067432ejy.63.1679067339296;
        Fri, 17 Mar 2023 08:35:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/17] cocci: apply the "revision.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:19 +0100
Message-Id: <patch-15.17-c8ff241844a-20230317T152725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"revision.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c                               |  2 +-
 builtin/bisect.c                                |  4 ++--
 builtin/stash.c                                 |  6 +++---
 builtin/submodule--helper.c                     |  2 +-
 contrib/coccinelle/the_repository.cocci         |  4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 14 --------------
 range-diff.c                                    |  2 +-
 revision.h                                      |  3 ---
 8 files changed, 12 insertions(+), 25 deletions(-)
 delete mode 100644 contrib/coccinelle/the_repository.pending.cocci

diff --git a/add-interactive.c b/add-interactive.c
index 00a0f6f96f3..33f41d65a47 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -551,7 +551,7 @@ static int get_modified_files(struct repository *r,
 		opt.def = is_initial ?
 			empty_tree_oid_hex() : oid_to_hex(&head_oid);
 
-		init_revisions(&rev, NULL);
+		repo_init_revisions(the_repository, &rev, NULL);
 		setup_revisions(0, NULL, &rev, &opt);
 
 		rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 34ba7b18f69..0f35361bd16 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -568,7 +568,7 @@ static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
 	 * sets up a revision walk.
 	 */
 	reset_revision_walk();
-	init_revisions(revs, NULL);
+	repo_init_revisions(the_repository, revs, NULL);
 	setup_revisions(0, NULL, revs, NULL);
 	for_each_glob_ref_in(add_bisect_ref, bad, "refs/bisect/", &cb);
 	cb.object_flags = UNINTERESTING;
@@ -1095,7 +1095,7 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
 			struct rev_info revs;
 			struct commit *commit;
 
-			init_revisions(&revs, NULL);
+			repo_init_revisions(the_repository, &revs, NULL);
 			setup_revisions(2, argv + i - 1, &revs, NULL);
 
 			if (prepare_revision_walk(&revs))
diff --git a/builtin/stash.c b/builtin/stash.c
index 2017c278df2..888ffa07288 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -901,7 +901,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
-	init_revisions(&rev, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
@@ -1090,7 +1090,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	if (repo_read_index(the_repository) < 0)
 		return -1;
 
-	init_revisions(&rev, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
 	rev.diffopt.flags.quick = 1;
@@ -1277,7 +1277,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	struct strbuf diff_output = STRBUF_INIT;
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 
-	init_revisions(&rev, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
 	set_alternate_index_output(stash_index_path.buf);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 25c70f415f1..32b8e498172 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1108,7 +1108,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 		strvec_pushv(&diff_args, info->argv);
 
 	git_config(git_diff_basic_config, NULL);
-	init_revisions(&rev, info->prefix);
+	repo_init_revisions(the_repository, &rev, info->prefix);
 	rev.abbrev = 0;
 	precompose_argv_prefix(diff_args.nr, diff_args.v, NULL);
 	setup_revisions(diff_args.nr, diff_args.v, &rev, &opt);
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 1d1ac7d4fc5..765ad689678 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -113,6 +113,10 @@
 |
 - rerere
 + repo_rerere
+// revision.h
+|
+- init_revisions
++ repo_init_revisions
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
deleted file mode 100644
index 1190a3312bd..00000000000
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ /dev/null
@@ -1,14 +0,0 @@
-// This file is used for the ongoing refactoring of
-// bringing the index or repository struct in all of
-// our code base.
-
-@@
-@@
-(
-// revision.h
-- init_revisions
-+ repo_init_revisions
-)
-  (
-+ the_repository,
-  ...)
diff --git a/range-diff.c b/range-diff.c
index 15d0bc35a87..ff5d19f8add 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -588,7 +588,7 @@ int is_range_diff_range(const char *arg)
 	int i, positive = 0, negative = 0;
 	struct rev_info revs;
 
-	init_revisions(&revs, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	if (setup_revisions(3, argv, &revs, NULL) == 1) {
 		for (i = 0; i < revs.pending.nr; i++)
 			if (revs.pending.objects[i].item->flags & UNINTERESTING)
diff --git a/revision.h b/revision.h
index 30febad09a1..eeb91677d07 100644
--- a/revision.h
+++ b/revision.h
@@ -415,9 +415,6 @@ struct rev_info {
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
-#endif
 
 /**
  * Parse revision information, filling in the `rev_info` structure, and
-- 
2.40.0.rc1.1034.g5867a1b10c5


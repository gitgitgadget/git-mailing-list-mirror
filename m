Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E8C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjC1OAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjC1N76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED730C659
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so9490759wmq.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQPB7xv25mD+qPlsfdEHWuQM3h7wEXK4ApXoqkMKqPo=;
        b=QLr06ke92e+mEw5Mlt6o1YS8UFud+LW4fLNugmiY5vFQEKESyKoIpsG5IaWkRXiT5E
         OwXKKLHRmdPGK9WCbSgvkI8ksF28L5XqDlc4yeyba2tR7Id9kuHDnyyNzE+6f/EY0MQB
         B6BTOoxBO/1cR4AbVMyqtH6IZ5XOqTbiwCutityhjP8yDDlwICuGrUXpK6MD+eLcxWQ+
         Bvp1xTAV2h9jxMUH4sSPygUqCRaRhQTeJ4g5q2B/cMRqP32FP8jvMEf6vRlM9iDESwvq
         TuKWkbuN7ZcKeVAX4wD/x7EnTomiybv/XZ28Vvl+w690Cj01pP3fJPnaRolqk7dPVZdp
         4rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQPB7xv25mD+qPlsfdEHWuQM3h7wEXK4ApXoqkMKqPo=;
        b=H3WUkQa614tWt9bR9zsqSnaGrC21RNBa2a5O+bvFhVEJRHR8pL2j42GoOPkLmDSnMF
         3NZxLzoglfliSRc3ZU+/8OvdwXMGVoLpTOkbtYMdHW7pDgxMEfoQsoAuwPkAEoxLn9ja
         +V0JM12gT5jHxmxnrUhhVziz7tW/NDm1MTeVkM19UiMCMzhCB3I/UAmxNFK+qMNWlE8g
         K2N1N9X93SKF8Qk9L9PaDPggVAWkUsX8Vwn/n6f6QaZsebo+FMmzuPPpE9nwSQxz7Nlb
         qqwtfQLfqKZsH9KXVO6cocOqPIzejPNWGWPO+u+Ti8whU8HsaNl57Iph7Vay/a5fGF+T
         5Pcw==
X-Gm-Message-State: AO0yUKX0Ay3jAYxxV/TvFz8HBeuT22I+G5zC/TgQPb+FF4NCmTA+idGa
        8Hnste75uprhkmkDHWHQVaq8/e20Z8KmGw==
X-Google-Smtp-Source: AK7set/n/PIfP4jDBd0MU58tcUACBsKvKBhzC42y6Iep6Ca5aQMgAPc5Tg5AkpM9n5/gH/PV4tpOSQ==
X-Received: by 2002:a05:600c:3653:b0:3ed:c84c:7efe with SMTP id y19-20020a05600c365300b003edc84c7efemr12387344wmq.7.1680011963002;
        Tue, 28 Mar 2023 06:59:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/17] cocci: apply the "revision.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:56 +0200
Message-Id: <patch-v2-15.17-b7561c87ba5-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
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
index ae25ec50bce..313cfd39d8e 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -552,7 +552,7 @@ static int get_modified_files(struct repository *r,
 		opt.def = is_initial ?
 			empty_tree_oid_hex() : oid_to_hex(&head_oid);
 
-		init_revisions(&rev, NULL);
+		repo_init_revisions(the_repository, &rev, NULL);
 		setup_revisions(0, NULL, &rev, &opt);
 
 		rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 6b01e3c3e8e..c77564053a1 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -570,7 +570,7 @@ static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
 	 * sets up a revision walk.
 	 */
 	reset_revision_walk();
-	init_revisions(revs, NULL);
+	repo_init_revisions(the_repository, revs, NULL);
 	setup_revisions(0, NULL, revs, NULL);
 	for_each_glob_ref_in(add_bisect_ref, bad, "refs/bisect/", &cb);
 	cb.object_flags = UNINTERESTING;
@@ -1097,7 +1097,7 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
 			struct rev_info revs;
 			struct commit *commit;
 
-			init_revisions(&revs, NULL);
+			repo_init_revisions(the_repository, &revs, NULL);
 			setup_revisions(2, argv + i - 1, &revs, NULL);
 
 			if (prepare_revision_walk(&revs))
diff --git a/builtin/stash.c b/builtin/stash.c
index b60c82f7af2..5e9fe6b4623 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -902,7 +902,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
-	init_revisions(&rev, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
@@ -1091,7 +1091,7 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	if (repo_read_index(the_repository) < 0)
 		return -1;
 
-	init_revisions(&rev, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
 	rev.diffopt.flags.quick = 1;
@@ -1278,7 +1278,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	struct strbuf diff_output = STRBUF_INIT;
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 
-	init_revisions(&rev, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
 	set_alternate_index_output(stash_index_path.buf);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b21857479de..3833c47aa1f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1110,7 +1110,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
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
index ab71443696d..742700504a7 100644
--- a/revision.h
+++ b/revision.h
@@ -416,9 +416,6 @@ struct rev_info {
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


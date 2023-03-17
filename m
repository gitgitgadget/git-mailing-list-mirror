Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F39C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjCQPgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCQPgF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F411FC4
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so21880540edb.12
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja1zl9DTpwCZlNdZryId9ajKO6EXoU8t70ZMcb6AZBI=;
        b=pjOV/nZqqSndVIF8BL/2P+zPF2Vo3UnA0hjDDbdFvSWQ1057W4gdr9Z34RM0Zyg/hC
         c4PiPKZMXKM7z6c7SgabqRNXIZTH4J18H32wkCbBQ3CsWSR/VRaMGkFRKH8pnB7SZTt0
         y93uV81Wuslvd5FYpBpXtSHDIoHKSSkHuIRBp6khbGuulNJLkzFk5iSUylRgOSJz/QNh
         cBsyGvhIC3L+OatnRUNTavECf7AxSCpUc8tc5vxNdVji020XZI9bKGEwwN7bIVBl94vh
         v+YUQ36y5VstfN9LWtLaiWZBi22p+sBaAvlCVYvvMeZHgUqQVpZlK6k5MssjrJEXHmWP
         sy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja1zl9DTpwCZlNdZryId9ajKO6EXoU8t70ZMcb6AZBI=;
        b=6BAblEHxhDeyR8vWlA1C6Z9NkthnkCwiNaYG4ZfIVfBm6O2kQtcKD7toBu48CxCQmD
         2ELRNV014/DskCKMRU/OcgsVF0+pa2DLOB3/s9Zx2GJqKde3swD1vYfA77YulhzLbHbz
         1ur7EYYa4g154QAJRTwl3T0+T9JPihEzfiJ9yyLUpQOrcuyA0SOQZ3p0xUcisTI0x5iU
         M0rVmvvUnw0jPJLV7t/MZw9g7PIIyG9AgxnYwaqZEV3V+zmsWny3/LiYN0OE6RrwJhEF
         f3fJJhHVequ/1eDiy3+tQALu09l+t0Kah0S5JU9iRW0MiI7z9IcqWOLSLWLQAW2IDCx/
         120w==
X-Gm-Message-State: AO0yUKVAXExhJgxd2NESlsIG+tSLz4ybeMMPcfZ6P/uA708nHz97W0JQ
        GkC6aNTuKZvZPqakiuxaR2qxzmxfXGV9Ww==
X-Google-Smtp-Source: AK7set8jH3vXusDf1W2zrwv772nbzXgL/cVp9E1zA8Bp41PdPV8OcZRQuVomNwct4AJEiWzLVavqVw==
X-Received: by 2002:a05:6402:b2e:b0:4f9:9e56:84bf with SMTP id bo14-20020a0564020b2e00b004f99e5684bfmr3644913edb.10.1679067332695;
        Fri, 17 Mar 2023 08:35:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/17] cocci: apply the "diff.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:12 +0100
Message-Id: <patch-08.17-6c5f4861471-20230317T152724Z-avarab@gmail.com>
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
"diff.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c                                   | 2 +-
 builtin/rebase.c                                | 2 +-
 builtin/stash.c                                 | 2 +-
 contrib/coccinelle/the_repository.cocci         | 4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 4 ----
 diff.h                                          | 3 ---
 log-tree.c                                      | 2 +-
 range-diff.c                                    | 2 +-
 8 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f249aca049a..b76a1c82d8f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1371,7 +1371,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			.other_arg = &other_arg
 		};
 
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 		opts.file = rev->diffopt.file;
 		opts.use_color = rev->diffopt.use_color;
 		diff_setup_done(&opts);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index eba48bffaad..76cce94373e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1786,7 +1786,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 
 		/* We want color (if set), but no pager */
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 		opts.stat_width = -1; /* use full terminal width */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
diff --git a/builtin/stash.c b/builtin/stash.c
index ed1275829e7..6c062e52048 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -427,7 +427,7 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 	 * to the index before a merge was run) and the current index
 	 * (reflecting the changes brought in by the merge).
 	 */
-	diff_setup(&diff_opts);
+	repo_diff_setup(the_repository, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 0cdf3f46304..3c0bd8781e7 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -73,6 +73,10 @@
 |
 - get_commit_tree
 + repo_get_commit_tree
+// diff.h
+|
+- diff_setup
++ repo_diff_setup
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index bf19e6a2487..00461ee86b3 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// diff.h
-- diff_setup
-+ repo_diff_setup
 // object-store.h
-|
 - read_object_file
 + repo_read_object_file
 |
diff --git a/diff.h b/diff.h
index 8d770b1d579..8b510eb579d 100644
--- a/diff.h
+++ b/diff.h
@@ -535,9 +535,6 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
-#endif
 void repo_diff_setup(struct repository *, struct diff_options *);
 struct option *add_diff_options(const struct option *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
diff --git a/log-tree.c b/log-tree.c
index 4bebb86ecac..1bd4d6ab008 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -849,7 +849,7 @@ void show_log(struct rev_info *opt)
 		 * Pass minimum required diff-options to range-diff; others
 		 * can be added later if deemed desirable.
 		 */
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 		opts.file = opt->diffopt.file;
 		opts.use_color = opt->diffopt.use_color;
 		diff_setup_done(&opts);
diff --git a/range-diff.c b/range-diff.c
index 5bcf966f6c5..15d0bc35a87 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -485,7 +485,7 @@ static void output(struct string_list *a, struct string_list *b,
 	if (range_diff_opts->diffopt)
 		memcpy(&opts, range_diff_opts->diffopt, sizeof(opts));
 	else
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 
 	opts.no_free = 1;
 	if (!opts.output_format)
-- 
2.40.0.rc1.1034.g5867a1b10c5


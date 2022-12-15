Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6CC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLOIws (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLOIwc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729F286FC
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w15so2281847wrl.9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUVG1T3e5KOzbjNytgckKwmcnBoi3CdYMk+VaOSV6ng=;
        b=BF/NBMrRUizaeIot7Fmvz+RCondDnSCvlRmVLErAGIBuYrnNcmTVa4Nq50U6ocHfZV
         aAOF1bwkokufH/T12rv41FTtnRz5zlKdxabVyVlczO+yol6QaSUJbsPXZzXWjQShED59
         eLj9GOcaqKSh+hSMCIB3V13OD3L1DUUeo45QxVeGH81e0JIaxruK4nf0pc0u4SHPqtz5
         S2FblUy6ZuFrGexSNqC3VV16Tjtd8Y0t9QmGKq+7/Jm0PW7LcdeRuiXSuWW8fd/Wr7LN
         8V8/xhiMoL5CbYo/OMAm7WxtokUIbRTrtdI4OJGOCgNL4I3/sOIsJ+FfxEtHo1ysxjEo
         bvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUVG1T3e5KOzbjNytgckKwmcnBoi3CdYMk+VaOSV6ng=;
        b=7jRyxSjlG8+8roPw5GStZ2yQ2R3R61MlO6HrVfI/+j1OEU6traInxjIkwPsXm/8+1E
         n1ezSyH+MK4+cOVPYAUcGdPeCyeYnJ0i9FSBGEKanT9x+eiXg/n7OkHjHOeQPsK+Ifer
         z+gsDi9lNdvbkovf5XJdYY7nwMfZCUt2C3VYxpLAQ5aGAiDy0yfeG1/EHC1H6bu2Tl9k
         tgRRTCM2tT+05CkJwyX2awqyJAyeWFsgQGUyqJzw129rKCCgjlE6NPTdLsyIYg+uNC+v
         othFXH+mdZtLbN/+4sJWvbBfku1LDXlAypsk0Paneph7zUekiFW+/djY7jweQRS0Qdbd
         weNQ==
X-Gm-Message-State: AFqh2krgptlVnQS6muFEuI6PmaqWn1ftsfIpK6Ytmyax8hRN7YQCb0mZ
        bHeCcvHCL9knQVNxI++GDBacsKtfgimRkQ==
X-Google-Smtp-Source: AMrXdXtWrjEStIVDENhZysrKvbKHHa5+Xx4guCfGvLoxuxmeGuM2RLqRoRMtv5q5iqbKXPDI5mBd7g==
X-Received: by 2002:a5d:58f8:0:b0:256:1d9b:bd4b with SMTP id f24-20020a5d58f8000000b002561d9bbd4bmr3889277wrd.55.1671094349438;
        Thu, 15 Dec 2022 00:52:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 05/12] merge-index: migrate to parse_options() API
Date:   Thu, 15 Dec 2022 09:52:09 +0100
Message-Id: <patch-v10-05.12-a3f69564ac5-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate the "merge-index" command to the parse_options() API, a
preceding commit added tests for the existing behavior.

In a subsequent commit we'll adjust the behavior to be more consistent
with how most other commands work, but for now let's take pains to
preserve it as-is. We need to e.g. call parse_options() twice now, as
the "-a" option is currently only understood after "<merge-program>".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c  | 71 ++++++++++++++++++++++++++----------------
 git.c                  |  2 +-
 t/t6060-merge-index.sh | 10 +++---
 3 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 69b18ed82ac..3855531c579 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,5 +1,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "parse-options.h"
 #include "run-command.h"
 
 static const char *pgm;
@@ -72,7 +73,26 @@ static void merge_all(void)
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
-	int i, force_file = 0;
+	int all = 0;
+	const char * const usage[] = {
+		N_("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))"),
+		NULL
+	};
+#define OPT__MERGE_INDEX_ALL(v) \
+	OPT_BOOL('a', NULL, (v), \
+		 N_("merge all files in the index that need merging"))
+	struct option options[] = {
+		OPT_BOOL('o', NULL, &one_shot,
+			 N_("don't stop at the first failed merge")),
+		OPT__QUIET(&quiet, N_("be quiet")),
+		OPT__MERGE_INDEX_ALL(&all), /* include "-a" to show it in "-bh" */
+		OPT_END(),
+	};
+	struct option options_prog[] = {
+		OPT__MERGE_INDEX_ALL(&all),
+		OPT_END(),
+	};
+#undef OPT__MERGE_INDEX_ALL
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -80,38 +100,35 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))");
+		usage_with_options(usage, options);
+
+	/* Option parsing without <merge-program> options */
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (all)
+		usage_msg_optf(_("'%s' option can only be provided after '<merge-program>'"),
+			      usage, options, "-a");
+	/* <merge-program> and its options */
+	if (!argc)
+		usage_msg_opt(_("need a <merge-program> argument"), usage, options);
+	pgm = argv[0];
+	argc = parse_options(argc, argv, prefix, options_prog, usage, 0);
+	if (argc && all)
+		usage_msg_opt(_("'-a' and '<file>...' are mutually exclusive"),
+			      usage, options);
 
 	repo_read_index(the_repository);
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
 
-	i = 1;
-	if (!strcmp(argv[i], "-o")) {
-		one_shot = 1;
-		i++;
-	}
-	if (!strcmp(argv[i], "-q")) {
-		quiet = 1;
-		i++;
-	}
-	pgm = argv[i++];
-	for (; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!force_file && *arg == '-') {
-			if (!strcmp(arg, "--")) {
-				force_file = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-a")) {
-				merge_all();
-				continue;
-			}
-			die("git merge-index: unknown option %s", arg);
-		}
-		merge_one_path(arg);
-	}
+
+	if (all)
+		merge_all();
+	else
+		for (size_t i = 0; i < argc; i++)
+			merge_one_path(argv[i]);
+
 	if (err && !quiet)
 		die("merge program failed");
 	return err;
diff --git a/git.c b/git.c
index 277a8cce840..557a33925e3 100644
--- a/git.c
+++ b/git.c
@@ -560,7 +560,7 @@ static struct cmd_struct commands[] = {
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
-	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-index", cmd_merge_index, RUN_SETUP },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index edc03b41ab9..6c59e7bc4e5 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -22,9 +22,10 @@ test_expect_success 'usage: 2 arguments' '
 
 test_expect_success 'usage: -a before <program>' '
 	cat >expect <<-\EOF &&
-	fatal: git merge-index: b not in the cache
+	fatal: '\''-a'\'' option can only be provided after '\''<merge-program>'\''
 	EOF
-	test_expect_code 128 git merge-index -a b program >out 2>actual &&
+	test_expect_code 129 git merge-index -a b program >out 2>actual.raw &&
+	grep "^fatal:" actual.raw >actual &&
 	test_must_be_empty out &&
 	test_cmp expect actual
 '
@@ -33,9 +34,10 @@ for opt in -q -o
 do
 	test_expect_success "usage: $opt after -a" '
 		cat >expect <<-EOF &&
-		fatal: git merge-index: unknown option $opt
+		fatal: '\''-a'\'' option can only be provided after '\''<merge-program>'\''
 		EOF
-		test_expect_code 128 git merge-index -a $opt >out 2>actual &&
+		test_expect_code 129 git merge-index -a $opt >out 2>actual.raw &&
+		grep "^fatal:" actual.raw >actual &&
 		test_must_be_empty out &&
 		test_cmp expect actual
 	'
-- 
2.39.0.rc2.1048.g0e5493b8d5b


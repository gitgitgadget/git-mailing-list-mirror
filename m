Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6936AC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiKRLSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiKRLSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837F15A38
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m22so12172311eji.10
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA6/mZb7+6bN66lK8hMNUdrqBO7YwIM1KUWly6kRs7M=;
        b=j0/qYKsUrlk6BcZclkTrpaBpGfXS/dZyjFbebc8uQyDMYO+swPnBEa9mpQnglhwQL5
         sEaDnot0UFG5kAMeqAT4FUwFT0WzmRIfeLY/SE+YlGzbTuufK8u0VXPG8tKHj38Avohx
         dor0dtNqKMf2mP99SMhAwazPtdBWEjCyk+W/b3BbaWt8mCM+1y9cR9EwDNMcRa4tag0n
         HotS7Ag33VaBMCjKogTuPGuU7Ba0GfoeEjb/q/5mgLBzYqZ3SSvP2sGB0obfGEJ6L2Ra
         N9DdIRNrYGZP4MUFh3wTKMxU8DD0ijw6K3ybvA4rR4DqgBR1Q81M7tNOc4uutIzc8ORM
         3D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA6/mZb7+6bN66lK8hMNUdrqBO7YwIM1KUWly6kRs7M=;
        b=lmPKEC0b6FTg3dKKJPY2FVkiClwKyuHNiEuLTNaAbbCmPJnKuc9949oHUrviRjOhbX
         63Ewuh9XO0mwvUychAfa5LM51p3+gAZjWsyTbVvH0qkTAONLsLxl4IQOPA1lvBe33nge
         Mz++FLzB0dS8MzmLq1EkFV5BAYWwCgUziJGxdQjubn51sDjbMWiNCSSXxT2v9u6UbVHR
         ZcPuR/kMU4aTGQs7UdUcUfLPJgDAgrWzlSiP7SsiIejtFCMzmFV8zSY5qj3+FOSm660l
         JPyo+k3nnXa+KEoH2HhVVNsOMjw9bfy/pQ41QuGuXVl9sN6UXbuhBgrTNe8B8erUBa8B
         lPgg==
X-Gm-Message-State: ANoB5pkanZkX1ZT7HUeYxeV7vOJRm0xfTdlvKFUcF4qMZqOa7uskzpjF
        uoQaDutsOZMKM1NVS7OiCagkgc2ArL1z8w==
X-Google-Smtp-Source: AA0mqf5ktEP4m113XidwujbF9aYJlqtdCqQRJnal1gxNZuyfIJinTS5BBZz1S71OBdo1dFbgLPT+4Q==
X-Received: by 2002:a17:906:1c52:b0:780:bd74:f960 with SMTP id l18-20020a1709061c5200b00780bd74f960mr5524260ejg.701.1668770317716;
        Fri, 18 Nov 2022 03:18:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:37 -0800 (PST)
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
Subject: [PATCH v9 05/12] merge-index: migrate to parse_options() API
Date:   Fri, 18 Nov 2022 12:18:22 +0100
Message-Id: <patch-v9-05.12-845f9b0cc19-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
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
index 1a5a64afd2a..3bd0790465e 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,5 +1,6 @@
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
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
 
 	read_cache();
 
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
index 6662548986f..83696fd8b4a 100644
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
2.38.0.1511.gcdcff1f1dc2


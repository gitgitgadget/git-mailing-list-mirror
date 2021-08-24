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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D97BC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5068261262
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhHXJQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhHXJQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:16:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40EC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e5so13646920wrp.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FL064AzexlrSGZmL8Gv9VXzA7yyS86A4Wr86hubsW0E=;
        b=V1R8czo342X4L57xMpultZh03pP1eXTrAoi2AEuiqC7bcK44SbB0DdvAJkCYph1fMI
         bami1Ranpa/+lkQveyTjrU9Fz5Fyb9VGWIiMqyHcMNd/MH9X3yCsEflr9jnM6VrHGaWi
         zJ9oBVtCnz1fDZFORBJdnEIGdTIrf76MVQvoaxIeHG9btZ5k0cHPKFVCJzVZu5Nr++m1
         C4di6moA9xYOOvGIbuBDhGSlhOId5UT40toQmIy6scnSM/FIHkUSc0Lj8XHVMu7HzCKJ
         uCoekYsNxy8s3g3rm5nW0FBMWFFBuBz7GpkdOyrzymmbfe91+lCDufrXtuUvguM2H0YH
         OkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FL064AzexlrSGZmL8Gv9VXzA7yyS86A4Wr86hubsW0E=;
        b=ukn0cjRqFtnsZCQQP+/CXl6F4QDoEg/ypImsguKMnBEbbkVcEbmvMwFFVabOd9BcKk
         dkQp0Ls0RnW7FU5r4lnpamjLUHWs5Xb6IGYr9fddQPUraTkjmCRGZwe1UfszCOgEWPo7
         QG1VYN7FPRAWSHmuznWDZkstDCovLK9pzP6pgoDH9EpkueUjGaLb1sgQQkLS9XNoM1Ey
         4dEM1/fUnngfeFJ6s1Jlqbv0c8QDspBYme+MwdYX9oy0aMuJQZmqEGtbTPLq83FQ1tsp
         x0wP+xFPnzw+qESlXJs8BuxRnwfkjCzrkB+U1JqocfOQIQL49dxWHRewgosJfD+QK+fi
         WlXg==
X-Gm-Message-State: AOAM530Yor45B7tJELFeTRr3Ej/3Npo2dw/61+z2MnQHdVeALDt5L2fz
        xW4DPOBGNRZ4cjKpXF7vhffPViYrkeZ0Zg==
X-Google-Smtp-Source: ABdhPJyRwv4YqRpbW5jVGCtF/3mFSH8NCohMB9uL6wmxdkvgIEHqHb2JKCaBIBGdfSZlXenOR/wJ6Q==
X-Received: by 2002:adf:d4c2:: with SMTP id w2mr18725956wrk.235.1629796531926;
        Tue, 24 Aug 2021 02:15:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm1853104wmq.45.2021.08.24.02.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:15:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] test-tool: split up test-tool read-cache
Date:   Tue, 24 Aug 2021 11:15:22 +0200
Message-Id: <patch-v2-1.4-adb3f989a29-20210824T091204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gbaff4edb973
In-Reply-To: <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "test-tool read-cache" was originally added back in
1ecb5ff141 (read-cache: add simple performance test, 2013-06-09) the
test-read-cache.c tool has been growing various features that make the
code harder to read. I.e. sometimes running as a one-off, sometimes looping.

It's also been unconditionally reading config since
dc76852df2f (fsmonitor: demonstrate that it is not refreshed after
discard_index(), 2019-05-07), which introduces unnecessary noise into
the performance test.

Then in recent changes in e2df6c3972 (test-read-cache: print cache
entries with --table, 2021-03-30) and 2782db3eed (test-tool: don't
force full index, 2021-03-30) we gained even more logic to deal with
sparse index testing.

I think that having one test tool do so many different things makes it
harder to read its code. Let's instead split up the "again" and "perf"
uses for it into their own small tools, this makes the main
"test-read-cache.c" a simpler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                         |  2 ++
 t/helper/test-read-cache-again.c | 31 ++++++++++++++++++
 t/helper/test-read-cache-perf.c  | 21 ++++++++++++
 t/helper/test-read-cache.c       | 56 +++++++++++++-------------------
 t/helper/test-tool.c             |  2 ++
 t/helper/test-tool.h             |  2 ++
 t/perf/p0002-read-cache.sh       |  2 +-
 t/t7519-status-fsmonitor.sh      |  2 +-
 8 files changed, 83 insertions(+), 35 deletions(-)
 create mode 100644 t/helper/test-read-cache-again.c
 create mode 100644 t/helper/test-read-cache-perf.c

diff --git a/Makefile b/Makefile
index 9573190f1d7..4d3f8ece74f 100644
--- a/Makefile
+++ b/Makefile
@@ -739,6 +739,8 @@ TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
 TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
+TEST_BUILTINS_OBJS += test-read-cache-again.o
+TEST_BUILTINS_OBJS += test-read-cache-perf.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
diff --git a/t/helper/test-read-cache-again.c b/t/helper/test-read-cache-again.c
new file mode 100644
index 00000000000..707db036cb1
--- /dev/null
+++ b/t/helper/test-read-cache-again.c
@@ -0,0 +1,31 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__read_cache_again(int argc, const char **argv)
+{
+	struct repository *r = the_repository;
+	int i, cnt;
+	const char *name;
+
+	if (argc != 2)
+		die("usage: test-tool read-cache-again <count> <file>");
+
+	cnt = strtol(argv[0], NULL, 0);
+	name = argv[2];
+
+	setup_git_directory();
+	for (i = 0; i < cnt; i++) {
+		int pos;
+		repo_read_index(r);
+		refresh_index(r->index, REFRESH_QUIET,
+			      NULL, NULL, NULL);
+		pos = index_name_pos(r->index, name, strlen(name));
+		if (pos < 0)
+			die("%s not in index", name);
+		printf("%s is%s up to date\n", name,
+		       ce_uptodate(r->index->cache[pos]) ? "" : " not");
+		write_file(name, "%d\n", cnt);
+		discard_index(r->index);
+	}
+	return 0;
+}
diff --git a/t/helper/test-read-cache-perf.c b/t/helper/test-read-cache-perf.c
new file mode 100644
index 00000000000..90176c010a1
--- /dev/null
+++ b/t/helper/test-read-cache-perf.c
@@ -0,0 +1,21 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__read_cache_perf(int argc, const char **argv)
+{
+	struct repository *r = the_repository;
+	int i, cnt = 1;
+
+	if (argc == 2)
+		cnt = strtol(argv[1], NULL, 0);
+	else
+		die("usage: test-tool read-cache-perf [<count>]");
+
+	setup_git_directory();
+	for (i = 0; i < cnt; i++) {
+		repo_read_index(r);
+		discard_index(r->index);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b52c174acc7..616894072d1 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -5,6 +5,12 @@
 #include "commit.h"
 #include "tree.h"
 #include "sparse-index.h"
+#include "parse-options.h"
+
+static const char *read_cache_usage[] = {
+	"test-tool read-cache [<options>...]",
+	NULL
+};
 
 static void print_cache_entry(struct cache_entry *ce)
 {
@@ -34,49 +40,33 @@ static void print_cache(struct index_state *istate)
 int cmd__read_cache(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
-	int i, cnt = 1;
-	const char *name = NULL;
 	int table = 0, expand = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "table", &table,
+			 "print a dump of the cache"),
+		OPT_BOOL(0, "expand", &expand,
+			 "call ensure_full_index()"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, "test-tools", options, read_cache_usage, 0);
+	if (argc)
+		usage_msg_opt("Too many arguments.", read_cache_usage, options);
 
 	initialize_the_repository();
 	prepare_repo_settings(r);
 	r->settings.command_requires_full_index = 0;
 
-	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
-		if (skip_prefix(*argv, "--print-and-refresh=", &name))
-			continue;
-		if (!strcmp(*argv, "--table"))
-			table = 1;
-		else if (!strcmp(*argv, "--expand"))
-			expand = 1;
-	}
-
-	if (argc == 1)
-		cnt = strtol(argv[0], NULL, 0);
 	setup_git_directory();
 	git_config(git_default_config, NULL);
+	repo_read_index(r);
 
-	for (i = 0; i < cnt; i++) {
-		repo_read_index(r);
-
-		if (expand)
-			ensure_full_index(r->index);
+	if (expand)
+		ensure_full_index(r->index);
 
-		if (name) {
-			int pos;
+	if (table)
+		print_cache(r->index);
+	discard_index(r->index);
 
-			refresh_index(r->index, REFRESH_QUIET,
-				      NULL, NULL, NULL);
-			pos = index_name_pos(r->index, name, strlen(name));
-			if (pos < 0)
-				die("%s not in index", name);
-			printf("%s is%s up to date\n", name,
-			       ce_uptodate(r->index->cache[pos]) ? "" : " not");
-			write_file(name, "%d\n", i);
-		}
-		if (table)
-			print_cache(r->index);
-		discard_index(r->index);
-	}
 	return 0;
 }
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3ce5585e53a..fb537c158e9 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -57,6 +57,8 @@ static struct test_cmd cmds[] = {
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
+	{ "read-cache-again", cmd__read_cache_again },
+	{ "read-cache-perf", cmd__read_cache_perf },
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9f0f5228508..e5616e6f7a7 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -46,6 +46,8 @@ int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
+int cmd__read_cache_again(int argc, const char **argv);
+int cmd__read_cache_perf(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index cdd105a5945..d0ba5173fb1 100755
--- a/t/perf/p0002-read-cache.sh
+++ b/t/perf/p0002-read-cache.sh
@@ -8,7 +8,7 @@ test_perf_default_repo
 
 count=1000
 test_perf "read_cache/discard_cache $count times" "
-	test-tool read-cache $count
+	test-tool read-cache-perf $count
 "
 
 test_done
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index deea88d4431..7de5fcb1bd7 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -360,7 +360,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
 	test_might_fail git update-index --refresh &&
-	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
+	test-tool read-cache-again 2 tracked >actual &&
 	printf "tracked is%s up to date\n" "" " not" >expect &&
 	test_cmp expect actual
 '
-- 
2.33.0.663.gbaff4edb973


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A1C43381
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D28F64F45
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCQN2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhCQN2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:28:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF3BC061760
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3377156wmy.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3TFlgltYvc50tTPtlZGXggR2zaCmsjuG7+xA3uhBWE=;
        b=Rm9f3LsleApTQ0dEmNS+U98fmBB781sZQylZuoysdRjTTMzNPwS+kNftJ1Caxx0syb
         /c66b2qx8bzkAv0QlVRBzOAj33BzHid644QQTkUeJtm0ZMSMjXeVPJQBhzWFOWKFnKsh
         qRDz0YZ9Q5up4LMwxR5/tkhB2bCL0R+xOJxw9ssXvozwCrUVVirMc59Esof4Z99hlfdw
         ttd7FUYfNhqsIch3YyRZDnfqCpOIHoHzojR9chFKiwFFX4/Pcat4/mk6wkQIkNVr8jb9
         QL0+ua8jHho0umeX4LLSon4SZNCBwDkQMvcXNrgKaCJ7JFu/9+EkOxNmmkjOSokj+BRg
         gQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3TFlgltYvc50tTPtlZGXggR2zaCmsjuG7+xA3uhBWE=;
        b=PXFowwLOdK1QWQhbyHWcs2fOA1zigBngi3Yi6sRzfybYDTBVNEz8DSNTVHj6ewYVx+
         Vpn/nhpUSIVx8vthKcbCC5sOAXd/8za+wxdJgt6W4Sfkd9nDC67CVTJOoISv2bUYRdmU
         S0bzwNIrTOY8rbV4afezjIelnav3M2iHnRgUjWY77z9nQZvGVLq9693u9SMgZZviEhyk
         PbVbi1Ap7XazDNJ0HMd/0mYhpLrqWHlZv8WHQq5yJHn8mTGRClfDSKz4pPSFem4OgSzc
         YghVcVNLGbMeJrJe1mmYrvohO4lAg48VdIfSuIGs9gz9BTMCbKUSEkx8flIj1r7yeq2A
         WMGw==
X-Gm-Message-State: AOAM530C+byyi3LuNZxdc6fuezW6pM0UpMZ/MOWwSBfQsyBf/TKFFgYO
        HyA1kAF3SzzT36TvztHbrEcPyMRiTJEhQQ==
X-Google-Smtp-Source: ABdhPJy6Iuudil9yGfh2mXIwczcO73RDv4VLb7vJqPJJXcAfP6fYOqQH3M9CERaMlsP3eSsxGcQRSQ==
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr3875340wmi.64.1615987716905;
        Wed, 17 Mar 2021 06:28:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm26061448wrt.70.2021.03.17.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:28:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: [RFC/PATCH 5/5] test-tool: split up test-tool read-cache
Date:   Wed, 17 Mar 2021 14:28:14 +0100
Message-Id: <20210317132814.30175-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "test-tool read-cache" was originally added back in
1ecb5ff141 (read-cache: add simple performance test, 2013-06-09) it's
been growing all sorts of bells and whistles that aren't very
conducive to performance testing the index, e.g. it learned how to
read config.

Let's split what remains of the "test-tool read-cache" into the two
narrow use-cases it's used for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                         |  3 ++-
 t/helper/test-read-cache-again.c | 31 +++++++++++++++++++++++++
 t/helper/test-read-cache-perf.c  | 21 +++++++++++++++++
 t/helper/test-read-cache.c       | 39 --------------------------------
 t/helper/test-tool.c             |  3 ++-
 t/helper/test-tool.h             |  3 ++-
 t/perf/p0002-read-cache.sh       |  2 +-
 t/t7519-status-fsmonitor.sh      |  2 +-
 8 files changed, 60 insertions(+), 44 deletions(-)
 create mode 100644 t/helper/test-read-cache-again.c
 create mode 100644 t/helper/test-read-cache-perf.c
 delete mode 100644 t/helper/test-read-cache.c

diff --git a/Makefile b/Makefile
index 89b1d53741..a1bbb818d9 100644
--- a/Makefile
+++ b/Makefile
@@ -724,7 +724,8 @@ TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
 TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
-TEST_BUILTINS_OBJS += test-read-cache.o
+TEST_BUILTINS_OBJS += test-read-cache-again.o
+TEST_BUILTINS_OBJS += test-read-cache-perf.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
diff --git a/t/helper/test-read-cache-again.c b/t/helper/test-read-cache-again.c
new file mode 100644
index 0000000000..5e20ca1c8f
--- /dev/null
+++ b/t/helper/test-read-cache-again.c
@@ -0,0 +1,31 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__read_cache_again(int argc, const char **argv)
+{
+	struct repository *r = the_repository;
+	int cnt;
+	const char *name;
+
+	if (argc != 2)
+		die("usage: test-tool read-cache-again <count> <file>");
+
+	cnt = strtol(argv[0], NULL, 0);
+	name = argv[2];
+
+	setup_git_directory();
+	while (cnt--) {
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
index 0000000000..ac9c297efa
--- /dev/null
+++ b/t/helper/test-read-cache-perf.c
@@ -0,0 +1,21 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__read_cache_perf(int argc, const char **argv)
+{
+	struct repository *r = the_repository;
+	int cnt = 1000;
+
+	if (argc == 1)
+		cnt = strtol(argv[0], NULL, 0);
+	else if (argc)
+		die("usage: test-tool read-cache-perf [<count>]");
+
+	setup_git_directory();
+	while (cnt--) {
+		repo_read_index(r);
+		discard_index(r->index);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
deleted file mode 100644
index 2499999af3..0000000000
--- a/t/helper/test-read-cache.c
+++ /dev/null
@@ -1,39 +0,0 @@
-#include "test-tool.h"
-#include "cache.h"
-#include "config.h"
-
-int cmd__read_cache(int argc, const char **argv)
-{
-	struct repository *r = the_repository;
-	int i, cnt = 1;
-	const char *name = NULL;
-
-	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
-		if (skip_prefix(*argv, "--print-and-refresh=", &name))
-			continue;
-	}
-
-	if (argc == 1)
-		cnt = strtol(argv[0], NULL, 0);
-	setup_git_directory();
-	git_config(git_default_config, NULL);
-
-	for (i = 0; i < cnt; i++) {
-		repo_read_index(r);
-
-		if (name) {
-			int pos;
-
-			refresh_index(r->index, REFRESH_QUIET,
-				      NULL, NULL, NULL);
-			pos = index_name_pos(r->index, name, strlen(name));
-			if (pos < 0)
-				die("%s not in index", name);
-			printf("%s is%s up to date\n", name,
-			       ce_uptodate(r->index->cache[pos]) ? "" : " not");
-			write_file(name, "%d\n", i);
-		}
-		discard_index(r->index);
-	}
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f97cd9f48a..1334fa25ba 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -52,7 +52,8 @@ static struct test_cmd cmds[] = {
 	{ "proc-receive", cmd__proc_receive},
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
-	{ "read-cache", cmd__read_cache },
+	{ "read-cache-again", cmd__read_cache_again },
+	{ "read-cache-perf", cmd__read_cache_perf },
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 28072c0ad5..d70cde8574 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -41,7 +41,8 @@ int cmd__prio_queue(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
-int cmd__read_cache(int argc, const char **argv);
+int cmd__read_cache_again(int argc, const char **argv);
+int cmd__read_cache_perf(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index cdd105a594..d0ba5173fb 100755
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
index 45d025f960..3761a8781d 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -359,7 +359,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
 	test_might_fail git update-index --refresh &&
-	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
+	test-tool read-cache-again 2 tracked >actual &&
 	printf "tracked is%s up to date\n" "" " not" >expect &&
 	test_cmp expect actual
 '
-- 
2.31.0.260.g719c683c1d


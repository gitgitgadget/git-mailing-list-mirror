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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C3C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D304C61208
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFGMBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:01:40 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:47067 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGMBh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:01:37 -0400
Received: by mail-wr1-f43.google.com with SMTP id a11so15408401wrt.13
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SFQVszDfc9jEdSowYFdVPzt+0lUNS6ZXcUUW7YgVck=;
        b=nLhs/xxDgxYmUsMGmdRS31zsA/+YnlQ8M6UelvchAPpCfBPZGX0KYQEQw6Sux2P4Hn
         QVfGKuPF6ikRmFGnUXgtmOowR9e160iPIFqH1UfHf/ToaOZMTZ9M7pC2stveAobfkiVR
         kBL+zd4AH7etajhKtULN735WkqguEXCtke7O1AyC36/R7s6daeq4sZ53CRhBkCLB8YdT
         FaaR3UIWMte7B4jcOR0YCS68LKddlRmoYvvSrvXgntTgaqrCbB9ZqV4uduv4PktQkJye
         +J02UVnzD8qOtygM5Hk7L1ycJpwQvUrsWo6BUgZtGAw40lkq2MBX9an1Y5EPGHgit9C7
         16yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SFQVszDfc9jEdSowYFdVPzt+0lUNS6ZXcUUW7YgVck=;
        b=qTQnTMlTFcPdC/KFjN3Lhs8+cfe3CJkAXSfltmNzFGuig79Z+iBNEILiLk2IyrSV3Y
         KXImMViiE2uYOCKCjEf6yKpN6nzxjeBFjbGUq1vJIosJbi1ye9tvFNQiSfgIy646tTqk
         9d5zfOpN/0y13jQuu4i5G4pMiexdd1PrY//RhLwJlFn0inUN8pD8YezBRn0sMSYZ9R7D
         mRkxv7aUd8TqBFZYsCft+a3maYK6dMt19vB8xHFYZz7e7Ms39fSc5pDr+kXvUglQdVM7
         2+gDMhc1BOaGHzaC3wULm5nplYinX1APvuye8cR4N8bFwXWOrBkDgpnRlHuUffNl49W4
         Mekg==
X-Gm-Message-State: AOAM532XAtDMp5Mc/TJcSLnyyzJu8cPOzyyX7NQ6HcZE3sRCRgrsM92D
        EX82jOF/PwnoJ4t6/zlz0qpqaLRyWPW2Qg==
X-Google-Smtp-Source: ABdhPJzMHZ/6Gm5UqHhs3V9UyULWa0rNVCavQYSz4sqte9NMFX1SWyAS4KleNaSmUFDrgWdTCeVD2A==
X-Received: by 2002:adf:ec43:: with SMTP id w3mr16216859wrn.270.1623067114106;
        Mon, 07 Jun 2021 04:58:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 92sm17215166wrp.88.2021.06.07.04.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:58:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] test-tool: split up test-tool read-cache
Date:   Mon,  7 Jun 2021 13:58:24 +0200
Message-Id: <patch-1.4-6e7fcd4693-20210607T115454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
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

Then in recent changes in e2df6c3972 (test-read-cache: print cache
entries with --table, 2021-03-30) and 2782db3eed (test-tool: don't
force full index, 2021-03-30) we gained even more logic to deal with
sparse index testing.

I think that having one test tool do so many different things makes it
harder to read its code. Let's instead split up the "again" and "perf"
uses for it into their own tools.

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
index c3565fc0f8..142303bd17 100644
--- a/Makefile
+++ b/Makefile
@@ -732,6 +732,8 @@ TEST_BUILTINS_OBJS += test-prio-queue.o
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
index 0000000000..707db036cb
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
index 0000000000..90176c010a
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
index b52c174acc..ae4b9b70ad 100644
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
+	if (argc > 0)
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
index c5bd0c6d4c..b0300f70c7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -54,6 +54,8 @@ static struct test_cmd cmds[] = {
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
+	{ "read-cache-again", cmd__read_cache_again },
+	{ "read-cache-perf", cmd__read_cache_perf },
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e8069a3b22..7f451a1eb5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -43,6 +43,8 @@ int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
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
index 637391c6ce..4c199c16d4 100755
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
2.32.0.rc3.434.gd8aed1f08a7


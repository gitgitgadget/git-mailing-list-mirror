Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B424CA0EC1
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbjIKVcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbjIKPGz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:06:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E88FA
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a9cd066db5so580013566b.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444808; x=1695049608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIuBc1u92iLzcfmkHZ+6m29kIwnDkPD0rFroXqkZje4=;
        b=NXDQT5gtiqfrKWuxdWyu8JsLzuWjr4CILOt/W5idVi7scIfmngluZZNS1SI60b+kbA
         V44a8fBbTwiG52Sy+HmwFN0FdNoyE+WQWNC1/ByuhLjoWmy0ae8swSIH3qu2oIOoyIpv
         qhkLhkz1Gyb7MH0jMjw6Z6KTqA1+ZBAQX0rd5sVCIJLHjMshDl4m73vxb8kKQWf4LKj+
         RS3pOho9FBPcfcfQCa8gMvHIKT7FOVzJ4YtZTzy7mLYD6Y/9Os2z9yFFNmeCjN06zpcW
         +swQyvXrfcXTFEtoznXGZwIXG3eAEQ2N85j6mRoP7KNVB0DS/eMxUECXlsW4Hn2ktyby
         7tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444808; x=1695049608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIuBc1u92iLzcfmkHZ+6m29kIwnDkPD0rFroXqkZje4=;
        b=H9lvImy2XtQOG/UQs7e63/X4zcuG+kpBYFqPK3szUsXoK3naj6Cma9/OEuP5IIeR4P
         RZb9GODus1MiLVDCDqyPeFcaX+ZzLQAqmdPJ05KvYaQSH65ysLnas02N46i5bS4+N9xO
         4nRiW2g6FR4g0ANDx8N10KQh8hEJAYPBZOl3/LJ9rW2TtfEmfgtc+FfFCOMTFwWAF7J0
         M/C3ocvq0KEkYDX94ZP6lkJoz9MYrz2s6cNvLlYuZGXQ47iOxCBqp2xYYFd0Zdz8krd+
         4Ami1xae8bj47KrBNxFFilTsKTYVlD2dOc8IjCiVYe0Ivc4FMjzqVnFp8M0lLF0htwVc
         9dtw==
X-Gm-Message-State: AOJu0YwuAssgBXWejOblv9VEapT6JQifsdBZloVa8M6YS4dYoa6poizY
        1VeNTCWMcdStUiwTQWDDCR4fYXbBIxY=
X-Google-Smtp-Source: AGHT+IHOcBudCi6fibOy8BF96z6fJhwDGNoWq/rGqF4cmucQalcyFgUE+m06f7UsLP3znb2OSIqpSw==
X-Received: by 2002:a17:906:32d2:b0:9aa:1e2d:d7fd with SMTP id k18-20020a17090632d200b009aa1e2dd7fdmr4687793ejk.21.1694444807927;
        Mon, 11 Sep 2023 08:06:47 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:47 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 2/9] t/helper: add 'find-pack' test-tool
Date:   Mon, 11 Sep 2023 17:06:11 +0200
Message-ID: <20230911150618.129737-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a following commit, we will make it possible to separate objects in
different packfiles depending on a filter.

To make sure that the right objects are in the right packs, let's add a
new test-tool that can display which packfile(s) a given object is in.

Let's also make it possible to check if a given object is in the
expected number of packfiles with a `--check-count <n>` option.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                  |  1 +
 t/helper/test-find-pack.c | 50 ++++++++++++++++++++++++
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 t/t0080-find-pack.sh      | 82 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 t/helper/test-find-pack.c
 create mode 100755 t/t0080-find-pack.sh

diff --git a/Makefile b/Makefile
index 5776309365..742b76998e 100644
--- a/Makefile
+++ b/Makefile
@@ -800,6 +800,7 @@ TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
+TEST_BUILTINS_OBJS += test-find-pack.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
new file mode 100644
index 0000000000..e8bd793e58
--- /dev/null
+++ b/t/helper/test-find-pack.c
@@ -0,0 +1,50 @@
+#include "test-tool.h"
+#include "object-name.h"
+#include "object-store.h"
+#include "packfile.h"
+#include "parse-options.h"
+#include "setup.h"
+
+/*
+ * Display the path(s), one per line, of the packfile(s) containing
+ * the given object.
+ *
+ * If '--check-count <n>' is passed, then error out if the number of
+ * packfiles containing the object is not <n>.
+ */
+
+static const char *find_pack_usage[] = {
+	"test-tool find-pack [--check-count <n>] <object>",
+	NULL
+};
+
+int cmd__find_pack(int argc, const char **argv)
+{
+	struct object_id oid;
+	struct packed_git *p;
+	int count = -1, actual_count = 0;
+	const char *prefix = setup_git_directory();
+
+	struct option options[] = {
+		OPT_INTEGER('c', "check-count", &count, "expected number of packs"),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, find_pack_usage, 0);
+	if (argc != 1)
+		usage(find_pack_usage[0]);
+
+	if (repo_get_oid(the_repository, argv[0], &oid))
+		die("cannot parse %s as an object name", argv[0]);
+
+	for (p = get_all_packs(the_repository); p; p = p->next)
+		if (find_pack_entry_one(oid.hash, p)) {
+			printf("%s\n", p->pack_name);
+			actual_count++;
+		}
+
+	if (count > -1 && count != actual_count)
+		die("bad packfile count %d instead of %d", actual_count, count);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index abe8a785eb..41da40c296 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
 	{ "env-helper", cmd__env_helper },
 	{ "example-decorate", cmd__example_decorate },
 	{ "fast-rebase", cmd__fast_rebase },
+	{ "find-pack", cmd__find_pack },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ea2672436c..411dbf2db4 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -25,6 +25,7 @@ int cmd__dump_reftable(int argc, const char **argv);
 int cmd__env_helper(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
+int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
diff --git a/t/t0080-find-pack.sh b/t/t0080-find-pack.sh
new file mode 100755
index 0000000000..67b11216a3
--- /dev/null
+++ b/t/t0080-find-pack.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='test `test-tool find-pack`'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four &&
+	test_commit five
+'
+
+test_expect_success 'repack everything into a single packfile' '
+	git repack -a -d --no-write-bitmap-index &&
+
+	head_commit_pack=$(test-tool find-pack HEAD) &&
+	head_tree_pack=$(test-tool find-pack HEAD^{tree}) &&
+	one_pack=$(test-tool find-pack HEAD:one.t) &&
+	three_pack=$(test-tool find-pack HEAD:three.t) &&
+	old_commit_pack=$(test-tool find-pack HEAD~4) &&
+
+	test-tool find-pack --check-count 1 HEAD &&
+	test-tool find-pack --check-count=1 HEAD^{tree} &&
+	! test-tool find-pack --check-count=0 HEAD:one.t &&
+	! test-tool find-pack -c 2 HEAD:one.t &&
+	test-tool find-pack -c 1 HEAD:three.t &&
+
+	# Packfile exists at the right path
+	case "$head_commit_pack" in
+		".git/objects/pack/pack-"*".pack") true ;;
+		*) false ;;
+	esac &&
+	test -f "$head_commit_pack" &&
+
+	# Everything is in the same pack
+	test "$head_commit_pack" = "$head_tree_pack" &&
+	test "$head_commit_pack" = "$one_pack" &&
+	test "$head_commit_pack" = "$three_pack" &&
+	test "$head_commit_pack" = "$old_commit_pack"
+'
+
+test_expect_success 'add more packfiles' '
+	git rev-parse HEAD^{tree} HEAD:two.t HEAD:four.t >objects &&
+	git pack-objects .git/objects/pack/mypackname1 >packhash1 <objects &&
+
+	git rev-parse HEAD~ HEAD~^{tree} HEAD:five.t >objects &&
+	git pack-objects .git/objects/pack/mypackname2 >packhash2 <objects &&
+
+	head_commit_pack=$(test-tool find-pack HEAD) &&
+
+	# HEAD^{tree} is in 2 packfiles
+	test-tool find-pack HEAD^{tree} >head_tree_packs &&
+	grep "$head_commit_pack" head_tree_packs &&
+	grep mypackname1 head_tree_packs &&
+	! grep mypackname2 head_tree_packs &&
+	test-tool find-pack --check-count 2 HEAD^{tree} &&
+	! test-tool find-pack --check-count 1 HEAD^{tree} &&
+
+	# HEAD:five.t is also in 2 packfiles
+	test-tool find-pack HEAD:five.t >five_packs &&
+	grep "$head_commit_pack" five_packs &&
+	! grep mypackname1 five_packs &&
+	grep mypackname2 five_packs &&
+	test-tool find-pack -c 2 HEAD:five.t &&
+	! test-tool find-pack --check-count=0 HEAD:five.t
+'
+
+test_expect_success 'add more commits (as loose objects)' '
+	test_commit six &&
+	test_commit seven &&
+
+	test -z "$(test-tool find-pack HEAD)" &&
+	test -z "$(test-tool find-pack HEAD:six.t)" &&
+	test-tool find-pack --check-count 0 HEAD &&
+	test-tool find-pack -c 0 HEAD:six.t &&
+	! test-tool find-pack -c 1 HEAD:seven.t
+'
+
+test_done
-- 
2.42.0.167.gd6ff314189


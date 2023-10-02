Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076BFE748F8
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbjJBQzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbjJBQze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C81EB3
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533df112914so18000928a12.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265729; x=1696870529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6QHRWDp7bquaIBXN4OjkivgJWCDnWcW10iYJcceakk=;
        b=GgyhJhEJdXN/7EcBcoCLg4zg1AtX8dVxbmfou/CIQ6Ajeu2F1pBuyolyOO7XC0ujU8
         1pQ2llrvRO++UbdthTkZWQ7qdvfBgqaoiGYxKA/IW4H+EcnNxQNhmBD2iRkwm3fhWyBn
         /PaF25le6WC4+9k2gGlzmAIPhUmOEwG4J0wPzBcK6gSZLKhaEIlmd6Oywfnznbivy2wI
         T6S1zKH9Cm+8tQobDnTy7FQ6CB6hssfI4du/JIay9TyDcAQqnL3sFOg5tc2SdzeGhMZq
         hu+O/Ei8+ftZOc5YZN+/1+5C8qkBCyn4S5u1IiBnQiMyiU8hWimaXAGkB5w7suHt6nDF
         l+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265729; x=1696870529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6QHRWDp7bquaIBXN4OjkivgJWCDnWcW10iYJcceakk=;
        b=WbUtIpK/TmaHh/MZYtPAnyGb2eAWt/YZMJPoI0Z3QMrTVr9srROomEtfOmRTLYrPTd
         8CUW+lipwjsRfRsRQQ3/biyFP22VaSRtoVeoSyqz5FYtPr7vsdMb6yZdQ2afVIO5uGYf
         BZQPPHJyeLNYL3d+gMhWKG1f600DTG+A1jfjBEz2s010ylDr/63yLxwrqVD/Wuas59ss
         PBDzWKO+86RTUSeWuKi1qJxyjvE6J37tEEeLI99//AW8Hbza+GyQXPXSlhT7FYdxcz/6
         ECuEZysBEmcB2N+GLz9ZJevdoT5ExD5hg2wQ51r+7OYqwCQB6UjAKWmDL4zf89DGsUHc
         JTJg==
X-Gm-Message-State: AOJu0Yye/E20YITj7lc9ZsP11TV66w2WW4IlQtk/T8OAifruJ43Ax+3z
        /+XiIlqZajp68KKJUY5eC9Ju8qytXoFeIQ==
X-Google-Smtp-Source: AGHT+IGpOah46Ab5n+efUPiXIAW21Sx15Xh9StcS1T7mELhnvQxEMbriqj+AarMu3uj9yRtVeLhfPQ==
X-Received: by 2002:aa7:d451:0:b0:536:24ff:74ff with SMTP id q17-20020aa7d451000000b0053624ff74ffmr11427127edr.5.1696265729200;
        Mon, 02 Oct 2023 09:55:29 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:28 -0700 (PDT)
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
Subject: [PATCH v8 2/9] t/helper: add 'find-pack' test-tool
Date:   Mon,  2 Oct 2023 18:54:57 +0200
Message-ID: <20231002165504.1325153-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
 t/t0081-find-pack.sh      | 82 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 t/helper/test-find-pack.c
 create mode 100755 t/t0081-find-pack.sh

diff --git a/Makefile b/Makefile
index 003e63b792..f267034d23 100644
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
index 621ac3dd10..9010ac6de7 100644
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
index a641c3a81d..f134f96b97 100644
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
diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
new file mode 100755
index 0000000000..67b11216a3
--- /dev/null
+++ b/t/t0081-find-pack.sh
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
2.42.0.305.g5bfd918c90


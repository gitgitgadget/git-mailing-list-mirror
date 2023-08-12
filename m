Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46648C001B0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjHLAAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbjHLAAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:00:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ECF19AE
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc7e65ea44so17924815ad.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798439; x=1692403239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skyNehnkSuqAclYi6nXNluuSYkwDjuqXXyzBR4Rsax8=;
        b=XmscF62QqBhsPA+2jMnyMDm2TNiRqeUlDPQbbWUwyuTGQ93oL71O128tYI6JZt8INM
         JVdluX5b+LJMClRVpoCBB9xY5D2atTkbj24+wjNZGf9VroCECR6gan5IkWEh85MOZYpL
         zhx30d95AokM/gjuf0uBgvWoh/LdS5roW4m0q/4KScsVTScDmq0lqF2HoiZlPox+UoQZ
         P7g9/9og3YUQjLNJO625YCKY5RIMHWZECOEnLWc1Jhi6H8HOh6WIJ2Wzsk+DKtAdn+Dz
         bHN0B2gjE9EsoTdpJmWFyyZ6JV948ePTB+xbfX2Yw47mnG08eGLSTX6MnKl1M2BImgaR
         bStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798439; x=1692403239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skyNehnkSuqAclYi6nXNluuSYkwDjuqXXyzBR4Rsax8=;
        b=gjPWLKdh7x+jKYwhkn/awlUU+FXhPiNwsyjkU8sTLsngj9vrzHPBZx/G2nWR99Pxyf
         LzCaE3jUdOWQMERJ8KYKo4r4WW6AXxIZPd0hwlHYOUTJTRhLmaqFf9wNk2fgwoWcTHSS
         9u+zWhHk6jvWchLvfSVCXG5qwpmwHLR7ue9ahBZYZ0r4Wnk4rLPaQX/A9HKe+65+6Ld0
         mXnSJcRzCDe7GfXPYgMMaEYyE7mw3+JoCj7H2rVaB7tAfrRQyxY3a9MKnS8GZRrl3Gul
         21a9m3ywXi4IScnFW6wOuEI5M9ZwPMcTz1jJx0YPN6v/sXPYJT9NTw1rNsjYoxzk1SNN
         VNXA==
X-Gm-Message-State: AOJu0Yzi5DnETGPJCFIyIe/hZVjQMH2FXBpSiux/UTgZlpCRFo9CcDBx
        qn+IFwm4eTaI1dHgl5CKdeFSJex1WCxnEQ==
X-Google-Smtp-Source: AGHT+IEhE/dQULFNhUE+jMRA9V7ao+SAeFHIKoqE5iN0hwQdIwhE8cfPfixMNsH4QW+OUQ0Nz3kGqg==
X-Received: by 2002:a17:902:74c8:b0:1b8:76d1:f1e8 with SMTP id f8-20020a17090274c800b001b876d1f1e8mr3597779plt.28.1691798439315;
        Fri, 11 Aug 2023 17:00:39 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:38 -0700 (PDT)
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
Subject: [PATCH v5 2/8] t/helper: add 'find-pack' test-tool
Date:   Sat, 12 Aug 2023 02:00:05 +0200
Message-ID: <20230812000011.1227371-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
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
index ace3e5a506..2534c831e8 100644
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
2.42.0.rc1.8.ga52e3a71db


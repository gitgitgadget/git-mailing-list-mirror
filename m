Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04125CE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjIYPZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjIYPZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7294A3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso834141366b.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655540; x=1696260340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m1lnk4SOv0jMEroRHHNjRkmIXEZmLmf9v7yBToSmb0=;
        b=ivR97JuBjEOOygATUiokmoj12WgYAwNaoe4ONZIyORvDSYRWQsJUjQCdL+k2R9MfIW
         NwKs8OuMVtq2ynj3SKLnMVJmF1VlMpp2Iy77IgedV1fI4tOLhDKxy70iLsqAvo+NJMHi
         8h2ZUCdh5Wa5wYQod2CzLIZ7kQ6w67jA0K+uCyc4LSQrMrYexbdaab9Uc4qkpxXFBrnz
         7TcKRWCRCHs3hTVaaA3My27Tf7a802k9aqAeNj1r9qIvPNd9qwNZRqFz4S66JeEHbXKA
         cGULIvOORYeuLG1Qs7JPs6B1Ucaw4SXcV5X2halgv8Jo1mm4peIAv9PiHa8/9d9HLrXp
         bQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655540; x=1696260340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m1lnk4SOv0jMEroRHHNjRkmIXEZmLmf9v7yBToSmb0=;
        b=VT0dGglf6AtWZ6BSCzgRA8vDGPnIdx5bDwNNwKk8h8R7Tjk/jAId9gSnEhkmW6e+K8
         nRvwza1VXEQ45aFwklueTzkwKYKHMDJ4H8+8gfe95YnJFjPAOOtiHQs5uc/4tZwFy5Ll
         taY+BLccBlUHgEynh3Em1WIKQyVT11OEeWxtzzMqI82fxs6xrkP89XAXMuCsc0j0JM3W
         98Efj0yYKPRyqBngbjHh9MCtNx0y/SYjoOk2/vHChnbYcTbVMiw3u+ITQqD4ZU8iRiZf
         zNBFlVOs2UY7Z/GOOy+03VdNbcj8LlvHrYGsnE3SAzvbhY+9uHzA4tI0QhqbAZCXS9tP
         SW7A==
X-Gm-Message-State: AOJu0YzWe9lxFPLjEv9d0cqseAEKeisWMHlV0FhVTG89me1Ugqb13BbN
        yw/zsSy3cXu+djg0GW7cF8RhWG8ylFUhZg==
X-Google-Smtp-Source: AGHT+IEJFoI59jsL6p+NN6KWLiADVVrdnivAhBmRlwzONk6Ty35dRuxND3cw8fUJXhN9PkTptM6+jQ==
X-Received: by 2002:a17:907:a0c7:b0:9ae:46f3:b03f with SMTP id hw7-20020a170907a0c700b009ae46f3b03fmr5815064ejc.0.1695655539849;
        Mon, 25 Sep 2023 08:25:39 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:38 -0700 (PDT)
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
Subject: [PATCH v7 2/9] t/helper: add 'find-pack' test-tool
Date:   Mon, 25 Sep 2023 17:25:10 +0200
Message-ID: <20230925152517.803579-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
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
2.42.0.279.g57b2ba444c


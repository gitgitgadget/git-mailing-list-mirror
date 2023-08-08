Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A0C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjHHUly (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHHUlm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:41:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB4EF3D
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:37:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so8472322a12.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691516264; x=1692121064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14kFQkukaOyYdHuI2u460N/PytYqmFh/v2uxe5BXiVc=;
        b=fpPzTxoeVYJxxQLRuthT/y1lLLEUUPaL2lrp6UWfMN+AgmBUVQLvlCA88WOe1wLxSQ
         2Iou/yq2FuRM8eotajCNhPDdNs+w7eRdQsjHRjEg21whVDjHpss3FxyKgh40mD626UU5
         FX4tM8HrethqbfGqScGxf7yd2+JY1weNCtbMaI1BA4hWgCQi4j3YYUzxRkISrxymysAM
         TE4zVkCxOuFaXFAMTRtZcgybGYHkSPlitAn9AyDutPvwLDkWvGZiOhAJeNSJpg3SX4kn
         yxX+7YEK9vDunyYV2RNozUURq+AA1MpSaLDldY7G6ItnIsTU2VSXqAkBprvUSWCbequ1
         s7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516264; x=1692121064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14kFQkukaOyYdHuI2u460N/PytYqmFh/v2uxe5BXiVc=;
        b=YDDpivl82WoA/BijwVh64cK/ZXzYcrHokI84fo68Rh4J9ReKbCkNdS18G1mxbLPtS0
         eCWX1sWHX550p1OCLxNzn9ooXANFo3+nHsr/Qv9X2Od9382MakLjqwnX3MlZ3PZ3cwV2
         ZfxqMpbtsPqPNZ0s+D+yeGcv0neMJSYl5RC81ehEdokVPP5Oc9nm6DoEw7T+nPcAGiYt
         bjQZCF2+2kHs9nbtIySgKfAcqk6nap1hzQuLvN0Nm2wMvskQ6hyMe1YjsTp/bSIEen29
         V7vddMGb1MVTow1tXL+p/n6V7mQvulrGvJUDhll4LJ2IRG+JRF27yFRFAR+CyhMT1Tom
         QWCg==
X-Gm-Message-State: AOJu0YyufP/F9I7hX4sUuZcEBrmwIdAeyY8m5fYFaZg0P2Q/s9Ud7L4x
        f+MBTckOuySrJvDNlcgXjvvE1JKcp/Q=
X-Google-Smtp-Source: AGHT+IFb3QU7mJepLvKFXZprc1rMJ5ZkedebejWhLBm1sACelgY1s8/EzKZn1BjTfaqWCDtoMp/L0w==
X-Received: by 2002:a1c:f603:0:b0:3fe:21b9:806 with SMTP id w3-20020a1cf603000000b003fe21b90806mr7747620wmc.0.1691483190256;
        Tue, 08 Aug 2023 01:26:30 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:29 -0700 (PDT)
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
Subject: [PATCH v4 2/8] t/helper: add 'find-pack' test-tool
Date:   Tue,  8 Aug 2023 10:26:02 +0200
Message-ID: <20230808082608.582319-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
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
index fb541dedc9..14ee0c45d4 100644
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
index 0000000000..4b9e09ce25
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
+		die ("bad packfile count %d instead of %d", actual_count, count);
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
2.42.0.rc0.8.g76fac86b0e


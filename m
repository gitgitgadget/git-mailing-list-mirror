Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A73C001B3
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGEGIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEGIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D30510C8
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a573cso36259065e9.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537314; x=1691129314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvPhXB4LCLkFU3+zBc7i3nD4HUnMOaMi20t4DB/wEsU=;
        b=mRdVwaV3foaDvANhczbRNARFbHI1/XGMgzq5daOgYsp3p3tc7jWB0Yu3hwzFNlIVPz
         PLnoYq7g3psY1crfMJGR3FliC0SjiYY0fV1WNBsvM66+Tj4r44tbwea8LsiIGkdBkX5a
         PDFMQn9SyZt7twsdQ0gopHa19Ofg1Q2BqLoxG3hkHTCgWD623v+CKaWTdn3hOogR02MV
         phdHNRk01S+hZ8idPxuArEzlA5Lxkd8dz0moIGkZJOMz3+1LAsXFQHTRWtGHqF/tn+gS
         zCgMOsy6OdPNGY3STyUAVFK11FOub+8qSZrfv6Z8j9d83Ye6huILq0Tsp/hdSTxk3+bn
         Ercg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537314; x=1691129314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvPhXB4LCLkFU3+zBc7i3nD4HUnMOaMi20t4DB/wEsU=;
        b=K5bKiO1r8yfI/bgZ1xxj+0MlFrsuYZyGy6ZroqzX6cqgmvw30GrdmESmo12MiLC41V
         lAKfE5WCOvdU/Ira8QO3Dhd4/bDke5m/AGbpWT/AruHAWyntK9uRauRUUJQF2NrpsJXF
         4nIxOSGG+bzvmimkXmIfXeaeEEljeNsxC8jVuk3ckrvP2/JlYyCrIMDRma9bCSYgdulE
         oM/McwBVAGBZrLhKu9OeElhLRwN6LMkzzIX34zDjxfzqWbl5EV1YuflKO9Omod06BpC5
         w6BXyOYMcgnCYR2oqBStKjirTB9Yq94GnVRHBharlKK/JQgr08/+ErWF1HyMbpjpoa0v
         eQOw==
X-Gm-Message-State: AC+VfDxgRlf3R6h0wnGNiHvwQNqn4kiuY3ThKC8e7lag0gZGylDD6tZU
        pv6qb5cuvNxmCjlTVzTumJe695ES92k=
X-Google-Smtp-Source: ACHHUZ6oVzz6I/0h7/ne1uzAniqWPJbNhpRFRTAsR95wWMF2Ny9xOspSrZA3cC+CwWxH1SPfJvCBBQ==
X-Received: by 2002:a7b:cd97:0:b0:3fb:ac9c:e6f with SMTP id y23-20020a7bcd97000000b003fbac9c0e6fmr12261014wmj.38.1688537313884;
        Tue, 04 Jul 2023 23:08:33 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:33 -0700 (PDT)
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
Subject: [PATCH v2 2/8] t/helper: add 'find-pack' test-tool
Date:   Wed,  5 Jul 2023 08:08:06 +0200
Message-ID: <20230705060812.2865188-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a following commit, we will make it possible to separate objects in
different packfiles depending on a filter.

To make sure that the right objects are in the right packs, let's add a
new test-tool that can display which packfile(s) a given object is in.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                  |  1 +
 t/helper/test-find-pack.c | 35 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 4 files changed, 38 insertions(+)
 create mode 100644 t/helper/test-find-pack.c

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
index 0000000000..1928fe7329
--- /dev/null
+++ b/t/helper/test-find-pack.c
@@ -0,0 +1,35 @@
+#include "test-tool.h"
+#include "object-name.h"
+#include "object-store.h"
+#include "packfile.h"
+#include "setup.h"
+
+/*
+ * Display the path(s), one per line, of the packfile(s) containing
+ * the given object.
+ */
+
+static const char *find_pack_usage = "\n"
+"  test-tool find-pack <object>";
+
+
+int cmd__find_pack(int argc, const char **argv)
+{
+	struct object_id oid;
+	struct packed_git *p;
+
+	setup_git_directory();
+
+	if (argc != 2)
+		usage(find_pack_usage);
+
+	if (repo_get_oid(the_repository, argv[1], &oid))
+		die("cannot parse %s as an object name", argv[1]);
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (find_pack_entry_one(oid.hash, p))
+			printf("%s\n", p->pack_name);
+	}
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
-- 
2.41.0.244.g8cb3faa74c


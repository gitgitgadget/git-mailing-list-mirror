Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62960EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjFNT0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjFNT0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28C2683
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8d17639feso11731305e9.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770764; x=1689362764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYZvrlhaWmNoHVEZ0191rldez8vAixJ2smS+NWbDwUk=;
        b=gRS/hdErupgc1gySOJz23lhzg5sRgSSTu2DYkocOgu/NSsxVemR7dkLA8X+lMv3G/2
         dp3uUqKAW9pOguQj8A3mYlKyoqoFohSaHEw1e8IN+vj7PlXlqFNrSGmeLylyVQnAq2XM
         +01bBvfhdx2nxv/goYUVzIkamtVMVHSPmFv9pEWCrvh1VCfC6p8BBk7GmnrZBN7M5HeD
         fKlISgwdQm10WoeBcRgNnoHLiZDnlEkd3q8vxCiyZtuPqmABNKN2WiCP00JJXFBgzw9x
         Gre1AjA34OJkSDTBMSTeHnGHl2ecy/iwRI9Ut8rQaeOShlyDHKWOXv+aRpQYBknv3z6l
         aBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770764; x=1689362764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYZvrlhaWmNoHVEZ0191rldez8vAixJ2smS+NWbDwUk=;
        b=ShOuyicjP/yeXYScAKIzGNZ4MF8s9fkkN74w7CcgyL4Ag3mI6TJp3iM9VEtpp19gLZ
         YnwxA/7A/QDHU+qmpBSS13GuDuAi1OTBFnrVNMjgyEZ48yOShVtIJPGs8O8biWoA4uuZ
         kgN4207MweVha/AyA4+DguxYUkqV6GZCnhcWEpagem64MUOtcQVpdzwJp34nY0J6+Z06
         5IP6S8Aad80ZBBq2kPebKoIUbZq59NKvWYNWH3DTw5gfYyl2WcE+YM0EOC4Nn94+DeH6
         kaccgCBR7eo0hZTpueDBsZksi6422zunx6BwMoGtfmIiK+MOd9nndadlAcy7ZV9/Wo0K
         0+Pw==
X-Gm-Message-State: AC+VfDwEfga7VHjZvl31x3p1/i1i7MtgLOr7ODmJriXvPK6Fe1zUBGlO
        HZ5PbJxxF6C0rsfdY1XtqhQ6awRNb5A=
X-Google-Smtp-Source: ACHHUZ7do4fzXU8N+E7zMVDE3W9+PQsQCtrLHLpYWYK2cB1tdR/eNh3tM2soRY0PM5q4OglLu9JRww==
X-Received: by 2002:a7b:cc12:0:b0:3f7:f398:e1ca with SMTP id f18-20020a7bcc12000000b003f7f398e1camr12930535wmh.26.1686770764257;
        Wed, 14 Jun 2023 12:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:03 -0700 (PDT)
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
Subject: [PATCH 3/9] t/helper: add 'find-pack' test-tool
Date:   Wed, 14 Jun 2023 21:25:35 +0200
Message-ID: <20230614192541.1599256-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
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
index e440728c24..c1cd735b31 100644
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
2.41.0.37.gae45d9845e


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D84C001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 08:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjGXI7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGXI7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86EF9
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9926623e367so730003066b.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189178; x=1690793978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONbOqFjvECLFyVJxWULnwHX3t0j3KCY+T8uobbkhpqY=;
        b=rXrvUI1t+FXQ1afsanctLzY91LCzLSBn3TzZDJvgbqVkoYyiWFpkNKjqD/NTzlqT7j
         PZ9vbBPMRkfi8lpuU1DpjW85U5Zu9T89L/K88tFcPh4/qU9SXtwp56BqvPq/6qgAXF18
         nTmrHuIZVeFqNEaPv+PvpM36Y0GU09FTulnbdSdrqf55frVOSxZNB/RrrYlvywYl3nFt
         pEYHnaLigSSkFMgRBF/DahwrwD1YFcBX8Atr9fAXvuMXy03O0uC5xB3OGIAPa9rdn6/m
         VNH+N2d80hxZ4RivmkrTbtdEUOb2fR98gD++meXtrAuGToDEMyV9wzQGCmAyE3GYjpeL
         pw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189178; x=1690793978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONbOqFjvECLFyVJxWULnwHX3t0j3KCY+T8uobbkhpqY=;
        b=GVJl9gUVVt5yMLzFxKDm4dYT60+1mO/9lXEB0ua2jrjB9HOB1rkIOa0iFSB+ou5zBX
         3t3OM1Ay6PhFeMuRVTEXXBSjKBlrE9AP3GAiG0Nh9ABLT5IECE+CVutT6XVws/abdbXB
         YlB3Hk8CHpwM+oBQ3rURuhw01GwLOULYqDvHoavcQp/ktDMwjY2AcNI6dD5/2yoV0UWT
         7bvIq3pyK+twnqO5itn2N95pnRR+LF/fVumzAWL5fKwyM4lQOkHvXR/De2zP3Mwj+MX2
         LXQ4REg5EaMJZmJSUrQDDiL5fncQl4UT527iKR9g8NjVcg10JoZlBZ22LLeY3uYkyOfE
         MzpQ==
X-Gm-Message-State: ABy/qLbSzH9Imk9UzVmbN1MvPYe7QUNve2OaZ6X/RgowFTMD60tXiVHQ
        Puyz+EoJ41NeeTGh7qBN2cNcMT8KIvQ=
X-Google-Smtp-Source: APBJJlGFJ2PxZqHtOPSB3tHSxVYLL/pjk+d9iHTtYfbxCFo9umvrSRpxKGi7oKkeSGCDZdOdB1pABA==
X-Received: by 2002:a17:906:8a67:b0:994:673:8b00 with SMTP id hy7-20020a1709068a6700b0099406738b00mr8227902ejc.12.1690189177649;
        Mon, 24 Jul 2023 01:59:37 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:36 -0700 (PDT)
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
Subject: [PATCH v3 2/8] t/helper: add 'find-pack' test-tool
Date:   Mon, 24 Jul 2023 10:59:03 +0200
Message-ID: <20230724085909.3831831-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
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
2.41.0.384.ged66511823


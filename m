Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B012C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354049AbiETXSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354014AbiETXRx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:17:53 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0411A35B5
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:48 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x7so5667777qta.6
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SqASYvmKa442CO3IwI5FZCBpEfKsU3INt4MwBobT+bg=;
        b=htLC5MA43u28HNR4ohEvDj7hFUmSMVf6ZpuS+mT/qkKifoX2v8nKZmCx6H2d5DAkrR
         sx55oOPzdJQqxk8l19hRfW6Ny84Xuf1JF45n9obcraHYK7Cimo1eba1hHfoRF2kHA6YO
         5aX273Xac8vC7KH15h5KtkKFXVSvrEGngi1uU5YPzbik0Qo/d0lVKhPUlV9RXVy4Eatz
         NjlAjr6FUKyrrgVV6o3bjSX18DtfXxwGGUo6tgX0n2uBYZfWrOTibV3vaQgdhFlJRkqq
         aC01pv4Tx7E8nWmU0O7re0cnPMgfpGrbcW8vl3K1FjSAscH22yTWgva5k8fm8/VVsiNE
         TD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SqASYvmKa442CO3IwI5FZCBpEfKsU3INt4MwBobT+bg=;
        b=Mx56ckFwKD7ItZIZIN6GUJ+SduejpSLe3Qg4XoPZ3wc3hKNJaLveT2pMdgXOjQkK6P
         bj2rSvqrE9mkOhKclc+VZ4iKHe5OP5EjJu7ppeGvoePpw88bZQw2Ul5SqRnfHERzV0iX
         Br43CBc8yjSW49Vw3TVF0XNB0c4fWnNYfFnC8msCi0Mz9sjaIMwichHrFLBiC6K90CKv
         +bfhQDo/I4vcneLmtcQvbBGsyHyUF988y3B4QDEno683kDekvvkVheRbP9nOD5Bt4sDT
         3VOfUUfO6xdKh/rUSyBa0yrztqbv+QEh8FvdrGwrYNZ97T6sXxGjgCT0+RSA/i5lT02l
         Doaw==
X-Gm-Message-State: AOAM530chUsevarPjqxbmGF/t6s+xeuBD2TKHdb1VwzCkYvrC3XwMjVB
        bmNK5LW+mznFZurUtHllTLu73jR6wEMzoVzo
X-Google-Smtp-Source: ABdhPJyURXU0lq1+2erhYRBtEfpxR/SsNJ8VWqgWo1k2Z2xpbuJ1zJKfmxY2k4YpO9Yhm7UncdN21Q==
X-Received: by 2002:ac8:5b51:0:b0:2f3:d5a9:fde with SMTP id n17-20020ac85b51000000b002f3d5a90fdemr9467372qtw.60.1653088667967;
        Fri, 20 May 2022 16:17:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z18-20020ac87cb2000000b002f39b99f6b6sm424700qtv.80.2022.05.20.16.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:47 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 06/17] t/helper: add 'pack-mtimes' test-tool
Message-ID: <2a6cfb00bf287380f44f324549db274a1b022499.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, we will implement and test support for writing a
cruft pack via a special mode of `git pack-objects`. To make sure that
objects are written with the correct timestamps, and a new test-tool
that can dump the object names and corresponding timestamps from a given
`.mtimes` file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile                    |  1 +
 t/helper/test-pack-mtimes.c | 56 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 4 files changed, 59 insertions(+)
 create mode 100644 t/helper/test-pack-mtimes.c

diff --git a/Makefile b/Makefile
index a299580b7c..0b6eab0453 100644
--- a/Makefile
+++ b/Makefile
@@ -738,6 +738,7 @@ TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-oidtree.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-pack-mtimes.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-partial-clone.o
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
new file mode 100644
index 0000000000..f7b79daf4c
--- /dev/null
+++ b/t/helper/test-pack-mtimes.c
@@ -0,0 +1,56 @@
+#include "git-compat-util.h"
+#include "test-tool.h"
+#include "strbuf.h"
+#include "object-store.h"
+#include "packfile.h"
+#include "pack-mtimes.h"
+
+static void dump_mtimes(struct packed_git *p)
+{
+	uint32_t i;
+	if (load_pack_mtimes(p) < 0)
+		die("could not load pack .mtimes");
+
+	for (i = 0; i < p->num_objects; i++) {
+		struct object_id oid;
+		if (nth_packed_object_id(&oid, p, i) < 0)
+			die("could not load object id at position %"PRIu32, i);
+
+		printf("%s %"PRIu32"\n",
+		       oid_to_hex(&oid), nth_packed_mtime(p, i));
+	}
+}
+
+static const char *pack_mtimes_usage = "\n"
+"  test-tool pack-mtimes <pack-name.mtimes>";
+
+int cmd__pack_mtimes(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct packed_git *p;
+
+	setup_git_directory();
+
+	if (argc != 2)
+		usage(pack_mtimes_usage);
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		strbuf_addstr(&buf, basename(p->pack_name));
+		strbuf_strip_suffix(&buf, ".pack");
+		strbuf_addstr(&buf, ".mtimes");
+
+		if (!strcmp(buf.buf, argv[1]))
+			break;
+
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&buf);
+
+	if (!p)
+		die("could not find pack '%s'", argv[1]);
+
+	dump_mtimes(p);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0424f7adf5..d2eacd302d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -48,6 +48,7 @@ static struct test_cmd cmds[] = {
 	{ "oidmap", cmd__oidmap },
 	{ "oidtree", cmd__oidtree },
 	{ "online-cpus", cmd__online_cpus },
+	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "partial-clone", cmd__partial_clone },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c876e8246f..960cc27ef7 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -38,6 +38,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__partial_clone(int argc, const char **argv);
-- 
2.36.1.94.gb0d54bedca


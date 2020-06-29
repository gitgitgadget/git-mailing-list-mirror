Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3CFC433E2
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEC2206F1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTbVCZyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgF2VOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbgF2S5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674B7C031C41
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so17145398wmh.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uTQ4fDJZqA0hQFcXE5ueeXZuSfgUrPV0NbXHkKMb2Ho=;
        b=TTbVCZyJMOknK9OZc1QA3eufysZjmOQcG4rRpDbrU1Kf0HUvmWt6UZs20br/iti1FP
         qViuThgG9bUzo67LOKF5OLiqMfzJWhhoK7+/byXavHsZ1SqR9ESPL/Qoe4xCN0nW6avh
         c5nCN/HLzAM4EypsU2GPz6Q8VB329tldwdg938q/wovH0ZynbwlQjo88pq+xdKwuk3H1
         /5Dly50EuVt6VEeFAwT57sN5NZLoYIZ2FaZ7dbqxGZebdfNzjI9RVYJkt6azZSdJqVZw
         ZOKK/KzKNCH18tPB1BEEXJGFd7cvQC5fBRf4kcgi02F4MCdWMHDZ9LEmlGC5zPm/VlIr
         cTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uTQ4fDJZqA0hQFcXE5ueeXZuSfgUrPV0NbXHkKMb2Ho=;
        b=L8g03hR2z91vJTvLhcbP0TNFUhMOhQCtyWMAwE4+hcdhuNyxcqidZCShqbj+DFiF+4
         fF9vCddY0qrYYIBOG2isFLXhGJRsdCR9N+k8BKFcxf2cTkVvEB9Du+2/XefoJEZJ44Wx
         Ll0eD7I3tNGHhgKdC54dDuwECREk1aZ0ZtJpCfj4sPNgiaUNR2ZPYrlb8CUsgId/c/Ei
         HynMAvx0PkJreodPzytXMAcGLDM3W9MJkzSu5xjSiFqj1qEknCCkb67pdoybrR4peya3
         miPUIihQ/28no/U742zLuX10w/MHoCQ3OY428QoGGFYMQJVX6x10ZExCuHISdS1HUjSK
         FxtA==
X-Gm-Message-State: AOAM533WHXgKhdIuqNhugWVlMjsD8oV1/iaeIXhGmct6ilTJjmVJbXFX
        4ek/Xb2Pl1ua/mWalzVKvzs5WVwHdSg=
X-Google-Smtp-Source: ABdhPJweZZNg4aR4ymZ/slK+I7TSI3fdJxnJa3w0BS+ATrpqezsX6LKYrj1EQlZA4Dkfc6JzPY+EcA==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr17286453wmc.145.1593457033966;
        Mon, 29 Jun 2020 11:57:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14sm710311wmk.19.2020.06.29.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:13 -0700 (PDT)
Message-Id: <04c86e7395d88e6d12acee81c8388c53a1921725.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:53 +0000
Subject: [PATCH v19 15/20] Hookup unittests for the reftable library.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The unittests are under reftable/*_test.c, so all of the reftable code stays in
one directory. They are called from t/helpers/test-reftable.c in t0031-reftable.sh

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 | 17 ++++++++++++++++-
 t/helper/test-reftable.c | 15 +++++++++++++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/t0031-reftable.sh      |  5 +++++
 5 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-reftable.c

diff --git a/Makefile b/Makefile
index 6571ed1246..8f33ad899a 100644
--- a/Makefile
+++ b/Makefile
@@ -725,6 +725,7 @@ TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
+TEST_BUILTINS_OBJS += test-reftable.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-repository.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
@@ -808,6 +809,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 REFTABLE_LIB = reftable/libreftable.a
+REFTABLE_TEST_LIB = reftable/libreftable_test.a
 
 GENERATED_H += config-list.h
 GENERATED_H += command-list.h
@@ -2371,6 +2373,15 @@ REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
+REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/merged_test.o
+REFTABLE_TEST_OBJS += reftable/record_test.o
+REFTABLE_TEST_OBJS += reftable/refname_test.o
+REFTABLE_TEST_OBJS += reftable/reftable_test.o
+REFTABLE_TEST_OBJS += reftable/strbuf_test.o
+REFTABLE_TEST_OBJS += reftable/stack_test.o
+REFTABLE_TEST_OBJS += reftable/tree_test.o
+REFTABLE_TEST_OBJS += reftable/test_framework.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
@@ -2378,6 +2389,7 @@ OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(VCSSVN_OBJS) \
 	$(FUZZ_OBJS) \
 	$(REFTABLE_OBJS) \
+	$(REFTABLE_TEST_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2521,6 +2533,9 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -2803,7 +2818,7 @@ t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
new file mode 100644
index 0000000000..def8883439
--- /dev/null
+++ b/t/helper/test-reftable.c
@@ -0,0 +1,15 @@
+#include "reftable/reftable-tests.h"
+#include "test-tool.h"
+
+int cmd__reftable(int argc, const char **argv)
+{
+	block_test_main(argc, argv);
+	merged_test_main(argc, argv);
+	record_test_main(argc, argv);
+	refname_test_main(argc, argv);
+	reftable_test_main(argc, argv);
+	strbuf_test_main(argc, argv);
+	stack_test_main(argc, argv);
+	tree_test_main(argc, argv);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 590b2efca7..10366b7b76 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -52,6 +52,7 @@ static struct test_cmd cmds[] = {
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
+	{ "reftable", cmd__reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ddc8e990e9..d52ba2f5e5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -41,6 +41,7 @@ int cmd__read_cache(int argc, const char **argv);
 int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
+int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
index a6634bc882..8496371f38 100755
--- a/t/t0031-reftable.sh
+++ b/t/t0031-reftable.sh
@@ -15,6 +15,11 @@ initialize ()  {
 	mv .git/hooks .git/hooks-disabled
 }
 
+test_expect_success 'unittests' '
+	test-tool reftable
+'
+
+
 test_expect_success 'delete ref' '
 	initialize &&
 	test_commit file &&
-- 
gitgitgadget


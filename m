Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0966EC433E3
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94982076E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBFUK8/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgFVVz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgFVVzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CAC061797
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so217273wmg.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=emrJuQFlzoVZ6VudXsxics9/03kJfKo6TufZ+GVw0fw=;
        b=DBFUK8/j7q03LRWW5hHjN17LTtHfQgg8oU762u6Cu7hUy2BUxnRFM5rqNfd/e9JJuT
         EZE4Dwpb7sie7LiniWK/adTwWHen9rZ/MvD6Y2xW9GZZvTN/1DYCRrcdksFK7XyIvjCq
         qTVfAlK4xTlIdq4yIcejBJB9mn6NAfMU0B9z0siuPMzcVDXGDpSsptEeIqyquguBUSXD
         xYCV53+5du5SFPqE5wYNJyvPdl0kGNXNcwzkuPns0uWUMTyanoZiVJYhKTOXotF1U66M
         f/0HCcU8m8WKsROwVUCdBjOuvMnl8Nio67IUSmPH7fljifmnI84fP94AcYTIWd66B/oI
         FdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=emrJuQFlzoVZ6VudXsxics9/03kJfKo6TufZ+GVw0fw=;
        b=Thi7utvLMqHhVm/OKB0iPCtez7xnTDwDVTLH4piU9kNGZyI2aEdJ58kgqXQOTFJKIB
         31scIVIByFTHVWHal7c2Lu4t7iRP07Re/+6zucMK++6mgWNtpAmTfYN7QszXe9SK1PH3
         PeSNV761b0ZDWcsl4bU2J/b6u9GpACJx4Y4fGBwBvReYZ83HEd92UagRjXclp7d9SIHg
         cuDR6DujaLmoyEhMXEaQmLFUfJuBQlgbfWe9YgzaMQGUCpGcHDHdRYW0BitkKAnFOjz7
         1l+KF/Ffzb8zKe/PMtpjgPGYRNaHsyKAfHN4Ci/CgRQESfvyM/KC6K5f5BI+UWYjs8ND
         WS2g==
X-Gm-Message-State: AOAM530p6Q0wOqtqa8m5WVjSPKJw2M4ytv4nba7T22ptwc8ZhLLguTxD
        wwiyAH+PY47BdOlpQH784GyvqrjN
X-Google-Smtp-Source: ABdhPJyiyocAokLQVtWmm5Ff2NIBtWtNYE3c6mFyfShqTRNsRcKHSlQU9uF6X+S4PYR3V0WcNdsI2g==
X-Received: by 2002:a05:600c:2045:: with SMTP id p5mr22037732wmg.91.1592862936445;
        Mon, 22 Jun 2020 14:55:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b19sm1381552wmj.0.2020.06.22.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:35 -0700 (PDT)
Message-Id: <eafd8eeefcc2efa5953ad35412e7b0883f87d559.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:15 +0000
Subject: [PATCH v18 14/19] Hookup unittests for the reftable library.
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
index 6571ed12468..8f33ad899ae 100644
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
index 00000000000..def88834396
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
index 590b2efca70..10366b7b762 100644
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
index ddc8e990e91..d52ba2f5e57 100644
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
index 168d0b0b2f4..3615e364a51 100755
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


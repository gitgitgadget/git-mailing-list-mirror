Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C3C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F918208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8pm888D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbgGaP1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbgGaP1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE0CC061756
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k8so9614499wma.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sA9xv8EeVW1Ze59bd+uUvJzbpChdDiOdGdLI5vA/bmE=;
        b=D8pm888DAxscsvPNpP0E9piH2CF0unM5mauSdruBR3iwJhSHmYDThbVQF3S5XzQma3
         B3dAWuh0iCCBDqqoFINV28uPZ+0mw68vvt/nRqmSl10W2HodnoYl7yWfNhx0M0LomeYz
         vnepWyfq/8RlXvtI81GFAMfzuNpmVQS2Tmjw+RHWh6FyN00zSlAJ0cBe7amOr9XUq7RP
         +T+QhqoljWDVg3NrxSMgln17oFjNtRw4gC0NDYL2PzOc7loOsVnw8CRxCXbHYJ1lQWPt
         453XjQaD1jXXlf9Bnhc534eMGR6n4eOGBlKJ1tGm5F5B7E0J0J/xpdrB/lBJNZYRfLKk
         sBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sA9xv8EeVW1Ze59bd+uUvJzbpChdDiOdGdLI5vA/bmE=;
        b=lHNTlN9Amlx+JvWgw3gpnAl5lCczB3u0+wflwgvBcoY0w7Q27D27y30OmIL8E55CEf
         UByL7DP1Dp9hjZKlzAMfGQwYnEsjtzkQuLSD33kuTNPNxv3lgWWy1JV2Y7gqlrudHzqw
         z40c4EhQ3mWCqZovs5ZoZM8tGN/JwdgLw4VaW5ZIV05WAE1IZdQ0ZxxHZcH3f7lPbrek
         P143NK7s0nUSXv3n1c50N3Zsn0yr2W5PGqp1bgT+zUo0BryYPohtihok5lVspC64qYqR
         co+0aOAbWNs6t1/jObP38tIhDu4S27uK9SpDAd8HA0x20KKB5lgh5HCXivV57wujQWLB
         Zzrg==
X-Gm-Message-State: AOAM531mwFa7IYtTQ60hjUovQPxR6povFdsRSpeU/KgVQbYGbcK1LiJm
        jLX0SYRWeTY8LR0J6RtQjFy9c9Gf
X-Google-Smtp-Source: ABdhPJxmN+P4nh8yBTTdfnALzlfuRRdusas8I6RaggLykxQfpR7XYLDpmEIpYYKdYmbiDALTKLJ0kA==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr4250023wmb.22.1596209258702;
        Fri, 31 Jul 2020 08:27:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i82sm6672467wmi.10.2020.07.31.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:38 -0700 (PDT)
Message-Id: <f13e4798c48da64841f8eee73d2edb8ec0f6fbf7.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:12 +0000
Subject: [PATCH v20 16/21] Hookup unittests for the reftable library.
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
 Makefile                 | 19 +++++++++++++++++--
 t/helper/test-reftable.c | 15 +++++++++++++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/t0031-reftable.sh      |  5 +++++
 5 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-reftable.c

diff --git a/Makefile b/Makefile
index 6571ed1246..5e69c16507 100644
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
@@ -3136,7 +3151,7 @@ cocciclean:
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
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
index 9f90c10030..34cc787a61 100755
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


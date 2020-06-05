Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691B7C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455ED2074B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUhXL8LC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFESDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgFESDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6CC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d128so9957523wmc.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oIO5Rl3Lg+cYrwf0VxuA3QnmZOdolbBHSSO2WvMD070=;
        b=AUhXL8LCuQUP1dQS+BoM+ZCI82vMFWvvAKBJlFA/OcI+aplyFSptlwOJzs4SnrLz6M
         PF2W17V6hGhtyIeN6/tX6s7wy5Rv3U7cxcE+CvYUGcOlG3obHsCbajITPHnZGZSPMmkY
         vHd5yVZju499/TrvDq1YEO1BUaqRhJ76CTxZPtTdfD7EhdQJSVr8NsLjPOjpHQZovC37
         MNb3aONGNxDBWbf9jfKH+zxI8kUZLq5o1gPwUbn2z3qc7j94tfRNCYNvumnVgdUw2xY6
         tKVMy/9GXf4Ql2CsxBMmzB91zQ+rb5iRNvasYzfFja93j2GLC7ZMOlHpEVKivcviUYQs
         g53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oIO5Rl3Lg+cYrwf0VxuA3QnmZOdolbBHSSO2WvMD070=;
        b=KcIUfrXbxwYVzl4dG1awlFexfjBUXzhkjNQDvFkYkflL5THGnL/ElXth2ILVca1Fgt
         HYpXuKZFq2pPr/q0pSmDQNMA1T2zEjhLep+a6j0mm0/d15IMRR+qaK7avNjgNGWuQtD5
         CPjNwSWp16QMukk4UBrwIJo8cy7ncO15x6a8IYCCKtBoK5nS+o/DfJbgivNVwhMBUzkj
         cNlJjzptiWmEObHpoFcfYhgldlWA0y7MkFYiMuC6YpJOSyBwLeH5rBpyt4xJ/d/0A6YX
         AjDC27NCEX/+PJnbt6OykcPAsTZWRwnT7EJf6zMGSCYGYFWF9Zp0aQl+rJbB2XIUuML3
         bWig==
X-Gm-Message-State: AOAM530OdoliYp7wIgSs8QEE6/dWVSxmrkqV+ubYA2eYMkld+IzjqoXJ
        nYfwak1XVJ0xl5sOrBlF2GOKNZ9y
X-Google-Smtp-Source: ABdhPJyaB5JFDsl+eJ9RqAWKRYDFbEnbgiGjqBgXRQrRzPzLSfB3XnjPech/12XDQOpFls9OBb3ZNA==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr3841651wmg.136.1591380216597;
        Fri, 05 Jun 2020 11:03:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm11577762wmb.39.2020.06.05.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:36 -0700 (PDT)
Message-Id: <3e7868ee409146fc3e13e824f4dbfa6bdbeee3d9.1591380200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:15 +0000
Subject: [PATCH v16 11/14] Hookup unittests for the reftable library.
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
 Makefile             | 17 ++++++++++++++++-
 t/helper/test-tool.c |  1 +
 t/helper/test-tool.h |  1 +
 t/t0031-reftable.sh  |  5 +++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b21c247b12..a39896191c7 100644
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
@@ -2370,6 +2372,15 @@ REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
+REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/merged_test.o
+REFTABLE_TEST_OBJS += reftable/record_test.o
+REFTABLE_TEST_OBJS += reftable/refname_test.o
+REFTABLE_TEST_OBJS += reftable/reftable_test.o
+REFTABLE_TEST_OBJS += reftable/slice_test.o
+REFTABLE_TEST_OBJS += reftable/stack_test.o
+REFTABLE_TEST_OBJS += reftable/tree_test.o
+REFTABLE_TEST_OBJS += reftable/test_framework.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
@@ -2377,6 +2388,7 @@ OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(VCSSVN_OBJS) \
 	$(FUZZ_OBJS) \
 	$(REFTABLE_OBJS) \
+	$(REFTABLE_TEST_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2520,6 +2532,9 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -2802,7 +2817,7 @@ t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
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
index 221ef51447c..c1f3abfda9f 100755
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


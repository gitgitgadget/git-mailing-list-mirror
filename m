Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C248C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E3C20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrWgduoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbgFPTVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgFPTU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D2C06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j198so2914696wmj.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=llBNhnDvlfjkZLHMGZfSg1IJEZIFGF6oKkGalQ3fIm4=;
        b=NrWgduoJftxy+05VlWnTyKEfScrjG/YCmocEwxSut2lXZMqLbhm05uNZg19Zr+qMWG
         FjF+MQWF68c81GlPKRaW1xScDHzEN/wWgRSNXGsIP3PqZe170caOMrie+qhu9KKnu7k+
         r2DhNVVK6J39YAHWa/pJqy/1XedFWi0/Cigde3qvwneu+pTNkTSr3BXy3xVr48eyeVOA
         btt5hfX1vb9mydd2SO4SdCvCcTM8jcTlOMbogjHtvOFAOzIAQwoO+U9Hbc1iRqphts2h
         GClS0+V4MKpZEc8nzsya6VABcWYMhAjuRGPW6vWRJg3VezLxgo4VOgX8zNh7m0GQwVZ1
         6eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=llBNhnDvlfjkZLHMGZfSg1IJEZIFGF6oKkGalQ3fIm4=;
        b=q02OHv9pTZuQ/BPRskKXoIp1s4pVgtAy4ySpefJwAN1J03UjM67uLc6Q9asIK31pAh
         tB/JxWLYiYFcBTTz12Mc9Eimq/5VjiF7XiPVflrGEHYTX585uveAuMIVkW7pR5VplyhB
         oC6zcb+GLAiDqTq5igA1fBPw4lWbjnyE33kL8VpZ2Ive9Ihp3BbkIq7avpr9+udGTvBq
         OS6xOkSaZmyq9+Ekw/XLYSwUq5NLc/rrvX4lh0qwW0BKOL5/UrgZcTlyEX4vJ9/F7ETs
         rRdTZB5wXAd+BU3bHQQMiD/38OLrTzkURAdSUo3LystXN6IiF2SJUUZKOCHKyvDxmZXY
         VdQA==
X-Gm-Message-State: AOAM531kvspKFlQr5P1w2se9hfree4u/oCqJ4bjxHLDOMltlpU93WG51
        QdKUzgJtc+VUdrWBdpkE8Jl14pc8
X-Google-Smtp-Source: ABdhPJyE8KnZJSIqIGfPeSovnNhoyhidPaD6pqOhD1J1VgqcfW7QK2x4Mlj7HQsQ5CDj5NqpuYFmsA==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr4481528wmi.7.1592335256116;
        Tue, 16 Jun 2020 12:20:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d28sm1246286wrc.50.2020.06.16.12.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:55 -0700 (PDT)
Message-Id: <0359fe416fa2723cde7b5aa18de84c0b72098598.1592335243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:38 +0000
Subject: [PATCH v17 13/17] Hookup unittests for the reftable library.
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
index 7a42362aa42..feb2e52ad22 100644
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
+REFTABLE_TEST_OBJS += reftable/slice_test.o
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
index 00000000000..95d18ba1fa9
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
+	slice_test_main(argc, argv);
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
index 802afb40e70..eeca76965a5 100755
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


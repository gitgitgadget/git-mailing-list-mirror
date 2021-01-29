Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D097C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C556464DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhA2Xtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhA2Xto (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:49:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC2C061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:49:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q2so6230559plk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sr8sbKQORvE5o4W5pjR3zDtM6HhkOOEt47sKq3Hs1zI=;
        b=lbmtOWkqiFnTYaY94s5SnLMic9JPtY+oA0yMsR9obGoGAoOwKBbKiyR0tNtGVBPRnl
         83adwQscAnDYqTBv44lM+zR/ZFDAvbgtq+PCL+wyKkjzKumi3hcu3+ICXXGvMH7kkEB5
         qmUnOj53XqK+3C3rX4FDXcyRkBa7VgqqEMF18yTQ9LAig6hdf7cwqk57o5eGeaIZcMym
         sX35NdXaHntFczS5xQZK2Y5I+bq0sjLrrcr6iJVVccO89jOt/VxG0tzTYCtv09uLb+0k
         3IG7E+kHj4z1UDKrlGe1qiWMTRxuR6RpCMrRbVmCeu9MtCC9tFmCwY4lvui9JikE5chs
         kEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr8sbKQORvE5o4W5pjR3zDtM6HhkOOEt47sKq3Hs1zI=;
        b=DzaABpYg4Hml2mnMEOz23jo4tFYSwIvAhF722Ue343RHZkXlDbpC3dtGv94x0WIqof
         H/R4IQybhoQys7+UmBzYFFne9tTO2CijxoHH3V7PM2sKn6hQrmw+tn44JI89z3w9i/6z
         5hpKWtZi22N6rhnIsn9KagFZ6cRU3rWVrm7MRhJj1fN0gkmEhxY6xZG/VgrxuHrePnjJ
         Iijk6CfbIg0NczEv2QgrM0vEdb01Zwe73xhIq9mZrMTNICa1QwBxatwmGv6D+8tINxan
         kplD5+PSP3um9DAsw0vu/fom+p3LyLivW5K3oM5fb2GWCqab0M4V6gOJ9VlMdgOz/jEO
         mkZA==
X-Gm-Message-State: AOAM533kiedLdOwdM/sWgYv+5V3Oax74MGCDgSQT8JNhjfm51R4Fpra1
        yprczr3/gqx1KBcvT9L/ypnfb0Ox86c=
X-Google-Smtp-Source: ABdhPJzd93R21kalQvtpoP2fQTLFOP1clTxBl9pvLEog/oaWKqsW8GS/jWyhQmhKht+T4CRIALj4SA==
X-Received: by 2002:a17:902:9a4a:b029:dc:435c:70ad with SMTP id x10-20020a1709029a4ab02900dc435c70admr6650984plv.77.1611964143336;
        Fri, 29 Jan 2021 15:49:03 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id s9sm10070851pfd.38.2021.01.29.15.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 15:49:02 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Vincent Lefevre <vincent@vinc17.net>
Subject: [PATCH] pager: exit without error on SIGPIPE
Date:   Fri, 29 Jan 2021 15:48:54 -0800
Message-Id: <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <YAG/vzctP4JwSp5x@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the pager closes before the git command feeding the pager finishes,
git is killed by a SIGPIPE and the corresponding exit code is 141.
Since the pipe is just an implementation detail, it does not make sense
for this error code to be user-facing.

Handle SIGPIPEs by simply calling exit(0) in wait_for_pager_signal().

Introduce `test-tool pager` which infinitely prints `y` to the pager in
order to test the new behavior. This cannot be tested with any existing
git command because there are no other commands which produce infinite
output. Without the change to pager.c, the newly introduced test fails.

Reported-by: Vincent Lefevre <vincent@vinc17.net>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Sorry for the resend, it seems like vger has dropped the first patch.

 Makefile              |  1 +
 pager.c               |  2 ++
 t/helper/test-pager.c | 12 ++++++++++++
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 t/t7006-pager.sh      |  4 ++++
 6 files changed, 21 insertions(+)
 create mode 100644 t/helper/test-pager.c

diff --git a/Makefile b/Makefile
index 4edfda3e00..38a1a20f31 100644
--- a/Makefile
+++ b/Makefile
@@ -719,6 +719,7 @@ TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-pager.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-path-utils.o
diff --git a/pager.c b/pager.c
index ee435de675..5922d99dc8 100644
--- a/pager.c
+++ b/pager.c
@@ -34,6 +34,8 @@ static void wait_for_pager_atexit(void)
 static void wait_for_pager_signal(int signo)
 {
 	wait_for_pager(1);
+	if (signo == SIGPIPE)
+		exit(0);
 	sigchain_pop(signo);
 	raise(signo);
 }
diff --git a/t/helper/test-pager.c b/t/helper/test-pager.c
new file mode 100644
index 0000000000..feb68b8643
--- /dev/null
+++ b/t/helper/test-pager.c
@@ -0,0 +1,12 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__pager(int argc, const char **argv)
+{
+	if (argc > 1)
+		usage("\ttest-tool pager");
+
+	setup_pager();
+	for (;;)
+		puts("y");
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9d6d14d929..88269a7156 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
 	{ "oid-array", cmd__oid_array },
 	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
+	{ "pager", cmd__pager },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "path-utils", cmd__path_utils },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a6470ff62c..78900f7938 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -32,6 +32,7 @@ int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__pager(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__path_utils(int argc, const char **argv);
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fdb450e446..2eb89e8f75 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -656,4 +656,8 @@ test_expect_success TTY 'git tag with auto-columns ' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY 'SIGPIPE from pager returns success' '
+	test_terminal env PAGER=true test-tool pager
+'
+
 test_done
-- 
2.30.0.478.g8a0d178c01


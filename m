Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A4C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACBF6124B
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 00:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhFAAkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 20:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhFAAke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 20:40:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05661C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:38:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q5so1757549wrm.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 17:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtYyr72e+eIn9azfXJtdbHGBeoup7H86ClFJQADSgJ4=;
        b=dZG1mMNQV3De5WWihkPLXns/bxzHd9XWs7VITdfH/yxqamA/Nn3104AwxaKAIRgkVS
         HRC35E0JYuFt0LpuDBx9T7pE26800FM2pai/B6bBalJUlNRLbFGKoXZd/ET38CbIEN/D
         ACbnHueH+NQvVSTGtCbzbFoZlGVJLLtFEewAKe2zxOhz2fp05U1ArhJiWqxkCKRN9eJr
         0Xo4BEBZLsxj7LPMdGH9eVlY7nvXD9JXhTLwBFZ3KnFpc/RTWbttvEQib6NqFvaakTtV
         JkZ97hS6+L4LI/w7OChs3Fn7ajmdsn9PJPN3eBOW2LRc7DkCkOsGLK/SVj+V/31wOlEQ
         Lb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtYyr72e+eIn9azfXJtdbHGBeoup7H86ClFJQADSgJ4=;
        b=hXO5dEStcR92ZgFHzoF+AJG4IvjARv7sBlX8LMm6G8MBKV4ZdkqMa8Dl7xjbphsCjb
         vlauCfR3OiCQXqzGLLaR/SppCqe6dsQddWZhSuHdV4KC7AnXyEy1E3UiJO6HUPLvcnng
         TNcFlrsExT1cTjILR8H2T0VA5Fz0swOaUrT9b5G4tNf2cgpVKJTtMLSfF5saZOt+tgTr
         sOJQbidM4/QGUqjvw+dqTqp9dhiflhGJTn0KpESWx9qN1xeWVV4XFdOgdfvrtur9AH9D
         Zy2ekh8cyym+frhabRXehDcYJlbRvlkyYCVQX+8qOzOaJjcQy1cC5l9CN5T64fBCzC0B
         XCUQ==
X-Gm-Message-State: AOAM532X8MnfJFbqVrSILcxDxQmWm1/fWh4zahSm83TJqtxlonTt7HIo
        KHxUG0pqMZLigDLpm1gkrj28Y4Sxf3ZIOw==
X-Google-Smtp-Source: ABdhPJyJrIvrV90OfWRJAQ0/MN3eMGVvh2SkA7pSjnKWg/lpFGPBO6rfoQITlF9nehcrcGG3GmKU6A==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr24658128wrq.112.1622507931350;
        Mon, 31 May 2021 17:38:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6sm7728005wmg.17.2021.05.31.17.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 17:38:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t0001: fix broken not-quite getcwd(3) test in bed67874e2
Date:   Tue,  1 Jun 2021 02:38:48 +0200
Message-Id: <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
References: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With a54e938e5b (strbuf: support long paths w/o read rights in
strbuf_getcwd() on FreeBSD, 2017-03-26) we had t0001 break on systems
like OpenBSD and AIX whose getcwd(3) has standard (but not like glibc
et al) behavior.

This was partially fixed in bed67874e2 (t0001: skip test with
restrictive permissions if getpwd(3) respects them, 2017-08-07).

The problem with that fix is that while its analysis of the problem is
correct, it doesn't actually call getcwd(3), instead it invokes "pwd
-P". There is no guarantee that "pwd -P" is actually going to call
getcwd(3), as opposed to e.g. being a shell built-in.

On AIX under both bash and ksh this test breaks because "pwd -P" will
happily display the current working directory, but getcwd(3) called by
the "git init" we're testing here will fail to get it.

I checked whether clobbering the $PWD environment variable would
affect it, and it didn't. Presumably these shells keep track of their
working directory internally.

Let's change the test to a new "test-tool getcwd".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Not an issue new in v2.32.0, but an easy enough fix, so I thought I'd
send it now anyway in case we'd like these various AIX fixes in one
batch...

 Makefile               |  1 +
 t/helper/test-getcwd.c | 26 ++++++++++++++++++++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0001-init.sh        |  5 ++++-
 5 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-getcwd.c

diff --git a/Makefile b/Makefile
index c3565fc0f8..8c000ba48b 100644
--- a/Makefile
+++ b/Makefile
@@ -711,6 +711,7 @@ TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
+TEST_BUILTINS_OBJS += test-getcwd.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
diff --git a/t/helper/test-getcwd.c b/t/helper/test-getcwd.c
new file mode 100644
index 0000000000..d680038a78
--- /dev/null
+++ b/t/helper/test-getcwd.c
@@ -0,0 +1,26 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "parse-options.h"
+
+static const char *getcwd_usage[] = {
+	"test-tool getcwd",
+	NULL
+};
+
+int cmd__getcwd(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	char *cwd;
+
+	argc = parse_options(argc, argv, "test-tools", options, getcwd_usage, 0);
+	if (argc > 0)
+		usage_with_options(getcwd_usage, options);
+
+	cwd = xgetcwd();
+	puts(cwd);
+	free(cwd);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c5bd0c6d4c..3c13cb19b5 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -33,6 +33,7 @@ static struct test_cmd cmds[] = {
 	{ "fast-rebase", cmd__fast_rebase },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
+	{ "getcwd", cmd__getcwd },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
 	{ "index-version", cmd__index_version },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e8069a3b22..e691a4d9e9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -23,6 +23,7 @@ int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
+int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index acd662e403..df544bb321 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -356,7 +356,10 @@ test_lazy_prereq GETCWD_IGNORES_PERMS '
 	chmod 100 $base ||
 	BUG "cannot prepare $base"
 
-	(cd $base/dir && /bin/pwd -P)
+	(
+		cd $base/dir &&
+		test-tool getcwd
+	)
 	status=$?
 
 	chmod 700 $base &&
-- 
2.32.0.rc1.460.g26a014da44c


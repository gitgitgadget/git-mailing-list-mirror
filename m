Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D0AC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2C960EE2
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhG3QSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhG3QSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:18:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD6C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 09:18:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b13so1122193wrs.3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Vb4TyEeVwlJxiiQTf19gonXhvpa+2UTnF2KguF9Xd4=;
        b=Z2OiN7IEgUvZWYhlaMtRdVaEBGVU5cgn+RfRXvvnsQEEwojhRuBQ3YEEu0Tgit2Mi7
         UdAD/Mwfy2GMWPLapRFrZg+IU3Cd8Dx+uSsGk988jI+D3DANI2dVzf5jJiJKFvr5du+q
         6hhMrXzTV4c9O4UBUbkh1aLT4YWrZJykIW3tTzUFv+4t2HE31B7vGOE9ZlU0zZxRiHp6
         E99mWM4eHcs9TNY4wlM7jw83WiXLgawqXx3MAR3p5rNWmK2FmXsL3shCiAC1VS82h529
         dL15NHq9swVucwTuz0GEx1TKD4evZArsD+PeIIwPodKLpS13KkXhW9/rHkMvVkHhZGEZ
         EeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Vb4TyEeVwlJxiiQTf19gonXhvpa+2UTnF2KguF9Xd4=;
        b=GWfXWC3J4U+qIzzySC+jiHa0sST16Mu8kaLksDKitn0MYLZcv3Y8/r56GIymsY1aUd
         9v//TtVIQXuxSDYaQjGxAv+sO9Y1MEKT2A605fIO4Jgz7QLopJ/glbei1Mcu2u6JGrmV
         OK4EO0hFQtvGD0looqRVJxrKj8Qesrir+5MJm2uf++I7vJvoJrdtHphkB6OKBuW6FK0s
         dzX3vAN642qE7W6Bu09JgFPJFzFsQ4+j2Gkw0UIs8DT8RqkxmeJC9Lix51Xle1WspSl5
         EibDFo0JW/R4eIOhSZopwTn+NWMih7J0qeaXV4G0L38p3j90UvY76NK2shHWBdDwSJ5J
         4WWw==
X-Gm-Message-State: AOAM532Lf3sg8AMfnXkcXA8x0L1qS19OcF20cXtpd15w2sAeGJSJ6yk6
        jQGc/aLdf+SpkOb6CqVB31AgSo73zVfQDQ==
X-Google-Smtp-Source: ABdhPJy4yTooC8mLeUrRiW00XbUFOnIprx1596gSfs9QX0p23OvhJgKjB1cHg7EAnxGq8xkje4CrfQ==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr3895164wrw.158.1627661897104;
        Fri, 30 Jul 2021 09:18:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d24sm2274522wmb.42.2021.07.30.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:18:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] t0001: fix broken not-quite getcwd(3) test in bed67874e2
Date:   Fri, 30 Jul 2021 18:18:14 +0200
Message-Id: <patch-v2-1.1-d7d071441b0-20210730T161540Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1071.g36f34456314
In-Reply-To: <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
References: <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
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
-P". There is no guarantee that "pwd -P" is going to call getcwd(3),
as opposed to e.g. being a shell built-in.

On AIX under both bash and ksh this test breaks because "pwd -P" will
happily display the current working directory, but getcwd(3) called by
the "git init" we're testing here will fail to get it.

I checked whether clobbering the $PWD environment variable would
affect it, and it didn't. Presumably these shells keep track of their
working directory internally.

There's possible follow-up work here in teaching strbuf_getcwd() to
get the working directory with whatever method "pwd" uses on these
platforms. See [1] for a discussion of that, but let's take the easy
way out here and just skip these tests by fixing the
GETCWD_IGNORES_PERMS prerequisite to match the limitations of
strbuf_getcwd().

1. https://lore.kernel.org/git/b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: I tried to get this in around the v2.32.0 release, see previous
proddings at:

  https://lore.kernel.org/git/871r9d6hhy.fsf@evledraar.gmail.com/
  https://lore.kernel.org/git/87y2bl52v4.fsf@evledraar.gmail.com/

Here's another try with a slightly updated commit message discussing
that there's a possible more perfect solution here (per René's reply),
but that this fixes the immediate bug on AIX/OpenBSD etc.

Range-diff against v1:
1:  c70791bbd3a ! 1:  d7d071441b0 t0001: fix broken not-quite getcwd(3) test in bed67874e2
    @@ Commit message
     
         The problem with that fix is that while its analysis of the problem is
         correct, it doesn't actually call getcwd(3), instead it invokes "pwd
    -    -P". There is no guarantee that "pwd -P" is actually going to call
    -    getcwd(3), as opposed to e.g. being a shell built-in.
    +    -P". There is no guarantee that "pwd -P" is going to call getcwd(3),
    +    as opposed to e.g. being a shell built-in.
     
         On AIX under both bash and ksh this test breaks because "pwd -P" will
         happily display the current working directory, but getcwd(3) called by
    @@ Commit message
         affect it, and it didn't. Presumably these shells keep track of their
         working directory internally.
     
    -    Let's change the test to a new "test-tool getcwd".
    +    There's possible follow-up work here in teaching strbuf_getcwd() to
    +    get the working directory with whatever method "pwd" uses on these
    +    platforms. See [1] for a discussion of that, but let's take the easy
    +    way out here and just skip these tests by fixing the
    +    GETCWD_IGNORES_PERMS prerequisite to match the limitations of
    +    strbuf_getcwd().
    +
    +    1. https://lore.kernel.org/git/b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     

 Makefile               |  1 +
 t/helper/test-getcwd.c | 26 ++++++++++++++++++++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0001-init.sh        |  5 ++++-
 5 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-getcwd.c

diff --git a/Makefile b/Makefile
index c6f6246bf63..9573190f1d7 100644
--- a/Makefile
+++ b/Makefile
@@ -715,6 +715,7 @@ TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
+TEST_BUILTINS_OBJS += test-getcwd.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
diff --git a/t/helper/test-getcwd.c b/t/helper/test-getcwd.c
new file mode 100644
index 00000000000..d680038a780
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
index 490ac026c51..3ce5585e53a 100644
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
index f8dc266721f..9f0f5228508 100644
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
index acd662e403b..df544bb321f 100755
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
2.32.0.1071.g36f34456314


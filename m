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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D49C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF626108B
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhIKTLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhIKTLl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C254C061757
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u15so1767177wru.6
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKOtTE4VdYJSOQFubwW3r0efBX9cH5DrpT3H43dQvbo=;
        b=OS7oaalkS/Y8sFVYbXyOnXsSRGVxMeWRGKZPi0Mvuvn5eUQGWxlOPXrDgpuRk/v7EX
         RwP2gfmtDAxvMXbo9vOEAy5ohenmCbpCVMDVK1FlkA12A7bmbQb3kMW+A/V8JPOfhg6t
         cLyOud8pQaMVx+IcJushkQfyvUZIqJVbsgnkMmCe59b80/XnhLgDIqMG6RFEasTIXOwh
         B6Jyu80I3d4MFKRWsLIWLW8UcjPv7AgYHq2YDjzkI3qperUAeJct3kaqMd8dYT2Ah6g2
         kKhwTeR6Sl+LaR4E6e5YZEuc0FyPNE0NlLkT3Y8deaQc9q34qJK3LmkVVpF4+Z1Yv1R9
         toUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKOtTE4VdYJSOQFubwW3r0efBX9cH5DrpT3H43dQvbo=;
        b=hD2XiUsI5XzyyBw7VWiJ0hTor7Uzoek7ptNKCCsTR3I+6jWmsN1fjNrH7cOWXXurzT
         E5/VwH3zHRBogyK4ev92bCQqyDEm7v2dUWnWg+0Rfg64Sor516EQvCS5oJfaACeqrUH1
         ofiBvM8Z4trKpVhxBa/6Seo2ZdrYRGulLjssjfe71uGXZQD45scrGzAQrSeSiedHNQj9
         Qbn2byDu1hI0ImZMjnBxEkb3kiyRE9MKZlsIKsoXdmiPJhgKPtSxcQSra7xHNNK1Iu2k
         SdqlaHrk60Uq/a8J5r893/q00VsVJNRasHmj0J28yTyYcsWRMGb1T8fhV3X64xiqcEkt
         xP8g==
X-Gm-Message-State: AOAM532vb4B+T/tKBkI/H02YxkzwWQ2Hy21wHnbj+DrrsfZ9u/jiCki1
        E7qBSzfYAt+P7elJb4wnpb4VqQKjMdEMOQ==
X-Google-Smtp-Source: ABdhPJx4m2Dgb0GZi2UVOBB0d8ljVug/O+G8XPZ8+m+rRfza09BtZNsh/Vy/b4bVQTARWFAzxvsl7A==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6mr3544333wrt.108.1631387426615;
        Sat, 11 Sep 2021 12:10:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm2256822wmk.2.2021.09.11.12.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 12:10:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] credential-cache{,--daemon}: don't build under NO_UNIX_SOCKETS
Date:   Sat, 11 Sep 2021 21:09:00 +0200
Message-Id: <patch-v3-1.6-ad857e80fd8-20210911T190239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the implementation of b5dd96b70ac (make credential helpers
builtins, 2020-08-13) to not build these at all under
NO_UNIX_SOCKETS.

This is the easiest way to get rid of one out of two users of an
obscure parse_options() API I'm trying to get rid of. It does mean
that the goal of emitting a custom error message in b5dd96b70ac is
being eliminated, but per [1] that seems to be an OK direction to go
in.

By not compiling it at all it won't be included in the "struct
cmd_struct", and therefore will also be omitted from
"--list-cmds=builtins".

1. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                           |  3 +++
 builtin.h                          |  2 ++
 builtin/credential-cache--daemon.c | 21 ---------------------
 builtin/credential-cache.c         | 21 ---------------------
 git.c                              |  2 ++
 5 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index 429c276058d..ecde3367fa2 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,8 +1086,10 @@ BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
+ifndef NO_UNIX_SOCKETS
 BUILTIN_OBJS += builtin/credential-cache--daemon.o
 BUILTIN_OBJS += builtin/credential-cache.o
+endif
 BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
@@ -1693,6 +1695,7 @@ ifdef NO_INET_PTON
 endif
 ifdef NO_UNIX_SOCKETS
 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
+	EXCLUDED_PROGRAMS += git-credential-cache git-credential-cache--daemon
 else
 	LIB_OBJS += unix-socket.o
 	LIB_OBJS += unix-stream-server.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f0..9b3f173bd7c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -140,8 +140,10 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 int cmd_config(int argc, const char **argv, const char *prefix);
 int cmd_count_objects(int argc, const char **argv, const char *prefix);
 int cmd_credential(int argc, const char **argv, const char *prefix);
+#ifndef NO_UNIX_SOCKETS
 int cmd_credential_cache(int argc, const char **argv, const char *prefix);
 int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
+#endif
 int cmd_credential_store(int argc, const char **argv, const char *prefix);
 int cmd_describe(int argc, const char **argv, const char *prefix);
 int cmd_diff_files(int argc, const char **argv, const char *prefix);
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4c6c89ab0de..7785412dea4 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,8 +1,5 @@
 #include "builtin.h"
 #include "parse-options.h"
-
-#ifndef NO_UNIX_SOCKETS
-
 #include "config.h"
 #include "tempfile.h"
 #include "credential.h"
@@ -299,21 +296,3 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
-
-#else
-
-int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
-{
-	const char * const usage[] = {
-		"git credential-cache--daemon [options] <action>",
-		"",
-		"credential-cache--daemon is disabled in this build of Git",
-		NULL
-	};
-	struct option options[] = { OPT_END() };
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	die(_("credential-cache--daemon unavailable; no unix socket support"));
-}
-
-#endif /* NO_UNIX_SOCKET */
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index e8a74157471..64942978650 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,8 +1,5 @@
 #include "builtin.h"
 #include "parse-options.h"
-
-#ifndef NO_UNIX_SOCKETS
-
 #include "credential.h"
 #include "string-list.h"
 #include "unix-socket.h"
@@ -137,21 +134,3 @@ int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
-
-#else
-
-int cmd_credential_cache(int argc, const char **argv, const char *prefix)
-{
-	const char * const usage[] = {
-		"git credential-cache [options] <action>",
-		"",
-		"credential-cache is disabled in this build of Git",
-		NULL
-	};
-	struct option options[] = { OPT_END() };
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	die(_("credential-cache unavailable; no unix socket support"));
-}
-
-#endif /* NO_UNIX_SOCKETS */
diff --git a/git.c b/git.c
index 18bed9a9964..7c696e06ecf 100644
--- a/git.c
+++ b/git.c
@@ -513,8 +513,10 @@ static struct cmd_struct commands[] = {
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
+#ifndef NO_UNIX_SOCKETS
 	{ "credential-cache", cmd_credential_cache },
 	{ "credential-cache--daemon", cmd_credential_cache_daemon },
+#endif
 	{ "credential-store", cmd_credential_store },
 	{ "describe", cmd_describe, RUN_SETUP },
 	{ "diff", cmd_diff, NO_PARSEOPT },
-- 
2.33.0.995.ga5ea46173a2


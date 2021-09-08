Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD949C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930F961157
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhIHFRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhIHFQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 01:16:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C3C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 22:15:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 18so1016121pfh.9
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzJvCmPxG446CHNTS/woGu4NjKJ/nUg4ehBPN6zNlag=;
        b=X+qM/70TmxzAvvmq+xMssvZhuGXQAR/OF9aktmhMHl5lDAkUxltua26sAgl2rZctLY
         uGZpEc5a+Kgfyt4HaqA2tafkFDClhSXKACkQIIjJjc22d7gtsFewlxUSFZW1nhA9T0gW
         CtYGH5CV0vuoCOKLfBjloV0X6elc+Ftmf3P4VcwqUVDsd/f5xYCsMw7sAgKF4IN7V++7
         aSCpj6q4xdq5FYx1Mt8a02AVosltdGvrWcAQlCgzpeEo/BNd4h+3V3afapj6b9rTPsob
         RAM4o6xm6REJLmHDDw433vcvOF7V1jRQn9js8EqnmBy04x3MLwpteRy9cyDZTlo2PYOv
         X+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzJvCmPxG446CHNTS/woGu4NjKJ/nUg4ehBPN6zNlag=;
        b=ch80Pot1qXsS+GxDLosWOH9Pmx2Y6R1ynMMhXH7pJZrFTykENnZ5ZgNCnxpg81EN9B
         pKPv+AiLQegR6y4nwBTQWuXL0rs5Ij+hf+zriYv5P1R1lkkR0dcl2lRcwuQjQkbiK5BO
         xzwww6WBfx+9/6FtUOitX/yZnLPrvIQi1VUobE3mlmpLsMGSRP0lVJc0p3jMB66JcWPD
         7yf6f4Apbaa64ZJZ1KglvthSyD/IlKiWro7YlMSQYmneNoGUaCgm2Q7FCwD41cEP6mjo
         cXXFyYVGkj8Isr5dHJgYqYz1VM5DfJaiRHdypwux3Nr7psS+eTTTWJruy0kAk7qSZf2Q
         ryfw==
X-Gm-Message-State: AOAM531QUSMRjOrQssncCp2u6lefaLxXDN6pQs5qP0wsr/GsAnsIFmQJ
        6T5R6KCaGygjwIQCk/hJvNcgcpkt+mp7Rg==
X-Google-Smtp-Source: ABdhPJyHiyuVuDedmLhC0hwz8/Dh8p1zlqwzKwk+ckpst0KeYvzoUa8xs4wtJUj/hwIylXWdUM46RQ==
X-Received: by 2002:a63:af4a:: with SMTP id s10mr1932951pgo.469.1631078150261;
        Tue, 07 Sep 2021 22:15:50 -0700 (PDT)
Received: from localhost.localdomain ([74.213.228.209])
        by smtp.gmail.com with ESMTPSA id s200sm745665pfs.89.2021.09.07.22.15.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:15:49 -0700 (PDT)
From:   Colin Curtis <colinpcurtis@gmail.com>
X-Google-Original-From: Colin Curtis <colinpcurtis826@ucla.edu>
To:     git@vger.kernel.org
Cc:     Colin Curtis <colinpcurtis@gmail.com>
Subject: [PATCH 1/2] add cmd_gud to open git-scm.com webpage
Date:   Tue,  7 Sep 2021 22:13:39 -0700
Message-Id: <20210908051340.13332-2-colinpcurtis826@ucla.edu>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
References: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Colin Curtis <colinpcurtis@gmail.com>

---
 .gitignore                |  1 +
 Documentation/git-gud.txt | 33 +++++++++++++++++++++++++++++++++
 Makefile                  |  3 ++-
 builtin.h                 |  1 +
 builtin/gud.c             | 27 +++++++++++++++++++++++++++
 git.c                     |  1 +
 t/t9904-git-gud.sh        | 16 ++++++++++++++++
 7 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-gud.txt
 create mode 100644 builtin/gud.c
 create mode 100755 t/t9904-git-gud.sh

diff --git a/.gitignore b/.gitignore
index 311841f9be..5fec146bd8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@
 /git-gc
 /git-get-tar-commit-id
 /git-grep
+/git-gud
 /git-hash-object
 /git-help
 /git-http-backend
diff --git a/Documentation/git-gud.txt b/Documentation/git-gud.txt
new file mode 100644
index 0000000000..357ff915a6
--- /dev/null
+++ b/Documentation/git-gud.txt
@@ -0,0 +1,33 @@
+git-gud(1)
+===========
+
+NAME
+----
+git-gud - Display git-scm.com website
+
+SYNOPSIS
+--------
+[verse]
+'git gud' [-d | --display] [<pathspec>...]
+
+DESCRIPTION
+-----------
+
+'git gud' command opens the webpage for git-scm.com in the default
+web browser.
+
+OPTIONS
+-------
+-d::
+--display::
+	Opens the webpage for git-scm.com in the default browser
+
+OUTPUT
+------
+If the '[-d | --display]' option is present, then the command opens
+up the git-scm.com webpage in the default web browser.  Otherwise,
+nothing is done.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 429c276058..379cd91a97 100644
--- a/Makefile
+++ b/Makefile
@@ -1108,6 +1108,7 @@ BUILTIN_OBJS += builtin/fsck.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
+BUILTIN_OBJS += builtin/gud.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/index-pack.o
@@ -1513,7 +1514,7 @@ ifndef NO_ICONV
 		ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
 			ICONV_LINK += -lintl
 		endif
-		EXTLIBS += $(ICONV_LINK) -liconv
+		EXTLIBS += $(ICONV_LINK) /usr/local/Cellar/libiconv/1.16/lib/libiconv.dylib # -liconv
 	endif
 endif
 ifdef ICONV_OMITS_BOM
diff --git a/builtin.h b/builtin.h
index 16ecd5586f..e183a1a8d4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -162,6 +162,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix);
 int cmd_gc(int argc, const char **argv, const char *prefix);
 int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
+int cmd_gud(int argc, const char **argv, const char *prefix);
 int cmd_hash_object(int argc, const char **argv, const char *prefix);
 int cmd_help(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/gud.c b/builtin/gud.c
new file mode 100644
index 0000000000..04808a08f5
--- /dev/null
+++ b/builtin/gud.c
@@ -0,0 +1,27 @@
+#include <stdio.h>
+#include "builtin.h"
+#include "parse-options.h"
+
+static int display_page;
+
+static const char * const builtin_gud_usage[] = {
+	N_("git gud [<options>]"),
+	NULL
+};
+
+static struct option builtin_gud_options[] = {
+        OPT_BOOL('d', "display", &display_page, N_("display the webpage for git-scm.com")),
+		OPT_END()
+};
+
+int cmd_gud(int argc, const char **argv, const char *prefix)
+{    
+
+    argc = parse_options(argc, argv, prefix,
+                builtin_gud_options, builtin_gud_usage, 0);
+    if (display_page) {
+        system("open https://git-scm.com/book/en/v2");
+    }
+    
+    return 0;
+}
\ No newline at end of file
diff --git a/git.c b/git.c
index 18bed9a996..2da1f4d2d4 100644
--- a/git.c
+++ b/git.c
@@ -536,6 +536,7 @@ static struct cmd_struct commands[] = {
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
+	{ "gud", cmd_gud, RUN_SETUP },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
diff --git a/t/t9904-git-gud.sh b/t/t9904-git-gud.sh
new file mode 100755
index 0000000000..47fa97498c
--- /dev/null
+++ b/t/t9904-git-gud.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+test_description='git-gud test
+
+This test runs git-gud and makes sure it does not crash.'
+
+. ./test-lib.sh
+
+test_expect_success 'runs correctly with no args' '
+	git gud
+'
+
+test_expect_success 'runs correctly with -d option' '
+	git gud -d
+'
+
+test_done
-- 
2.30.1 (Apple Git-130)


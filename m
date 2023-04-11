Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0ECC76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDKHnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDKHnB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:43:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DD840C3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ik20so6929998plb.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198950; x=1683790950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6lsqqwNO+iMXHMQZn8Q4eBQwPklw0gDnVX1psZE5qM=;
        b=RmcAVe4AZq08WZuNTuAZHdDsRA5rXfkXy82B0otp1/SYSHHRzmKxniXUFE+195M2Ps
         ipxOKf6WWddu70F6iFK/h6+C8rKnuvappxBIPTTgW4lqTdmI4A52o1BCW7qZmCdUn4eR
         NpMlwX+vtSuXXjt/kvGVRpDOWb2WX6XlSOV2GI5m+XeAh39Po/Z6Js80Y9zeSB1D2NzQ
         4/hqwr0WT9RJLMiBvhljXT+YfnfR5aiKa7TAizFfbOIv3WhHXFLKgBB23gD8XFRxX5sW
         XMagaSoFLJgzL60L24y6Pz0ArvHJzBZpvRMoltfv60SboQLOKHQday6EeCQIG7nsjlmm
         Hi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198950; x=1683790950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6lsqqwNO+iMXHMQZn8Q4eBQwPklw0gDnVX1psZE5qM=;
        b=G6Byu0vpI6hljKhF403UoIqYgX+tF0iyzbyO21Zohe278eFkjfhgm0XxLDqqS5y6O5
         hZ8PWj1s5VMtiPB/ypXasvjPnG2QgEFVF+nTA8McFza1r4Uq5GgHkh/TZ3Fg6M6+aDCD
         O9x67lkxZsB3294aJaPEQ0N+50gaFNceLQsnjtTVBi3FMSxwbtJAXU4lRxJuGgs5e7TD
         Rc6ZcOw8XonwMKOmDDY1Lcv7gIbcBQ8fNXy0dFLjGUUftz5vBZBm3Z2XTMWbzuBazGQj
         6yjKCF/a2DftAHFIvQEMBTvi5s7CLT+v4d/iLEVvGHBEeUu9BGjr8WQjryqs3Mf1zLUz
         EbVg==
X-Gm-Message-State: AAQBX9fM5eYTS+dtaBWnIp7IETbuPfjUAg/OdEu/d4CPQeB5MaB9DVrX
        OG7bmXJWsOfDo2PpbQf8Uno1CB/f8Ds=
X-Google-Smtp-Source: AKy350av5SQZTWAoca/umrqUfxBHGbTLDFU4LcdWG04bVnKTTplZpC/JGUxcHcag7OwZa7D+o+KD9w==
X-Received: by 2002:a17:902:d14a:b0:1a4:f1aa:3ea8 with SMTP id t10-20020a170902d14a00b001a4f1aa3ea8mr13893994plt.48.1681198950480;
        Tue, 11 Apr 2023 00:42:30 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 18/23] pager.h: move declarations for pager.c functions from cache.h
Date:   Tue, 11 Apr 2023 00:41:59 -0700
Message-Id: <20230411074204.3024420-13-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 builtin/am.c       |  1 +
 builtin/blame.c    |  1 +
 builtin/fetch.c    |  1 +
 builtin/grep.c     |  1 +
 builtin/help.c     |  1 +
 builtin/log.c      |  1 +
 builtin/name-rev.c |  1 +
 builtin/var.c      |  1 +
 cache.h            | 13 -------------
 color.c            |  1 +
 column.c           |  1 +
 config.c           |  1 +
 date.c             |  1 +
 diff.c             |  1 +
 editor.c           |  1 +
 environment.c      |  1 -
 git.c              |  1 +
 pager.c            |  3 +++
 pager.h            | 17 +++++++++++++++++
 pretty.c           |  1 +
 progress.c         |  1 +
 range-diff.c       |  1 +
 sequencer.c        |  1 +
 23 files changed, 39 insertions(+), 14 deletions(-)
 create mode 100644 pager.h

diff --git a/builtin/am.c b/builtin/am.c
index f7a065e5290..5c83f2e003f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -40,6 +40,7 @@
 #include "apply.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "pager.h"
 #include "repository.h"
 #include "pretty.h"
 #include "wrapper.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index a628388c2ce..2df6039a6e0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -30,6 +30,7 @@
 #include "progress.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "pager.h"
 #include "blame.h"
 #include "refs.h"
 #include "setup.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8a8ab6799e8..61e8ac113b1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "strvec.h"
 #include "utf8.h"
 #include "packfile.h"
+#include "pager.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
 #include "branch.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index fb11be6075a..b86c754defb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -30,6 +30,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "pager.h"
 #include "write-or-die.h"
 
 static const char *grep_prefix;
diff --git a/builtin/help.c b/builtin/help.c
index 87333a02ec4..128aa83099a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "gettext.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "config-list.h"
diff --git a/builtin/log.c b/builtin/log.c
index b6246c7042c..95de51921f8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -15,6 +15,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "pager.h"
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 41fd56b9ba9..593f0506a10 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -9,6 +9,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "object-name.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "hash-lookup.h"
diff --git a/builtin/var.c b/builtin/var.c
index 90616cf65a2..aa8150fa92e 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -7,6 +7,7 @@
 #include "config.h"
 #include "editor.h"
 #include "ident.h"
+#include "pager.h"
 #include "refs.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
diff --git a/cache.h b/cache.h
index 97ddf4094a3..21fd520b045 100644
--- a/cache.h
+++ b/cache.h
@@ -145,7 +145,6 @@ struct cache_entry {
 
 /* Forward structure decls */
 struct pathspec;
-struct child_process;
 struct tree;
 
 /*
@@ -621,8 +620,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-const char *git_pager(int stdout_is_tty);
-
 struct cache_def {
 	struct strbuf path;
 	int flags;
@@ -671,16 +668,6 @@ int copy_fd(int ifd, int ofd);
 int copy_file(const char *dst, const char *src, int mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
 
-/* pager.c */
-void setup_pager(void);
-int pager_in_use(void);
-extern int pager_use_color;
-int term_columns(void);
-void term_clear_line(void);
-int decimal_width(uintmax_t);
-int check_pager_config(const char *cmd);
-void prepare_pager_args(struct child_process *, const char *pager);
-
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
diff --git a/color.c b/color.c
index a8e8d5202ab..6031998d3ea 100644
--- a/color.c
+++ b/color.c
@@ -4,6 +4,7 @@
 #include "editor.h"
 #include "gettext.h"
 #include "hex.h"
+#include "pager.h"
 
 static int git_use_color_default = GIT_COLOR_AUTO;
 int color_stdout_is_tty = -1;
diff --git a/column.c b/column.c
index fbf88639aae..c89c90328a6 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "column.h"
 #include "string-list.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "utf8.h"
diff --git a/config.c b/config.c
index aac439530e9..11e3295419b 100644
--- a/config.c
+++ b/config.c
@@ -25,6 +25,7 @@
 #include "string-list.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "pager.h"
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
diff --git a/date.c b/date.c
index 1fb2cd1b538..e944c8905af 100644
--- a/date.c
+++ b/date.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "date.h"
 #include "gettext.h"
+#include "pager.h"
 
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
diff --git a/diff.c b/diff.c
index f8e0d3b5c59..fa86d023196 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,7 @@
 #include "graph.h"
 #include "oid-array.h"
 #include "packfile.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "help.h"
 #include "promisor-remote.h"
diff --git a/editor.c b/editor.c
index 12025dfec37..7c796385493 100644
--- a/editor.c
+++ b/editor.c
@@ -5,6 +5,7 @@
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
+#include "pager.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
diff --git a/environment.c b/environment.c
index 39efa49fe31..8a96997539a 100644
--- a/environment.c
+++ b/environment.c
@@ -59,7 +59,6 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
-int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
diff --git a/git.c b/git.c
index d2bb86e0d32..0241d2cf913 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "help.h"
+#include "pager.h"
 #include "run-command.h"
 #include "alias.h"
 #include "replace-object.h"
diff --git a/pager.c b/pager.c
index 6367e8ef867..be78c706644 100644
--- a/pager.c
+++ b/pager.c
@@ -1,10 +1,13 @@
 #include "cache.h"
 #include "config.h"
 #include "editor.h"
+#include "pager.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "alias.h"
 
+int pager_use_color = 1;
+
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
 #endif
diff --git a/pager.h b/pager.h
new file mode 100644
index 00000000000..b77433026dc
--- /dev/null
+++ b/pager.h
@@ -0,0 +1,17 @@
+#ifndef PAGER_H
+#define PAGER_H
+
+struct child_process;
+
+const char *git_pager(int stdout_is_tty);
+void setup_pager(void);
+int pager_in_use(void);
+int term_columns(void);
+void term_clear_line(void);
+int decimal_width(uintmax_t);
+int check_pager_config(const char *cmd);
+void prepare_pager_args(struct child_process *, const char *pager);
+
+extern int pager_use_color;
+
+#endif /* PAGER_H */
diff --git a/pretty.c b/pretty.c
index 76fc4f61e40..c4671603b56 100644
--- a/pretty.c
+++ b/pretty.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "utf8.h"
 #include "diff.h"
+#include "pager.h"
 #include "revision.h"
 #include "string-list.h"
 #include "mailmap.h"
diff --git a/progress.c b/progress.c
index c5c8514737a..96a8e36a52f 100644
--- a/progress.c
+++ b/progress.c
@@ -10,6 +10,7 @@
 
 #define GIT_TEST_PROGRESS_ONLY
 #include "cache.h"
+#include "pager.h"
 #include "progress.h"
 #include "strbuf.h"
 #include "trace.h"
diff --git a/range-diff.c b/range-diff.c
index a2994331a14..a1e0cffb9f6 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -11,6 +11,7 @@
 #include "linear-assignment.h"
 #include "diffcore.h"
 #include "commit.h"
+#include "pager.h"
 #include "pretty.h"
 #include "userdiff.h"
 #include "apply.h"
diff --git a/sequencer.c b/sequencer.c
index be10249fd0a..fcca3b81447 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -12,6 +12,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "object.h"
+#include "pager.h"
 #include "commit.h"
 #include "sequencer.h"
 #include "tag.h"
-- 
2.40.0.172.g72fe1174621


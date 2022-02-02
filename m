Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B585EC433FE
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347361AbiBBVEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiBBVEH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:04:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB944C06173B
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:04:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v13so864990wrv.10
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DW4Sau7EZrCaJMacaj4zL5XS5XWT7gPTZDgrBk7RMQ=;
        b=LGFA4qaQh2DEoxBx5ufgxe2kcn5OCeWyrNRuxlOI/4Usefgq/KQTyX3SaP2ZfiASZV
         qRhrWEdmlsab3Zbvj7YEclCBwZVTdOKunSsvy707nTNBDnDkXuRHDzIc7jJp6H2XQVu0
         OCY8BSv+l+XA0/vGpleuZl1vjCMc6jRIFWAuK+iEk7/l/JOAbjYiShI+f6s+iue8fEA6
         v83nSMwb8hmZkpTlU32Lc+yC6+yAqCRYmC8HBFi9KdWfMIZBwVxN7MbH9EjY8XJN2Be0
         lHSAejDpN+xvnzMcWxgLdosG4WxKIdZo7HjchLovIdXI620fmIfa5rjxcrZEBifOy/VB
         +d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DW4Sau7EZrCaJMacaj4zL5XS5XWT7gPTZDgrBk7RMQ=;
        b=3Ell+xVDHSCek1/L8XDmIcWyGpoHFQNBusis/F05RF/La/ew1VAhzDIn2ck01/fkvR
         GEVTnaCqfgOtlu6WZ2UxY3YRK2KlDOd2hayDYIAFQ/70mOfa4oQZRY1Y3tXcwiMAasLK
         d00tU7ZhcclNmLvlUEKjEeD33iMLFh5s649d8y8uH2TFrFo9jf1hglQa39UH+LCfV5m8
         yr6Npzqm5gx+6qxVXCiPsfOT2oUUqIeKq+YgAojrCawqY53FPDgGnJDLSethowLYcCQV
         I/EetmtLklwVyvntm9kGKljyhUAX/zPVvy7Kgj/wT06khzr0vAiZiuae7clkMJ/HCRgY
         3sJg==
X-Gm-Message-State: AOAM531Dp23MXe8Rh9d5tgZKHkhMmk0a25+CUcv8kdltosEoEfXNWMYl
        +HxE9z83mj1/oi8/1gIxB7yHshkGFljBEw==
X-Google-Smtp-Source: ABdhPJxfcB/nqzAKG0YfxTYzEgQAZPCo/UdkXxc1wo7CvAtKTcuZEo58GBoCJd0e9uDaYBSMI+j1kg==
X-Received: by 2002:a05:6000:2c1:: with SMTP id o1mr3492922wry.258.1643835845169;
        Wed, 02 Feb 2022 13:04:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm17264592wry.50.2022.02.02.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:04:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] date API: create a date.h, split from cache.h
Date:   Wed,  2 Feb 2022 22:03:50 +0100
Message-Id: <patch-2.5-7de62956db4-20220202T195651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.920.g34be1f84792
In-Reply-To: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net> <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of the date.c functions from cache.h, and adjust
the relevant users to include the new date.h header.

The show_ident_date() function belonged in pretty.h (it's defined in
pretty.c), its two users outside of pretty.c didn't strictly need to
include pretty.h, as they get it indirectly, but let's add it to them
anyway.

Similarly, the change to "builtin/{fast-import,show-branch,tag}.c"
isn't needed as far as the compiler is concerned, but since they all
use the "DATE_MODE()" macro we now define in date.h, let's have them
include it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive-zip.c         |  1 +
 builtin/am.c          |  1 +
 builtin/commit.c      |  1 +
 builtin/fast-import.c |  1 +
 builtin/show-branch.c |  1 +
 builtin/tag.c         |  1 +
 cache.h               | 48 -------------------------------------------
 config.c              |  1 +
 date.c                |  1 +
 date.h                | 43 ++++++++++++++++++++++++++++++++++++++
 http-backend.c        |  1 +
 ident.c               |  1 +
 object-name.c         |  1 +
 pretty.h              | 10 +++++++++
 refs.c                |  1 +
 strbuf.c              |  1 +
 t/helper/test-date.c  |  1 +
 17 files changed, 67 insertions(+), 48 deletions(-)
 create mode 100644 date.h

diff --git a/archive-zip.c b/archive-zip.c
index 2961e01c754..8ea9d1a5dae 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -9,6 +9,7 @@
 #include "object-store.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
+#include "date.h"
 
 static int zip_date;
 static int zip_time;
diff --git a/builtin/am.c b/builtin/am.c
index b6be1f1cb11..cc8cd6d6e4b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -34,6 +34,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "pretty.h"
 
 /**
  * Returns the length of the first line of msg.
diff --git a/builtin/commit.c b/builtin/commit.c
index b9ed0374e30..6b99ac276d8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -37,6 +37,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "pretty.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2b2e28bad79..28f2b9cc91f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -19,6 +19,7 @@
 #include "mem-pool.h"
 #include "commit-reach.h"
 #include "khash.h"
+#include "date.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e12c5e80e3e..330b0553b9d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "dir.h"
 #include "commit-slab.h"
+#include "date.h"
 
 static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
diff --git a/builtin/tag.c b/builtin/tag.c
index 134b3f1edf0..2479da07049 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -20,6 +20,7 @@
 #include "oid-array.h"
 #include "column.h"
 #include "ref-filter.h"
+#include "date.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
diff --git a/cache.h b/cache.h
index 49b46244c74..6add78fd701 100644
--- a/cache.h
+++ b/cache.h
@@ -1557,46 +1557,6 @@ struct object *repo_peel_to_type(struct repository *r,
 #define peel_to_type(name, namelen, obj, type) \
 	repo_peel_to_type(the_repository, name, namelen, obj, type)
 
-enum date_mode_type {
-	DATE_NORMAL = 0,
-	DATE_HUMAN,
-	DATE_RELATIVE,
-	DATE_SHORT,
-	DATE_ISO8601,
-	DATE_ISO8601_STRICT,
-	DATE_RFC2822,
-	DATE_STRFTIME,
-	DATE_RAW,
-	DATE_UNIX
-};
-
-struct date_mode {
-	enum date_mode_type type;
-	const char *strftime_fmt;
-	int local;
-};
-
-/*
- * Convenience helper for passing a constant type, like:
- *
- *   show_date(t, tz, DATE_MODE(NORMAL));
- */
-#define DATE_MODE(t) date_mode_from_type(DATE_##t)
-struct date_mode *date_mode_from_type(enum date_mode_type type);
-
-const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
-void show_date_relative(timestamp_t time, struct strbuf *timebuf);
-int parse_date(const char *date, struct strbuf *out);
-int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
-int parse_expiry_date(const char *date, timestamp_t *timestamp);
-void datestamp(struct strbuf *out);
-#define approxidate(s) approxidate_careful((s), NULL)
-timestamp_t approxidate_careful(const char *, int *);
-timestamp_t approxidate_relative(const char *date);
-void parse_date_format(const char *format, struct date_mode *mode);
-int date_overflows(timestamp_t date);
-time_t tm_to_time_t(const struct tm *tm);
-
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
 #define IDENT_NO_NAME	       4
@@ -1642,14 +1602,6 @@ struct ident_split {
  */
 int split_ident_line(struct ident_split *, const char *, int);
 
-/*
- * Like show_date, but pull the timestamp and tz parameters from
- * the ident_split. It will also sanity-check the values and produce
- * a well-known sentinel date if they appear bogus.
- */
-const char *show_ident_date(const struct ident_split *id,
-			    const struct date_mode *mode);
-
 /*
  * Compare split idents for equality or strict ordering. Note that we
  * compare only the ident part of the line, ignoring any timestamp.
diff --git a/config.c b/config.c
index 2bffa8d4a01..9c9dc8a6f62 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,7 @@
  *
  */
 #include "cache.h"
+#include "date.h"
 #include "branch.h"
 #include "config.h"
 #include "environment.h"
diff --git a/date.c b/date.c
index 84bb4451c1a..863b07e9e63 100644
--- a/date.c
+++ b/date.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "date.h"
 
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
diff --git a/date.h b/date.h
new file mode 100644
index 00000000000..5db9ec8dd29
--- /dev/null
+++ b/date.h
@@ -0,0 +1,43 @@
+#ifndef DATE_H
+#define DATE_H
+
+enum date_mode_type {
+	DATE_NORMAL = 0,
+	DATE_HUMAN,
+	DATE_RELATIVE,
+	DATE_SHORT,
+	DATE_ISO8601,
+	DATE_ISO8601_STRICT,
+	DATE_RFC2822,
+	DATE_STRFTIME,
+	DATE_RAW,
+	DATE_UNIX
+};
+
+struct date_mode {
+	enum date_mode_type type;
+	const char *strftime_fmt;
+	int local;
+};
+
+/*
+ * Convenience helper for passing a constant type, like:
+ *
+ *   show_date(t, tz, DATE_MODE(NORMAL));
+ */
+#define DATE_MODE(t) date_mode_from_type(DATE_##t)
+struct date_mode *date_mode_from_type(enum date_mode_type type);
+
+const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
+void show_date_relative(timestamp_t time, struct strbuf *timebuf);
+int parse_date(const char *date, struct strbuf *out);
+int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
+int parse_expiry_date(const char *date, timestamp_t *timestamp);
+void datestamp(struct strbuf *out);
+#define approxidate(s) approxidate_careful((s), NULL)
+timestamp_t approxidate_careful(const char *, int *);
+timestamp_t approxidate_relative(const char *date);
+void parse_date_format(const char *format, struct date_mode *mode);
+int date_overflows(timestamp_t date);
+time_t tm_to_time_t(const struct tm *tm);
+#endif
diff --git a/http-backend.c b/http-backend.c
index 807fb8839e7..81a7229ece0 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -13,6 +13,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "protocol.h"
+#include "date.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
diff --git a/ident.c b/ident.c
index 6aba4b5cb6f..89ca5b47008 100644
--- a/ident.c
+++ b/ident.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "config.h"
+#include "date.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
diff --git a/object-name.c b/object-name.c
index fdff4601b2c..f9527817b64 100644
--- a/object-name.c
+++ b/object-name.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "midx.h"
 #include "commit-reach.h"
+#include "date.h"
 
 static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
 
diff --git a/pretty.h b/pretty.h
index 2f16acd213d..f34e24c53a4 100644
--- a/pretty.h
+++ b/pretty.h
@@ -2,6 +2,7 @@
 #define PRETTY_H
 
 #include "cache.h"
+#include "date.h"
 #include "string-list.h"
 
 struct commit;
@@ -163,4 +164,13 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 			const char **arg,
 			char **invalid_arg);
 
+/*
+ * Like show_date, but pull the timestamp and tz parameters from
+ * the ident_split. It will also sanity-check the values and produce
+ * a well-known sentinel date if they appear bogus.
+ */
+const char *show_ident_date(const struct ident_split *id,
+			    const struct date_mode *mode);
+
+
 #endif /* PRETTY_H */
diff --git a/refs.c b/refs.c
index addb26293b4..33ed3732d1b 100644
--- a/refs.c
+++ b/refs.c
@@ -19,6 +19,7 @@
 #include "strvec.h"
 #include "repository.h"
 #include "sigchain.h"
+#include "date.h"
 
 /*
  * List of all available backends
diff --git a/strbuf.c b/strbuf.c
index 613fee8c82e..00abeb55afd 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "date.h"
 
 int starts_with(const char *str, const char *prefix)
 {
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 099eff4f0fc..ded3d059f56 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "date.h"
 
 static const char *usage_msg = "\n"
 "  test-tool date relative [time_t]...\n"
-- 
2.35.0.913.g12b4baa2536


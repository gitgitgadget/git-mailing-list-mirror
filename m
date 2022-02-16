Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8345C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiBPIOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:14:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiBPIO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:14:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F82503B3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so971308wmq.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lmRz54IBwh6lqRlhHobkqzV8zdEE+2tPmrMXxJOjeE=;
        b=CvvyejT1+JJRAceoNRqzcLrcivaeIaPBXgrdXPrCueL2BS9NY2Wm/nH4okjIfWMlHx
         BBHaG+CHHugcfqj9vnuaMHa6mURUG4dwIt313oSbGAZ2FoiXYPygj51toCm02rqekdMx
         lVeT3SARJqrg75eLrUoMzsA6QZ4ihtQOx4vkx+gfDU74bqnpTFB5jB5tBeJbQtcr2wy6
         HWYj1uDcfFZG5A9PJLMwISdBTcl+fZee85MjWEgI/TVzA2GrIJkoPl8246ri7MieMIBr
         lCYMkwdT7b7X6IMiKSwalk9nvCrX/wyYOGO4vscSbVvTtSotXF0ER+SdKsx4SZEYZ1ll
         qB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lmRz54IBwh6lqRlhHobkqzV8zdEE+2tPmrMXxJOjeE=;
        b=Y4jbN/pGUNQdpmSTYYjzXKEdbEQaVWEaNFVieiGRtm/gxe4EDqDrPXkiS7ljGpgpH4
         teisYuyIqRFcPb8PclvWaCk6KFUfRZHKHwgvU0Sq9Xjno+MRzWhJP+Ie8KyJ76NDTlOO
         ELV65OfMQdZd+6gb2rut2DTIzJ01p6QsjlXg9edBbgggpfYm/Y502dIa3bPlmvSM83SC
         FszYU7uJf8N9awJ1HsZLay37cighuYqav04ZOUtLhqooRMbI7AmEskFKOPa67cMw5Ak/
         vcbLHQh+YGWw+HbSK+8UcmV2lG+2may1Xik7Oi+1M5slRmrymCSyV53qWrEeM3dhlmzG
         USZw==
X-Gm-Message-State: AOAM5301X349TxH3UwMwloSKuENl127OjxSfaUlU9uTmhmfS/z9RjZJ6
        l4K6MEi3C+47Ctmfogl77RvfrEbJDWlaxQ==
X-Google-Smtp-Source: ABdhPJwhixdULYUzu/ISQCv4CBL2DyB5sqbfunplTcYe2O7qUIdkpHLfXFJWwRFjKyGar3CNQXJgXQ==
X-Received: by 2002:a7b:cb44:0:b0:37b:c569:5924 with SMTP id v4-20020a7bcb44000000b0037bc5695924mr418687wmj.83.1644999254778;
        Wed, 16 Feb 2022 00:14:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b16sm26173443wrj.26.2022.02.16.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:14:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] date API: create a date.h, split from cache.h
Date:   Wed, 16 Feb 2022 09:14:02 +0100
Message-Id: <patch-v3-2.5-f73aa601e95-20220216T081203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
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

We could simply include this new header in "cache.h", but as this
change shows these functions weren't common enough to warrant
including in it in the first place. By moving them out of cache.h
changes to this API will no longer cause a (mostly) full re-build of
the project when "make" is run.

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
 reflog-walk.h         |  1 +
 refs.c                |  1 +
 strbuf.c              |  1 +
 t/helper/test-date.c  |  1 +
 18 files changed, 68 insertions(+), 48 deletions(-)
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
index 7de2c89ef22..eb24bc89bb5 100644
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
index 703a474e5a7..48e77aa0697 100644
--- a/cache.h
+++ b/cache.h
@@ -1559,46 +1559,6 @@ struct object *repo_peel_to_type(struct repository *r,
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
@@ -1644,14 +1604,6 @@ struct ident_split {
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
index e0c03d154c9..430868f1ec0 100644
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
index 92862eeb1ac..060d892a97f 100644
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
diff --git a/reflog-walk.h b/reflog-walk.h
index f26408f6cc1..e9e00ffd479 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -5,6 +5,7 @@
 
 struct commit;
 struct reflog_walk_info;
+struct date_mode;
 
 void init_reflog_walk(struct reflog_walk_info **info);
 int add_reflog_for_walk(struct reflog_walk_info *info,
diff --git a/refs.c b/refs.c
index 7017ae59804..b74f3815a52 100644
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
2.35.1.1028.g2d2d4be19de


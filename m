Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DFC2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1A233F6
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgLPOwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLPOwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:52:09 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1FC061282
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:13 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b64so18677962qkc.12
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqvjEPwDySi5qCZ9C1GDjHrDd4rLxD1WRnAODmeT4Ko=;
        b=j+EGkkxub9kUDMyBxmQBnunFy0yeo94rGa+7zsitZt4SqmJ33qvBMNlZUe4Uec8EL8
         QJOIp31W17OL5JjyPh62BUP7w473Tu7FdOeuBw8Xv8dBBJi/IfY426SL568KBuzospbx
         I1+CKmml3ZdbccCFJu7fEytxQToluhVV4eLaNjmf0zVt55g0IK7g5lTIp7R4cC+d/Nd6
         YtTMUoORDXnHDlxHugR1Tb9P76SuvYSg/8sVgHGxHt6XAqNHtT5sICs9/E35PS7HDR1M
         ZmVVj8Tx2g5gpxUCB0SuVqRfZDrBBqAwUgBof7ax0kV/5Q7QluatIElVCFKBlNoAeFJu
         oeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqvjEPwDySi5qCZ9C1GDjHrDd4rLxD1WRnAODmeT4Ko=;
        b=MTUohbM15xduEGImb5xa7zo/2cK58xD+B0x71lo7NikwQVOInB7izq0DPYZcYAV5iF
         a62aYYvyBslbtFfIkv9i/9Dlg1nLFCam2sKFCWxEP36bfQz5gnt7PApqNRQ7v9PbRI3x
         l2BNBSmiDPppZDSOBxIgv9XRcq5OmbcgN7QMj9sNC5X17cqychYvqEOApysCvMfanfAq
         EabtxhGKLDHhYMqq4M2rNLHgYtOhG42Cv9GY02Ysk/zPtKsrREsOWCs+A6iAxiSmrUaB
         Cfh8wYFnkT8/B20ptc1BVsmed51iT9ob+8vJZMZBRL9jZYaVWYF/s2T4SryHfWP41Y6h
         431g==
X-Gm-Message-State: AOAM533fMtqs8F6PUU7cKsGDE/v07URPRx081/q1txUP8cwGGN75KJ8+
        jfy3iXyNQVuVKRkGAP5wMmRDcGN45N2dDw==
X-Google-Smtp-Source: ABdhPJxseIhuewYJlpCXCtMVG5iFIKTNmqa55zamxfBrwOpA/W8VjpIWfRrZaGcVBy4IrXlLNxLC6g==
X-Received: by 2002:a37:458:: with SMTP id 85mr43302092qke.61.1608130272025;
        Wed, 16 Dec 2020 06:51:12 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:11 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
Subject: [PATCH v5 5/9] entry: extract a header file for entry.c functions
Date:   Wed, 16 Dec 2020 11:50:34 -0300
Message-Id: <934ead9519a97e404a76e27331db32ac65670268.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The declarations of entry.c's public functions and structures currently
reside in cache.h. Although not many, they contribute to the size of
cache.h and, when changed, cause the unnecessary recompilation of
modules that don't really use these functions. So let's move them to a
new entry.h header. While at it let's also move a comment related to
checkout_entry() from entry.c to entry.h as it's more useful to describe
the function there.

Original-patch-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 apply.c                  |  1 +
 builtin/checkout-index.c |  1 +
 builtin/checkout.c       |  1 +
 builtin/difftool.c       |  1 +
 cache.h                  | 24 -----------------------
 entry.c                  |  9 +--------
 entry.h                  | 42 ++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c           |  1 +
 8 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 entry.h

diff --git a/apply.c b/apply.c
index 4a4e9a0158..fda7b4f770 100644
--- a/apply.c
+++ b/apply.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "rerere.h"
 #include "apply.h"
+#include "entry.h"
 
 struct gitdiff_data {
 	struct strbuf *root;
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 4bbfc92dce..9276ed0258 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -11,6 +11,7 @@
 #include "quote.h"
 #include "cache-tree.h"
 #include "parse-options.h"
+#include "entry.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b82119129..f92f29bad3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -26,6 +26,7 @@
 #include "unpack-trees.h"
 #include "wt-status.h"
 #include "xdiff-interface.h"
+#include "entry.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6e18e623fd..ef25729d49 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -23,6 +23,7 @@
 #include "lockfile.h"
 #include "object-store.h"
 #include "dir.h"
+#include "entry.h"
 
 static int trust_exit_code;
 
diff --git a/cache.h b/cache.h
index 8d279bc110..a3a70cd8a4 100644
--- a/cache.h
+++ b/cache.h
@@ -1711,30 +1711,6 @@ const char *show_ident_date(const struct ident_split *id,
  */
 int ident_cmp(const struct ident_split *, const struct ident_split *);
 
-struct checkout {
-	struct index_state *istate;
-	const char *base_dir;
-	int base_dir_len;
-	struct delayed_checkout *delayed_checkout;
-	struct checkout_metadata meta;
-	unsigned force:1,
-		 quiet:1,
-		 not_new:1,
-		 clone:1,
-		 refresh_cache:1;
-};
-#define CHECKOUT_INIT { NULL, "" }
-
-#define TEMPORARY_FILENAME_LENGTH 25
-int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath, int *nr_checkouts);
-void enable_delayed_checkout(struct checkout *state);
-int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
-/*
- * Unlink the last component and schedule the leading directories for
- * removal, such that empty directories get removed.
- */
-void unlink_entry(const struct cache_entry *ce);
-
 struct cache_def {
 	struct strbuf path;
 	int flags;
diff --git a/entry.c b/entry.c
index a0532f1f00..b0b8099699 100644
--- a/entry.c
+++ b/entry.c
@@ -6,6 +6,7 @@
 #include "submodule.h"
 #include "progress.h"
 #include "fsmonitor.h"
+#include "entry.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -429,14 +430,6 @@ static void mark_colliding_entries(const struct checkout *state,
 	}
 }
 
-/*
- * Write the contents from ce out to the working tree.
- *
- * When topath[] is not NULL, instead of writing to the working tree
- * file named by ce, a temporary file is created by this function and
- * its name is returned in topath[], which must be able to hold at
- * least TEMPORARY_FILENAME_LENGTH bytes long.
- */
 int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		   char *topath, int *nr_checkouts)
 {
diff --git a/entry.h b/entry.h
new file mode 100644
index 0000000000..acbbb90220
--- /dev/null
+++ b/entry.h
@@ -0,0 +1,42 @@
+#ifndef ENTRY_H
+#define ENTRY_H
+
+#include "cache.h"
+#include "convert.h"
+
+struct checkout {
+	struct index_state *istate;
+	const char *base_dir;
+	int base_dir_len;
+	struct delayed_checkout *delayed_checkout;
+	struct checkout_metadata meta;
+	unsigned force:1,
+		 quiet:1,
+		 not_new:1,
+		 clone:1,
+		 refresh_cache:1;
+};
+#define CHECKOUT_INIT { NULL, "" }
+
+#define TEMPORARY_FILENAME_LENGTH 25
+/*
+ * Write the contents from ce out to the working tree.
+ *
+ * When topath[] is not NULL, instead of writing to the working tree
+ * file named by ce, a temporary file is created by this function and
+ * its name is returned in topath[], which must be able to hold at
+ * least TEMPORARY_FILENAME_LENGTH bytes long.
+ */
+int checkout_entry(struct cache_entry *ce, const struct checkout *state,
+		   char *topath, int *nr_checkouts);
+
+void enable_delayed_checkout(struct checkout *state);
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
+
+/*
+ * Unlink the last component and schedule the leading directories for
+ * removal, such that empty directories get removed.
+ */
+void unlink_entry(const struct cache_entry *ce);
+
+#endif /* ENTRY_H */
diff --git a/unpack-trees.c b/unpack-trees.c
index 323280dd48..a511fadd89 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,6 +16,7 @@
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "entry.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
-- 
2.29.2


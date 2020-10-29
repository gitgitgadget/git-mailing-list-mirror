Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FBC388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9039820720
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Em8OSLuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403942AbgJ2CQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgJ2CPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:39 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB2C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:39 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h12so1005664qtu.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWt5S6CR4bv3wmLSVyvNCY7+0YIRjTJ13RI1O+bm5Bw=;
        b=Em8OSLuhYdCZ0zh00A/M47+yQfXboGA35yQfTTuMBQI/yC++Z1BkHbtFcIx4YwptxZ
         4aYHCnyEBRbmnVcgIrwLZS9HUHVbyvZve9RjUQ+wMfFBWzBQ+KRG4hIIMdpfxIRlb+f1
         e4bZN/kDTnjvRHiMmncZC+B3HhPFDlEFKPGF8frmfBBzJ1ysZzevHnIg4wfbVg9q0l3a
         MoeksXrTqG5gBvRmZjNN3zAtKanWvv+TWrGFQprB3/WMFAb3wyX/dGEiJJkLfOqkEnoe
         Z2OZotDWmFeYarxMW2p4BIG2OaydtuesDUu9StLTeQISJVVjisJZU2NgCl2Fo/4zMTMS
         ulgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWt5S6CR4bv3wmLSVyvNCY7+0YIRjTJ13RI1O+bm5Bw=;
        b=b1TcUoT2ivYy94E5N67hqS1OE+NldsbchIwK1bUmvPaZFzcUXpcb9MXHjmuMNVxfT/
         YMSzX9Dr9Z5zzn6a5M//wdoeOGlOgy42CEG8pZWSUu5PJiAhfYFVzK6FN4TNi4C7bjxt
         QHQGveqYLiJqYdYGd/iJuSifg6iCoRzDLTWP35Y1UFeZTuZo+RLIcC5ITv3bB4roKDLT
         oFBSKyJIpaCQIV7eJvnAQhxhUerHLjAu+R9Ttwcmf89anVRBe08sa9t8wpTX3iKiU1NO
         usCdB87hA66BqoNx14r1JeJ8XubMdHiJ0pEtOF8Etnyu0sI/Ya0uHzR9N9D5St2QcJkO
         kHkA==
X-Gm-Message-State: AOAM531O5+xYLEZsZpj0aRBUJdySsGTP6RrUbmtlCilRztEFOp87o104
        ji5yaE3NX+Idrt5IU+y07by5EQHkn5A3+g==
X-Google-Smtp-Source: ABdhPJx8wWiQ0K2QYQQmidm01y5mxNov4WGxwMF8mmvY75yb+Ij7UpxRZyE910mrL0yUozjo0pC09g==
X-Received: by 2002:aed:2227:: with SMTP id n36mr1751892qtc.118.1603937738355;
        Wed, 28 Oct 2020 19:15:38 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:37 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 05/19] entry: extract a header file for entry.c functions
Date:   Wed, 28 Oct 2020 23:14:42 -0300
Message-Id: <2caa2c4345d524e9e3bb0c388f8dc0b99236d166.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
new entry.h header.

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
 entry.h                  | 41 ++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c           |  1 +
 8 files changed, 47 insertions(+), 32 deletions(-)
 create mode 100644 entry.h

diff --git a/apply.c b/apply.c
index 76dba93c97..ddec80b4b0 100644
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
index 0951f8fee5..b18b9d6f3c 100644
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
index 7ac432b881..dfa22b67eb 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -23,6 +23,7 @@
 #include "lockfile.h"
 #include "object-store.h"
 #include "dir.h"
+#include "entry.h"
 
 static int trust_exit_code;
 
diff --git a/cache.h b/cache.h
index c0072d43b1..ccfeb9ba2b 100644
--- a/cache.h
+++ b/cache.h
@@ -1706,30 +1706,6 @@ const char *show_ident_date(const struct ident_split *id,
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
index 0000000000..2d69185448
--- /dev/null
+++ b/entry.h
@@ -0,0 +1,41 @@
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
+
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
+void enable_delayed_checkout(struct checkout *state);
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
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
2.28.0


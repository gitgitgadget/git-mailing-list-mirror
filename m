Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9657DC433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E65619C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhCWOVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhCWOUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:34 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B4AC061764
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:33 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i9so14435559qka.2
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkfRpfTpn+NS3vzQdXi7TfSATsSh7Zg5oSwIvKlVtfQ=;
        b=ZgpxvlWudioaPNaqRjhdCigZ9Ltsoz2o2ra1JGK1vIYDstWqvPKaQ0Es961//chc6r
         mU595ZIo9egAV9dN9JP/P9xc/bktj3SLRjtfoH69V1212UAzFI/cA/QuWvSFZpRPo9wz
         ObTHUuPtkOY/XEciumYCdbB6tJ6HvQ1z91dTzqOfYXjsY11KYhPJCirOcEqjrcsOYAub
         AN7IEiZXR5t4Wfc0MGznDx+rK3xn89Er337lvzXdKBl983eo6v33EXTrvcGqmVZw6Ajo
         PVFO4703adLB3V3QMZiFVcRRZhAX/ZWoyoCeWjtjzpsZ8a3wVlV0EGLfxtOggecJ5Pvj
         FxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkfRpfTpn+NS3vzQdXi7TfSATsSh7Zg5oSwIvKlVtfQ=;
        b=ujRqnpBwfIszDxS9ve80JCDMPp1Fs3h0gMPxEKHOAG+UqE019FPy6/jkFgd2TGS+Bs
         zm2B0Jd+FHV6b3cyK1Tpp/UCddD1DGjbCQdHZ/e5BSQMSqKdJJYlkK9Armzm4enI7Ycx
         TDaw1b1Ev7U1+NCgj+hVVW0h8hH63c8j3o2plVGD5IPBpG4gGxg02LSjSB+FR7VJB8vY
         wDXefW9Isp/WwQgkrmYfFT4oSM3n0fUSAk1d31fW+UNEFgD5wS0jmI/2z4hDBpjlpQfq
         Y+lnl2kpMDmDArixQ8DkxsNv3wjTIMu1eQnrGHiRHDAWiV4JWChotdyKsVqkunu336Mf
         4ZbA==
X-Gm-Message-State: AOAM531D967danQzREp0tcl0qeDvamDijU1JofvLOcH1ghlNQiQKiAEy
        Wk2EQTybSaZLXscvzfJRFfbw6KM/wztKdQ==
X-Google-Smtp-Source: ABdhPJwcowOKPUmgevrq3YFlxRzowrtKMogNvl46JAHs9UZdQsZPQ5TrpM/9ZyfRYPHTFIdTw/5T7g==
X-Received: by 2002:a05:620a:2216:: with SMTP id m22mr5819572qkh.73.1616509232962;
        Tue, 23 Mar 2021 07:20:32 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:32 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v6 5/9] entry: extract a header file for entry.c functions
Date:   Tue, 23 Mar 2021 11:19:32 -0300
Message-Id: <4d85af1579738a3f2f5f3815007c3f8bfd1a31f8.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
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
 builtin/stash.c          |  1 +
 cache.h                  | 24 -----------------------
 entry.c                  |  9 +--------
 entry.h                  | 42 ++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c           |  1 +
 9 files changed, 49 insertions(+), 32 deletions(-)
 create mode 100644 entry.h

diff --git a/apply.c b/apply.c
index 6695a931e9..466f880d73 100644
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
index 023e49e271..c0bf4ac1b2 100644
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
index 2d6550bc3c..06c90d76e8 100644
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
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 3477e940e3..0cdcc75618 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "diffcore.h"
 #include "exec-cmd.h"
+#include "entry.h"
 
 #define INCLUDE_ALL_FILES 2
 
diff --git a/cache.h b/cache.h
index 6fda8091f1..5d45d145fa 100644
--- a/cache.h
+++ b/cache.h
@@ -1621,30 +1621,6 @@ const char *show_ident_date(const struct ident_split *id,
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
index 7b9f43716f..c3e511bfb3 100644
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
index 9af8e796b3..f6cc6a8117 100644
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
2.30.1


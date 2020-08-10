Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB97DC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD27820734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="GY9lwhtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgHJVet (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49924C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s16so7980661qtn.7
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fkne9ypIVXomr3Ar74ayXp8Yz9Wd1nC55Ua9FdsUSSM=;
        b=GY9lwhtBI6kzIq/PcHJIMuKL9LdIS1s6iLpoY/gD/QcIK+BZQ8TJq/IFXAU0b800oT
         cOV5im8lGYupCYN+sr8Jbhe2TW6qz9nQmacw1rOR5W8WaYuO726vL4pmLks0iXAHTRow
         GRteREvJ9SqJaKZ6FAiA5IkPLdGp6Hs6ifBOE2ZHfzj53oA73eZ9NXLsPDqnvlYYrxk9
         IRKL+Ouo4Zk0ENK2SXvQc5kcNcUgI1ib0arMnsqskiektvrzZ+a9Fk6+vYIJ4pNXyxMC
         1dRH2cvHgjYidVJTaG2teorwIVU/9od7oPY2HfR1UvjEe9rSdWp6cjvxUTLS0U3OkVA2
         wZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fkne9ypIVXomr3Ar74ayXp8Yz9Wd1nC55Ua9FdsUSSM=;
        b=HhQd/KVD2KmfIU5Y3wDmAMnd5abYNKGRD/kcGwVBTcOeyBQMeFskapvdxhjAIr5rtz
         KuPmS2njmuOPnN8ZbtP3iKHV+G0g9OPgDdsleBtcDPczv7gzFIBrnfI3VqcfnsY5drsI
         vRYt10jfkd45IUYR66UqJVWP3oxOKZVwuAKQVpzKAgJXoMH//nXmLjqB/SPAKDPfEEfe
         njfPovEvcj0c3rHszWYeLS5puXWUOGklZX/xbrxSKOFyORPksqfj1hj8hvmeQ2yfEP4d
         fyTawAK/AvgTBwAy0gfOQMDSsr1dfgp57og/hsn1wpQ9jd90r98UvqutCvx3b2ZW5tnA
         x4FQ==
X-Gm-Message-State: AOAM533FMtVKs6Z4nt/Bg3qd2SYwe0qlEIlWbRx+tW8fJiJetcBZemtp
        KTBbE0jPJ5UuUxoJDo5K/vWg1DhuvME=
X-Google-Smtp-Source: ABdhPJz4yU4yeHoiMC0NOkXdCcZL+eOk8GNFkLLOckAdQ36rnbslg9wuaKOCNj7Sghsn65HASSva3g==
X-Received: by 2002:ac8:73d1:: with SMTP id v17mr29626691qtp.51.1597095287047;
        Mon, 10 Aug 2020 14:34:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:46 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 05/21] entry: extract a header file for entry.c functions
Date:   Mon, 10 Aug 2020 18:33:13 -0300
Message-Id: <a8f05a2471389fd4b4103223678f259c261a335f.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index 8bff604dbe..1443c307a4 100644
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
index a854fd16e7..0f1ff73129 100644
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
index 2837195491..3e09b29cfe 100644
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
index 0290849c19..e6963cf8fe 100644
--- a/cache.h
+++ b/cache.h
@@ -1695,30 +1695,6 @@ const char *show_ident_date(const struct ident_split *id,
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
index 449bd32dee..f46c06e831 100644
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
2.27.0


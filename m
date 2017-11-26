Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170A120A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdKZTma (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:42:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41487 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbdKZTm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:42:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so30294599wmd.0
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IsTXajOauhG9uPRvY29Q+PAnp3SvEU0Q+MA1lC3QWIk=;
        b=J52Vrllx+CLHgsuPLsajC+Bcnx9yyZssz5dz9a8ACAaFhMNBytZG88SKud6X0sG5uD
         uQuM2QpernBPWyFwbwjojMcMdhp1ou2EkAqdDKOpiD5kFf6wderKwV802yCKFlnXDRh3
         hixdAGhu6p4ge56ufyF2eU7Q/oE5GbPkFLlEMFBdJGVZiScVWvVI4FqAlsIpx0/aySG7
         j3j+8pNHrKB9UPF8sP5AWWvj7Kaa3JhNkGaK/0vUioLESm6VWh2PPfHkDDK4yOaDUXyV
         5WoB/XRFYxwEJKcD1MGjIHoLgSsRbMMeZ8yrfiCjmf6JjBTZ6Y4l9LY8jaF8p1bFupah
         tPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IsTXajOauhG9uPRvY29Q+PAnp3SvEU0Q+MA1lC3QWIk=;
        b=O+mJPceVXX3X8ht4/KrTpEiicV9kAFsrnL8bZMLEstFwDRiZa5vP8woG9OXQkRjSQ4
         6FluS/TCbegZjizluPBGxVHA0AIrYau0ym2J32Bp+W9TEQ04vM/iR65r3eq7aLJsqRGc
         fsiywv8aDPrEAx10QbfggDvHSRSuglzKokLJAA5rG+1cQYsiEsooJ0TGgueFH11aD/02
         7hXmdkAeEBj/qY5lwMaZsbILxVz3ofZeNWGo+Lexg3mzEbUZMASx/eP6Y8HZ4g1ITEk2
         8TY7e56rEjzfdE3rj//13ku5I3SaskSLVFwRw02OwIf5DrQ2yXf9Uk9PZ1tf4ldGjm0g
         Q83Q==
X-Gm-Message-State: AJaThX4X7WOLVCN/kHqccquZu7nOBqnIlnHpo2PuTCVnG3O2vN1Ojxb3
        pdWHKIhywRSTV7F+xioiMQHwjUh/
X-Google-Smtp-Source: AGs4zMaXXXsAh+e4pmTGdAXBNeyJb9ySIM/KW/nJAjPKAnNgLX/vrw3C0MLD7QzFpKC/sD9hQa+tLA==
X-Received: by 10.28.103.8 with SMTP id b8mr16693200wmc.70.1511725347047;
        Sun, 26 Nov 2017 11:42:27 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o135sm9709750wmg.1.2017.11.26.11.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 11:42:26 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 1/6] checkout: factor out functions to new lib file
Date:   Sun, 26 Nov 2017 19:43:51 +0000
Message-Id: <20171126194356.16187-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171126194356.16187-1-t.gummerer@gmail.com>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171126194356.16187-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor the functions out, so they can be re-used from other places.  In
particular these functions will be re-used in builtin/worktree.c to make
git worktree add dwim more.

While there add some docs to the function.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Makefile           |  1 +
 builtin/checkout.c | 41 +----------------------------------------
 checkout.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 checkout.h         | 13 +++++++++++++
 4 files changed, 58 insertions(+), 40 deletions(-)
 create mode 100644 checkout.c
 create mode 100644 checkout.h

diff --git a/Makefile b/Makefile
index e53750ca01..a80a8fcca9 100644
--- a/Makefile
+++ b/Makefile
@@ -759,6 +759,7 @@ LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += checkout.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7d8bcc3833..ad8f94044c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "checkout.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "refs.h"
@@ -872,46 +873,6 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	return git_xmerge_config(var, value, NULL);
 }
 
-struct tracking_name_data {
-	/* const */ char *src_ref;
-	char *dst_ref;
-	struct object_id *dst_oid;
-	int unique;
-};
-
-static int check_tracking_name(struct remote *remote, void *cb_data)
-{
-	struct tracking_name_data *cb = cb_data;
-	struct refspec query;
-	memset(&query, 0, sizeof(struct refspec));
-	query.src = cb->src_ref;
-	if (remote_find_tracking(remote, &query) ||
-	    get_oid(query.dst, cb->dst_oid)) {
-		free(query.dst);
-		return 0;
-	}
-	if (cb->dst_ref) {
-		free(query.dst);
-		cb->unique = 0;
-		return 0;
-	}
-	cb->dst_ref = query.dst;
-	return 0;
-}
-
-static const char *unique_tracking_name(const char *name, struct object_id *oid)
-{
-	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
-	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
-	cb_data.dst_oid = oid;
-	for_each_remote(check_tracking_name, &cb_data);
-	free(cb_data.src_ref);
-	if (cb_data.unique)
-		return cb_data.dst_ref;
-	free(cb_data.dst_ref);
-	return NULL;
-}
-
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
diff --git a/checkout.c b/checkout.c
new file mode 100644
index 0000000000..ac42630f74
--- /dev/null
+++ b/checkout.c
@@ -0,0 +1,43 @@
+#include "cache.h"
+#include "remote.h"
+#include "checkout.h"
+
+struct tracking_name_data {
+	/* const */ char *src_ref;
+	char *dst_ref;
+	struct object_id *dst_oid;
+	int unique;
+};
+
+static int check_tracking_name(struct remote *remote, void *cb_data)
+{
+	struct tracking_name_data *cb = cb_data;
+	struct refspec query;
+	memset(&query, 0, sizeof(struct refspec));
+	query.src = cb->src_ref;
+	if (remote_find_tracking(remote, &query) ||
+	    get_oid(query.dst, cb->dst_oid)) {
+		free(query.dst);
+		return 0;
+	}
+	if (cb->dst_ref) {
+		free(query.dst);
+		cb->unique = 0;
+		return 0;
+	}
+	cb->dst_ref = query.dst;
+	return 0;
+}
+
+const char *unique_tracking_name(const char *name, struct object_id *oid)
+{
+	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
+	cb_data.dst_oid = oid;
+	for_each_remote(check_tracking_name, &cb_data);
+	free(cb_data.src_ref);
+	if (cb_data.unique)
+		return cb_data.dst_ref;
+	free(cb_data.dst_ref);
+	return NULL;
+}
diff --git a/checkout.h b/checkout.h
new file mode 100644
index 0000000000..9980711179
--- /dev/null
+++ b/checkout.h
@@ -0,0 +1,13 @@
+#ifndef CHECKOUT_H
+#define CHECKOUT_H
+
+#include "cache.h"
+
+/*
+ * Check if the branch name uniquely matches a branch name on a remote
+ * tracking branch.  Return the name of the remote if such a branch
+ * exists, NULL otherwise.
+ */
+extern const char *unique_tracking_name(const char *name, struct object_id *oid);
+
+#endif /* CHECKOUT_H */
-- 
2.15.0.426.gb06021eeb


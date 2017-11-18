Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20E12036D
	for <e@80x24.org>; Sat, 18 Nov 2017 22:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424476AbdKRWpt (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 17:45:49 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36029 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423811AbdKRWpo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 17:45:44 -0500
Received: by mail-wr0-f195.google.com with SMTP id y42so4984185wrd.3
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 14:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/cOUK50YuIF6DS2VcPh6DjiL61kJSHHDdCU1hROsOT4=;
        b=X54t/kixn3I6ZZoFgowqhe++Ae5kVlmrS4NzWuIcehrJKxlCzvJMlV83zVURuZkPsu
         pl4tl2BQtY++lmzP7DPcL8wKuTBp0ur0pgCFq0yhJDxgHVono31j+ovK7RmzKdBl+7vm
         bcLqz2j60J0qQ4TyrVIBuRFRIJtx8ghzuf5lrcOvbTw7cs/v9JosvNmqx0fDWaDby007
         BZdlpb1TANwq7NvdCmFT9G5UKBQNjTuK7OYXnz3b+frOHJ/NB5kK2hSDVOP7YSetYzpV
         R9yccUW6zzK8WihZe+OLYMWkNpIhYeLmi0CIT+Mh5CEfuizeFsbyrZ0DGa9WH5zGMYBc
         GStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/cOUK50YuIF6DS2VcPh6DjiL61kJSHHDdCU1hROsOT4=;
        b=UKfwLtVHJPz/RQUhutunnReVaBgmQsDATHCkMD57mS07/ZPZueKumKSx5lyObhWWQ5
         P9cK4EFmF4TiCbnvTDcBw6p0JZ6p+RCC/RrlFexabaNSNMpD9CmHyowiU44845FNuI0Z
         xKn3lMaDv+3uHu/474Py6QYXYu484PS91F+88UkpDCDxZ8+YS1CxUg3ZrsQibYnYambY
         Sd/ximOVttSzGCwgbHRxRx0K+e907ewM2KUdzPpL9nbWvi6obeWmiwj5zUBLmRIRkhfu
         QfA+k0uniPHDdWeOWGT/6ZnwC/d/h4JxgMHwaBEagEPvI4dJjjD7atSI+YuFxLgQmaSr
         Hhmg==
X-Gm-Message-State: AJaThX4aSaz3c4Wslsd5+/02Gx6ujE7PG93S2x8/EXY75ft5lhJnRo/A
        vggxxddt9Bu6udnGYocJG1UfqOZm
X-Google-Smtp-Source: AGs4zMa9i5dzLgtIQfGcQh+NhBGHYklI9jq4GJv9LSIpRiV/J7yPvx+XIerEiD/glTiO+bg6W79/AA==
X-Received: by 10.223.139.3 with SMTP id n3mr1686304wra.166.1511045142535;
        Sat, 18 Nov 2017 14:45:42 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id e131sm3435265wmg.1.2017.11.18.14.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 14:45:41 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/3] checkout: factor out functions to new lib file
Date:   Sat, 18 Nov 2017 22:47:04 +0000
Message-Id: <20171118224706.13810-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171118224706.13810-1-t.gummerer@gmail.com>
References: <20171118181103.28354-1-t.gummerer@gmail.com>
 <20171118224706.13810-1-t.gummerer@gmail.com>
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
 checkout.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 checkout.h         | 13 +++++++++++++
 4 files changed, 57 insertions(+), 40 deletions(-)
 create mode 100644 checkout.c
 create mode 100644 checkout.h

diff --git a/Makefile b/Makefile
index cd75985991..8d603c7443 100644
--- a/Makefile
+++ b/Makefile
@@ -757,6 +757,7 @@ LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += checkout.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc4f8fd2ea..9e1cfd10b3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "checkout.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "refs.h"
@@ -874,46 +875,6 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
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
index 0000000000..b0c744d37a
--- /dev/null
+++ b/checkout.c
@@ -0,0 +1,42 @@
+#include "cache.h"
+#include "remote.h"
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
2.15.0.345.gf926f18f3


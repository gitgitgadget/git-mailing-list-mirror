Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68295201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 13:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdKLNmS (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 08:42:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33461 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdKLNmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 08:42:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so11034180wmr.0
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f0W8BEWknglvzmrpPn42jdxOQKWiDLP7t9uYqipaFPY=;
        b=tZD0kicrVg9G1aeErujUrQ3ED8VyR5T4qJaqJsYwS3vqjh1OxJCh8gPdH/urzNSN9T
         decUyulVeeWw17oSkLqck+6BtDR+9OxLooUhrD6NBGXptaNnu1cYZj9YWs6Sfl8nFGGN
         pHoGM3fyHocKFQ/htZGKAG4GcWjdxPvXrcJoXAgdPkLUeMwQSxQSBY8SkBxNq6Yw+8wS
         jxtQ3e2hcLK9/IbmXZca0d8RUy8HqWDsVuXD2LuOkC8pcz5OOR4kFcfzAvr45LOo4IXV
         rYdjFN2ZRY/Y9O7W9rlZ+mzVe5vv4m/fpztIz+jUxOsoQ02+M7eq+kWB2E2raNQwACPw
         axfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f0W8BEWknglvzmrpPn42jdxOQKWiDLP7t9uYqipaFPY=;
        b=nZAq0jdqRf9Mvl0tjwJWRkULTiqTLUqG6MimPY0MePUA5cPfRGi3bGNtZRbNH68dFp
         bPQPHDQMWQvMz2Rzs3lFqWaI8UdPo7Dqn+sExPoES6nbDNzfCZ3DPz4LwWMYjYUvQyz6
         pBM4jZapNSXAx1BG47Gm80bEOJ7OwNveMFahoBlk4SWKkdHFWP7/XExaaXRUyouiEpXn
         qZqgiOlIAgFPi3Cg+cB/SaZOeX9ZHOfl/vLRdzM7oOYxMFpavlqwDrjybF9/Wx6FFUZG
         DQmTgHsnJsb2Ldmb1oo1RRZokz2lpVvZFZerXMGNCdplPxTFvwxQ4EMy+IYsKDnU7zvu
         vmYw==
X-Gm-Message-State: AJaThX4ViRwRgR5Uzo21HXzknAWY/CGLfx283DmDLTs5hb2wa11aa6KX
        hzOZYE4TgxceG7xeBW00vRDhHCHh
X-Google-Smtp-Source: AGs4zMY4Ax4BXmdPP6+Unk3fIP7R9updvosEzJLaMs0uYcM6KxuafniYKQ3Br/K5PCI8+3+Pe0N9Cg==
X-Received: by 10.28.155.18 with SMTP id d18mr4378831wme.107.1510494135326;
        Sun, 12 Nov 2017 05:42:15 -0800 (PST)
Received: from localhost ([62.189.9.199])
        by smtp.gmail.com with ESMTPSA id l16sm13354489wma.19.2017.11.12.05.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 05:42:14 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v1 1/2] checkout: factor out functions to new lib file
Date:   Sun, 12 Nov 2017 13:43:04 +0000
Message-Id: <20171112134305.3949-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor the functions out, so they can be re-used from other places.  In
particular these functions will be re-used in builtin/worktree.c to make
git worktree add dwim more.

While there add a description to the function.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I'm not sure where these functions should go ideally, they don't seem
to fit in any existing library file, so I created a new one for now.
Any suggestions for a better home are welcome!

 Makefile           |  1 +
 builtin/checkout.c | 41 +----------------------------------------
 checkout.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 checkout.h         | 14 ++++++++++++++
 4 files changed, 59 insertions(+), 40 deletions(-)
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
index 0000000000..a9cf378453
--- /dev/null
+++ b/checkout.c
@@ -0,0 +1,43 @@
+#include "cache.h"
+
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
index 0000000000..9272fe1449
--- /dev/null
+++ b/checkout.h
@@ -0,0 +1,14 @@
+#ifndef CHECKOUT_H
+#define CHECKOUT_H
+
+#include "git-compat-util.h"
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
2.15.0.403.gc27cc4dac6


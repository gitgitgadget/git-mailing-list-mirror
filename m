Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01F2201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030841AbdKRSJt (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:09:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37372 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030836AbdKRSJr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:09:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id v186so11764635wma.2
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 10:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dKJDMQCgrzJ80dE7ewxGDhSTAU8SYd3A11eLknP0DNY=;
        b=iQwX5e41rOxzmz5jWIacoA6qTZpswkBD4GHisNKeiC6AwWMZD3dpV4ZP/BwPabizv1
         /uEPBbAGSPBjdVsfjsudB8RQILqJAHmYuzet3VGmFczVBRAwEfbz0miyAmW5puhF2fdT
         aD1JfLZ/nIU70YeVqvbgul6iluE5N8n2iZk7OCKvuHgDQWDmQSLKFfFZDsN0ZE9ocRge
         0LnnXkYMSxufMxeLmttabl6IW4eNiCIPSlaH1Fzd+b2DTkWudVj/z84xiGTWFDRZ2QUU
         +wejF695KnwGOquXsqx73YxhAzZcI8qPlqoWG4cmiwOmCcjCe7eVvJwig81DelUffY2j
         p8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dKJDMQCgrzJ80dE7ewxGDhSTAU8SYd3A11eLknP0DNY=;
        b=QFDqhCum9pM1HYjTf6Empdh7eFC8d3yxTovvtWP6RwUhMVIZbIIrEv5qnZYypg+8ur
         TdyADA5hJ+iypRA6h2Iyjiar/YX3svlpy2ka8wQOILCM6yAyT9xEVwzIt8DoChV2W5xU
         g/OTjaiHT6kQ9AXJeskZ9vW8QzKNCSml+UoIIJV7lkWtdRBStlYqDPDpZ/ghRy2qSgIY
         gpIkiatFAyl+9vUKE9IwSMboHFKT3/S3P2NBtY9RWbN3cvAV+Zah2YSPY1DJtN9PQICz
         waoG4jjlqfOY/d7qzHksoSpDTxnDB6Goj4yObs0GTnF1g2/MA1gfQKe4b01WR9/Bt1iM
         5VYg==
X-Gm-Message-State: AJaThX5hC0AVEqKpjpULFFbQsJqPdlbLxTkXxj/PznoVE8dOVzCgQWYe
        QEQud4W227qniNnyVVApe0AKPgF1
X-Google-Smtp-Source: AGs4zMZMUJnk5PaVDK5ngszxYMBPyVypLdrg2qDuFSJnDUXts53Qo14Z3V2dJqwz/+Xv3CvuANxctg==
X-Received: by 10.28.22.16 with SMTP id 16mr6173793wmw.138.1511028586173;
        Sat, 18 Nov 2017 10:09:46 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 143sm13294209wmj.35.2017.11.18.10.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 10:09:44 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/3] checkout: factor out functions to new lib file
Date:   Sat, 18 Nov 2017 18:11:01 +0000
Message-Id: <20171118181103.28354-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171112134305.3949-1-t.gummerer@gmail.com>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
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
The previous round of this series is at
https://public-inbox.org/git/20171112134305.3949-1-t.gummerer@gmail.com/.
Thanks Junio and Eric for the comments on the previous round!

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
2.15.0.345.gf926f18f3d


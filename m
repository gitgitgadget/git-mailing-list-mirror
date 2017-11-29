Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499E820A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdK2UDX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:03:23 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41065 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdK2UDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:03:21 -0500
Received: by mail-wr0-f194.google.com with SMTP id z18so4535319wrb.8
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IsTXajOauhG9uPRvY29Q+PAnp3SvEU0Q+MA1lC3QWIk=;
        b=kY8zoJ7zLrLJRDqRefPUTmS6zb39FSuOQJ3wqGi4bdgOLDNbovEFAFMhOmAqKoQ5/S
         ajrIkS1wfYOuVfhD9CCka4E1GI7LFFardnkHPreAW1jLcTNiy9iT44HILnvZbdLaUl9E
         AQKD6mVGogOPMmXwMjGs3x1+Cdu0RCThhPF6/JSP8HpMLJQd0dlFL7IJn43ipbeV2uBW
         moGH3QQhZ3IKXoozuIZgBZ9F3tBcH/I+i5fjRiAFwi0dnIgH4MDJzgK5gvWnX8U57FE3
         4QgkU/36wP03ZIPvwznl4DIMhumr807zKOqbehyLIdGvWZZFMRjNupqklG/yLrK7HGQb
         tLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IsTXajOauhG9uPRvY29Q+PAnp3SvEU0Q+MA1lC3QWIk=;
        b=LcB9rXmppztsahj9Is5clbpus4r0rF9MIW0w563m8yLnSz/drlPSBH1DEeR07H/FGx
         hoem1Swm3oPMcC4gXNEkPLR76ecz3Mc0iZLlH6wbkW3Ahe15WbxHsXhfk2JyL+28r4Gj
         PoGtLb+nkawuDiAcgU2xUE3Ccvg5EWajYtrXC1GeCY+GhgoTuqbLCSXQm6x7dDELobUb
         D55RsWuUsKzpzPM50P0lOljzoDs4rHWPAt5msGgldWNoaliEfTTiDKTx0VULUaCrEV/T
         wSnoVvoa32o1bOFCstYr1ghRPQRxvqGd3LGJKweMixFcCN2NsnTljYx9iUHIUeA+8+3v
         J8dQ==
X-Gm-Message-State: AJaThX5do763Ap6F/PlxcayF6ZUud28vR/oLzcZixJ3UzY8HgLGm4ZCb
        tM4PLeTQO9qsE7hfCD/dOghO3rGi
X-Google-Smtp-Source: AGs4zMY3/dX5sIAcRI1YWbUcrwTUYvdsRu9yQQRMJg0PlrcelH2010bLn93PtoKrF3g+CyWUDDWWIg==
X-Received: by 10.223.133.250 with SMTP id 55mr30459wru.23.1511985800513;
        Wed, 29 Nov 2017 12:03:20 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id g7sm6686338wra.38.2017.11.29.12.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:03:19 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 1/6] checkout: factor out functions to new lib file
Date:   Wed, 29 Nov 2017 20:04:46 +0000
Message-Id: <20171129200451.16856-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171129200451.16856-1-t.gummerer@gmail.com>
References: <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171129200451.16856-1-t.gummerer@gmail.com>
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


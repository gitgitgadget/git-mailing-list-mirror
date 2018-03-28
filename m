Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5371F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeC1R4m (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40744 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbeC1R4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:40 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so4722679lfb.7
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHyuoa9BAVd1OZfa8PtTFliTOdKNzi6SS1Iz9yjZGz8=;
        b=Dti5uY9A7Oq+pOTfTiUQuSnaZcDlA4Ch++kqmc5iP666nKVX3wUe9+e1AI/LW0aoT5
         GJI22MddnYnFNI6lWnLgrAWe2ab7TMyO67WMJ6J6Fcqyntb4vMpIgUkPNpQwqDkfPf++
         XdY8GgnCG8D/FWDdRYteGiZRTxLxnAr84rWnC69Xo/rKBoINtmExBAFdcFraZtQjJLdk
         Dr98Kvx+4nXF2Mj7rf8XRl6Ht8dYIgiTKQGHYrDZjfXPY8mxDynt1Rv79vEY7W/r83oc
         rFxJVeu5kkm3Y13jAANne+Tc6tn1u1aryRu/Vvsf1epA8KIpuek6HoVkkKm+A0FsWfdC
         NLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHyuoa9BAVd1OZfa8PtTFliTOdKNzi6SS1Iz9yjZGz8=;
        b=eXzgbsvUB92NQ3StT6BRGvDX40dJ7Yui3ZMwShOgreopDL8QW+bJkhOWsi8Wlp7sON
         JiJSrL+KIg+t2LCO0/SxqNgp0UhY3lAYSLOkd91B/weU/G3Dh1gZ8zatLTWnQEiUGGQx
         zajt9ZnVj1GTS9cO7wH/RJCvpLVK5h2IzrHE/BpBfsketOWC1Bvw3d3ncHZs4spSbqK8
         VecRiQkhE2o8+jNJesOZoxvtjmwpre94KMqqJ8kqVc1mod+rPMLMKDF7ie88XxdsCQov
         TE3wWoKj2ycQJTsuJypvAGkmySx8cImZqyif2P3cTPv+8Q+zWmkZduVDBFhOCpG4ZBlR
         qVAQ==
X-Gm-Message-State: AElRT7GueTrO4UPVE6fNcgxfwUw2VFCSRgQ4FOPA4ylClGjZDBCpTvS6
        NIeAvkBHgbaxYx4ivC40CiniIA==
X-Google-Smtp-Source: AIpwx48vRa8odbS3dgQ0nkOo4WfVwFMGTDU6Q+spS+9XJX4QzVmq4PpqAXXguhmv8vZJjFYS8j+uYQ==
X-Received: by 2002:a19:f101:: with SMTP id p1-v6mr2727210lfh.118.1522259798574;
        Wed, 28 Mar 2018 10:56:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 8/8] refs: adjust main repo paths when $CWD moves
Date:   Wed, 28 Mar 2018 19:55:37 +0200
Message-Id: <20180328175537.17450-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c                | 10 ++++++++++
 refs/files-backend.c  | 15 +++++++++++++++
 refs/packed-backend.c | 12 ++++++++++++
 refs/refs-internal.h  |  4 ++++
 setup.c               |  1 +
 5 files changed, 42 insertions(+)

diff --git a/refs.c b/refs.c
index 8b7a77fe5e..2457a31d4d 100644
--- a/refs.c
+++ b/refs.c
@@ -1651,12 +1651,22 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	return refs;
 }
 
+static void ref_store_adjust_paths(const char *old_cwd,
+				   const char *new_cwd,
+				   void *cb)
+{
+	struct ref_store *refs = cb;
+
+	refs->be->adjust_paths(refs, old_cwd, new_cwd);
+}
+
 struct ref_store *get_main_ref_store(void)
 {
 	if (main_ref_store)
 		return main_ref_store;
 
 	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
+	add_cwd_update_callback(ref_store_adjust_paths, main_ref_store);
 	return main_ref_store;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bec8e30e9e..d35a8db844 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3092,6 +3092,20 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	return -1;
 }
 
+static void files_adjust_paths(struct ref_store *ref_store,
+			       const char *old_cwd,
+			       const char *new_cwd)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "files_adjust_paths");
+
+	setup_adjust_path("ref store's gitdir",
+			  &refs->gitdir, old_cwd, new_cwd);
+	setup_adjust_path("ref store's commondir",
+			  &refs->gitcommondir, old_cwd, new_cwd);
+}
+
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
 	struct files_ref_store *refs =
@@ -3117,6 +3131,7 @@ struct ref_storage_be refs_be_files = {
 	"files",
 	files_ref_store_create,
 	files_init_db,
+	files_adjust_paths,
 	files_transaction_prepare,
 	files_transaction_finish,
 	files_transaction_abort,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 65288c6472..764d1250a5 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1047,6 +1047,17 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 	return is_lock_file_locked(&refs->lock);
 }
 
+static void packed_adjust_paths(struct ref_store *ref_store,
+				const char *old_cwd,
+				const char *new_cwd)
+{
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_WRITE,
+				"packed_adjust_paths");
+
+	setup_adjust_path("packed-refs", &refs->path, old_cwd, new_cwd);
+}
+
 /*
  * The packed-refs header line that we write out. Perhaps other traits
  * will be added later.
@@ -1632,6 +1643,7 @@ struct ref_storage_be refs_be_packed = {
 	"packed",
 	packed_ref_store_create,
 	packed_init_db,
+	packed_adjust_paths,
 	packed_transaction_prepare,
 	packed_transaction_finish,
 	packed_transaction_abort,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd834314bd..73480543c0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -505,6 +505,9 @@ struct ref_store;
  */
 typedef struct ref_store *ref_store_init_fn(const char *gitdir,
 					    unsigned int flags);
+typedef void ref_store_adjust_paths_fn(struct ref_store *refs,
+				       const char *old_cwd,
+				       const char *new_cwd);
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
@@ -625,6 +628,7 @@ struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
 	ref_init_db_fn *init_db;
+	ref_store_adjust_paths_fn *adjust_paths;
 
 	ref_transaction_prepare_fn *transaction_prepare;
 	ref_transaction_finish_fn *transaction_finish;
diff --git a/setup.c b/setup.c
index e364aea7e5..35e89a03e5 100644
--- a/setup.c
+++ b/setup.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "dir.h"
 #include "string-list.h"
+#include "refs.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
-- 
2.17.0.rc1.439.gca064e2955


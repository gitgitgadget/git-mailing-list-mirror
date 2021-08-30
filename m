Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D2C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54EC60249
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbhH3Otv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbhH3Otq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:49:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCFFC06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so171107wms.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lLGa/TaIfjwyW/OzxTP81M4S8j+dHKIfBkmyNbPjv3c=;
        b=GCoiprV6o+LgnaRl/5CWvW7qQS+ZxuQWt8WCNFjFI4sFYV4pTx3ckfy3b2SdfFpMzz
         GMHcuBLWE3deq4xhh3Itrb26hbFjeXSefoqF1YGLmYaFyA6LevxvFvef2c19lPN4t6by
         MuLXQjwSGYl95Gxydd/31/JzaLrJOPdHnktpWoj9Np5YlFHceJpbJNwWPlgri1gqyt+g
         0BdDH61Cvh0x7R6YxTMfYi1BwbKuedR39meeUvYq1jMFpC5Ov21Jo4W7XidlsS3b+a7P
         nFaTwdcdxeDSK5wYAjHRXs2VSd3o+PuuizQvgx64hi27z82LUifO6qHRMJeI3dbCWVsV
         ahhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lLGa/TaIfjwyW/OzxTP81M4S8j+dHKIfBkmyNbPjv3c=;
        b=aVOaNxUerHVyciizbvpULz31do9khJ9HFLxlDgZhmx06YHY6TxZP9yyhf0twGAO9nB
         5umYIaUl5rt/ZLjkueM08Ts2o3WnScKSjbgB/jgEJ2BBZ4j64PVvkGqli65GYzHjUAoD
         sAcQlXX33hXPHrgqXiRdfl884EHvkRxkIlzCDHS09wppdUS4LpfmxOARMSUfnw3T4Oua
         g2tw3ZNxzWoaPgmzrDzfZIIOxR3vf+dTIWjmraYLbOnwMBrE1MtXnYoWxq92itZUq5ic
         YcQGQcgywkpNwwqKV5vNUWWXkqAurOiBQiArJFpQK98FetiYXzCEB2UT4vg2//jeZOVN
         ndvw==
X-Gm-Message-State: AOAM530X2vYGJqFw/v7L5tMPwJrKXIL/j5bxpGlQKKD/RCvKKuKXKY3q
        A7txkJBx7GpgceX1m0+8uKmtVuX9M4Q=
X-Google-Smtp-Source: ABdhPJxy4f6HNxaD7WdPJrSkEaJbHeqdPbHckVbxTvGsirRiL/O4O/k+PlPfviAef8dEssgevNadPQ==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr32798293wma.125.1630334931710;
        Mon, 30 Aug 2021 07:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm15753998wrm.74.2021.08.30.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:48:51 -0700 (PDT)
Message-Id: <048e2d17077f89049221e6e4a16b7e4143bc244c.1630334929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:48:47 +0000
Subject: [PATCH 3/4] refs: drop force_create argument of create_reflog API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

There is only one caller, builtin/checkout.c, and it hardcodes
force_create=1.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/checkout.c             | 2 +-
 refs.c                         | 9 ++++-----
 refs.h                         | 4 ++--
 refs/debug.c                   | 5 ++---
 refs/files-backend.c           | 5 ++---
 refs/packed-backend.c          | 3 +--
 refs/refs-internal.h           | 2 +-
 t/helper/test-ref-store.c      | 3 +--
 t/t1405-main-ref-store.sh      | 2 +-
 t/t1406-submodule-ref-store.sh | 2 +-
 10 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a7..3c6506e0595 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -876,7 +876,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				int ret;
 				struct strbuf err = STRBUF_INIT;
 
-				ret = safe_create_reflog(refname, 1, &err);
+				ret = safe_create_reflog(refname, &err);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
 						opts->new_orphan_branch, err.buf);
diff --git a/refs.c b/refs.c
index 8b9f7c3a80a..ca59a7cc652 100644
--- a/refs.c
+++ b/refs.c
@@ -2347,16 +2347,15 @@ int reflog_exists(const char *refname)
 }
 
 int refs_create_reflog(struct ref_store *refs, const char *refname,
-		       int force_create, struct strbuf *err)
+		       struct strbuf *err)
 {
-	return refs->be->create_reflog(refs, refname, force_create, err);
+	return refs->be->create_reflog(refs, refname, err);
 }
 
-int safe_create_reflog(const char *refname, int force_create,
-		       struct strbuf *err)
+int safe_create_reflog(const char *refname, struct strbuf *err)
 {
 	return refs_create_reflog(get_main_ref_store(the_repository), refname,
-				  force_create, err);
+				  err);
 }
 
 int refs_delete_reflog(struct ref_store *refs, const char *refname)
diff --git a/refs.h b/refs.h
index 48970dfc7e0..3c457bc19c8 100644
--- a/refs.h
+++ b/refs.h
@@ -416,8 +416,8 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags);
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
 int refs_create_reflog(struct ref_store *refs, const char *refname,
-		       int force_create, struct strbuf *err);
-int safe_create_reflog(const char *refname, int force_create, struct strbuf *err);
+		       struct strbuf *err);
+int safe_create_reflog(const char *refname, struct strbuf *err);
 
 /** Reads log for the value of ref during at_time. **/
 int read_ref_at(struct ref_store *refs,
diff --git a/refs/debug.c b/refs/debug.c
index 1a7a9e11cfa..f6b01b1eba0 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -340,11 +340,10 @@ static int debug_reflog_exists(struct ref_store *ref_store, const char *refname)
 }
 
 static int debug_create_reflog(struct ref_store *ref_store, const char *refname,
-			       int force_create, struct strbuf *err)
+			       struct strbuf *err)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->create_reflog(drefs->refs, refname,
-						 force_create, err);
+	int res = drefs->refs->be->create_reflog(drefs->refs, refname, err);
 	trace_printf_key(&trace_refs, "create_reflog: %s: %d\n", refname, res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd2..e05ada9286d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1598,15 +1598,14 @@ error:
 	return -1;
 }
 
-static int files_create_reflog(struct ref_store *ref_store,
-			       const char *refname, int force_create,
+static int files_create_reflog(struct ref_store *ref_store, const char *refname,
 			       struct strbuf *err)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
 	int fd;
 
-	if (log_ref_setup(refs, refname, force_create, &fd, err))
+	if (log_ref_setup(refs, refname, /*force_create=*/1, &fd, err))
 		return -1;
 
 	if (fd >= 0)
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d7998..af7038de42d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1618,8 +1618,7 @@ static int packed_reflog_exists(struct ref_store *ref_store,
 }
 
 static int packed_create_reflog(struct ref_store *ref_store,
-			       const char *refname, int force_create,
-			       struct strbuf *err)
+				const char *refname, struct strbuf *err)
 {
 	BUG("packed reference store does not support reflogs");
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3155708345f..cc0e56e8c82 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -590,7 +590,7 @@ typedef int for_each_reflog_ent_reverse_fn(struct ref_store *ref_store,
 					   void *cb_data);
 typedef int reflog_exists_fn(struct ref_store *ref_store, const char *refname);
 typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
-			     int force_create, struct strbuf *err);
+			     struct strbuf *err);
 typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
 typedef int reflog_expire_fn(struct ref_store *ref_store,
 			     const char *refname, const struct object_id *oid,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index d7bbb20e614..58d5438a290 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -181,11 +181,10 @@ static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
 static int cmd_create_reflog(struct ref_store *refs, const char **argv)
 {
 	const char *refname = notnull(*argv++, "refname");
-	int force_create = arg_flags(*argv++, "force-create");
 	struct strbuf err = STRBUF_INIT;
 	int ret;
 
-	ret = refs_create_reflog(refs, refname, force_create, &err);
+	ret = refs_create_reflog(refs, refname, &err);
 	if (err.len)
 		puts(err.buf);
 	return ret;
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 16a99382770..4ee95fceccd 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -109,7 +109,7 @@ test_expect_success 'delete_reflog(HEAD)' '
 '
 
 test_expect_success 'create-reflog(HEAD)' '
-	$RUN create-reflog HEAD 1 &&
+	$RUN create-reflog HEAD &&
 	git reflog exists HEAD
 '
 
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index b0365c1fee0..78d40bdcd8b 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -92,7 +92,7 @@ test_expect_success 'delete_reflog() not allowed' '
 '
 
 test_expect_success 'create-reflog() not allowed' '
-	test_must_fail $RUN create-reflog HEAD 1
+	test_must_fail $RUN create-reflog HEAD
 '
 
 test_done
-- 
gitgitgadget


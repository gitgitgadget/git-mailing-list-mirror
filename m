Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE02FC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D427A61051
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhIFQxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbhIFQxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 12:53:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B772C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 09:52:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so5460321wme.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kKKFpVfYPxKKzWYMV/lhWUYC/2Q29tOtbs82LkkaFFQ=;
        b=K+7Tp3YqN6M9tY3NA4i694QjEFQgk7kHbVZN3C6zqQEtOmm9VjYSlEnghzE22Q65lZ
         Y3vIxriCsPP07ZBGfaT1Z3MecPVeAPkv19dZ0nzEqj34i4NEIQPW5RKIEFe7KnlQbK6n
         0Ax/AVwDcj2l3jR5Bt4kHn3/lsNEG63KjsLq5+qnY3v3fwj0p7mfYSx7oE1w6+OCPOct
         ix7JKuqOA2YW9yfi/EBU/y12MlkcNwxrWkSaS7V6lFTHMX82NCRJrcAy+9apjstWhusJ
         vLhzZ4cQSN9L99rGaHz2qD9sVaquiqEI4Qdsy3hVxkFsHCEF6CqNJe3YOZ5q5OW/Y33x
         03EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kKKFpVfYPxKKzWYMV/lhWUYC/2Q29tOtbs82LkkaFFQ=;
        b=m5BtOe5YnxHslSDbuCp69XlX2DhfLI47KTSV/ss2PIlf4AXb7sA6Jx/HsN4FBJPUPi
         Vh3dPwpME9j8czDSU0B30Y0HRMHYRb8UZNmmSV3SXv29MfOwAHxw2DcLmjybf8XoKjEd
         9+2sew50XcEXzGVI/qb4g3u0ySZRSYNr4cU/Bp+MMoF5gRMZilbGHL0uiW68ijmdLlfh
         mTYiqB7oU0ObwmBYatoZYqFbMDiFmn4nkcJL+UNdXaULcDDh0/IbIS3ANZVBSyom0DbO
         sd44RG0lSloQPCRJBknLtRZgI2Gkx/dTvDK1k26igCNm6gQXuwoAVTwF3FVbeDFJJvzX
         ufDQ==
X-Gm-Message-State: AOAM5303Xks4gOZLQ1DIpddQhdXTKz6mXfEOuHxORWP8QsTcIu1RaT7g
        jwAgIGE3twkODk7dI8v1ljm9tONMDAY=
X-Google-Smtp-Source: ABdhPJxKvLCK20sCPJGkgEHWOGNpZN6hRYzHA6cV+BptTOb5FI6mae7dgP8a9B3Hh9FL6rpzzg5P2w==
X-Received: by 2002:a05:600c:3b0e:: with SMTP id m14mr69354wms.118.1630947146705;
        Mon, 06 Sep 2021 09:52:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a133sm53801wme.5.2021.09.06.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:52:26 -0700 (PDT)
Message-Id: <aa25fd9b7de02c3b5c620def8fae4d5b6ce456c5.1630947142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 16:52:21 +0000
Subject: [PATCH v2 4/5] refs: drop force_create argument of create_reflog API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 206c9f8b932..b710d43be16 100644
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
index 0fcad9b3812..a65fda66ddc 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -180,11 +180,10 @@ static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
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
index 76b15458409..3cb5e23d6db 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -108,7 +108,7 @@ test_expect_success 'delete_reflog(HEAD)' '
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7ECC07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A1961985
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGEU7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhGEU6u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 16:58:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA9C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 13:56:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i8so10604547wrp.12
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wJ8tP77YWHy9FvkzV2fhzNftEApwtOKkhypJepj/ttE=;
        b=nE2dWaPs9mK8fm22CyX8Ew9jRDVGadw7d+HPUmYk0SUG+MuwYx0wZmZlegdsijSsey
         QZgqlu5a5IzmmW6qkHq/5Sgr6eo2wie2RXt/2ofkht7knlWv9aqQP6muhpzegRLB5v3z
         nimFl3nXihos/CzkW62jyr/oqPiYHMz+Q0TtiAOFe/tRAnqjh7DuxnG9MvKbnH5Euw/g
         fLOLXAHNLdW7UAGK9RiH64d28JnqZHQU+ug534oC8Von2Ck2YGqZ3n6dS7yXO2S3xWwD
         eUKkUxtAoYTuUrMNa80AYJk8kyR3sIaxFhWYH77MgdRzvUCE7yBepVfH3M2zCKrs4GVD
         ZxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=wJ8tP77YWHy9FvkzV2fhzNftEApwtOKkhypJepj/ttE=;
        b=RGR7gr63FE4ErVTQk1WtLecaWQzMrcMpYuu/gmSBi4CpsOHuoAGXwD29AWyEzx8pcO
         TRXA5ZbeLCbPldwTsMyqMD3z4K8E3vmfLykpq7mklDG3RKrSIHhaPKADiBeLw/BRBS8+
         DwyKgk5vIRJYriXehbpa497vdqUFCWJHxO295uhgC5XOJVDEF2PT+1ydCTIyhQEDDk5S
         hUL8kOO+wt8q9xlZlFERGZild68Vm/eXTm7r2bTHTlHH0//XCn3mxNSlXAlLZ5Dci4x/
         HiMiJidKpo6+dTVVlNC0w6ajGf31NQsGOt9KTaKYR/+8Jo4X3ETRSw/eofRL6ocX2CEW
         NBag==
X-Gm-Message-State: AOAM532kCqIPMRQkjo02MzQ4SO3lPpNlqcMtGxMChwJQCUSyQzp1UCpk
        R4BlNzljIoWaq3XvpNHbcnVN3mzZzQ4=
X-Google-Smtp-Source: ABdhPJzbtHnXianiXwYhSK52J4nkGbx7TKk7G0lypman6wa6jy5RTI4+rOQ1CXRRajTCMOz/0DCWkQ==
X-Received: by 2002:a5d:6511:: with SMTP id x17mr17612629wru.212.1625518570385;
        Mon, 05 Jul 2021 13:56:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm1028138wmq.1.2021.07.05.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 13:56:10 -0700 (PDT)
Message-Id: <ed5347d7bb61257a164750835b754babb876e36a.1625518566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
        <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Jul 2021 20:56:05 +0000
Subject: [PATCH v3 5/5] refs: make errno output explicit for
 refs_resolve_ref_unsafe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
contract for the errno output explicit. The implementation still relies on
the global errno variable to ensure no side effects of this refactoring.

lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
that needs error information to make logic decisions, so update that caller

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 15 ++++++++-------
 refs/refs-internal.h |  8 ++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f38c9703504..8506c8b3bde 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -923,6 +923,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -935,10 +936,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_ref_path(refs, &ref_file, refname);
-	resolved = !!refs_resolve_ref_unsafe(&refs->base,
-					     refname, resolve_flags,
-					     &lock->old_oid, type);
-	if (!resolved && errno == EISDIR) {
+	resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
+							resolve_flags,
+							&lock->old_oid, type,
+							&resolve_errno);
+	if (!resolved && resolve_errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -958,15 +960,14 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		int last_errno = errno;
-		if (last_errno != ENOTDIR ||
+		if (resolve_errno != ENOTDIR ||
 		    /* in case of D/F conflict, try to generate a better error
 		     * message. If that fails, fall back to strerror(ENOTDIR).
 		     */
 		    !refs_verify_refname_available(&refs->base, refname, extras,
 						   skip, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
+				    refname, strerror(resolve_errno));
 
 		goto error_return;
 	}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 54f57c6a2df..c52a64b081b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -153,6 +153,14 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
+/* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
+ * failure. */
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno);
+
 /*
  * Write an error to `err` and return a nonzero value iff the same
  * refname appears multiple times in `refnames`. `refnames` must be
-- 
gitgitgadget

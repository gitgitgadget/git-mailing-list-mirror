Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13952C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E849661357
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhHWLxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbhHWLxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:53:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F8AC061764
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so25871050wrn.3
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZY23QlS7LS9bzKtlJLI+hejPzLCrRa8/I1X5G/vTR0=;
        b=E56p82gTam7vEQYu46EkS6m+5M2toFZh0Tt4x8WSoMln5WQUQu8HclI4c9MNZpnvWT
         HSUA312aSaWLqpUoCsIvVmdV7jPI3U4z4v0SJofEQItHGg2L/8SL/URr8xBpDYI7tvNS
         52f1OSRt2dOkKxjoRDg5lNjr8XNO4Os4s70Xt3wAwf1drlzEcrhJKLMHUNyNhYzxEuqF
         AVhTJibiQNv8JdZhtqdclnd9qps9repomaWMs6JV7fk7q3JKJAcw5JrJCsAURWXoUVQJ
         QS549gVaU0ECob69sBkbB764xOraH+wrDzfUZD2ixvfm1XRKMNuYtYx2C0up9d62Yhm+
         aCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZY23QlS7LS9bzKtlJLI+hejPzLCrRa8/I1X5G/vTR0=;
        b=klwKV098uf+Rt0pi6UzZmAbEVccT8US5EqTRPkGzZDbi1zpb5ZTz/hudt5epXS5O5H
         nud0xSGdDTA4igVC9huwDtuphjNHQQAMVdKOilLgLUtwUGnIQ74irrUX73p1teS1EFM8
         buHO1CftpXkN2tPgzKSfLNvd56mTuRuoNNuiQo08MbF0588prO750m8o2wiUUzTcUj5K
         ZrrdGNBzyG2Ua/OHSuftMf9ATnzlbonXx0vNnM2iZUuiRqFkhwNboS6yFjq9EbRfLOEA
         pk/7rcnvLWuzaGMSiAcs9H2UWjtgLqFEOtGa46kY+tlYZEFy+lkQDpDL5Co/uaxotN/o
         kDeQ==
X-Gm-Message-State: AOAM5312/VyyUauVK38h77Cim1jGadbJIg6Zx8ZFJ0L3BoMGvJpNW7Ab
        FF23KNLMBi1dazZA0NoCE1q131fOYT801nh5
X-Google-Smtp-Source: ABdhPJwDP/fvSjb/ZpuAt3jAEpaqPEwesRVLhfG0z40q4/m5WsYWo/KvIkz5auCyN7dGLcssblZIMQ==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr12834725wrw.202.1629719574705;
        Mon, 23 Aug 2021 04:52:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm12350713wmi.1.2021.08.23.04.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:52:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 3/8] refs/files-backend: stop setting errno from lock_ref_oid_basic
Date:   Mon, 23 Aug 2021 13:52:39 +0200
Message-Id: <patch-v10-3.8-2c4c30e8e06-20210823T114712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com> <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

refs/files-backend.c::lock_ref_oid_basic() tries to signal how it failed
to its callers using errno.

It is safe to stop setting errno here, because the callers of this
file-scope static function are

* files_copy_or_rename_ref()
* files_create_symref()
* files_reflog_expire()

None of them looks at errno after seeing a negative return from
lock_ref_oid_basic() to make any decision, and no caller of these three
functions looks at errno after they signal a failure by returning a
negative value. In particular,

* files_copy_or_rename_ref() - here, calls are followed by error()
(which performs I/O) or write_ref_to_lockfile() (which calls
parse_object() which may perform I/O)

* files_create_symref() - here, calls are followed by error() or
create_symref_locked() (which performs I/O and does not inspect
errno)

* files_reflog_expire() - here, calls are followed by error() or
refs_reflog_exists() (which calls a function in a vtable that is not
documented to use and/or preserve errno)

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 950f9738ae0..c1794dcd295 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -982,7 +982,6 @@ static int create_reflock(const char *path, void *cb)
 
 /*
  * Locks a ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname, int *type,
@@ -990,7 +989,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
-	int last_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -1001,11 +999,10 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	if (!refs_resolve_ref_unsafe(&refs->base, refname,
 				     RESOLVE_REF_NO_RECURSE,
 				     &lock->old_oid, type)) {
-		last_errno = errno;
 		if (!refs_verify_refname_available(&refs->base, refname,
 						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
+				    refname, strerror(errno));
 
 		goto error_return;
 	}
@@ -1018,15 +1015,12 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
-					  NULL, NULL, err)) {
-		last_errno = ENOTDIR;
+					  NULL, NULL, err))
 		goto error_return;
-	}
 
 	lock->ref_name = xstrdup(refname);
 
 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
-		last_errno = errno;
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
@@ -1043,7 +1037,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
2.33.0.662.g438caf9576d


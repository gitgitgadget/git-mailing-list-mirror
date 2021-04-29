Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E01C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF686141E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbhD2PdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhD2PdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC3C06138C
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so58326575wrt.12
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dAjq7gpUAKf+nhWN3RaxzK79Jrd7riKdpJvlhkjm5+k=;
        b=gH/+OlwVSZ2bxMcvQv7424w6GAjswnpuGix9kPLxxmtRzkEKiqOXCCioilID2ad69n
         NnXdtYubl4yoRNP0VyoIuOqNro+TBmGkYgI9U+99Eh1B77ZcbKiqXkbGEZ/NZ9jI5njR
         yTdxR1HfjUHXYIg/Q8OPcoMIFCojKOHMznYwkhqTipIS3qoIQUIrf3ns5rppsdZ4Y+sA
         5zlp3UwOnFJ6er9AwotIK6nVK56yWiiXm/ac5bdgRspSHMTf7jJ689a2P1HCDzXUEkVL
         kUIQ+yY1bhUBa4lzjbDLUYZXNFNTLxMBZYPdecbeSna7CGGD/tRtXLXAwj/9X/Z6e+Q4
         PI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dAjq7gpUAKf+nhWN3RaxzK79Jrd7riKdpJvlhkjm5+k=;
        b=C5sWeXLd+3ECm1tPzf1Uhk393oXQ58WYq7D7mTJKDmwniqxd839utCWjk7fffeSTAR
         350lgctO3T0zr8dedHi6cZgJuzfGVXHaTZ138ShBRDEBWNbo+deoFmwPTy8KLK/+tQ8X
         VY8htAEBJVJvWmZRHOqf/9OMJ/krwuuQOBabrNIILwHpVS5D/iDTwHYGR+qQRylqCNZr
         PAP7rFSdar5QrkQXGEJmO/o1qIoaWgncLAwLlR/swSU79IAeH6RLPpKz6ZG0fLl6oq9s
         43wPzOPbaNwf3tC0eSoH7GRKhZfgoKBoN8i15EOaWP90Ufz8WS4UkhSZRp6Y3hZ/uylr
         rUYg==
X-Gm-Message-State: AOAM531JjoRh6dvBh7T7ogxWlpF3jsXSOdMt4+CscJlk87xOlw+TN6MX
        fS8IpMm+UYwbZuEgHTbNNNV4nGRaeT0=
X-Google-Smtp-Source: ABdhPJzkh1k6KRNpcDHgL/1/SsAhCwHzzYSDLMQ/Gt3VwLCz7Cj+YYOllWaQJzIoEx0vODhDTntuHQ==
X-Received: by 2002:a05:6000:1843:: with SMTP id c3mr368437wri.361.1619710331646;
        Thu, 29 Apr 2021 08:32:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm5447099wrw.60.2021.04.29.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:11 -0700 (PDT)
Message-Id: <b2c72097e5e8985e7fdd8e3eee66cdf43d1b65c0.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:02 +0000
Subject: [PATCH 2/8] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
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

Errno is a global variable written by almost all system calls, and therefore it
is hard to reason about its state. It's also useless for user-visible errors, as
it leaves no place to report the offending file and/or syscall.

For the copy/rename support, calls to lock_ref_oid_basic() in this file are
followed by:

* lock_ref_oid_basic (copy/rename rollback error path)

* write_ref_to_lockfile (both in the rollback path and the success path of
  copy/rename)

These calls do not inspect the incoming errno. As they perform I/O, they can
clobber errno. For this reason, callers cannot reliably observe the errno that
lock_ref_oid_basic() generated, so it is unsound for programmatic use.

For files_create_symref() and files_reflog_expire(), grepping over callers
showed no callers inspecting errno.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 119972ee16f8..c9511da1d387 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -910,7 +910,6 @@ static int create_reflock(const char *path, void *cb)
 
 /*
  * Locks a ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
@@ -922,7 +921,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
-	int last_errno = 0;
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
@@ -949,7 +947,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		 * to remain.
 		 */
 		if (remove_empty_directories(&ref_file)) {
-			last_errno = errno;
 			if (!refs_verify_refname_available(
 					    &refs->base,
 					    refname, extras, skip, err))
@@ -962,7 +959,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		last_errno = errno;
+		int last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !refs_verify_refname_available(&refs->base, refname,
 						   extras, skip, err))
@@ -981,20 +978,17 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
 					  extras, skip, err)) {
-		last_errno = ENOTDIR;
 		goto error_return;
 	}
 
 	lock->ref_name = xstrdup(refname);
 
 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
-		last_errno = errno;
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
 
 	if (verify_lock(&refs->base, lock, old_oid, mustexist, err)) {
-		last_errno = errno;
 		goto error_return;
 	}
 	goto out;
@@ -1005,7 +999,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
gitgitgadget


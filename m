Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D5C07E9B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF32F61183
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhGKQdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhGKQdk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A23C0613EE
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso9711638wmj.0
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBvGiZFOHzWy6eephCuM9Ij7J4C+tYPO23bkdiPO5vM=;
        b=AYnzDWRP7k/wPH/3NlnOk7LlOwhyJPLDoEtB0k9mA1ABSzcynMtOmrQHQmSs3M4/pB
         1lBvFyzKwEbRdYfA3vDxc06v1UxD/3tOQbNgXDvPCSMvFtKCAOSYeBidcFpbIgL4Edit
         G6+Gm0V0lIB1uQhUNe1JDESMj7ao6xUx6BIysAJX9kI/1XTHDsqeUhynP+Z6kRay9oMg
         VevUgKSz+BXlPBy2L9Gl2G8p1ahcHUabmsjOfJZyDuRludjYiehPKZtpGKHnxE/MWMHt
         tb2if9VH2Jm9RCLsbvZngcfdXgcNho7eLi6RB30R2bMbyVoiVU+//5KWStMbMyZfdS6V
         tWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBvGiZFOHzWy6eephCuM9Ij7J4C+tYPO23bkdiPO5vM=;
        b=D9U4B4RCj0Gwp3/VFLQRwgdqyw+gOpfGXXkHbUBiXOrGfZkFdFi6nlhGO/kNHRUB91
         OXglSIJrLBVPsVDlwKzc67W+gtOXBLVrVh9O4jI557FeXBa1tX4tiK1KTfYU/GRsRZ7K
         SXw1ca62WUm+TT+j4YUT6hmkNwzlDb3NK8pDaVYsEkI5nGMth9hkMQLvAOQ99J/BSAvu
         pjzs/70tiNN2qHNT2koBeEs9gCrPDHI4l0y30xyHjbhiCJc6WzlCt/FQ0Qrhj4Q+8eMr
         haZbI1SyxX5ffi2mvQ61fHQ2Fqo7vxTv59LW3CL2yekhhtzYyEe5Hkz0ikql4lSfHv8J
         ULiw==
X-Gm-Message-State: AOAM532k6g5iJ7LKid4WcBDXoxg8VYGMIuZgV7o1/hetBwSdyjY8cwrQ
        X/IVEYzCB5rohj64AHDYQMtvJfGAqAlm7Q==
X-Google-Smtp-Source: ABdhPJwB2M+VZLLmQFT7ocknmcuSdVboTg7xkJ7bGoGhBMJqXMGHwVnW9CFuQwPSCJiyMD99yQLm1Q==
X-Received: by 2002:a05:600c:3501:: with SMTP id h1mr43862938wmq.157.1626021051724;
        Sun, 11 Jul 2021 09:30:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 07/17] refs: make errno ignoring explicit in lock_ref_oid_basic()
Date:   Sun, 11 Jul 2021 18:30:31 +0200
Message-Id: <patch-07.17-10a40c9244e-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit we moved away from refs_resolve_ref_unsafe()
in this function and started using a "resolve_errno" variable, which
means that if this refs_resolve_ref_unsafe() invocation sets "errno"
we'd end up ignoring it for our earlier "resolve_errno" (if any).

I'm not sure if this is what we should be doing, but let's add a BUG()
here for now to indicate that we hit a case we'd previously "handle",
but which we now ignore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d6ee7c1172f..a4e9344ac8b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -953,6 +953,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 							&lock->old_oid, type,
 							&resolve_errno);
 	if (!resolved && resolve_errno == EISDIR) {
+		int ignore_errno = 0;
 		/*
 		 * we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -967,9 +968,15 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					    refname);
 			goto error_return;
 		}
-		resolved = !!refs_resolve_ref_unsafe(&refs->base,
-						     refname, resolve_flags,
-						     &lock->old_oid, type);
+		resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base,
+								refname, resolve_flags,
+								&lock->old_oid, type,
+								&ignore_errno);
+		if (ignore_errno)
+			BUG("hit errno %d (%s) that will be ignored, "
+			    "resolve errno is %d (%s)",
+			    ignore_errno, strerror(ignore_errno),
+			    resolve_errno, strerror(resolve_errno));
 	}
 	if (!resolved &&
 	    (resolve_errno != ENOTDIR ||
-- 
2.32.0-dev


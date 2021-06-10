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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3560C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C3F613F1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJNAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFJM77 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 08:59:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADEBC0617A6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso6478162wmi.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ujk4STVcumVRPnCWKQXzGN0IR0fSSdmAeYqUzyDQwdY=;
        b=auLMiZgbGnCMi49ywnHx5QogPhSmt/myB8lcjHckgQQOg/szW/CSxfQxbIW0TIraDU
         30oxQ7hH0b4OB31n9SO9eQwqtwmyckvhEdT2TUCCLLiSL+kM9Bo7ENoNeyR9RotrbFnX
         9NbXUVLyJK9JKd603G6Is/y5JBqOmoEOLxArSrS+wByMNAB8Uuh7Bm+kPi8iS2wmXnNG
         Sp16n1i+bz/SiHLL2u2wG4J6HPallA9AiISj3k/p1ZXH/p8OwAd54Od3b5NJ8VuNS/J8
         M/0YWxBHs4hwAhnOeJSvR7rDairDxfr2s9+45m8p5S3j8HDmBNr1q8zS3IOiiO1mqICp
         jbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ujk4STVcumVRPnCWKQXzGN0IR0fSSdmAeYqUzyDQwdY=;
        b=rDEYCfNACpvXLRUZYcwmEbFZCSJBEGytAlLzmJZMDyoNPduwnOrDyzyJ2Mf2643SHz
         1prH96pq63dKPvYR+vUy5dlokdpOmrSyCvXYfD6aWI7ivvXW+hOxPyLnXTX9OwG7PdOb
         2SYAXI41Lk6BhimA+6mmjAwBm94/ODH76xPrnP2iiWq/vaT3BmTn33/PbpS/L/SL4AvW
         v2IJH5O5YLeDTCyZ1xNmJuX5Oc/DZ10+sep2KUMaxUPrnA8i+nLdjEI9+8td5AQuNLf0
         zziyI7THSwwz9GFLe+octx6dTxM3pIpq4Et3XQN48Ax27f+OQQD5RDw/rybCtfsI+3s5
         XcuA==
X-Gm-Message-State: AOAM5331uGbu6zGfqFRysMA46DcgU2P6c/7KLEaF81Fwz53VFfO/p8vM
        m/UZwFjRifbVhEPV95Bc6ZZB71RNCz0=
X-Google-Smtp-Source: ABdhPJwLwS9q55PAhbmAtI36rULLVCcq2D1DKyStp5bDPDPb4rgjaWe6Ko1HylaSyPvKlbkoNCJ0Ww==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr4994229wmh.115.1623329873225;
        Thu, 10 Jun 2021 05:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm3499318wrr.43.2021.06.10.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:52 -0700 (PDT)
Message-Id: <005ee8e6fb2a0f1a38801bed1dfe082999bfec14.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:45 +0000
Subject: [PATCH v2 5/8] refs: use refs_resolve_ref_unsafe_with_errno() where
 needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
that needs error information to make logic decisions.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs/files-backend.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8f969c8f711f..5a430aabf623 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -924,6 +924,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -936,10 +937,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -959,12 +961,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		int last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
+		if (resolve_errno != ENOTDIR ||
+		    !refs_verify_refname_available(&refs->base, refname, extras,
+						   skip, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
+				    refname, strerror(resolve_errno));
 
 		goto error_return;
 	}
-- 
gitgitgadget


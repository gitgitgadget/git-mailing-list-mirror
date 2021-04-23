Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43346C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15116611AE
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhDWKYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhDWKYp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 06:24:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77EDC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 03:24:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e5so19170071wrg.7
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=+cO698uKkPeBjSDcgJbNosHQ6r9oblmaoQkI8E4+MbY=;
        b=Ngt74qy/f3V5qkHXpKVZGy5h6axENYlSwzGDifliirsXWXqYeftCw1R/zP65XO8TA0
         TC3neFH4cvo4a6ymd5RmhCYKMIB6UILfNqmBtARRte1ADv0+oMgZU9PBsCgbSfcO5o/9
         U7254GXrM76fbqRUnOF+/wEM0gGekl7r/uS0eZWfmP5i/gyij/1YJBzZ3YbQ+ak+WGEn
         uH7LH/0T/mXhwUin2FzLBe9CYIOpw4HtommAbLo6d4Tf0Mk4Fq131MwQCX/QUegr/Ml/
         UHpnXBzrgmCBE5MxCWqgkhRZ+ezAdI4cIz4y7p5Q0XI2warvrdxsmlsdBrpZPw0WdRSU
         DZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+cO698uKkPeBjSDcgJbNosHQ6r9oblmaoQkI8E4+MbY=;
        b=D0FMgNarEzqSGkDSESRHojtcnC3BYJikQ2ZLD2xYIiEcQKWYO3PZUazjKH1Ti4Es6I
         9WSQM3S49moVXT2GFk5y1jWcj3vsEwmWz8koXq8e0JHEIG/3vXBR2z5RXEPzkHa8YY8Y
         lT2Sm/rv5fx4mjIy47DzQdOf1KW8E6ADzybRkpcueznxjrvGPnK5mZgURlwLsaTc/UoY
         lYwyzWO2sP+Z7Bfk5qL0HDJiCvlmGPYX5wqlI8MFPGpzQLQO1TG74gsVubs4yX5HKEJD
         yc81YFYO922UD2YI8W/cqm/e6Kry7oGGJ2RrnXaVNzomqgmVewIb91htGgsng2tnMbDM
         ruQQ==
X-Gm-Message-State: AOAM533S2ivaQ0SnLIG7NuGMFUowfjQwortXaod+w0vZIz4uVyVAwQ6L
        9dAaPwwDEpxgLTSVs1pw0uAe7JyoriM=
X-Google-Smtp-Source: ABdhPJzOlOhF6Saoh9l73b9cO8/ISS7MyUcXFRKSH3RFaUY+Qs/WQQvVypCb6TRmVen+rKonmaXztA==
X-Received: by 2002:adf:fdca:: with SMTP id i10mr3752770wrs.55.1619173447678;
        Fri, 23 Apr 2021 03:24:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm8769681wrf.75.2021.04.23.03.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:24:07 -0700 (PDT)
Message-Id: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 10:24:06 +0000
Subject: [PATCH] refs: remove EINVAL specification from the errno sideband in
 read_raw_ref_fn
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

A grep for EINVAL */*c reveals that no code inspects EINVAL after reading
references.

The files ref backend does use EINVAL so parse_loose_ref_contents() can
communicate to lock_raw_ref() about garbage following the hex SHA1, or a short
read in files_read_raw_ref(), but the files backend does not call into
refs_read_raw_ref(), so its EINVAL sideband error is unused.

As the errno sideband is unintuitive and error-prone, remove EINVAL
value, as a step towards getting rid of the errno sideband altogether.

Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: remove EINVAL specification from the errno sideband in read_raw…
    
    …_ref_fn
    
    A grep for EINVAL */*c reveals that no code inspects EINVAL after
    reading references.
    
    The files ref backend does use EINVAL so parse_loose_ref_contents() can
    communicate to lock_raw_ref() about garbage following the hex SHA1, or a
    short read in files_read_raw_ref(), but the files backend does not call
    into refs_read_raw_ref(), so its EINVAL sideband error is unused.
    
    As the errno sideband is unintuitive and error-prone, remove EINVAL
    value, as a step towards getting rid of the errno sideband altogether.
    
    Spotted by Ævar Arnfjörð Bjarmason avarab@gmail.com.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1011%2Fhanwen%2Feinval-sideband-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1011/hanwen/einval-sideband-v1
Pull-Request: https://github.com/git/git/pull/1011

 refs.c               | 2 --
 refs/refs-internal.h | 9 ++++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 261fd82beb98..3179ebd71b2f 100644
--- a/refs.c
+++ b/refs.c
@@ -1705,7 +1705,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
-			errno = EINVAL;
 			return NULL;
 		}
 
@@ -1765,7 +1764,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
-				errno = EINVAL;
 				return NULL;
 			}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936d..29728a339fed 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -617,11 +617,10 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * properly-formatted or even safe reference name. NEITHER INPUT NOR
  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
- * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
- * EINVAL, and return -1. If there is another error reading the ref,
- * set errno appropriately and return -1.
+ * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
+ * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
+ * broken; set REF_ISBROKEN in type, and return -1. If there is another error
+ * reading the ref, set errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget

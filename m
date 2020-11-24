Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A41C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D519206B5
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS4dJ4i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390980AbgKXTKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390973AbgKXTKO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 14:10:14 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A0C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:10:14 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so23520952wrt.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GDoLPi9f11FW4AlfrG6RrGk/b3W5kxrMtVkUEROaAFM=;
        b=QS4dJ4i8Z69le8gM13d33qKMdGgpRaCwgcKSFOnNRvPDFxQi9zgE7y0Koq6cAeLKS9
         h3KH5fyKNfgOiir2/PIW+GzCZCDdZ58OquKTOIOSANKCxhWrP4R9eiPkzSOn0mo3uRJa
         fg7oP3gCU9xaFv4d308C0NEhvFSOMfHRlwqFC5mtP+4xonNjcVmiwMGy45wFinMUYoXB
         ykGJHxcDtD2wVifGdzJIdXWZ+Rb0GkQ19gMV2Me+rO5bltzKCII67ypyHCqdVsTecNje
         URzLfB3ZfgK7Jz+JhjSIzdjcLPWrjJH/K09TI2VGKb4laCoWbr7xhhwUWdx7CHKtNsvm
         jJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GDoLPi9f11FW4AlfrG6RrGk/b3W5kxrMtVkUEROaAFM=;
        b=qCdXV+qjmxaVIIzd1IpWTFiXBAhmqaKAgxfg9R/e0KYeOENarFWmFIdHHqiQrbJe3D
         ARbUY/LwZqQZSewNKsmfvc77YEGFtXaMrI/9hUuUsVfZw+Dm4ks7lMVKRHpEBnEO5+Or
         CvQ5Dd8wMJ4/ro8OZHsd+uuvK/TAHDdIymuXtYNZ5dMOQ0QKZCnu6rrZnDCg1/72Js/s
         /1JEAHVa+/rCWn6dXrz1xSCBfGOlEphx8D5yhOMyKwgp+6FbZYZYCT+7W1mXfRvfXbeX
         3bAMA4rq9nc/ROWqaTQCGR9oXJMZA6uPtOqQGHobO6bJSqjntkT1sBVKsV7wOKBBLybU
         atQw==
X-Gm-Message-State: AOAM5307wu9iT3c+ZStEue518tSWH0+sOKGG6rSeyGrUMKFw2KEV2uH0
        XhlZlQPSFKVQPAnxX8NfRcnolFsm+LA=
X-Google-Smtp-Source: ABdhPJyeyexrVuUnJ+gac/h8ckzmHVTrQmTe2hLCHNLpBGcHFYvkqM0ygNOly361jdS+bstZO1zHhA==
X-Received: by 2002:a5d:5482:: with SMTP id h2mr6981741wrv.18.1606245013154;
        Tue, 24 Nov 2020 11:10:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm28360845wrp.26.2020.11.24.11.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:10:12 -0800 (PST)
Message-Id: <pull.922.git.git.1606245012068.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 19:10:11 +0000
Subject: [PATCH] move sleep_millisec to git-compat-util.h
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

The sleep function is defined in wrapper.c, so it makes more sense to be a in
system compatibility header.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    move sleep_millisec to git-compat-util.h
    
    The sleep function is defined in wrapper.c, so it makes more sense to be
    a in system compatibility header.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-922%2Fhanwen%2Fsleep-header-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-922/hanwen/sleep-header-v1
Pull-Request: https://github.com/git/git/pull/922

 cache.h           | 1 -
 git-compat-util.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index c0072d43b1..e986cf4ea9 100644
--- a/cache.h
+++ b/cache.h
@@ -1960,7 +1960,6 @@ int stat_validity_check(struct stat_validity *sv, const char *path);
 void stat_validity_update(struct stat_validity *sv, int fd);
 
 int versioncmp(const char *s1, const char *s2);
-void sleep_millisec(int millisec);
 
 /*
  * Create a directory and (if share is nonzero) adjust its permissions
diff --git a/git-compat-util.h b/git-compat-util.h
index adfea06897..7d509c5022 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1354,4 +1354,6 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */
 
+void sleep_millisec(int millisec);
+
 #endif

base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
-- 
gitgitgadget

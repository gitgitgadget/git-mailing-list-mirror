Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4FC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 17:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhLPRbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhLPRbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 12:31:23 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A52C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 09:31:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so11392075wrg.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=T3CQS4qQo5V/HRec6bFKQcsGe9Xc+vska8JM17oI1x0=;
        b=VVBWyzY+PF7YL7J/aUkuJvzVm8mq+cmJKO5axKncZv2TNHXevCVFPM7siG/W9SFpm/
         u7/X+Lp7GjYEf3PWd1H4+XZeLfd1CppSM25ywRHO+4ZHBFBbjKrJciz7uRurhsz2GIr4
         gCApKwjLrVuNV6G+rcJxxIpg9tREq2wzNy/ij/u14DjBntq/OnLW2h5hyUEswMyCbXET
         4Vr/xoZ5w6x9lyhw5ZPzVwMvyUuLkzw6iathUCSY0y5bkCKB37f8YR23UCl3PjRRQE56
         nBsbXH2IZyrad5tulak924Fv4vNBKW+Oci+CLWm5vw1drFknwhN7Z9D4w0KaGSTPDB4F
         TB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T3CQS4qQo5V/HRec6bFKQcsGe9Xc+vska8JM17oI1x0=;
        b=E3PVxsic4TTuxwxGHqX1uMZg25UIXPlBOlywVcW4R2+iFoJBmBwh8jpUazovmSqXU3
         1sCULK374oM6o4t1711fMJaCkWb9FEzWKOCyvebRHnbjhteBY7/+rKU/Otzo9AWGczKh
         W3VWV2FqSjjB/3JyJ0Z99F/tTQ+Wwc5zaQfeRqoJ12O3izoXBhIVUCzURen/wMqri3Mw
         VEnqNOGbX2N02JBG5q44A2xath01zXFS4rEjfqUvWj0OQVw4OOv80KbsIuT7ab05HGTi
         OWO5QVpQkP1QMAZqEAB9I892sF8Oo94LwytptcfIzEW5n+RlAgVsRf7ZV0mcL78BOB8S
         o8CA==
X-Gm-Message-State: AOAM530xMe8xl+/Ouf3B3nuy2gLcrOibB+Atm7d+/+dV4F+PLSkJmdsa
        phcbs/Xsg8v4TlIzQImb+t5VsiS7+0A=
X-Google-Smtp-Source: ABdhPJx/YDGnpyO8ej93j08Gp563P9/T+KTTmKI+TZdW6fRfk17dEcMuhTqWhXJXt4PmDHScpO1rlg==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr9956261wrt.700.1639675881810;
        Thu, 16 Dec 2021 09:31:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm6204487wmq.20.2021.12.16.09.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:31:21 -0800 (PST)
Message-Id: <pull.1097.git.1639675881065.gitgitgadget@gmail.com>
From:   "Andriy Makukha via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 17:31:20 +0000
Subject: [PATCH] strlcpy(): safer and faster version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andriy Makukha <andriy.makukha@gmail.com>,
        Andrii Makukha <andriy.makukha@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrii Makukha <andriy.makukha@gmail.com>

Original strlcpy() has a significant disadvantage of being both unsafe
and inefficient. It unnecessarily calculates length of `src` which may
result in a segmentation fault if `src` is not terminated with a
NUL-character.

In this fix, if `src` is too long, strlcpy() returns `size`. This
allows to still detect an error while fixing the mentioned
vulnerabilities. It deviates from original strlcpy(), but for a good
reason.

Signed-off-by: Andrii Makukha <andriy.makukha@gmail.com>
---
    strlcpy(): safer and faster version

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1097%2Famakukha%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1097/amakukha/maint-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1097

 compat/strlcpy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/compat/strlcpy.c b/compat/strlcpy.c
index 4024c360301..e7fd11015c7 100644
--- a/compat/strlcpy.c
+++ b/compat/strlcpy.c
@@ -2,7 +2,12 @@
 
 size_t gitstrlcpy(char *dest, const char *src, size_t size)
 {
-	size_t ret = strlen(src);
+	/*
+	 * NOTE: original strlcpy returns full length of src, but this is
+	 * unsafe. This implementation returns `size` if src is too long.
+	 * This behaviour is faster and still allows to detect an issue.
+	 */
+	size_t ret = strnlen(src, size);
 
 	if (size) {
 		size_t len = (ret >= size) ? size - 1 : ret;

base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
-- 
gitgitgadget

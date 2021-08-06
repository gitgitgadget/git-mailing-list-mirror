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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F4AC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C461165
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 08:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhHFIHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhHFIHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 04:07:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A75C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 01:06:56 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id e1so2123149qvs.13
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 01:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNJX2UmuEWkKHDsW8E18Gze3+m5yi+tTjPw+azEaUV0=;
        b=ZXgXn77e7qXuHObkCvnpwuvYF0BCcHLQ87W7zr+DmMyHAPGU2zGly/LLQK3RycxO9/
         3asBZ64+dEJ6svGxzb0J7ikq04jBu/rJPk22de8XZXT4lWQSoKml/VeHT9er8llldSV4
         lcO0P+ZKl0EGTq2EgVdk2gkv2XWM75CK/bihyN3G1aYQQ4RCtjjg3pFUD1yZGzwWTwxD
         EXuMIactfferL4uUI7JOfaxqaAzxcL2//Qv+oRPOhxV/lgugTEaCLFUnrbBI2p5eQIsi
         zdNHUTR3Ix3+f3mZUpyJJbg4iDj17LHnmlzxzS9LkPcXxUfPrQSiA2bRIBe3n8vGO96z
         IhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MNJX2UmuEWkKHDsW8E18Gze3+m5yi+tTjPw+azEaUV0=;
        b=oYGSgWLf8YF7Z1Elnj/Da+wSqaoYpOWGQPiUwLTkzaFjOnZJ9/6m9umyALJEc4sFVC
         UzsbRj+TamXma4Fjtmva81l8xm2wTh8ZjvnyWCiV/f3RylUrmvpgi5qjO2WD3fd17k9o
         QH+y5Qc3OrWHRVzAeTAI4UhmEvgK8kGY0gKcR1lg61nsp9l1I2qGmcwjFlpjPzhtUd9n
         9ee8qknfLHhSEbMMhIq/wf7DwkbDPFmxs612FX28DceWaWMLsm9SqXTRJYQFK6/dwbBq
         yf36K6nCRPwlWJJP4/GbGRT+dOAQK0JBfA2ybk6cHU//vNVm2sQyHp2n5Bzq8zJChy5r
         1vPg==
X-Gm-Message-State: AOAM531je0RwVy91pxK5W9PmPhSz21jB451CKbtcKxe/hd4NUMil7UZn
        QQQqZ4E67pbDxL2LxbX0KUJNUPtK5Ac=
X-Google-Smtp-Source: ABdhPJz+pozTiekxIMw7lqDxlEeEdf2Pr/eFJmUzEvLPjbYnaptCUvekWzAbgtL6rUfvY6h9rVRDXw==
X-Received: by 2002:a05:6214:f0c:: with SMTP id gw12mr9679460qvb.33.1628237215733;
        Fri, 06 Aug 2021 01:06:55 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f13sm4158708qkk.29.2021.08.06.01.06.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 01:06:55 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] makefile: update detect-compiler for newer Xcode version
Date:   Fri,  6 Aug 2021 01:06:34 -0700
Message-Id: <20210806080634.11869-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.443.g98cc19b6c0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1da1580e4c (Makefile: detect compiler and enable more warnings in
DEVELOPER=1, 2018-04-14) uses the output of the compiler banner to
detect the compiler family.

Apple had since changed the wording used to refer to its compiler
as clang instead of LLVM as shown by:

  $ cc --version
  Apple clang version 12.0.5 (clang-1205.0.22.9)
  Target: x86_64-apple-darwin20.6.0
  Thread model: posix
  InstalledDir: /Library/Developer/CommandLineTools/usr/bin

so update the script to match, and allow DEVELOPER=1 to work as
expected again in macOS.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 detect-compiler | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/detect-compiler b/detect-compiler
index 70b754481c..c85be83c64 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -44,7 +44,7 @@ clang)
 "FreeBSD clang")
 	print_flags clang
 	;;
-"Apple LLVM")
+"Apple LLVM"|"Apple clang")
 	print_flags clang
 	;;
 *)
-- 
2.33.0.rc0.443.g98cc19b6c0


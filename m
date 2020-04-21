Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3D5C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C07A206D9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 17:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiDfjD7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDURfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDURfK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 13:35:10 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB088C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 10:35:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so10577264edv.8
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=W6WPq8aFA7PK9lowSBqdKmwtA+tmXYBigjQHnKw/ym0=;
        b=XiDfjD7XFy3VOIA926BjQC/14HPXOB+nd1Bh0J86VZrRuth/xbPOPrO/7u6nm3DgZM
         92ZAXfq98v2lqHpxyZVTjoUX4Vk0lDzrOtjPDvQWATJqU6TmK812TvNdcwFZnkH8flQ/
         2OY8VOnq1KImLviC0r7M4l2yfaXNaltHiGm5ROpQqioPuyk2PmfKL3NzWEF6d5zFeLPO
         xLulb+DBpiaAuDirVIYG9+oVOrVTPRzLxzfU9dv4o5I2lgAC6/I1O5GlXhRbylXLdmBe
         Tg6lqBP4AcRGqPQK6DH8CyUaxis4WIWZMpNepuTKg4Fw0yFQT6yn57bph+gutsEVAXGE
         R4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=W6WPq8aFA7PK9lowSBqdKmwtA+tmXYBigjQHnKw/ym0=;
        b=C2A5r4rLQS4HlRornd2OHeDo+L3qCKiLB2NkmIcr+6V5jZAboX1RMPInQUvqMp/9ez
         WJkR1DUaysP+awBx/cWHILxkp4XwVKfWwcIpUyDgCCjycIeoVp2DDjxB6oSOn9rTtR86
         gbMiQ/qhLJZxpo7VMv3KdnE5I+syQ3hi1238Omj2lAxOEJxm7u3dKAuPDEABrEH00DGE
         PuBj4c1kfu231SU8e0GUGFAN3ELqlV9FULDoQEsRkizzIgmwRIR9AOCNcF+eyqBUHhDX
         9tcdqnZXGCaTYOhOWTY6mHc9a5Y8J+vFCXJfkdS8YK7R82LncdmrZUdggLVcpfwbIIiX
         xiqw==
X-Gm-Message-State: AGi0PuafPAlHh8vpeOXkXomzob6oMPTRIqvs1rBW6ClxA2acyluh01xy
        zgomjt2+5PS8uHjORa/BWK7DxE+O
X-Google-Smtp-Source: APiQypKHYY7ufRSL0++Hr5CpA07iHXmZNUkQt58soT3PvrkkYHZfIwjmV4zruf36Oro3uQwMBAmB/Q==
X-Received: by 2002:a50:f98c:: with SMTP id q12mr3402150edn.172.1587490506313;
        Tue, 21 Apr 2020 10:35:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm539135ejs.0.2020.04.21.10.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:35:05 -0700 (PDT)
Message-Id: <pull.762.git.git.1587490505031.gitgitgadget@gmail.com>
From:   "Michael F. =?UTF-8?Q?Sch=C3=B6nitzer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 21 Apr 2020 17:35:04 +0000
Subject: [PATCH] docs: fix minor glitch in illustration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Michael F. =?UTF-8?Q?Sch=C3=B6nitzer?=" <michi4@schoenitzer.de>,
        =?UTF-8?q?Michael=20F=2E=20Sch=C3=B6nitzer?= 
        <michael@schoenitzer.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Michael=20F=2E=20Sch=C3=B6nitzer?= <michael@schoenitzer.de>

In the example by Jon Loeliger the selector 'A^2' was duplicated. This
might confuse readers.

Signed-off-by: Michael F. Schönitzer <michael@schoenitzer.de>
---
    fix minor glitch in an illustration in the documentation
    
    In the example by Jon Loeliger the selector 'A^2' was duplicated. Since
    it is the only duplicate and doesn't fix in the structure I assume it is
    there by incident and since it can confuse readers this patch removes
    it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-762%2FNudin%2FNudin-patch-docs-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-762/Nudin/Nudin-patch-docs-1-v1
Pull-Request: https://github.com/git/git/pull/762

 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 97f995e5a9a..1ad95065c1f 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -233,7 +233,7 @@ G   H   I   J
 
     A =      = A^0
     B = A^   = A^1     = A~1
-    C = A^2  = A^2
+    C =      = A^2
     D = A^^  = A^1^1   = A~2
     E = B^2  = A^^2
     F = B^3  = A^^3

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget

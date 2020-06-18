Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22296C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCD5208C7
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6nI4+/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgFRQit (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgFRQir (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 12:38:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A8C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 09:38:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so6725865wrm.13
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Dknm/crFLS4bA+pSFfAcuY32A94sWXxxQQVDKP2E80=;
        b=k6nI4+/LTL01VrdbVLhuaGro9Ziu45wE+IR9qSfg1c5RWYpvscLlrqc7PYn7ETSddi
         M32y122a/KBQ5rBiF04HAvgy6zvujJszL7CLb3c/ygMogm+rPOtbNdn/KtLRZgphycEW
         HA/PN/fKwxAQZCHhYUJix7sApO2BszjJJ4FZYY6Fojm+Xs+1ep4i7eufBi9bvPJvbI7u
         wbtN4Q6MVWAeA+P6FdpTYxXMTAXGgvm6QVtSBmnWChXNop7IHav9jgm/c64RCDWr5wAm
         w0jyZxFTVhxxuCLsiaZwP/xjthwz9TwpCsMs++XdnZgF8xbH0T2T6w/dsZ2A/+2Jc90K
         h/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+Dknm/crFLS4bA+pSFfAcuY32A94sWXxxQQVDKP2E80=;
        b=EXJzQDiYdSlQcWKSL3G/LmLWc2lErqATvPZjvpFjVLDGXG0abF71czL0Qsry0X0BpJ
         WrGLhiDJc+QaGnPsVMKdhNMnC4a/SuGuDC8Hemw7d7dAhTjaoVniSFy98LW73rTpL4z1
         lx/I0L+pkGINX1M1ZeiuwygJHFF6dZotwoc92d1kOJ+aF0g/5BZxyxYmtH+I+A5eocZ2
         XrqYoKDWT1Ur8KkO3+mAX4eM5hqklq1b68bX4Lurd4HZXL/+d9QTDwHBOLa21GWjk7D6
         zzp0TNfyLIwS0xZ9ubhj2CeNsd3Ypc/DEuHFjMkWghH3tc3iGJXi5dPQwpxSIYcTeVpd
         0I/g==
X-Gm-Message-State: AOAM533rqEZF6t2E06j2vekxCwo8m5ofsnIVO3sjbqVxQ1rAXFZLsPnN
        27hd9UWraHiYv73dnBDL3oCj5GjyENs=
X-Google-Smtp-Source: ABdhPJz8aEKZAvFGso0i44TZ9wwkmvwlXhE3n4/LLQLXA5dp8qUH0PW3kvwXkm2pApjAJv1h4wtCWg==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr5426760wrq.218.1592498325331;
        Thu, 18 Jun 2020 09:38:45 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id l17sm2276172wmh.14.2020.06.18.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 09:38:44 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests: do not use "slave branch" nomenclature
Date:   Thu, 18 Jun 2020 18:38:43 +0200
Message-Id: <20200618163843.22181-1-bonzini@gnu.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Git does not have slave branches and has never had.  Independent
of any future change to the naming of branches, remove the sole
appearance of the term.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 t/t4014-format-patch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 575e079cc2..3e5b921b0f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -81,16 +81,16 @@ test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
-	git checkout -b slave master &&
+	git checkout -b branch master &&
 	echo "Another line" >>file &&
 	test_tick &&
-	git commit -am "Slave change #1" &&
+	git commit -am "Branch change #1" &&
 	echo "Yet another line" >>file &&
 	test_tick &&
-	git commit -am "Slave change #2" &&
+	git commit -am "Branch change #2" &&
 	git checkout -b merger master &&
 	test_tick &&
-	git merge --no-ff slave &&
+	git merge --no-ff branch &&
 	git format-patch -3 --stdout >patch &&
 	grep "^From " patch >from &&
 	test_line_count = 3 from
-- 
2.25.4


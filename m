Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2465C2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A5F204EC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 13:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiZxVAc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgEMNYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgEMNYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 09:24:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B9C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 06:24:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so6817244plr.4
        for <git@vger.kernel.org>; Wed, 13 May 2020 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtIaUfMHL/cb8g1ogDp/DKNTG/L2swOrsnj5WsevUl4=;
        b=ZiZxVAc4exAANU8nJ9XoMEKI3f4bLmJZmuvJkNcuS0vHCtlyslyNLBMMu+8uoO3fdT
         5Lbd1RNPaidEtzv1pXnwOFOm7mXSzI7GRTAEY+PryhtVCr0/XqtXl/beTjsbm84hWHXV
         x+LnfbPSqu+WcCPX0qmrfMdTFde73Ki88hmfMWplTCFAABMplryc/rt396VD4gBARrW8
         2FiyyjCQDJMubJOMdjg2hiuwtG/FeZ/F5ZAvBxsEFXJDXBoD38/7qJOZGP8EQZ/gcnd8
         AurSbHOwqEeahAL9Le7XxIhQCJilHz+D1c7KRs7p6FBnKqWkltJyYKoEcAT4q/kyq8KR
         uhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtIaUfMHL/cb8g1ogDp/DKNTG/L2swOrsnj5WsevUl4=;
        b=TAV9EZ6oHKfSMvffA9geYT/CwpJgIwMfUE3o3IGu1OZ/8zhZMQZPuzoNtyGG+PRr9s
         TvgmvzUTPmOHTBiHGAJ+CmS5lvSJErO+Dl9RJn3Z/PRjr9TSTP4rrXlDvad83S1RYyzL
         6nxNMe0lH/7cHwbx/B9Xq6Gt+V/GGzbkirT4GwomoYatBOnMlykEMHIGHV/sjXNK7y/V
         AWpBqiFuWG59JWUedtH8HCyY+kr1vdh4Gi/FlgKJ39JjeVDOQzsEmJcxaa20n6nDUGnK
         2833rW1nFLvd779aHpVcX2/NCwRxh1ASI6PlzuqpSEIplithhTlYsCqrKRym2OgDfMDu
         2aCw==
X-Gm-Message-State: AGi0PubZgondcwrsP5jAWjhQ6mXHVvX1SDdMHW+VEujC0m9VG/Ji4UEK
        Wn8gaswVh0QzLG4vjNwM0J+znrCr
X-Google-Smtp-Source: APiQypJTi5pDnV+oR7uAZ13nig2m2ehPQ0OhkFGI9ueHga4PfUHwloXwX1URsJFp3FczsYEU0dhZbg==
X-Received: by 2002:a17:90b:78e:: with SMTP id l14mr34883855pjz.144.1589376247421;
        Wed, 13 May 2020 06:24:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id g10sm14918530pfk.103.2020.05.13.06.24.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 06:24:06 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/2] t1509: correct i18n test
Date:   Wed, 13 May 2020 20:23:06 +0700
Message-Id: <6675cb952771a48a50b46bcf577e363fcf5d7b3b.1589375923.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1589375923.git.congdanhqx@gmail.com>
References: <cover.1589375923.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-init(1)'s messages is subjected to i18n.
They should be tested by test_i18n* family.

Fix them.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t1509-root-work-tree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
index 553a3f601b..fd2f7abf1c 100755
--- a/t/t1509-root-work-tree.sh
+++ b/t/t1509-root-work-tree.sh
@@ -221,7 +221,7 @@ test_expect_success 'setup' '
 	rm -rf /.git &&
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
-	test_cmp expected result
+	test_i18ncmp expected result
 '
 
 test_vars 'auto gitdir, root' ".git" "/" ""
@@ -246,7 +246,7 @@ test_expect_success 'setup' '
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
-	test_cmp expected result
+	test_i18ncmp expected result
 '
 
 test_vars 'auto gitdir, root' "." "" ""
-- 
2.26.2.672.g232c24e857


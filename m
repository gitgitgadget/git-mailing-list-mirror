Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0D4C2D0C8
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C952082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0miTALw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLQMBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33008 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfLQMBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so5570468pgk.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5BvE+dUV0tEMUPeGwMeNXRc4OJSkexat6Drb16D/tLo=;
        b=j0miTALwbtUV3MrItFmwIh8a1Z+9T/kPEPIArAyMmwLLzsD0UvSTluz5D8EnfLhmRz
         PhTWvzrjNGyc8OH5/p0wEHaWiXeKuiqsTE94Fy5/aLFXVvr5rRIya2cCx44HzRuTzEN9
         QWMw3DSA0vVmjnKOQetDTqycgQjkckg7heanoNp4ZG/fODcfKrp/t+h8p5zdQKePChOp
         B5BAxhBdqaEB9ipVohzBg3GVs0UibNV8HQlJpZ7Ne1tk8M9MrJC6DgR8+Abqv5Qx+Lnt
         3EC4ubqTdhXVdOQkMSMMDylrCd7BtIOt7tbtJpXb9+ePnHQENUZ37Y4NZHV6H5/HLdy8
         oRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BvE+dUV0tEMUPeGwMeNXRc4OJSkexat6Drb16D/tLo=;
        b=DaZEA8NBGe54h9V3+G4ouTWu+3odi5ndvdNINX1hMTFdNb6h7U3twJP/mlqx8IIdIb
         BFggP3CQoCBoiTyHMaJwZ2CKKcAm5ttezjP8fw1aZ3uVjUveKJ0m1sCQwNlYYcWU/DYK
         CUfICrZM+7i/XNp6pDanqOJjAyENqtEnxuleMVRObUdeKDx9eZ1xjTODjjzL01wgnVkz
         KxrcaVWu+hAqzq59t284SKi5FhZx2vGaFmO0hRm9kC8TlTed2EmiNgCxAFb4mQiSIdlp
         t8c+rD6kJ1EXJJTRhsDN1Sj7/C3FA6chr07cJg1XLAMJOadb0Rmb1PqhxD646Q+zI1m1
         bapA==
X-Gm-Message-State: APjAAAXXjLysts20Lm0FN3/LUJSHussdz6nWUVSim62fgcOsPAKohjuJ
        RPgOwVEk+U4nuC6grvhXPuec5xer
X-Google-Smtp-Source: APXvYqz4u6fsExPvVkDBZ85StTxxjvhqOLZp3lH6RLZWfmrCvLD3WQYAUH24Cb72ZutvtM/tkyZkqQ==
X-Received: by 2002:a63:cc02:: with SMTP id x2mr24914038pgf.114.1576584107457;
        Tue, 17 Dec 2019 04:01:47 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:47 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 06/15] t0003: don't use `test_must_fail attr_check`
Date:   Tue, 17 Dec 2019 04:01:31 -0800
Message-Id: <3afa3a16ca2fc2fecba19ff9741925d513f68562.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to remove test_must_fail for all invocations not related to
git or test-tool, replace invocations of `test_must_fail attr_check`
with a plain attr_check call with the $expect argument set to the
actual value output by git.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 53a730e2ee..8d4343afdb 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -28,7 +28,7 @@ attr_check_quote () {
 
 test_expect_success 'open-quoted pathname' '
 	echo "\"a test=a" >.gitattributes &&
-	test_must_fail attr_check a a
+	attr_check a unspecified
 '
 
 
@@ -113,20 +113,20 @@ test_expect_success 'attribute test' '
 
 test_expect_success 'attribute matching is case sensitive when core.ignorecase=0' '
 
-	test_must_fail attr_check F f "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/F f "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/c/F f "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/G a/g "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/B/g a/b/g "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/G a/b/g "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/H a/b/h "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/D/g "a/b/d/*" "-c core.ignorecase=0" &&
-	test_must_fail attr_check oNoFf unset "-c core.ignorecase=0" &&
-	test_must_fail attr_check oFfOn set "-c core.ignorecase=0" &&
+	attr_check F unspecified "-c core.ignorecase=0" &&
+	attr_check a/F unspecified "-c core.ignorecase=0" &&
+	attr_check a/c/F unspecified "-c core.ignorecase=0" &&
+	attr_check a/G unspecified "-c core.ignorecase=0" &&
+	attr_check a/B/g a/g "-c core.ignorecase=0" &&
+	attr_check a/b/G unspecified "-c core.ignorecase=0" &&
+	attr_check a/b/H unspecified "-c core.ignorecase=0" &&
+	attr_check a/b/D/g a/g "-c core.ignorecase=0" &&
+	attr_check oNoFf unspecified "-c core.ignorecase=0" &&
+	attr_check oFfOn unspecified "-c core.ignorecase=0" &&
 	attr_check NO unspecified "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check a/b/D/NO unspecified "-c core.ignorecase=0" &&
 	attr_check a/b/d/YES a/b/d/* "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/E/f "A/e/F" "-c core.ignorecase=0"
+	attr_check a/E/f f "-c core.ignorecase=0"
 
 '
 
@@ -150,8 +150,8 @@ test_expect_success 'attribute matching is case insensitive when core.ignorecase
 '
 
 test_expect_success CASE_INSENSITIVE_FS 'additional case insensitivity tests' '
-	test_must_fail attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=0" &&
-	test_must_fail attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check a/B/D/g a/g "-c core.ignorecase=0" &&
+	attr_check A/B/D/NO unspecified "-c core.ignorecase=0" &&
 	attr_check A/b/h a/b/h "-c core.ignorecase=1" &&
 	attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=1" &&
 	attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=1"
-- 
2.24.0.627.geba02921db


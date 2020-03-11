Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E383CC2BB1D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8C9206E9
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRbv//jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgCKSGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:06:33 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:44464 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 14:06:33 -0400
Received: by mail-pf1-f178.google.com with SMTP id b72so1758401pfb.11
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=TMKqffFXWYRltdTGAeF5dC39hDcpbymfQb1WdtaJ5Jc=;
        b=rRbv//jxnsxAjDPryFvBaqH30m+BR/ivJX5lNn5IH2h7A4R/DXYFsdbd4YbtLZn2Q3
         V1KEy/oSPgIFD7+2Lk9KEyt/H4x3CxM+fpeL36kG9iDm3m8r23wJbNdNYnZOLvAslGN2
         wKJZHDuh9TT1czGFLPwBW38WB4oBuMYXN1J49jOJwFZlo4bY5doOQOwUI7JuPyojAWJd
         oEaKgvd9bHIoYw2P6XqOhonp9AEIfVKz4h0ygwzdSFcPpxx4+j1EDtT0vOZ354sx1btg
         FNKaOxs+6xaIr4SQe/ILZLLEuOCOuhwJjMro//lOsGRNqXVCzmp0nnXGeFPCiRJZdQ1g
         6ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=TMKqffFXWYRltdTGAeF5dC39hDcpbymfQb1WdtaJ5Jc=;
        b=Ja/abRuLrVPBjtiL42vhDP0+y9HEFjYrk8p6uX5b2wPjtcuLoRhoTjetFU1767a3a+
         ouM8uSG/AtknIdDVtGZMQYvDmOAUNgfQoArNg/w3paP1Ti03KzjoilIIKMhdpX0Ma84J
         iXzWGW5RBBmVXf2RqQAHnFpSs6AR9kDyS0kiu2tQTmaHIOTX61m22i00lGoyXTERZyH4
         w2FIIJcejLsLqwmGsw2Maad0SVuiwAIn4zE3CCZEjfIAVqRPPge3uNwNbZQP6j1jm1x5
         xANp/gujJTHRmpK8tZ5e9DIvIrAz5c+kDGx/C+P22nm+r5hG7ReR8AciTuh8t6jr0fYN
         3Nzg==
X-Gm-Message-State: ANhLgQ0BeWQw9P7L14uln63SDtpwCqbKzl7gi2Xnc2JXVEClNTP4HLlA
        fTIzymBZD15lS/PDGBYwEngvEPdXlfQ=
X-Google-Smtp-Source: ADFU+vv4KpbHZS0QgP1uIc4kUf7bUnYyoUWCrAMpkG7NCsFZuWL2vsdtUlScSPnO5aQzgsHY2gzXHw==
X-Received: by 2002:a63:8b41:: with SMTP id j62mr3834507pge.18.1583949992015;
        Wed, 11 Mar 2020 11:06:32 -0700 (PDT)
Received: from localhost.localdomain ([157.47.170.215])
        by smtp.gmail.com with ESMTPSA id u5sm30720120pfb.153.2020.03.11.11.06.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:06:31 -0700 (PDT)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [GSOC] [PATCH] replace test -f with test_path_is_file
Date:   Wed, 11 Mar 2020 23:36:25 +0530
Message-Id: <20200311180625.4643-1-shubhunic@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in the case where test_path_is_file() fails, we get much better
debugging information.

Replace `test -f` with test_path_is_file() so that future developers will have a better experience debugging these test cases.
---
 t/t9801-git-p4-branch.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 67ff2711f5..214c2a183d 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -200,19 +200,19 @@ test_expect_success 'git p4 clone simple branches' '
 		git p4 clone --dest=. --detect-branches //depot@all &&
 		git log --all --graph --decorate --stat &&
 		git reset --hard p4/depot/branch1 &&
-		test -f file1 &&
-		test -f file2 &&
-		test -f file3 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
 		grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
-		test -f file1 &&
-		test -f file2 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
 		test ! -f file3 &&
 		! grep update file2 &&
 		git reset --hard p4/depot/branch3 &&
-		test -f file1 &&
-		test -f file2 &&
-		test -f file3 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
 		grep update file2 &&
 		cd "$cli" &&
 		cd branch1 &&
@@ -603,22 +603,22 @@ test_expect_success 'git p4 clone simple branches with base folder on server sid
 		git p4 clone --dest=. --use-client-spec  --detect-branches //depot@all &&
 		git log --all --graph --decorate --stat &&
 		git reset --hard p4/depot/branch1 &&
-		test -f file1 &&
-		test -f file2 &&
-		test -f file3 &&
-		test -f sub_file1 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		test_path_is_file sub_file1 &&
 		grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
-		test -f file1 &&
-		test -f file2 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
 		test ! -f file3 &&
-		test -f sub_file1 &&
+		test_path_is_file sub_file1 &&
 		! grep update file2 &&
 		git reset --hard p4/depot/branch3 &&
-		test -f file1 &&
-		test -f file2 &&
-		test -f file3 &&
-		test -f sub_file1 &&
+		test_path_is_file file1 &&
+		test_path_is_file file2 &&
+		test_path_is_file file3 &&
+		test_path_is_file sub_file1 &&
 		grep update file2 &&
 		cd "$cli" &&
 		cd branch1 &&
-- 
2.17.1


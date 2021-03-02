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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD543C4332E
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AF364EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355322AbhCCGdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835246AbhCBSvl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 13:51:41 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D4C06178B
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 10:51:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k22so12551751pll.6
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db8GKDTbvWyqYZSECJROxb36sH4r7Cq9knBQha1Nw/8=;
        b=PDWq6hgSt+tmMeh8Din/eSpAUP8r/KylBKIDgZdRkU+f2CUgge+GM5UdyhaXLtvOhn
         /EuFW1+RmeXNdhDGBuYpBH7Pmzv36nigq/cK3jKrumsNlWgNEfCTSTNV0a+zjTByHbSU
         o/NhSLcLAoPn66eyPpcleLL6mAIW4M/oBgY6OuLbJc/Jy97EzlXmxRQpYjseiY063Xn4
         W+RnH9yv8i3m+ERVfj4oSz4zEvQZhhG5TCjuAQSc5bv0fp/1K3ihKTYkP0CVl7IaW8Mf
         2mrchztU65gLWHRk9dc7/j+6W2mobkGBFL2Dj0W01sJ20j1mYcQ0Ldn7oUlH/NlH6117
         pTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db8GKDTbvWyqYZSECJROxb36sH4r7Cq9knBQha1Nw/8=;
        b=a/AkAjPP5YjKM/St7FdF8TdVqsgpLBn6EbeoluP6v1NpSKMvL8D+cteVSK2Fqx+UXW
         q+hlw8bRWNUPdVLZvBjRUtvl71+wISt8MoFKBGGW4td5zlOIcEJaT8/Ot8WdlpAOkolN
         tyv10tnWcgXaWnTppjejLd5feQ5atnShSkmyw7BS3MqOEYCbMEAbo9cBjUVy0+hSKiY4
         7HSYgFRDzMv7lARjXf/3yOq3MooNt09Ch6NfNxoq+Teb9yRYhcvkixFi9ij5bv+RD5AL
         J4WsqAr91AcAzwboamg70jtf566w/0WdlplJoRS2QhcASrSBrIiApGF6KftGo/4YcbZI
         N0jQ==
X-Gm-Message-State: AOAM532br1KMz5emccgl/DhNHVrXLnxTzlBavbk67imcV2zLeMEjgCW/
        oAoAk+ugdLgwqMvw5rFvHe0gUEvjCE6NKw==
X-Google-Smtp-Source: ABdhPJwQc4u4d+V/pTSooxeiDnla7ztP5/UTpPNFQ+pXRz4l6rjf95jioBzTpXJG8QDZu46Z3VUlqA==
X-Received: by 2002:a17:90b:201:: with SMTP id fy1mr5708995pjb.108.1614711060909;
        Tue, 02 Mar 2021 10:51:00 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0c:1040:7574:7d48:72e9:afa8])
        by smtp.gmail.com with ESMTPSA id 4sm4007373pjc.23.2021.03.02.10.50.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:51:00 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] t9801: replace test -f with test_path_is_file
Date:   Wed,  3 Mar 2021 00:20:56 +0530
Message-Id: <20210302185056.65929-1-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `test -f` has the same functionality as test_path_is_file(), in
the case where test_path_is_file() fails, we get much better debugging
information.

Replace `test -f` with test_path_is_file so that future developers
will have a better experience debugging these test cases.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
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
2.25.1


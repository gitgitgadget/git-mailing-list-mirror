Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE55AC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30C820409
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B90JmDep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgCSNad (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:30:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38956 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCSNac (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 09:30:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id m1so1069271pll.6
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=wMOzBKWt+dfrzBLBntDC+t3FvHSa5+3FFI2uwwPVims=;
        b=B90JmDep2JkEeFoAznWeg/D58Qqfwu0x/4MJrvUo/hnS2fDXm67eyz1G/95BkkUuav
         jEHqhkxDp4qgTpoP4jp5Lf2J62u7G9OriPpsWfLUzBSYddzTY0LdcD9s9PkalsUcOqc2
         4qaLm8vRxbnDAJ3bUwGLI7boctjSFdjiSxRVjHqwbKQWEBoo82Q0fjJ7hJP8+ysybaqj
         7RV+bBRRb1rCrCeEaWgiJi4+qLaxoV03i2AxEvnRrlOtrl6lII5RB9ESxqju8kRrNDjb
         KksYUkyoRaYE3cNN8B2cij3eBakoWmSLVt7aq3WpSLhjmimFdyLaIgVg/WZiDgmvA86Z
         Dnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=wMOzBKWt+dfrzBLBntDC+t3FvHSa5+3FFI2uwwPVims=;
        b=hGgM63Iz/0IlCgaOi1Nw6inDtxdQbuiTuL2FJgU/l4FO3re7gCf4u7g5+f22f/m4UD
         yhb3C+rJ7lJcAyFJPh09wwmFJa4gGeDsP/I/dy/yZO11JEjXGiKHPRwxasQztleRd4VQ
         XHIh5JUVwOLACqQtwN5KcjKqovnC0gR5ItbwNa90lx4cVR8Rh9xSS+jl+Khn1MGU6lXY
         OLnFs1TRsl7kYzRo8tySOKSAlJuvv/vwiwQ19YKI31kyzqTZWSbiEYCBrv5fUo69v7ED
         lKnr96bJqb9pICWYi31qCr6XOPN5t6S0SnSB3+E/UxJjI5ud3ZtkxigWEKJcOHk93QrY
         BEJQ==
X-Gm-Message-State: ANhLgQ2UFgDeJ1qoupyPSO1KikkfefGGbHwlU7elrPONI/2+2Vd7R1R/
        EgL8r0Vt3g3LFRJci+YdKdp13qTNJ/g=
X-Google-Smtp-Source: ADFU+vvYL+QS/LeJVE/nV4u/51i9mkunMgxSmZifBJidqf79HBhT6uTlOAMnZudWXjqccXEpg6QpdA==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr3942901pjb.21.1584624630948;
        Thu, 19 Mar 2020 06:30:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:2e20:ac22:ec32:affe:2929:752d])
        by smtp.gmail.com with ESMTPSA id my15sm1960440pjb.28.2020.03.19.06.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 06:30:30 -0700 (PDT)
From:   Harshit Jain <harshitjain1371999@gmail.com>
To:     git@vger.kernel.org
Cc:     Harshit Jain <harshitjain1371999@gmail.com>
Subject: [GSoC][PATCH 1/2] t4131: modernize style
Date:   Thu, 19 Mar 2020 18:59:56 +0530
Message-Id: <20200319132957.17813-2-harshitjain1371999@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200319132957.17813-1-harshitjain1371999@gmail.com>
References: <20200319132957.17813-1-harshitjain1371999@gmail.com>
Reply-To: Harshit Jain <harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in 't4131-apply-fake-ancestor.sh' were written a long time ago, and have a few style violations. Update it to adhere to the CodingGuidelines.

Signed-off-by: Harshit Jain <harshitjain1371999@gmail.com>
---
 t/t4131-apply-fake-ancestor.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index b1361ce546..828d1a355b 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -17,8 +17,8 @@ test_expect_success 'setup' '
 
 test_expect_success 'apply --build-fake-ancestor' '
 	git checkout 2 &&
-	echo "A" > 1.t &&
-	git diff > 1.patch &&
+	echo "A" >1.t &&
+	git diff >1.patch &&
 	git reset --hard &&
 	git checkout 1 &&
 	git apply --build-fake-ancestor 1.ancestor 1.patch
@@ -26,8 +26,8 @@ test_expect_success 'apply --build-fake-ancestor' '
 
 test_expect_success 'apply --build-fake-ancestor in a subdirectory' '
 	git checkout 3 &&
-	echo "C" > sub/3.t &&
-	git diff > 3.patch &&
+	echo "C" >sub/3.t &&
+	git diff >3.patch &&
 	git reset --hard &&
 	git checkout 4 &&
 	(
-- 
2.26.0.rc2


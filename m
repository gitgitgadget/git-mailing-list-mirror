Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBCC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBFVS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBFVS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:18:57 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370641420A
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:18:56 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f10so14569754qtv.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQW9GLDT3EtbSNsIm+495sLYJXGqvr+jNOj4Zhlarxc=;
        b=VQTwrWmGNgDBQobWPYe75kLVxpwCI3ZwtpIcwppH3gHl2PzeAKlfOVWQbh4DtRAiic
         5zR/OMK53zINgkNGFB/Ibl5OET8txL62R/38clPoHjOmVyHfDrcdz8eVjzIMXYnoGaHr
         2u3Pe+4jyvfP1JO6cY/2Lc10pgPELyIs6OEwZpY8qh2DOksAPKV30EWtCqu6BREhXsVH
         fV54pP/EwY07wVWzgKwuustTHn8n5izUP81PcYRg5lH1Kyedghdy/ftDKOcvi+sC2Tq7
         udsQhwU+Sy1YTAgc9FdZEyYzE1D5+nr1q7dEQFKPjZvnS3EVhkoVAjRjGVFFj6+Z5sTz
         u9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQW9GLDT3EtbSNsIm+495sLYJXGqvr+jNOj4Zhlarxc=;
        b=mqb3bK82ivmKMLRrwNr4vC1EvPMlADJr6rxVIFyVtB0hqILSPG3nBKe2rNAVXbX9hv
         ncVzANESiF9fJF7SCD4eHIMODsvARdxl7vdUW0ju+fFwlQ0n1IH7vtljtKW0CsbLX386
         9MeA8yuJjO2n7oRjVhFrrp+O6FEMHdm3siC58RPf8M7kXNVo1+caoRFVjVq3xxnaHqjq
         eCMDweR/SoCId3Tg3tIZDBrB62JVoDrAF68mrF+j4np5KTKAxp/75lcmfZ7Zysf0wULy
         VREn/j61nJiRRAaUJyyEI4OBJcveBrEbZlNLUo0DMA/uKLN79aOMSCSK/RQOhbiy4mR5
         ZShA==
X-Gm-Message-State: AO0yUKUcqSS1Q79ZkqFs7i89XGtpqeLgKL7QpNpDWIYJQ8Cxtk15r4Pz
        euaAGJOFA1ljpnotcWWfp/qnBt9ZOThC/g==
X-Google-Smtp-Source: AK7set8xGLH36+s9r5ncfat4e8RLyR6KKnj0qzNKllZjZgdui3g4VchmcdE/2m4UmI9GBFQ8YwpLwg==
X-Received: by 2002:ac8:5909:0:b0:3b6:2b5c:97e5 with SMTP id 9-20020ac85909000000b003b62b5c97e5mr1554509qty.17.1675718334992;
        Mon, 06 Feb 2023 13:18:54 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id f11-20020ac8014b000000b003b86d5c4fbbsm8033014qtg.1.2023.02.06.13.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:18:54 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v4 1/3] t4113: modernize test script
Date:   Mon,  6 Feb 2023 16:18:21 -0500
Message-Id: <20230206211823.8651-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206211823.8651-1-cheskaqiqi@gmail.com>
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts in file in this script are written in old style,
where the test_expect_success command and test title are written on
separate lines. Change the old style to modern style.

for example :
-test_expect_success setup \
-    'git update-index --add file'
-
+test_expect_success setup '
+    git update-index --add file
+'
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 66fa51591e..aa57895b22 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -24,13 +24,14 @@ echo 'a' >file
 echo 'b' >>file
 echo 'c' >>file
 
-test_expect_success setup \
-    'git update-index --add file'
-
+test_expect_success setup '
+    git update-index --add file
+'
 # test
 
-test_expect_success 'apply at the end' \
-    'test_must_fail git apply --index test-patch'
+test_expect_success 'apply at the end' '
+    test_must_fail git apply --index test-patch
+'
 
 cat >test-patch <<\EOF
 diff a/file b/file
@@ -47,7 +48,8 @@ b
 c'
 git update-index file
 
-test_expect_success 'apply at the beginning' \
-	'test_must_fail git apply --index test-patch'
+test_expect_success 'apply at the beginning' '
+    test_must_fail git apply --index test-patch
+'
 
 test_done
-- 
2.39.0


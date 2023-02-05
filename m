Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C5DC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 14:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBEOxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBEOx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 09:53:28 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE21ABEC
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 06:53:27 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id m15so3852180ilh.9
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQW9GLDT3EtbSNsIm+495sLYJXGqvr+jNOj4Zhlarxc=;
        b=Umn1W9GdiUCKKqeInu+ynOk2frRzxtQtYbyF92OE8qn5JiBMmKRyf7W4cTQO093jZb
         FTir4Y+dEwQPh66gjAF/VOaMkCd+LL6S6wRCZLbolKHHa+1qqmeXSO8348cLyt4azgBH
         1ZxjoDW5kiAF4id/f2NnVCwTal/jOHtl5wQI8cqTVqJ5mEwWeebM2oGu3D7aBlIbP2ry
         a2NA9Wx5Fn7Gc3Yeblv1KReh5w5KVj4rSQUEEduGOBaqbUyiVkmEhYiWYh6hbytpxGsO
         5WaxhhwJpbFtK8QRDMoR2qwgdYg4qTosf0Sk1RZhVdzkRq7+5zWfvxBlciMBJsFyv0tx
         kojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQW9GLDT3EtbSNsIm+495sLYJXGqvr+jNOj4Zhlarxc=;
        b=GgAiXVXXP94/Wtv2z/904Tyrp23tTPh+AkVg9yXr3EhKIWcvkiIb4G3e/CPwRheuyX
         +wPQOiLrF2eo+49FjiKatpvStVAOm6GMeZWfpOVh5f1vLfjBEy55dKF4zvPHv2youPqa
         Rsq0kpB5sBDEXqHk2qbc3whspPT81FGnrHTYYoH1jyaOqzKgMmq0zlw1PxlNaMNghymC
         dUbhkoESTHwEyF/ez2edQ3TBbFvIC/yMGz3Pq/Gpe6nfKBXH3BNgomtcmFIZbwM/6Wob
         jBOMRCj1/XeN0klaaFQP15XhsJ8eLEAKc1qTzmCZhwAqmlsBlZ71tPM5OBWhtKMrot/B
         tWig==
X-Gm-Message-State: AO0yUKUV0nuJ+LQQkoTWp0F+0FSYsv1G6uP++wZcTOVu4wEcexP+3J1k
        rASEdjw11Qucm28FAlA8ml5DkyZZCt1Pzg==
X-Google-Smtp-Source: AK7set/9TB58zxbSm3R0GzQFUMKBy8tfLBF8Eej0I1yK5JCg5hZ8x5dElb4J4eQm28uz6YUwM0JW+w==
X-Received: by 2002:a05:6e02:1888:b0:310:add0:4b1b with SMTP id o8-20020a056e02188800b00310add04b1bmr16668403ilu.5.1675608806472;
        Sun, 05 Feb 2023 06:53:26 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056e02097200b00310a5b8504asm2518227ilt.36.2023.02.05.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:53:26 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v3 1/3]t4113: modernize a test script
Date:   Sun,  5 Feb 2023 09:52:43 -0500
Message-Id: <20230205145245.11078-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230205145245.11078-1-cheskaqiqi@gmail.com>
References: <20230202171821.10508-1-cheskaqiqi@gmail.com>
 <20230205145245.11078-1-cheskaqiqi@gmail.com>
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


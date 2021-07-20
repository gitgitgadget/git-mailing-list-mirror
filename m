Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9327AC636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9E0610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhGTQ2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhGTQY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A26DC0613DD
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f17so26790286wrt.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pBl9keprbyPXoTK8zNPwl5fONnH+JlzdDE+2Yk4oVBc=;
        b=iSJ9AlxAt3lSWMDBaIefPFLunB69y6ZJZromNEH9+xonKtyr50T5wXqBLRn8K0S8dU
         4EPkmekiQhl8Mo8eBo3iLvpvRm9GE7/b63umQgXNyoSKhuObLA90+BoV15QuWyVShZ0/
         2Od2oSCQCzNkqsHr1mB4wCrKGG/tECm26wUsVw2pB703xKD1vw4qBn2UvIm51D+dsOvl
         nrLIJec11em/MYgQ4LE2ttRTWNtYPNNIwcEKj7SNdeXYvWkvfqib953bWWO1rr5MaKLA
         S7NbkyGt5NRJ7Yq0xX2G7PK2YRKEz51CXDvRRCGIUI9Wnou7RimRFoTy/yYSSpz4BfJR
         pXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pBl9keprbyPXoTK8zNPwl5fONnH+JlzdDE+2Yk4oVBc=;
        b=f+VOn3dJ3Kupzu27CeE40q4KiYQPZCoayoSdZmmV+LUf5sCc10hdYRwJp788jRAJza
         4r3CPSjSXYoPpZBMIATYthx4JMbee9mo+JXgWq12UmzX/cWoyrQKQi+K/r4s1WUnJz5o
         Q9KJk8WGV57/Ox4PwL4/dH9r18fGvhW7kX7SilVSkbn6UklbQAkWQviqsW9ksTkWe/RP
         jSL6FzdN0fkh2jLRe810DTl5hom7uqwPApxek2qUfM80+AHz2Jgeep9jPwI1j62bXAG/
         c1lRfD6mkkJtb6S/T4JaPXLQavgO62X5tgwUUQ9BOybtjLUi4kis29MQlT15Z5N5bNfq
         vejg==
X-Gm-Message-State: AOAM532ZCNSg4YVBryBy7AeZwbJI1IiYcXa3lY89mjR8SvgZFvThQ1bV
        6yfFrB58WijWGi+2uJwIHx4pcJsIHl8=
X-Google-Smtp-Source: ABdhPJxrFIyP3RKiU/hawGZg0Pxu3V1hFQbRSB42mAMZWD6Mm2VZpLuuY+/7QygHDAeq2ShOQMF1pQ==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr10383902wru.45.1626800703699;
        Tue, 20 Jul 2021 10:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm2929351wmh.40.2021.07.20.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:05:03 -0700 (PDT)
Message-Id: <d895736f0e1b96fa407252acaaaf962ed1cfb667.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:44 +0000
Subject: [PATCH 24/26] t1401,t2011: parameterize HEAD.lock for REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1401-symbolic-ref.sh          | 11 +++++++++--
 t/t2011-checkout-invalid-head.sh | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 132a1b885ac..1b51013aded 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -102,9 +102,16 @@ test_expect_success LONG_REF 'we can parse long symbolic ref' '
 	test_cmp expect actual
 '
 
+if test_have_prereq REFFILES
+then
+	HEAD_LOCK=HEAD.lock
+else
+	HEAD_LOCK=reftable/tables.list.lock
+fi
+
 test_expect_success 'symbolic-ref reports failure in exit code' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git symbolic-ref HEAD refs/heads/whatever
 '
 
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index e52022e1522..a56f7af442c 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -22,9 +22,16 @@ test_expect_success 'checkout main from invalid HEAD' '
 	git checkout main --
 '
 
+if test_have_prereq REFFILES
+then
+	HEAD_LOCK=HEAD.lock
+else
+	HEAD_LOCK=reftable/tables.list.lock
+fi
+
 test_expect_success 'checkout notices failure to lock HEAD' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git checkout -b other
 '
 
-- 
gitgitgadget


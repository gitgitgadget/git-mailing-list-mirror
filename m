Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2FEC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A5F207DE
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfaP5IAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHURCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgHURAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:00:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9BFC061799
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so1287715pgb.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LXkrw20yLjX1KsUIavUoTrnoamJ1W6Y0DYIrZ43UJU8=;
        b=gfaP5IArblnpIOI1K2Sv8TwKX4IbToOKECY5qUVBLDzp/c2EBVy4NuHxKPlUxLdh7W
         HGmdb4oZXuZmLREBA1ufbVN4kKW1SfZvb6yrGo9SwTfWXwtOxaZfudS/ajxuXlWMDbIq
         XkFj4HI+KTCIbke7nwfGvj3Cb20heXp2ygQRA4HIJj72rllT5tKKOtgMuTlY9l8zmQPc
         Lqme6RVRp3HgQxJa6NF/gLWBWl8Lnsa7k6S4+ggrOeP6Z/lymmSMvswox+8CL7QgE1Ap
         I4XWOEn7qIX1IlU+/tbgMoHtJ7g2CIDNi8U4sfQGRi0IXx6tXRKDXGo/0Lsj28EXh5Gi
         TQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LXkrw20yLjX1KsUIavUoTrnoamJ1W6Y0DYIrZ43UJU8=;
        b=kfcqPMhgqr6mImsJ3D/8/CoSZG0q0NIyr+Ky+wTuh/ccrD2aZ2QuyjyhRaAbLdk4/x
         Q/VKKutClx/94VnerGC5GQ0gX+8ybY7iMhOCh3gQrcv8hzhCVXrQZKX/XZHBYYj5L6Vc
         HwnT8cjM1HBT0BJEr6V4M5eWCSbGxN31oZtwKTIByewVlqzMuH9WoVjCAoEJAhgcN2GC
         /8UmjIVVW0b+6qsZ/8rrf1778GjYkTpQm0O8puio8MuSJOnf34tHYXvwp8CINsHxnkTV
         0Yp6yaNObokR3UdFrRhNwvT1RuZdcv0qCXrrGz8dJLwwsHL5j+2v9mNU8S3d948GIQfL
         VthA==
X-Gm-Message-State: AOAM5332WwP2NSi1mI3Cand484lQ+GKBuo0taC1rQ1Z7pBUb0sdMEzW/
        OhEb+jRsRBjqf9gmaWmomworu6l7JYZt+w==
X-Google-Smtp-Source: ABdhPJwvGEN0Md4ZbB3iJNfEUr8QgDYmEkl0o/2D4KKJxh7od8CL9f4V71LzFhXi9jinXoSt+CuQpA==
X-Received: by 2002:aa7:9570:: with SMTP id x16mr3284799pfq.254.1598029213980;
        Fri, 21 Aug 2020 10:00:13 -0700 (PDT)
Received: from localhost.localdomain ([125.99.204.38])
        by smtp.gmail.com with ESMTPSA id q7sm3043505pfu.133.2020.08.21.10.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:00:13 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, me@ttaylorr.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/5] t7401: change syntax of test_i18ncmp calls for clarity
Date:   Fri, 21 Aug 2020 22:29:50 +0530
Message-Id: <20200821165952.14376-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
References: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
'test_i18ncmp expected actual' to align it with the convention followed
by other tests in the test script.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index ccbac875fe..3f580455f7 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -181,7 +181,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
   < Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
@@ -191,7 +191,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --files' "
   > Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -rf sm1 &&
@@ -202,7 +202,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 * sm1 $head4(submodule)->$head5(blob):
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -f sm1 &&
@@ -215,7 +215,7 @@ test_expect_success 'nonexistent commit' "
   Warn: sm1 doesn't contain commit $head4_full
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 commit_file
@@ -283,7 +283,7 @@ EOF
 
 test_expect_success '--for-status' "
 	git submodule summary --for-status HEAD^ >actual &&
-	test_i18ncmp actual - <<EOF
+	test_i18ncmp - actual <<EOF
 * sm1 $head6...0000000:
 
 * sm2 0000000...$head7 (2):
-- 
2.28.0


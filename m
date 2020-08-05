Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED966C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C770E21D95
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSkqnsZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgHERwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgHERt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:49:56 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D9C0617A0
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:49:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so3467822pje.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1JuxiEFbBgSuA8iGZ0RpKI2x/jJRiy3MfqRBbgyn/Q=;
        b=ZSkqnsZo1UlwCZiHl6dLPCIezaQVGtRHmvsmJGTx/ifi9kdeJdOq0+b5YFlKNHEQ3R
         a88CdxopT6LfEPl1DPGdI4u1WPCpGtENDo9JHX3SmDCOdZd/+pSWJmLvJlg3s4CbsPsI
         /lLLitOxD8MF9CVrbcvOCQFbWlh+YMr1UbsIffmPO9k1/8Pgq+tLL2sZbVR6OFz4LRS4
         e4e/BfTRSKmAvTawVq7cUdylB9t7Sfshzckn683bqSww5KvpwIUx57Z04W88xfgKbL46
         nQGyvHRifRYNemGQuBySoiZmahfVsj9fxubfetUEM83sIg9xxf0mHf+7i0NFkM4o4NQ2
         jzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1JuxiEFbBgSuA8iGZ0RpKI2x/jJRiy3MfqRBbgyn/Q=;
        b=l7osxsCARPyfYklfpVpNKWB+fiGoVAElkr2ddLo+VtFfh/LOZEwGP3C5Wjx0ET26Bv
         09Cm8zu3GuzAkSRV+fY8ChxYvNhQONR4gEuOZ4lHVaxWnOMqIDuJw027Es3gXqBlqutz
         oGbMqEgcq5eAhxxBzgY2ZCOGTzV2rxB6TK09IdhnOaKFqj29ipKHIneeDEsPVM2jMLLh
         k/MKppBivV0Yhr48EIiAOI1tfJW2Zai3Pkr84t3tjq4oe+GAkaES5xAUwT+jh9hnXi4D
         Qc09zWYF0GRTgGRWUxuJvaiXHtQfKFfuA50pSPQiZ+vJvNgyyjoyDFr6cAfqPH1gyS0I
         ISYg==
X-Gm-Message-State: AOAM532lsQbYHCJnW9P//sJcFmYfveamLbNRtujy0J8fWcpy/IaOp2A/
        CsORk6cQabMWfW5Cjxa8wHv4/NQ03Sc=
X-Google-Smtp-Source: ABdhPJwAUPUOpXjh6Fm0q1brexieUYu+s9WwH71m52Qtl+vfqk/4lXQ2QzlDjCfVAEJwbtVzas+M+g==
X-Received: by 2002:a17:90a:9f44:: with SMTP id q4mr4587514pjv.66.1596649793104;
        Wed, 05 Aug 2020 10:49:53 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.185])
        by smtp.gmail.com with ESMTPSA id z77sm4765150pfc.199.2020.08.05.10.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:49:52 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] t7401: change test_i18ncmp syntax for clarity
Date:   Wed,  5 Aug 2020 23:19:19 +0530
Message-Id: <20200805174921.16000-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
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
 t/t7401-submodule-summary.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 4439fb7c17..18fefdb0ba 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -183,7 +183,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
   < Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
@@ -193,7 +193,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --files' "
   > Add foo5
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -rf sm1 &&
@@ -204,7 +204,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' "
 * sm1 $head4(submodule)->$head5(blob):
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 rm -f sm1 &&
@@ -217,7 +217,7 @@ test_expect_success 'nonexistent commit' "
   Warn: sm1 doesn't contain commit $head4_full
 
 EOF
-	test_i18ncmp actual expected
+	test_i18ncmp expected actual
 "
 
 commit_file
-- 
2.27.0


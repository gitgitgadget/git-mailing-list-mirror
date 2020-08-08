Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45256C433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2327A206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd9D0xdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHHRBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgHHRBf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A490C061A2B
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so4220896wme.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+9Lrw6sN2XIQeBtapPHDCsWzdsNThDKuXUCzgi0LJ+k=;
        b=kd9D0xdM4Qmf9FD01BPMlpYf2B9+hjBuDdMOzdFlG/8Ti/f1EAXTJ07LUkf1p4HR1P
         NRuhHdEd9lXi2Pu1M4GBP9GoVobOTEPWw+Y8VWNIxcp2/M8xCQyoUek0aHXdRdAT8mWV
         oh6HEVYcNaV2unSPXS9IJ1j2tOWZ9aH6ktAM9J0YUQ60BCyuEcaQSSvlNI7Cotq216bf
         DZuClFFwEl3vR/KFDcA7ZGeDyJ2O5Tyg+TwFuw1s8SooC0hFCA7uajoPcAUKqdT/4SvY
         1OHjqGBmT771sU6onJE/D34orpVYgN3l3D1G0OSgRSC1ze8LKcyvpxycRZSMa51dGuV4
         Kdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+9Lrw6sN2XIQeBtapPHDCsWzdsNThDKuXUCzgi0LJ+k=;
        b=eeB7ct8XH/WrzRGSi5dmZrQ4J/rq2YCOMPs1BQUxrIpZws+S8v+xjR2ksQ88KI2b/9
         bzR5PiQeLhG98rWiWqkrR8j+VvnhYTFuSFyEnbmhjbNlLl8WYzZmm/6/pHBrIOlYSB3z
         dJd3RY6g6CCs2uxOPv29uWEu6K1+Cozg3mSWQEdhqf+fh9P3AzOEr0lUWw8EaYy4Cm5z
         26xlNXJZ3SKnYdFxACqamwHoWpR8KN/kCmB9L1B7tfCUdt2698H5N7ETaZ0Z2WA0ETfS
         l4pMkej2rESyArdabUUkLEB17RuGD1S5S2uh9UmEzq+2PBgroTTfl0y/eSECT4XSeUkU
         DnkQ==
X-Gm-Message-State: AOAM532Amzx+u9Du9iYnyXsJVjkVsjeZSzt9EJkQdZ+HGqp/2H55GUFp
        GXNwO7VCDv891ji/hwA2U7mR+YDW
X-Google-Smtp-Source: ABdhPJwv/pyzPtHGYRMTqST1bSXexfpxUygi3P/9bb+q0kIScpUC4l0c6BWBbhTApcRxU2OQQHnuSA==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr12883346wmj.129.1596906091178;
        Sat, 08 Aug 2020 10:01:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm14325038wmk.37.2020.08.08.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:30 -0700 (PDT)
Message-Id: <a9a02a0ca51f16b07fe0b28d16f5a3c2888227ca.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:19 +0000
Subject: [PATCH v2 10/11] t642[23]: be more flexible for add/add conflicts
 involving pair renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much like the last commit accepted 'add/add' and 'rename/add'
interchangably, we also want to do the same for 'add/add' and
'rename/rename'.  This also allows us to avoid the ambiguity in meaning
with 'rename/rename' (is it two separate files renamed to the same
location, or one file renamed on both sides but differently)?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6422-merge-rename-corner-cases.sh | 18 ++++++++++++------
 t/t6423-merge-rename-directories.sh  |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index f3929b65c0..3375eaf4e7 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -583,7 +583,7 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 		git checkout B^0 &&
 
 		test_must_fail git merge -s recursive C^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 2 out &&
@@ -959,11 +959,17 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 		git checkout A^0 &&
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
 
-		# Not sure whether the output should contain just one
-		# "CONFLICT (rename/rename/delete/delete)" line, or if it
-		# should break it into three: "CONFLICT (rename/rename)" and
-		# two "CONFLICT (rename/delete)" lines; allow for either.
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		# Instead of requiring the output to contain one combined line
+		#   CONFLICT (rename/rename/delete/delete)
+		# or perhaps two lines:
+		#   CONFLICT (rename/rename): ...
+		#   CONFLICT (rename/delete): info about pair 1
+		#   CONFLICT (rename/delete): info about pair 2
+		# and instead of requiring "rename/rename" instead of "add/add",
+		# be flexible in the type of console output message(s) reported
+		# for this particular case; we will be more stringent about the
+		# contents of the index and working directory.
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 		test_i18ngrep "CONFLICT (rename.*delete)" out &&
 		test_must_be_empty err &&
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 2b4a482277..f7ecbb886d 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -275,7 +275,7 @@ test_expect_success '1d: Directory renames cause a rename/rename(2to1) conflict'
 		git checkout A^0 &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 8 out &&
@@ -1686,7 +1686,7 @@ test_expect_success '7b: rename/rename(2to1), but only due to transitive rename'
 		git checkout A^0 &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
-- 
gitgitgadget


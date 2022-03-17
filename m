Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC34C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiCQKO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiCQKOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0699ADA6FF
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n35so1192821wms.5
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIwPDXqk8epioRmc6w3t/T7/biwiu373wU7KymyLv1A=;
        b=h3P1Yd7a8qZETxqVeOFbWJnLjf9qSmJvv5t8zKlrfjJxyt2v5N0NcYvQ5xPLcnQ74E
         d/YWlwWwYi3ESbhuiZQt5djNSZ10K4bdW7cPNHqai+xgbKRoI29bqY/kzICXUl2/hL8a
         1invx3oONdNPeJHTgk/MxIFjAGd30XLIx9lEjcES5y0vTwENb0qwHgCaDYyD4oZQQFeR
         l8wlzupeNx9jKshXreD0yCWvFOpIO1EVC6sUblHVjsMI3n14a5hhpAiClKn7CFErnO8/
         mCbe0kozmucH4AZq3MEdrnqoYuFYSQ6paZg/acOT4ZDSdAC8wW54ipPUOGn8pl0j907t
         k7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIwPDXqk8epioRmc6w3t/T7/biwiu373wU7KymyLv1A=;
        b=GPii6BH+U8ia7C5bop0pnXcgz4dMnFiAVUfrD4gyxiDpES8VNEDy54C3P6aDJzvcxG
         eN30Dru3fpcRur4l9/5ovMX9v3qD9pI9Dyl/JPEvf9RF+kaaOJKzDixD6Z8pLtCoD5Vr
         hS8GKX82Zbe2DGU8h4TYBdb49wJrNtZDhBs061YNU6MeVNDbg7wFb5H2RGPCkkZhdjlT
         esitXx8hihkvVyoWaw4rVUQDOJGNVyFnVP18MTT1yxlkVtTCD1ErFMFDWGxwfamJW9sp
         aZMtKKbSEHX2M1arfwMZv+MjzKPsEpL3fn1Nlt22QwDCvAkpQp1HyKLT09w40RyoBGKy
         Gztg==
X-Gm-Message-State: AOAM530O/1mBO7KIJSL8GtA28/CKw25QQAiHBm8sH+pdABzNUHIcOXq+
        wUJz20/5Z3H99tb9lOPgnigbvgRYy/U=
X-Google-Smtp-Source: ABdhPJxPVRm50tyviSdLZ92WXb/Kh1KSBxr7qxqlrr4/iSv4Lz/9QKkAOu1xbbMwAN2wfSowmCo1zA==
X-Received: by 2002:a05:600c:3511:b0:38a:1ca:da21 with SMTP id h17-20020a05600c351100b0038a01cada21mr3119683wmq.170.1647512009382;
        Thu, 17 Mar 2022 03:13:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/13] gc + p4 tests: use "test_hook", remove sub-shells
Date:   Thu, 17 Mar 2022 11:13:12 +0100
Message-Id: <patch-v3-07.13-bb57b298598-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the repository setup code for tests that test hooks the use
of sub-shells when setting up the test repository and hooks, and use
the "test_hook" wrapper instead of "write_scripts".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6500-gc.sh           | 22 ++++++++++------------
 t/t9800-git-p4-basic.sh | 23 ++++++++++++++---------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c2021267f2c..cd6c53360d2 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -101,12 +101,12 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 	EOF
 
 	git init pre-auto-gc-hook &&
+	test_hook -C pre-auto-gc-hook pre-auto-gc <<-\EOF &&
+	echo >&2 no gc for you &&
+	exit 1
+	EOF
 	(
 		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
-		echo >&2 no gc for you &&
-		exit 1
-		EOF
 
 		git config gc.auto 3 &&
 		git config gc.autoDetach false &&
@@ -128,14 +128,12 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 	See "git help gc" for manual housekeeping.
 	EOF
 
-	(
-		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
-		echo >&2 will gc for you &&
-		exit 0
-		EOF
-		git gc --auto >../out.actual 2>../err.actual
-	) &&
+	test_hook -C pre-auto-gc-hook --clobber pre-auto-gc <<-\EOF &&
+	echo >&2 will gc for you &&
+	exit 0
+	EOF
+
+	git -C pre-auto-gc-hook gc --auto >out.actual 2>err.actual &&
 
 	test_must_be_empty out.actual &&
 	test_cmp err.expect err.actual
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 806005a793a..8b30062c0cf 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -277,16 +277,21 @@ test_expect_success 'run hook p4-pre-submit before submit' '
 		git commit -m "add hello.txt" &&
 		git config git-p4.skipSubmitEdit true &&
 		git p4 submit --dry-run >out &&
-		grep "Would apply" out &&
-		mkdir -p .git/hooks &&
-		write_script .git/hooks/p4-pre-submit <<-\EOF &&
-		exit 0
-		EOF
+		grep "Would apply" out
+	) &&
+	test_hook -C "$git" p4-pre-submit <<-\EOF &&
+	exit 0
+	EOF
+	(
+		cd "$git" &&
 		git p4 submit --dry-run >out &&
-		grep "Would apply" out &&
-		write_script .git/hooks/p4-pre-submit <<-\EOF &&
-		exit 1
-		EOF
+		grep "Would apply" out
+	) &&
+	test_hook -C "$git" --clobber p4-pre-submit <<-\EOF &&
+	exit 1
+	EOF
+	(
+		cd "$git" &&
 		test_must_fail git p4 submit --dry-run >errs 2>&1 &&
 		! grep "Would apply" errs
 	)
-- 
2.35.1.1384.g7d2906948a1


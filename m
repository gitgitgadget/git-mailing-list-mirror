Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEA7C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B435D22248
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMRya+Hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508388AbgJVHUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508385AbgJVHUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 03:20:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB8C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:20:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so395625pgv.13
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=SMRya+Hm//ShVgZEmGj4D1mRuoE5lBPB+r2cAzqaoYWE0TxE3paIRX7hcBYXDjwT//
         pdJWt1YQiPYHQ6mSKrlVrfeAuH+4HH7P6bDjJ8A/fBXHdQDOUFX8fdwTodbVf8rrMul2
         IeT46Y5iGtHWOpQQfDDGj2c7zWTBukmtC8WqCPGqo3bBM2Oc+L1HRhrBc9rIucUUR/VB
         5Q1fEhR8tdniTi7wBiDCaIAYMWv/v+383K+zDQd2h8ehAulMpZpEPCKrV05vXDjV5wEG
         mkr3ryVrNqn9O4hUcYMYgcudkvmV4aTu/CdjYK1QVGNFJFkTL0atISuJGDSF3ehTN5yY
         XyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=A0DW+30rYGGJBC7Pt21Sk5L/6uX3TNmlLEpUlyqfG03tyiZwW7kOne/tDZI5X06idf
         TJIKS8KBUt4/AOsWu1auevBwqkUmJKvHa+I00xgrCVfd1vTYuYeKuKO9xAFwtWrp2LhD
         tr/30WRjoOKDr1+KyabskIPDfe8C8rhUQ0aHu7zirQH2aiGdRV0TWC9IH3N58GfbuvBc
         PXGREUtKSefAFZfKM1Zw2XRgAhspn0yYRNGK4dqk17BCtMutH+R/OkXkCLd+U/QGOMX1
         ZfkuR3JbR9ZMbBOihUNVgRqkEo1HP2YqCwecuzXTBtel7udAXB5086lX12ruPveE3c2Q
         aVXQ==
X-Gm-Message-State: AOAM5323dwcOSzr29p0vtIdZN/84AhcU671OttX5Nouxm0R5MtIOL/Bq
        rWAWaBZs36W0/F2DjHsznYIe2+tqboJ0LQ==
X-Google-Smtp-Source: ABdhPJx2le7FAfpHR27g3MP60X6+b7c1ohhpeALRHJu5L3JcaB1f7SxWvGr2V+3Kipb+a3AdQvqeLg==
X-Received: by 2002:aa7:9048:0:b029:152:883a:9a94 with SMTP id n8-20020aa790480000b0290152883a9a94mr1227731pfo.24.1603351209796;
        Thu, 22 Oct 2020 00:20:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:4050:2e84:4e7a:290b:4332:f03e:69aa])
        by smtp.googlemail.com with ESMTPSA id 78sm1030004pfz.211.2020.10.22.00.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 00:20:09 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v6 5/5][Outreachy] t7201: put each command on a separate line
Date:   Thu, 22 Oct 2020 12:46:50 +0530
Message-Id: <20201022071649.24284-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201021124823.2217-1-charvi077@gmail.com>
References: <20201021124823.2217-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modern practice is to avoid multiple commands per line,
and instead place each command on its own line.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7201-co.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 5898182fd2..b36a93056f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -157,7 +157,8 @@ test_expect_success 'checkout -m with merge conflict' '
 '
 
 test_expect_success 'format of merge conflict from checkout -m' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout -m simple &&
@@ -180,7 +181,9 @@ test_expect_success 'format of merge conflict from checkout -m' '
 '
 
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout --merge --conflict=diff3 simple &&
@@ -205,7 +208,9 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 '
 
 test_expect_success 'switch to another branch while carrying a deletion' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 	git rm two &&
 
 	test_must_fail git checkout simple 2>errs &&
@@ -218,7 +223,8 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 	git config advice.detachedHead false &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
@@ -237,7 +243,8 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
 	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
@@ -254,7 +261,8 @@ test_expect_success 'checkout to detach HEAD' '
 '
 
 test_expect_success 'checkout to detach HEAD with branchname^' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout renamer^ &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -269,7 +277,8 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
 '
 
 test_expect_success 'checkout to detach HEAD with :/message' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout ":/Initial" &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -284,7 +293,8 @@ test_expect_success 'checkout to detach HEAD with :/message' '
 '
 
 test_expect_success 'checkout to detach HEAD with HEAD^0' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout HEAD^0 &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
-- 
2.29.0.rc1


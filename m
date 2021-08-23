Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C93C4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAEA6137D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhHWKpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhHWKpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:45:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D011DC061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so588818wms.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8OshOFFksubrG8dgFvrbFoGaQzaJHsZ27Zk2Ml36dQA=;
        b=rECradWGKqdP0m89/Wck2z9HpHLLDgFIw1GvciBfe0YGTo2IabJj6rXl+Lr9ruhS5M
         GPkOEAkQoG0BjTpCbniOz/xolgcaLSkZFkHCpge+vkSlTL9zIKxlrvNnXQHCsH/8Qshy
         jEnK8QOFrFqLkdizG4zuBCz1L6Kv53GyJstuHGG4c0KtYYXfsgh878P9+aEP6WKlOt+t
         bibuKufpSc83YYUzUmV/LRI+F3v4p/NCVKElKsk+c8OgUDQOn2+tGTBURxfy5zhBNEIB
         rxTRtDddyP5rWUTNe3ddrw+KzLObVNgsnYeLLUQuP3ayqVF5i5Paku5+KyVwokGNgIfV
         P+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8OshOFFksubrG8dgFvrbFoGaQzaJHsZ27Zk2Ml36dQA=;
        b=T2n1FmEfUSBsq9DMQ7GrqDvXZnYUX61sDVKIejrGjzgEmTrZperDiyS+ATELNSzbmd
         20PtCgJL1LnExQmlIqjWwusRRRsbXLjmLOXCd9H3JkKS/Ji2N0cClfFB81oi6I8OX4lx
         Akrpp3Y9DrQBu5oIeGXBpxRM4Ras1rUl4IlOXXtlndLC3LxINGb1AtBa9Gt6Ocv3T1k0
         itqWB9r32vJQOX//ogLiAzUG9Qmg8UHP6/XRmAOThmC/kKIU4OqpzyrPJDi9Tb2DlUSz
         7qvGHDHLP9FXm3HaKC5+mCwtWxqtU6rZgWXKbmlLaONt4g89JIx2V0Vb0B3amQuErTsC
         Y4lQ==
X-Gm-Message-State: AOAM531tYOwfzup8TZW2T1Cz2v/IpA6vlDnpH+Xn9OLLFZe05JP6ChLZ
        d5Jhf2Ujb7qrTSdoY2ILyfTxqs8UVX7JGSVZ
X-Google-Smtp-Source: ABdhPJystWAzz2kTwrzT9S1BU2yDV5XJgqRc6a6MsIA/h2NF5yIDGK0dPpGWY6dw9V8WFPG+e+6j8g==
X-Received: by 2002:a05:600c:1ca9:: with SMTP id k41mr15198695wms.39.1629715454227;
        Mon, 23 Aug 2021 03:44:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k12sm15351187wrd.75.2021.08.23.03.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:44:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/4] advice: add enum variants for missing advice variables
Date:   Mon, 23 Aug 2021 12:43:59 +0200
Message-Id: <patch-v4-1.4-4e977e9d5a1-20210823T103719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
References: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

In daef1b300b0 (Merge branch 'hw/advice-add-nothing', 2020-02-14), two
advice settings were introduced into the `advice_config` array.

Subsequently, c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25)
started to deprecate `advice_config` in favor of a new array,
`advice_setting`.

However, the latter branch did not include the former branch, and
therefore `advice_setting` is missing the two entries added by the
`hw/advice-add-nothing` branch.

These are currently the only entries in `advice_config` missing from
`advice_setting`.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c | 2 ++
 advice.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/advice.c b/advice.c
index 0b9c89c48ab..6da51be63c1 100644
--- a/advice.c
+++ b/advice.c
@@ -106,6 +106,8 @@ static struct {
 	int enabled;
 } advice_setting[] = {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
+	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
+	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
diff --git a/advice.h b/advice.h
index 9f8ffc73546..68629b5ba1d 100644
--- a/advice.h
+++ b/advice.h
@@ -45,6 +45,8 @@ extern int advice_add_empty_pathspec;
  */
  enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
+	ADVICE_ADD_EMPTY_PATHSPEC,
+	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
-- 
2.33.0.663.gfcc3c7013a8


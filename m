Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAC5C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C98207FB
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 03:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyPpaA+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIYDul (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 23:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgIYDul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 23:50:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA76C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 20:50:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w16so1423542oia.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 20:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1q27E4mZPolZnFyMYMLJ0IzoBIvjfEmy1GdPVjFanI=;
        b=KyPpaA+gySPvzI1rH7e4/N8qyiWBsa+cfCVvzRvB1G5Oq/k50HzgVmvj1vi8ne9ftb
         Lzq400VxRupfaNbFqsMEswFKY4qd9pVuz45L/HYGxPwfyU7Z+kvAGJGdNtT941xOH79A
         ytrQVM8JG8Xb7PgU/x3qPsYepImRxHfICmCGvw9GewmoYCx8vnMkM3LbbGCIcSiRvV0P
         O5PBSSdN7v26tVJ1G4BPojEwaJUv6bbYE8Iz/m924FOudvABzaYJJE/QvfHj7y6OALVh
         sxD3iEcxVfmAybqKxclgfgG21W5OMvi3kzWsL6W4OIay0LcBBGnBx1WHDRf0dTmXRElb
         fWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1q27E4mZPolZnFyMYMLJ0IzoBIvjfEmy1GdPVjFanI=;
        b=q+TFE/C7/WQM9UiQGSqb3YybKORZaleJzKGaif+BiRaXT5kgyYISl5kBfIfS70LOi1
         j2qU42A2vcgMTpDb6ONK0dBeHIbh+aqJIoY2T3u8qXO1zi6aBQrq8ndGzTi3MU4aEGq6
         nQ8lHbplAFj6eqQNl1F3Iw8Hb+xzLGROx+Dv54eoWRx+p/4qpPOimrbVD0lssxpMmeht
         sbD1wF6+8Wifgu4J81an/s8i5f/0lMge/V8e12oNcEB3VqHpFAuBypuhnDZhxTXCW7of
         XgJqo6Y73XKSyBKznECb1QmB9yilyczixFrE/dX0xovP/UlWFRlyQLhEeXHNjA92yQYe
         47XQ==
X-Gm-Message-State: AOAM533eh7miY2SQ4U7ShJrjtlPxfTb4aXjspsu1Ia3Qd0W6gsWWvAzT
        GgJhSgDF+M9U3C+7mLuTTWcomBbBHoT8lg==
X-Google-Smtp-Source: ABdhPJwPwOOmJTTYNvUiusHeTiMqBRgjByahigD3WXmrnIOaiVIvxiY1eYcRc7zM8Bv3FaH5knx1aw==
X-Received: by 2002:a54:4189:: with SMTP id 9mr452636oiy.66.1601005840399;
        Thu, 24 Sep 2020 20:50:40 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:5900:961c:3398:e348:1cc1:ced7])
        by smtp.gmail.com with ESMTPSA id l15sm351107oil.24.2020.09.24.20.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:50:39 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, liu.denton@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pull: don't warn if pull.ff has been set
Date:   Thu, 24 Sep 2020 21:50:23 -0600
Message-Id: <20200925035023.8771-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A user who understands enough to set pull.ff does not need additional
instructions.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/pull.c               |  3 +--
 t/t7601-merge-pull-config.sh | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 015f6ded0b..425950f469 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -344,8 +344,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	if (opt_verbosity >= 0 &&
-	    (!opt_ff || strcmp(opt_ff, "--ff-only"))) {
+	if (opt_verbosity >= 0 && !opt_ff) {
 		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
 			"discouraged. You can squelch this message by running one of the following\n"
 			"commands sometime before your next pull:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 0f97828cd0..c5c4ea5fc0 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -33,11 +33,18 @@ test_expect_success 'pull.rebase not set' '
 	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
+test_expect_success 'pull.rebase not set and pull.ff=true' '
+	git reset --hard c0 &&
+	test_config pull.ff true &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
@@ -59,6 +66,18 @@ test_expect_success 'pull.rebase not set and --no-rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_expect_success 'pull.rebase not set and --ff given' '
+	git reset --hard c0 &&
+	git pull --ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'pull.rebase not set and --no-ff given' '
+	git reset --hard c0 &&
+	git pull --no-ff . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c0 &&
 	git pull --ff-only . c1 2>err &&
-- 
2.28.0


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005C7C433ED
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3C560FDA
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbhIBQCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbhIBQCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3293CC061796
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so1832257wmn.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdmvmXia+y1op93cYXwKOTbgaIO/dzVub4roa1ellm4=;
        b=ZXReraJO3ZRvY4mY3StrM99Twkc/lgbj++caSETetndG5CyHYq39dA2lkIGfRN52d2
         W9Uq8oros4UI2Q//F97pZZWzpSLU8SaGUjfGPIQ5KZ4WZksBu4GVpdKxNVbqYw2eVqvb
         4uoJPdxsalef4jbBWCcqIrR41YbMbjzmYLzI4R02+PZZYRA7s0B6zMgp/IMl8riExcHj
         cWmoO7ppll2ViAPTV/h7JMzdQnrfp601Fme7vm5Oc5PMupi+tou4vLbUSxIvR3VQdSwQ
         ADFSuq3A53BZY9D35gbEQIPRa7G/APY5Fz+l4Bw3Wa69VhOZAHEV5mp8oi7X6MrqgIhJ
         MAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdmvmXia+y1op93cYXwKOTbgaIO/dzVub4roa1ellm4=;
        b=lhXsMfwGqfbubFcazBOsbz2dKCGmU6yMSR+g1Jn2kekhNuxQmnhgpzCgjs1oGI6qua
         zE5uGEOzATq9A18b8d+kDaT+LesBkatWe/pYB0vli4ZqM24fog7SyD696911lrZYZQa3
         vm+qZE/3/PZF5yKnoOSuQCpdHOFUPrTlJ9IgTe9btztCfddI/PBgZ6gbCdwk6yWZ0Zpy
         tCx1JaqF0VDeztFU+t9wjVZrd8lXWXKXXXAAMtg0FYHkSar93lVHzqxIHlpDPccSE6IQ
         HPpBQ2dCN57Vw4IpxAuq5baWIofe07+HehaJznjgh+0sHob0854zIlSDgYVhuieibwRv
         7htA==
X-Gm-Message-State: AOAM530nM53J8uiYDNVVFe2YfNa24xEklaVfRTmE6xjzfkFoicORD0Fp
        2ECctV1K4iI0GLcGTTVAFNHQuqO6vI2ckQ==
X-Google-Smtp-Source: ABdhPJxgTl29bFSotIXga6w+SEswlBehtJ5cFtCgydYklx1sLYuqFxfgsa6AMT+Q+E0hrSxzWr7WIw==
X-Received: by 2002:a1c:2246:: with SMTP id i67mr3585054wmi.179.1630598486707;
        Thu, 02 Sep 2021 09:01:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/9] git-sh-setup: remove unused require_work_tree_exists() function
Date:   Thu,  2 Sep 2021 18:01:12 +0200
Message-Id: <patch-5.9-dc4dd7d1399-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last code that used the require_work_tree_exists() function went
away in d03ebd411c6 (rebase: remove the rebase.useBuiltin setting,
2019-03-18), let's remove it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-sh-setup.txt | 6 ------
 git-sh-setup.sh                | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 2a28361cf66..1d8c87e9b2f 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -52,12 +52,6 @@ require_work_tree::
 	checks if the current directory is within the working tree
 	of the repository, and otherwise dies.
 
-require_work_tree_exists::
-	checks if the working tree associated with the repository
-	exists, and otherwise dies.  Often done before calling
-	cd_to_toplevel, which is impossible to do if there is no
-	working tree.
-
 require_clean_work_tree <action> [<hint>]::
 	checks that the working tree and index associated with the
 	repository have no uncommitted changes to tracked files.
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index a2a28982b6d..363c0096842 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -122,14 +122,6 @@ cd_to_toplevel () {
 	}
 }
 
-require_work_tree_exists () {
-	if test "z$(git rev-parse --is-bare-repository)" != zfalse
-	then
-		program_name=$0
-		die "$(eval_gettext "fatal: \$program_name cannot be used without a working tree.")"
-	fi
-}
-
 require_work_tree () {
 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true || {
 		program_name=$0
-- 
2.33.0.814.gb82868f05f3


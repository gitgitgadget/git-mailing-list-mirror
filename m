Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE85C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358378AbiFVO3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358242AbiFVO2S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2301D31D
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g27so17030643wrb.10
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wj1ML0hitF9+i1K97U0avI1kegoWGXgQISNKEE9FCu8=;
        b=QC2G/YrPze0vCMb0oSA+S60tRCBDiPDA3gwLVb83M0mMOeBM7TA+SOej2ASAj7z916
         yRnsQlfj96/JSyGCMdvPMi6TKJpxXDcJyiMvw0zRnxOM/p6oZPLkAeDD6Yv7vVvtAfzj
         b8hvwt5czi8+cIZeRv7p0gfo3xgIUhsEyTIu6VHebnpKR/jkVmZ5RcCaG8vEMBTF1FcF
         wKNC9AC/Tyf9mJW3Ft/BfnZS1DK4a0u9g0T1CjSpd2vl64uoBWk3bNnAq6mImc9lV/Q3
         IWyKvxSmLR7ktCDUsSqYNOxaigqKGgTsDLcrVHNNsooQxhrVlWpAYwhjo1qjAXYLNhtd
         ReLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj1ML0hitF9+i1K97U0avI1kegoWGXgQISNKEE9FCu8=;
        b=NrL2l0fUuex+1Xu1hgvWHmgLccLBbQUB5qFofrQsdqpAUeVACAC8fWhyneD8J9brWu
         hEfzsgE7idOoFM4Kgb4EnwGeWVzSW15Dr4SMpdUzucuVWmWBuwrR1PxlZMqSp28FR/xG
         8aMyM3Gli645ICMi9Nd47Xl04owFU2ruoQ292SnNipNi9n9GHtsdu9Lfn6Fg1dwcId2O
         w6xcWZlRxQtP1aPHrk0q92xMEJ39XFEMD1l5bIH5tmRLqSHiS0cr1a43p1lILJPSjHkS
         +uz1fBEmGb6PPbPxHTteJgtxc9YyVmwDMuvW97A/gsi/F+dIa1ZZZahESq6N4O7ET9t1
         WnNQ==
X-Gm-Message-State: AJIora+Kz+aiVO2koUP1XycVlKTzxl64shplX9WuwqJev1MJhxBGYIA9
        ZD9/M0+wt5Tjanwlk/QdoRpA5DB8Is9Bag==
X-Google-Smtp-Source: AGRyM1toq0xO9pwP8roZTT4t6IqvKQIDWT6swdQ2IcXT6Hb3ktGBOvwYENwMXkzBQjM2cuanDwlNPw==
X-Received: by 2002:a5d:6da2:0:b0:219:abb9:6546 with SMTP id u2-20020a5d6da2000000b00219abb96546mr3758564wrs.541.1655908095310;
        Wed, 22 Jun 2022 07:28:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/12] submodule--helper: have --require-init imply --init
Date:   Wed, 22 Jun 2022 16:28:00 +0200
Message-Id: <patch-v3-05.12-64e4aa41d21-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 0060fd1511b (clone --recurse-submodules: prevent
name squatting on Windows, 2019-09-12) to have the internal
--require-init option imply --init, rather than having
"git-submodule.sh" add it implicitly.

This change doesn't make any difference now, but eliminates another
special-case where "git submodule--helper update"'s behavior was
different from "git submodule update". This will make it easier to
eventually replace the cmd_update() function in git-submodule.sh.

We'll still need to keep the distinction between "--init" and
"--require-init" in git-submodule.sh. Once cmd_update() gets
re-implemented in C we'll be able to change variables and other code
related to that, but not yet.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 5 ++++-
 git-submodule.sh            | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 03181c5ca50..1876375a4a0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2619,7 +2619,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &opt.progress,
 			    N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &opt.require_init,
-			   N_("disallow cloning into non-empty directory")),
+			   N_("disallow cloning into non-empty directory, implies --init")),
 		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
@@ -2643,6 +2643,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
+	if (opt.require_init)
+		opt.init = 1;
+
 	if (filter_options.choice && !opt.init) {
 		usage_with_options(git_submodule_helper_usage,
 				   module_update_options);
diff --git a/git-submodule.sh b/git-submodule.sh
index 20fc1b620fa..5b9683bf766 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -251,7 +251,6 @@ cmd_update()
 			init=1
 			;;
 		--require-init)
-			init=1
 			require_init=1
 			;;
 		--remote)
-- 
2.36.1.1239.gfba91521d90


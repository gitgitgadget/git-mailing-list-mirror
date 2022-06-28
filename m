Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24450C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbiF1KGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344721AbiF1KGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B60D2EA13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i1so12415345wrb.11
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YntMMDRKuJSFBVTFnlJULHQxXtAYpz3qj9xgHOA6a/E=;
        b=SPvtSTfYO7oAqCPVXyxbAW58doZX4RzYCPEueJqKttv+nUWgohtXaLX/BEwtzEUJl6
         xc4aauWky2J67OtRjcy2j40wYUqh2EDoPQDSjCSOipqgqfpLI7OIdhW12/AjZ0/VlNI4
         Cwta5QhW4tHbW+RLNgKNK286w0w2XwteqL5MpV2SjdRh3csPMfUtqg88WKNUpWqu7G3c
         u85qbCIdQpw+rJ6FB7Mw0vEySKDa8JguMNL21RBZJXZopnmQRn10Hsyp2BlQ6pJwgiLM
         b4w8020VZClMk1EO3H5ftGpZMDugQjlPxbIP8MEX0jWj4PBv6LjcKSYAvnIuSZKKtqL2
         ZLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YntMMDRKuJSFBVTFnlJULHQxXtAYpz3qj9xgHOA6a/E=;
        b=ma2nh8rUUEqOnBG+IeCZCOxbyF5T7fuhoIbAGJ3L6pT8HsYo+blelajoPHNyg5bFFY
         d+58HoORzN3b4llx9mcLcBe7RWH98QEjAggAxT2eOjkHOshi5VU4uVhgq8uDp9aDQadj
         em8b4I6X5Fig/KWiCDju8CpaH3HfsG3iOAEO3Ja63sfLQhfsJVE27y/1q5SEijUG/ib9
         Gm4Dxarr9OMAlpXRzbSvBUebfGlKOsZnlHg3sPf9i/Gh5kdHHuSFVJWELouZleSPwtc8
         N+oukPrMfrd8XFud404sWESeOhiptzyNY7566kHzLPSeFrvfdrJl5R5TGxUlT0519XX6
         Ynaw==
X-Gm-Message-State: AJIora9RDcE5UOdbJMkuJyKn/nV/nNa4sT9VXQoOZ4yLKS4mUcK03bvz
        4bD2KuwYDsthfP/zR4E17d7BN+KiWvLNMA==
X-Google-Smtp-Source: AGRyM1tz/qBmIRsRg2pt1ySbY+e7d5RTsUsAQ7mwzoIHH/ri6RmhhuoZeP7bNojFYKNgbApdDaTv3w==
X-Received: by 2002:a05:6000:1862:b0:216:3c40:6708 with SMTP id d2-20020a056000186200b002163c406708mr16586201wri.101.1656410773333;
        Tue, 28 Jun 2022 03:06:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/12] submodule--helper: have --require-init imply --init
Date:   Tue, 28 Jun 2022 12:05:27 +0200
Message-Id: <patch-v4-05.12-a4632f00a4a-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
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
index c597df7528e..0fab3a52e88 100644
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
2.37.0.880.gf07d56b18ba


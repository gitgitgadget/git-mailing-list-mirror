Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF69AC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbiFJCCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345906AbiFJCCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517ABA55B
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so378443wmz.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZIZtun4Grq8WUH21/BFtVaOnsQ6ZhWz6xTmg09hpFk=;
        b=ZBOkhCZNNk13k5u88et4kOCFyRWK58GdXRKlJWHD+sTLz3X8s4yl3tKMuNzkTeI7NH
         OXUsb4XpSKXc1fOJAc1KgkHHEfNyHHZ28ITQhkWhUUCxTpGIbmhVvGJZRAvDAwU8IpIp
         Dc/6czyZPAhpmArYXNYfAjKGhUXWzmhUBiS4qW8+L/edBw+WG4Q+C2ePsXJT591cEevu
         +IOKVipYmR9NG+rMqm1W1Ve69Gbue5fKhDFy05AOkAZSNmJEfJdCzk9V1EBOrlYZxs4b
         +CgyfKZkWWiFIxBddokZq/GryW0y7DEUjB7LnRpCgDj0++Q4AXPqhzBgFu5hrFBdCHnM
         yUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZIZtun4Grq8WUH21/BFtVaOnsQ6ZhWz6xTmg09hpFk=;
        b=6R6tmSZws7JtlnHSroIgZ85998wyoRlis7PQywdRcCyoJZykVB8y0Sw/OxksVs+wGX
         pdizWROiaXYilnElID7UFEMQtkh29/5MLaq7RjXxhpYy8U7h8Ci+mbz7aTTEuYc3OdE/
         zsWF9/7i5sx1wYiQMo14rjZpJ99Yh8J/80kz3D1t6nS8CoeOlwbxKytLTbwXNenGDEbW
         vwTXqJZIRYfNAt4JRLVcJn+ycKoTDp6M3y5IMJSc7JdFGDIkPLf5R4obtsVqq1eOsDXG
         mU/654J+EmH26ACD9uP2RKE8Op/KPWulyGnN0sfr/+/3x2ga+Jq7NHnRjfZSH4cQU1iX
         Yzlg==
X-Gm-Message-State: AOAM533Mr6Rq/1t0dB1CnyXro7dQmp3IRluAVcMvJrqxsW12bM+cxNWk
        Slbj5H8pjfIY0KFl9QjO1kc+qJPuBhf6/Q==
X-Google-Smtp-Source: ABdhPJwrs6gFUKu5KpkeyAvs6FWejA8jorVk6I5zag9MFWx7XE1MbwJm+KhzqF/TqDzs2+lzNTu0Kg==
X-Received: by 2002:a7b:c1c1:0:b0:39c:58c4:c701 with SMTP id a1-20020a7bc1c1000000b0039c58c4c701mr6333106wmj.117.1654826520700;
        Thu, 09 Jun 2022 19:02:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 15/20] submodule--helper: understand -v option for "update"
Date:   Fri, 10 Jun 2022 04:01:27 +0200
Message-Id: <RFC-patch-15.20-0c388eed1d1-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "OPT__QUIET()" in module_update() to use OPT__VERBOSITY()
instead. This is in preparation for passing the command in
"git-submodule.sh" to "git submodule update" directly.

Note that this implementation supports the "--verbose" synonym for
"-v", but "git-submodule.sh" does not. Once we make the switch to
calling "git submodule--helper update" directly we should update the
documentation to reflect that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 64d7c5d7ba4..94126bcca07 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2584,6 +2584,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct list_objects_filter_options filter_options;
 	int ret;
 	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
+	int verbosity = 0;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2625,7 +2626,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
-		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
+		OPT__VERBOSITY(&verbosity),
 		OPT_BOOL(0, "progress", &opt.progress,
 			    N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &opt.require_init,
@@ -2637,7 +2638,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule [--quiet] update"
+		N_("git submodule [--quiet] update [-v | --verbose]"
 		" [--init [--filter=<filter-spec>]] [--remote]"
 		" [-N|--no-fetch] [-f|--force]"
 		" [--checkout|--merge|--rebase]"
@@ -2656,6 +2657,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	if (opt.require_init)
 		opt.init = 1;
 
+	if (verbosity < 0)
+		opt.quiet = 1;
+
 	if (filter_options.choice && !opt.init) {
 		usage_with_options(git_submodule_helper_usage,
 				   module_update_options);
-- 
2.36.1.1178.gb5b1747c546


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42438CCA47B
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbiFJCCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbiFJCCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B61B82D0
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so378470wmz.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdNv2954wsXdpYKN09KuCV8MoYNxoY9sm/uFA7dXlao=;
        b=DsK+uF4ITyiifkzHCIxdwKHMPv3VHXP+gUOhJQgACfOa5tibCfIWICve0lDNrHxDLx
         wWzovtk7J60s59E2F6ddRBrhkmghonXtagr2V9c5EUfqdkJ/Pt5tocdIjH7A5fSLS+B9
         nWiMhqwgkCT2EWat3Ac7JvR+cUTJvwIjuoaHk4EqnnM8gFDweUEeuJP+tnuXiHwHQE81
         NIWWa2hFb9z4CrLXisJaGSgnCpOewdqvsEfPNdVz9qZRNQjlNOQntdECeHxDZorYByHB
         nRvGLMQLvv8y5wnEl1NWSQL4f0OFh3BxpsgBOPBOJfqyJ2Dk29br56mF7LXW4YNM5ChS
         YYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdNv2954wsXdpYKN09KuCV8MoYNxoY9sm/uFA7dXlao=;
        b=OZVk++umtzzuNLpAlEtObjB7nL+ELVpuWW8b2cef2/SqUspyhHyY1TZCN+7D+bB5Au
         GTQu66AC47MZKHK6ygtQnBFyORe5BWZeYW5Djv+mCcnN62Tj3XlKAMXS5sb2TEzVPQAm
         gUvm5qqYHPvPs3MkoBnD5zxeLmI9aVQYLew2flKx34fPcUNy6XYRhXUGiU0T6UHc7cBT
         8oK7o1PCpz1NT1jXDeW9lxiMRTIU/SWjHO62rermUUhSazX1gVgXW3R16m3Sx38heHzi
         Hhmnvv+s3FyvTpIzxskiZJWUwxQKrUWQJwW++9tDbYxyk6SBWGlpOjMQcPIkJcpKU5V9
         BCjw==
X-Gm-Message-State: AOAM530ehcd80Khg6SJonH9EqpllrJpuyw2ytWkyYAwABKqex8E/Tkf9
        x21KLEI7LjBcQmS2fUgDbqnVEXbo7mnUzA==
X-Google-Smtp-Source: ABdhPJy/sdqS3SQI0INJMg9u39ZBKZOldDNoqZnNdLdRqnbuFlG9fIpT3ESqZMyZunN906dQ2wUVhA==
X-Received: by 2002:a05:600c:ac4:b0:39c:4f54:9c5f with SMTP id c4-20020a05600c0ac400b0039c4f549c5fmr6138573wmr.135.1654826517925;
        Thu, 09 Jun 2022 19:01:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 12/20] submodule--helper: have --require-init imply --init
Date:   Fri, 10 Jun 2022 04:01:24 +0200
Message-Id: <RFC-patch-12.20-57b9df29ea6-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 5 ++++-
 git-submodule.sh            | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 459260efc65..f1f5c6b84c6 100644
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
index de6c71d6bd5..43fe3bcb00b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -71,7 +71,6 @@ cmd_update()
 			init=1
 			;;
 		--require-init)
-			init=1
 			require_init=1
 			;;
 		--remote)
-- 
2.36.1.1178.gb5b1747c546


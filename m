Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E797C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiGUTNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiGUTNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195188757
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3932650wme.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OJ7NIApgLVlls5zt0PNhmMbdxijbSDt9jjArUHUgck=;
        b=Opr/BXKv2wv5b3W8iedCiTCJIV8OLOShB+EgUzQzgVfZVhvNdOs9xmJBHLVSfj3T9v
         zzT6K3h68FoEZdXBZJ8O6lAbSBTrI9XSS3NqRHTMTCQTWgDMvej1+gCyTpo+inxhzJuo
         8QZDf+o1VRzWJPb2ZQzvQi0lAXRU9QFfPrHryZ0SDfjgCwSf8PcMKBxraFwr7avnXjxX
         dG7TfKyG093chlwPoSWPk8NPHMUrG/+6MYB08WqcGKMIIC9DJElWy/Zz2L7xMHUS5boS
         cp+6NzMZOn6ZY04a4KXSOzC/sjvAJ0RJPIjDgLCwoUt9loYKk8ThLFTCB3S6R4pkOZtS
         GJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OJ7NIApgLVlls5zt0PNhmMbdxijbSDt9jjArUHUgck=;
        b=cbfdEogmvQUKZ6TozD4ZupZadLY8ak5ApQjxAdS0YBVYrItmrlH5VZf2eLK5gxQqIq
         irzv01LrEpfobLhhjMLOYfQSbc5ebqCD9Y1m/YO4U8hCXQKxg9fc/e7G/vhY0a9V9WKz
         U9JlLmF06CYFZxmj3VYWK/CqgwL4vgDOpvKGx4+7Yrex6qsgfRv2RYSiSNMEI41af88c
         qTEgHUMMmfyY+heYuJMQVkx07nJqGG9eX6Pwy5gs4HsSXKlE/jOBn26UZ4Xat5kBQLX2
         PnIlX1Lof/Y1f4fkhjGexT7ZwUvpAI6kf55eHFiEuIN8EtYQSGTrm3RWUso+WDpUTjkL
         f6mw==
X-Gm-Message-State: AJIora/zIUPdxbxTHwLreu44U92v/L3EuorZA32wVtY0uu4rf2bUy9Wp
        Ivrwk8uIndatT2Y8VkpPMe7wSDXuPO7Rkg==
X-Google-Smtp-Source: AGRyM1u++Y5IwcjblFVRtKTVFwFuThYUJfwG1Os9l/2ltx7TUFJOsBLWQena6JGNSNgh2RemXZqqeA==
X-Received: by 2002:a05:600c:3b91:b0:3a3:1cbe:d531 with SMTP id n17-20020a05600c3b9100b003a31cbed531mr9656995wms.159.1658430813605;
        Thu, 21 Jul 2022 12:13:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/26] submodule--helper: replace memset() with { 0 }-initialization
Date:   Thu, 21 Jul 2022 21:12:57 +0200
Message-Id: <patch-v3-01.26-3c7ae3e0222-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the less verbose { 0 }-initialization syntax rather than memset()
in builtin/submodule--helper.c, this doesn't make a difference in
terms of behavior, but as we're about to modify adjacent code makes
this more consistent, and lets us avoid worrying about when the
memset() happens v.s. a "goto cleanup".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fac52ade5e1..73717be957c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1744,7 +1744,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
@@ -1786,7 +1786,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -2563,7 +2562,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct update_data opt = UPDATE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
 
 	struct option module_update_options[] = {
@@ -2623,7 +2622,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
-- 
2.37.1.1095.g0bd6f54ba8a

